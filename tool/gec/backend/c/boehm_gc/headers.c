/*
 * Copyright 1988, 1989 Hans-J. Boehm, Alan J. Demers
 * Copyright (c) 1991-1994 by Xerox Corporation.  All rights reserved.
 * Copyright (c) 1996 by Silicon Graphics.  All rights reserved.
 * Copyright (c) 2008-2022 Ivan Maidanski
 *
 * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
 * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
 *
 * Permission is hereby granted to use or copy this program
 * for any purpose, provided the above notices are retained on all copies.
 * Permission to modify the code and to distribute modified code is granted,
 * provided the above notices are retained, and a notice that the code was
 * modified is included with the above copyright notice.
 */

#include "private/gc_priv.h"

#if defined(KEEP_BACK_PTRS) && defined(GC_ASSERTIONS)
# include "private/dbg_mlc.h" /* for NOT_MARKED */
#endif
/*
 * This implements:
 * 1. allocation of heap block headers
 * 2. A map from addresses to heap block addresses to heap block headers
 *
 * Access speed is crucial.  We implement an index structure based on a 2
 * level tree.
 */

/* Non-macro version of header location routine */
GC_INNER hdr * GC_find_header(ptr_t h)
{
#   ifdef HASH_TL
        hdr * result;
        GET_HDR(h, result);
        return result;
#   else
        return HDR_INNER(h);
#   endif
}

/* Handle a header cache miss.  Returns a pointer to the        */
/* header corresponding to p, if p can possibly be a valid      */
/* object pointer, and 0 otherwise.                             */
/* GUARANTEED to return 0 for a pointer past the first page     */
/* of an object unless both GC_all_interior_pointers is set     */
/* and p is in fact a valid object pointer.                     */
/* Never returns a pointer to a free hblk.                      */
GC_INNER hdr *
#ifdef PRINT_BLACK_LIST
  GC_header_cache_miss(ptr_t p, hdr_cache_entry *hce, ptr_t source)
#else
  GC_header_cache_miss(ptr_t p, hdr_cache_entry *hce)
#endif
{
  hdr *hhdr;

  HC_MISS();
  GET_HDR(p, hhdr);
  if (IS_FORWARDING_ADDR_OR_NIL(hhdr)) {
    if (GC_all_interior_pointers) {
      if (hhdr != NULL) {
        ptr_t current = (ptr_t)GC_find_starting_hblk(HBLKPTR(p), &hhdr);
                    /* current points to near the start of the large object */

        if (hhdr -> hb_flags & IGNORE_OFF_PAGE)
            return 0;
        if (HBLK_IS_FREE(hhdr)
                || p - current >= (signed_word)(hhdr -> hb_sz)) {
            GC_ADD_TO_BLACK_LIST_NORMAL(p, source);
            /* Pointer past the end of the block */
            return 0;
        }
      } else {
        GC_ADD_TO_BLACK_LIST_NORMAL(p, source);
        /* And return zero: */
      }
      GC_ASSERT(NULL == hhdr || !HBLK_IS_FREE(hhdr));
      return hhdr;
      /* Pointers past the first page are probably too rare     */
      /* to add them to the cache.  We don't.                   */
      /* And correctness relies on the fact that we don't.      */
    } else {
      if (NULL == hhdr) {
        GC_ADD_TO_BLACK_LIST_NORMAL(p, source);
      }
      return 0;
    }
  } else {
    if (HBLK_IS_FREE(hhdr)) {
      GC_ADD_TO_BLACK_LIST_NORMAL(p, source);
      return 0;
    } else {
      hce -> block_addr = (word)(p) >> LOG_HBLKSIZE;
      hce -> hce_hdr = hhdr;
      return hhdr;
    }
  }
}

/* Routines to dynamically allocate collector data structures that will */
/* never be freed.                                                      */

