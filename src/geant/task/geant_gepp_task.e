indexing

	description:

		"Gepp tasks"

	library:    "Gobo Eiffel Ant"
	author:     "Sven Ehrke <sven.ehrke@sven-ehrke.de>"
	copyright:  "Copyright (c) 2001, Sven Ehrke and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"


class GEANT_GEPP_TASK

inherit

	GEANT_TASK
		rename
			make as task_make
		redefine
			make_from_element
		end

	GEANT_GEPP_COMMAND
		select
			make
		end

creation

	make_from_element

feature {NONE} -- Initialization

	make_from_element (a_project: GEANT_PROJECT; an_element: GEANT_ELEMENT) is
			-- Create a new task with information held in `an_element'.
		local
			a_value: STRING
			define_elements: DS_ARRAYED_LIST [GEANT_ELEMENT]
			define_element: GEANT_ELEMENT
			i, nb: INTEGER
		do
			precursor (a_project, an_element)
			if has_uc_attribute (an_element, Input_filename_attribute_name) then
				a_value := uc_attribute_value (an_element, Input_filename_attribute_name).out
				if a_value.count > 0 then
					set_input_filename (a_value)
				end
			end
			if has_uc_attribute (an_element, Output_filename_attribute_name) then
				a_value := uc_attribute_value (an_element, Output_filename_attribute_name).out
				if a_value.count > 0 then
					set_output_filename (a_value)
				end
			end
			define_elements := an_element.children_by_name (Define_element_name)
			nb := define_elements.count
			from i := 1 until i > nb loop
				define_element := define_elements.item (i)
				if has_uc_attribute (define_element, Name_attribute_name) then
					a_value := uc_attribute_value (define_element, Name_attribute_name).out
					defines.force_last(a_value)
				end
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Input_filename_attribute_name: UC_STRING is
			-- Name of xml attribute for input_filename
		once
			!! Result.make_from_string ("inputfile")
		ensure
			attribute_name_not_void: Result /= Void
			atribute_name_not_empty: not Result.empty
		end

	Output_filename_attribute_name: UC_STRING is
			-- Name of xml attribute for output_filename
		once
			!! Result.make_from_string ("outputfile")
		ensure
			attribute_name_not_void: Result /= Void
			atribute_name_not_empty: not Result.empty
		end

	Define_element_name: UC_STRING is
			-- Name of xml subelement for defines
		once
			!! Result.make_from_string ("define")
		ensure
			attribute_name_not_void: Result /= Void
			atribute_name_not_empty: not Result.empty
		end

end -- class GEANT_GEPP_TASK
