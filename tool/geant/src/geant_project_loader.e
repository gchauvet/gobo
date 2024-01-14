﻿note

	description:

		"Geant project laoders"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2002-2018, Sven Ehrke and others"
	license: "MIT License"

class GEANT_PROJECT_LOADER

inherit

	ANY

	GEANT_SHARED_PROPERTIES
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_build_filename: STRING)
			-- Initialize project loader.
		require
			a_build_filename_not_void: a_build_filename /= Void
			a_build_filename_not_empty: a_build_filename.count > 0
		local
			a_absolute_pathname: STRING
			l_gobo_misc: STRING
			l_library_common_config: STRING
			l_new_build_filename: STRING
		do
			build_filename := a_build_filename
			if not file_system.is_file_readable (build_filename) then
					-- Try to see whether the file is one which was in ${GOBO}/misc
					-- and which has been moved to ${GOBO}/library/common/config.
				l_gobo_misc := Execution_environment.interpreted_string ("${GOBO}/misc/")
				if a_build_filename.starts_with (l_gobo_misc) then
					l_library_common_config := Execution_environment.interpreted_string ("${GOBO}/library/common/config/")
					l_new_build_filename := a_build_filename.twin
					l_new_build_filename.remove_head (l_gobo_misc.count)
					l_new_build_filename := l_library_common_config + l_new_build_filename
					if file_system.is_file_readable (l_new_build_filename) then
						build_filename := l_new_build_filename
					end
				end
				if build_filename = a_build_filename then
					a_absolute_pathname := file_system.absolute_pathname (
						file_system.pathname_from_file_system (build_filename, unix_file_system))
					exit_application (1, <<"cannot read build file '", a_absolute_pathname, "'">>)
				end
			end
		ensure
			build_filename_set: build_filename = a_build_filename
		end

feature -- Access

	build_filename: STRING
			-- Name of the file containing the configuration
			-- information to build a project

	project_element: detachable GEANT_PROJECT_ELEMENT
			-- Project element of build script

feature -- Processing

	load (a_variables: GEANT_PROJECT_VARIABLES; a_options: GEANT_PROJECT_OPTIONS)
			-- Read current project's configuration from `build_filename'
			-- and convert it into a 'GEANT_DOM'.
		require
			a_variables_not_void: a_variables /= Void
			a_options_not_void: a_options /= Void
		local
			a_file: KL_TEXT_INPUT_FILE
			a_project_parser: GEANT_PROJECT_PARSER
			s: STRING
	    do
			project_element := Void
			create a_file.make (build_filename.out)
			a_file.open_read
			if a_file.is_open_read then
				create a_project_parser.make (a_variables, a_options, build_filename)
				a_project_parser.parse_file (a_file)
				a_file.close
				project_element := a_project_parser.last_project_element
			else
				std.error.put_string ("cannot read file: '")
				std.error.put_string (build_filename)
				std.error.put_character ('%'')
				std.error.put_new_line
			end
			if project_element = Void then
				s := file_system.absolute_pathname (file_system.pathname_from_file_system (
					build_filename, unix_file_system))
				exit_application (1, <<"Parsing error in file '", s, "%'">>)
			end
	    end

invariant

	build_filename_not_void: build_filename /= Void
	build_filename_not_empty: build_filename.count > 0

end