GC_INNER ptr_t GC_scratch_alloc(size_t bytes)
{
    ptr_t result = GC_scratch_free_ptr;
    size_t bytes_to_get;

    GC_ASSERT(I_HOLD_LOCK());
    bytes = ROUNDUP_GRANULE_SIZE(bytes);
    for (;;) {
        GC_ASSERT((word)GC_scratch_end_ptr >= (word)result);
        if (bytes <= (word)GC_scratch_end_ptr - (word)result) {
            /* Unallocated space of scratch buffer has enough size. */
            GC_scratch_free_ptr = result + bytes;
            return result;
        }

        GC_ASSERT(GC_page_size != 0);
        if (bytes >= MINHINCR * HBLKSIZE) {
            bytes_to_get = ROUNDUP_PAGESIZE_IF_MMAP(bytes);
            result = GC_os_get_mem(bytes_to_get);
            if (result != NULL) {
#             if defined(KEEP_BACK_PTRS) && (GC_GRANULE_BYTES < 0x10)
                GC_ASSERT((word)result > (word)NOT_MARKED);
#             endif
              /* No update of scratch free area pointer;        */
              /* get memory directly.                           */
#             ifdef USE_SCRATCH_LAST_END_PTR
                /* Update end point of last obtained area (needed only  */
                /* by GC_register_dynamic_libraries for some targets).  */
                GC_scratch_last_end_ptr = result + bytes;
#             endif
            }
            return result;
        }

        bytes_to_get = ROUNDUP_PAGESIZE_IF_MMAP(MINHINCR * HBLKSIZE);
                                                /* round up for safety */
        result = GC_os_get_mem(bytes_to_get);
        if (EXPECT(NULL == result, FALSE)) {
            WARN("Out of memory - trying to allocate requested amount"
                 " (%" WARN_PRIuPTR " bytes)...\n", bytes);
            bytes_to_get = ROUNDUP_PAGESIZE_IF_MMAP(bytes);
            result = GC_os_get_mem(bytes_to_get);
            if (result != NULL) {
#             ifdef USE_SCRATCH_LAST_END_PTR
                GC_scratch_last_end_ptr = result + bytes;
#             endif
            }
            return result;
        }

        /* TODO: some amount of unallocated space may remain unused forever */
        /* Update scratch area pointers and retry.      */
        GC_scratch_free_ptr = result;
        GC_scratch_end_ptr = GC_scratch_free_ptr + bytes_to_get;
#       ifdef USE_SCRATCH_LAST_END_PTR
          GC_scratch_last_end_ptr = GC_scratch_end_ptr;
#       endif
    }
}

/* Return an uninitialized header */
static hdr * alloc_hdr(void)
{
    hdr * result;

    GC_ASSERT(I_HOLD_LOCK());
    if (NULL == GC_hdr_free_list) {
        result = (hdr *)GC_scratch_alloc(sizeof(hdr));
    } else {
        result = GC_hdr_free_list;
        GC_hdr_free_list = (hdr *)(result -> hb_next);
    }
    return result;
}

GC_INLINE void free_hdr(hdr * hhdr)
{
    hhdr -> hb_next = (struct hblk *)GC_hdr_free_list;
    GC_hdr_free_list = hhdr;
}

#ifdef COUNT_HDR_CACHE_HITS
  /* Used for debugging/profiling (the symbols are externally visible). */
  word GC_hdr_cache_hits = 0;
  word GC_hdr_cache_misses = 0;
#endif

GC_INNER void GC_init_headers(void)
{
    unsigned i;

    GC_ASSERT(I_HOLD_LOCK());
    GC_ASSERT(NULL == GC_all_nils);
    GC_all_nils = (bottom_index *)GC_scratch_alloc(sizeof(bottom_index));
    if (GC_all_nils == NULL) {
      GC_err_printf("Insufficient memory for GC_all_nils\n");
      EXIT();
    }
    BZERO(GC_all_nils, sizeof(bottom_index));
    for (i = 0; i < TOP_SZ; i++) {
        GC_top_index[i] = GC_all_nils;
    }
}

/* Make sure that there is a bottom level index block for address addr. */
/* Return FALSE on failure.                                             */
static GC_bool get_index(word addr)
{
    word hi = (word)(addr) >> (LOG_BOTTOM_SZ + LOG_HBLKSIZE);
    bottom_index * r;
    bottom_index * p;
    bottom_index ** prev;
    bottom_index *pi; /* old_p */
    word i;

    GC_ASSERT(I_HOLD_LOCK());
#   ifdef HASH_TL
      i = TL_HASH(hi);

      pi = GC_top_index[i];
      for (p = pi; p != GC_all_nils; p = p -> hash_link) {
          if (p -> key == hi) return TRUE;
      }
#   else
      if (GC_top_index[hi] != GC_all_nils)
        return TRUE;
      i = hi;
#   endif
    r = (bottom_index *)GC_scratch_alloc(sizeof(bottom_index));
    if (EXPECT(NULL == r, FALSE))
      return FALSE;
    BZERO(r, sizeof(bottom_index));
    r -> key = hi;
#   ifdef HASH_TL
      r -> hash_link = pi;
#   endif

    /* Add it to the list of bottom indices */
      prev = &GC_all_bottom_indices;    /* pointer to p */
      pi = 0;                           /* bottom_index preceding p */
      while ((p = *prev) != 0 && p -> key < hi) {
        pi = p;
        prev = &(p -> asc_link);
      }
      r -> desc_link = pi;
      if (0 == p) {
        GC_all_bottom_indices_end = r;
      } else {
        p -> desc_link = r;
      }
      r -> asc_link = p;
      *prev = r;

      GC_top_index[i] = r;
    return TRUE;
}

GC_INNER hdr * GC_install_header(struct hblk *h)
{
    hdr * result;

    GC_ASSERT(I_HOLD_LOCK());
    if (EXPECT(!get_index((word)h), FALSE)) return NULL;

    result = alloc_hdr();
    if (EXPECT(result != NULL, TRUE)) {
      GC_ASSERT(!IS_FORWARDING_ADDR_OR_NIL(result));
      SET_HDR(h, result);
#     ifdef USE_MUNMAP
        result -> hb_last_reclaimed = (unsigned short)GC_gc_no;
#     endif
    }
    return result;
}

