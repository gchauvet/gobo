indexing

	description:

		"Eiffel creation instructions at run-time"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class ET_DYNAMIC_CREATION_INSTRUCTION

inherit

	ET_DYNAMIC_ATTACHMENT

creation

	make

feature {NONE} -- Initialization

	make (a_type: like source_type; a_creation: like creation_instruction;
		a_current_feature: like current_feature; a_current_type: like current_type) is
			-- Create a new creation instruction.
		require
			a_type_not_void: a_type /= Void
			a_creation_not_void: a_creation /= Void
			a_current_feature_not_void: a_current_feature /= Void
			a_current_type_not_void: a_current_type /= Void
		do
			source_type := a_type
			creation_instruction := a_creation
			current_feature := a_current_feature
			current_type := a_current_type
		ensure
			source_type_set: source_type = a_type
			creation_instruction_set: creation_instruction = a_creation
			current_feature_set: current_feature = a_current_feature
			current_type_set: current_type = a_current_type
		end

feature -- Access

	creation_instruction: ET_CREATION_INSTRUCTION
			-- Creation instruction

	position: ET_POSITION is
			-- Position of attachment
		do
			Result := creation_instruction.target.position
		end

feature -- Duplication

	cloned_attachment: like Current is
			-- Cloned version of current attachment
		do
			create Result.make (source_type, creation_instruction, current_feature, current_type)
		end

invariant

	creation_instruction_not_void: creation_instruction /= Void

end
