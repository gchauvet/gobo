indexing

	description:

		"Move commands"

	library:    "Gobo Eiffel Ant"
	author:     "Sven Ehrke <sven.ehrke@sven-ehrke.de>"
	copyright:  "Copyright (c) 2001, Sven Ehrke and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"


class GEANT_MOVE_COMMAND

inherit

	GEANT_COMMAND

creation

	make

feature -- Status report

	is_to_file_executable: BOOLEAN is
			-- Can command be executed on a file?
		do
			Result := to_file /= Void and then to_file.count > 0
		ensure
			to_file_not_void: Result implies to_file /= Void
			to_file_not_empty: Result implies to_file.count > 0
		end

	is_to_directory_executable: BOOLEAN is
			-- Can command be executed on a to_directory?
		do
			Result := to_directory /= Void and then to_directory.count > 0
		ensure
			to_directory_not_void: Result implies to_directory /= Void
			to_directory_not_empty: Result implies to_directory.count > 0
		end

	is_executable: BOOLEAN is
			-- Can command be executed?
		do
			Result := is_to_file_executable xor is_to_directory_executable
		ensure then
			file_xor_directory: Result implies (is_to_file_executable xor is_to_directory_executable)
		end

feature -- Access

	file: STRING
			-- Name of source file to copy

	to_file: STRING
			-- Name of destination file for copy

	to_directory: STRING
			-- Name of destination directory for copy

feature -- Setting

	set_file (a_file: like file) is
			-- Set `file' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_not_empty: a_file.count > 0
		do
			file := a_file
		ensure
			file_set: file = a_file
		end

	set_to_file (a_to_file: like to_file) is
			-- Set `to_file' to `a_to_file'.
		require
			a_to_file_not_void: a_to_file /= Void
			a_to_file_not_empty: a_to_file.count > 0
		do
			to_file := a_to_file
		ensure
			to_file_set: to_file = a_to_file
		end

	set_to_directory (a_to_directory: like to_directory) is
			-- Set `to_directory' to `a_to_directory'.
		require
			a_to_directory_not_void: a_to_directory /= Void
			a_to_directory_not_empty: a_to_directory.count > 0
		do
			to_directory := a_to_directory
		ensure
			to_directory_set: to_directory = a_to_directory
		end

feature -- Execution

	execute is
			-- Execute command.
		local
			a_to_file: STRING
			a_basename: STRING
			old_name, new_name: STRING
		do
			exit_code := 0
			if is_to_directory_executable then
				a_basename := unix_file_system.basename (file)
				a_to_file := unix_file_system.pathname (to_directory, a_basename)

			else
				check is_to_file_executable: is_to_file_executable end
				a_to_file := to_file
			end
			old_name := file_system.pathname_from_file_system (file, unix_file_system)
			new_name := file_system.pathname_from_file_system (a_to_file, unix_file_system)
			trace ("  [move] " + old_name + " to " + new_name + "%N")
				-- Check that source file exists:
			if not file_system.file_exists (old_name) then
				log ("  [move] error: cannot find file '" + old_name + "'%N")
				exit_code := 1
			else
				file_system.rename_file (old_name, new_name)
				if not file_system.file_exists (new_name) then
						-- The new file has not been created.
					log ("  [move] error: cannot move file '" + old_name + "' to file '" + new_name + "'%N")
					exit_code := 1
				elseif file_system.file_exists (old_name) then
					if not file_system.same_physical_file (old_name, new_name) then
							-- The old file has not been removed.
						log ("  [move] error: cannot remove file '" + old_name + "'%N")
						exit_code := 1
					end
				end
			end
		end

end -- class GEANT_MOVE_COMMAND
