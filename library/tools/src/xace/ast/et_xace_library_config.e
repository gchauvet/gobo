note

	description:

		"Xace libraries"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_XACE_LIBRARY_CONFIG

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new Xace library.
		do
			library_prefix := empty_prefix
		ensure
			no_library_prefix: library_prefix.count = 0
		end

feature -- Access

	name: detachable STRING
			-- Name of library

	options: detachable ET_XACE_OPTIONS
			-- Options

	clusters: detachable ET_XACE_CLUSTERS
			-- Clusters

	libraries: detachable ET_XACE_MOUNTED_LIBRARIES
			-- Mounted libraries

	library_prefix: STRING
			-- Prefix to be applied to the names of the
			-- clusters of the current library when mounted

feature -- Setting

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_options (an_options: like options)
			-- Set `options' to `an_options'.
		do
			options := an_options
		ensure
			options_set: options = an_options
		end

	set_clusters (a_clusters: like clusters)
			-- Set `a_clusters' to `clusters'.
		do
			clusters := a_clusters
			if a_clusters /= Void then
				a_clusters.set_library_prefix (library_prefix)
			end
		ensure
			clusters_set: clusters = a_clusters
		end

	set_libraries (a_libraries: like libraries)
			-- Set `libraries' to `a_libraries'.
		do
			libraries := a_libraries
		ensure
			libraries_set: libraries = a_libraries
		end

	set_library_prefix (a_prefix: like library_prefix)
			-- Set `library_prefix' to `a_prefix'.
		require
			a_prefix_not_void: a_prefix /= Void
		do
			library_prefix := a_prefix
			if attached clusters as l_clusters then
				l_clusters.set_library_prefix (library_prefix)
			end
		ensure
			library_prefix_set: library_prefix = a_prefix
		end

feature -- Basic operations

	mount_libraries
			-- Add clusters `libraries' to `clusters'.
			-- Mark these clusters as mounted.
		local
			l_clusters: like clusters
		do
			if attached libraries as l_libraries then
				l_clusters := clusters
				if l_clusters = Void then
					create l_clusters.make_empty
					clusters := l_clusters
				end
				l_libraries.mount_libraries (l_clusters)
			end
		end

	merge_libraries (a_libraries: ET_XACE_MOUNTED_LIBRARIES; an_error_handler: ET_XACE_ERROR_HANDLER)
			-- Add `libraries' to `a_libraries'.
			-- Report any error (e.g. incompatible prefixes) in `an_error_handler'.
		require
			a_libraries_not_void: a_libraries /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			if attached libraries as l_libraries then
				l_libraries.merge_libraries (a_libraries, an_error_handler)
			end
		end

	merge_externals (an_externals: ET_XACE_EXTERNALS)
			-- Merge current library's externals, and those of
			-- all clusters and subclusters, to `an_externals'.
		require
			an_externals_not_void: an_externals /= Void
		local
			a_cursor: DS_HASH_SET_CURSOR [STRING]
			a_link_cursor: DS_ARRAYED_LIST_CURSOR [STRING]
		do
			if attached options as l_options then
				a_cursor := l_options.c_compiler_options.new_cursor
				from a_cursor.start until a_cursor.after loop
					an_externals.put_c_compiler_options (a_cursor.item)
					a_cursor.forth
				end
				a_cursor := l_options.header.new_cursor
				from a_cursor.start until a_cursor.after loop
					an_externals.put_include_directory (a_cursor.item)
					a_cursor.forth
				end
				a_link_cursor := l_options.link.new_cursor
				from a_link_cursor.start until a_link_cursor.after loop
					an_externals.put_link_library (a_link_cursor.item)
					a_link_cursor.forth
				end
			end
			if attached clusters as l_clusters then
				l_clusters.merge_externals (an_externals)
			end
			if attached libraries as l_libraries then
				l_libraries.merge_externals (an_externals)
			end
		end

	merge_exported_features (an_export: DS_LIST [ET_XACE_EXPORTED_FEATURE])
			-- Merge current library's exported features and those
			-- all clusters and subclusters to `an_export'.
		require
			an_export_not_void: an_export /= Void
			no_void_export: not an_export.has_void
		do
			if attached clusters as l_clusters then
				l_clusters.merge_exported_features (an_export)
			end
		ensure
			no_void_export: not an_export.has_void
		end

feature {NONE} -- Constants

	empty_prefix: STRING = ""
			-- Empty prefix

invariant

	library_prefix_not_void: library_prefix /= Void

end
