indexing

	description:

		"Eiffel comma-separated lists of class names"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class ET_CLASS_NAME_LIST

inherit

	ET_AST_LIST [ET_CLASS_NAME_ITEM]
	ET_SHARED_CLASS_NAME_TESTER
	ET_SHARED_TOKEN_CONSTANTS

creation

	make, make_with_capacity

feature -- Access

	class_name (i: INTEGER): ET_CLASS_NAME is
			-- Class name at index `i' in list
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		do
			Result := item (i).class_name
		ensure
			class_name_not_void: Result /= Void
		end

feature -- Status report

	is_none: BOOLEAN is
			-- Does current client list only contain the
			-- class name "NONE"?
		do
			if count = 1 then
				Result := class_name (1).same_class_name (tokens.none_class_name)
			end
		end

	has (a_name: like class_name): BOOLEAN is
			-- Does `a_name' appear in current list?
		require
			a_name_not_void: a_name /= Void
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				if class_name_tester.test (a_name, class_name (i)) then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

	has_class (a_class: ET_CLASS): BOOLEAN is
			-- Does the name of `a_class' appear in current list?
		require
			a_class_not_void: a_class /= Void
		do
			Result := has (a_class.name)
		end

	has_descendant (a_class: ET_CLASS; a_processor: ET_AST_PROCESSOR): BOOLEAN is
			-- Is `a_class' a descendant of any of classes in list?
			-- True if `a_class' is NONE, even if current list is empty.
			-- (Note: Use `a_processor' on the classes whose ancestors
			-- need to be built in order to check for descendants.)
		require
			a_class_not_void: a_class /= Void
			a_processor_not_void: a_processor /= Void
		local
			i, nb: INTEGER
			a_name: ET_CLASS_NAME
			a_universe: ET_UNIVERSE
		do
			a_universe := a_processor.universe
			if a_class = a_universe.none_class then
					-- NONE is a descendant of all classes.
				Result := True
			else
					-- Search ancestors of `a_class' first to make sure that if
					-- `a_class' is a descendant of any class in list then this
					-- class is in the universe (it is possible to specify class
					-- names in client clauses which are not in the universe).
				if not a_class.is_preparsed then
					a_universe.preparse
				end
				if not a_class.is_preparsed then
					Result := has_class (a_class)
				else
					a_class.process (a_processor)
					if a_class.ancestors_built and then not a_class.has_ancestors_error then
						nb := count
						from i := 1 until i > nb loop
							a_name := class_name (i)
							if a_universe.has_class (a_name) then
								if a_class.has_ancestor (a_universe.eiffel_class (a_name), a_universe) then
									Result := True
									i := nb + 1 -- Jump out of the loop.
								else
									i := i + 1
								end
							else
								i := i + 1
							end
						end
					end
				end
			end
		end

feature -- Comparison

	same_class_names (other: ET_CLASS_NAME_LIST): BOOLEAN is
			-- Do current list and `other' contain the same set of class names?
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER
		do
			if other = Current then
				Result := True
			else
				Result := True
				nb := count
				from i := 1 until i > nb loop
					if not other.has (class_name (i)) then
						Result := False
						i := nb + 1 -- Jump out of the loop.
					else
						i := i + 1
					end
				end
				if Result then
					nb := other.count
					from i := 1 until i > nb loop
						if not has (other.class_name (i)) then
							Result := False
							i := nb + 1 -- Jump out of the loop.
						else
							i := i + 1
						end
					end
				end
			end
		end

feature -- Element change

	extend_first (other: ET_CLASS_NAME_LIST) is
			-- Add class names of `other' to current list.
		require
			other_not_void: other /= Void
			not_full: count + other.count <= capacity
		local
			i, nb: INTEGER
		do
			nb := other.count
			from i := 1 until i > nb loop
				put_first (other.item (i))
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	fixed_array: KL_SPECIAL_ROUTINES [ET_CLASS_NAME_ITEM] is
			-- Fixed array routines
		once
			create Result
		end

end