GC_INNER GC_bool GC_install_counts(struct hblk *h, size_t sz /* bytes */)
{
    struct hblk * hbp;

    for (hbp = h; (word)hbp < (word)h + sz; hbp += BOTTOM_SZ) {
        if (!get_index((word)hbp))
            return FALSE;
        if ((word)hbp > GC_WORD_MAX - (word)BOTTOM_SZ * HBLKSIZE)
            break; /* overflow of hbp+=BOTTOM_SZ is expected */
    }
    if (!get_index((word)h + sz - 1))
        return FALSE;
    GC_ASSERT(!IS_FORWARDING_ADDR_OR_NIL(HDR(h)));
    for (hbp = h + 1; (word)hbp < (word)h + sz; hbp++) {
        word i = (word)HBLK_PTR_DIFF(hbp, h);

        SET_HDR(hbp, (hdr *)(i > MAX_JUMP? MAX_JUMP : i));
    }
    return TRUE;
}

GC_INNER void GC_remove_header(struct hblk *h)
{
    hdr **ha;
    GET_HDR_ADDR(h, ha);
    free_hdr(*ha);
    *ha = 0;
}

GC_INNER void GC_remove_counts(struct hblk *h, size_t sz /* bytes */)
{
    struct hblk * hbp;

    if (sz <= HBLKSIZE) return;
    if (NULL == HDR(h + 1)) {
#     ifdef GC_ASSERTIONS
        for (hbp = h + 2; (word)hbp < (word)h + sz; hbp++)
          GC_ASSERT(NULL == HDR(hbp));
#     endif
      return;
    }

    for (hbp = h + 1; (word)hbp < (word)h + sz; hbp++) {
      SET_HDR(hbp, NULL);
    }
}

GC_API void GC_CALL GC_apply_to_all_blocks(GC_walk_hblk_fn fn,
                                           GC_word client_data)
{
    signed_word j;
    bottom_index * index_p;

    for (index_p = GC_all_bottom_indices; index_p != NULL;
         index_p = index_p -> asc_link) {
        for (j = BOTTOM_SZ-1; j >= 0;) {
            if (!IS_FORWARDING_ADDR_OR_NIL(index_p->index[j])) {
                if (!HBLK_IS_FREE(index_p->index[j])) {
                    (*fn)(((struct hblk *)
                              (((index_p->key << LOG_BOTTOM_SZ) + (word)j)
                               << LOG_HBLKSIZE)),
                          client_data);
                }
                j--;
             } else if (index_p->index[j] == 0) {
                j--;
             } else {
                j -= (signed_word)(index_p->index[j]);
             }
         }
     }
}

GC_INNER struct hblk * GC_next_block(struct hblk *h, GC_bool allow_free)
{
    REGISTER bottom_index * bi;
    REGISTER word j = ((word)h >> LOG_HBLKSIZE) & (BOTTOM_SZ-1);

    GC_ASSERT(I_HOLD_READER_LOCK());
    GET_BI(h, bi);
    if (bi == GC_all_nils) {
        REGISTER word hi = (word)h >> (LOG_BOTTOM_SZ + LOG_HBLKSIZE);

        bi = GC_all_bottom_indices;
        while (bi != 0 && bi -> key < hi) bi = bi -> asc_link;
        j = 0;
    }

    while (bi != 0) {
        while (j < BOTTOM_SZ) {
            hdr * hhdr = bi -> index[j];
            if (IS_FORWARDING_ADDR_OR_NIL(hhdr)) {
                j++;
            } else {
                if (allow_free || !HBLK_IS_FREE(hhdr)) {
                    return (struct hblk *)(((bi -> key << LOG_BOTTOM_SZ)
                                            + j) << LOG_HBLKSIZE);
                } else {
                    j += divHBLKSZ(hhdr -> hb_sz);
                }
            }
        }
        j = 0;
        bi = bi -> asc_link;
    }
    return NULL;
}

GC_INNER struct hblk * GC_prev_block(struct hblk *h)
{
    bottom_index * bi;
    signed_word j = ((word)h >> LOG_HBLKSIZE) & (BOTTOM_SZ-1);

    GC_ASSERT(I_HOLD_READER_LOCK());
    GET_BI(h, bi);
    if (bi == GC_all_nils) {
        word hi = (word)h >> (LOG_BOTTOM_SZ + LOG_HBLKSIZE);

        bi = GC_all_bottom_indices_end;
        while (bi != NULL && bi -> key > hi)
            bi = bi -> desc_link;
        j = BOTTOM_SZ - 1;
    }
    for (; bi != NULL; bi = bi -> desc_link) {
        while (j >= 0) {
            hdr * hhdr = bi -> index[j];

            if (NULL == hhdr) {
                --j;
            } else if (IS_FORWARDING_ADDR_OR_NIL(hhdr)) {
                j -= (signed_word)hhdr;
            } else {
                return (struct hblk*)(((bi -> key << LOG_BOTTOM_SZ) + (word)j)
                                       << LOG_HBLKSIZE);
            }
        }
        j = BOTTOM_SZ - 1;
    }
    return NULL;
}
