indexing

	description:

		"Eiffel agent implicit argument passings at run-time.%N%
		%This is when we have 'agent f' instead of 'agent f (?)'."

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class ET_DYNAMIC_AGENT_IMPLICIT_ACTUAL_ARGUMENT

inherit

	ET_DYNAMIC_ATTACHMENT
		rename
			attachment as feature_name
		end

creation

	make

feature {NONE} -- Initialization

	make (a_type_set: like source_type_set; a_name: like feature_name;
		a_current_feature: like current_feature; a_current_type: like current_type) is
			-- Create a new agent implicit argument passing.
		require
			a_type_set_not_void: a_type_set /= Void
			a_name_not_void: a_name /= Void
			a_current_feature_not_void: a_current_feature /= Void
			a_current_type_not_void: a_current_type /= Void
		do
			source_type_set := a_type_set
			feature_name := a_name
			current_feature := a_current_feature
			current_type := a_current_type
		ensure
			source_type_set_set: source_type_set = a_type_set
			feature_name_set: feature_name = a_name
			current_feature_set: current_feature = a_current_feature
			current_type_set: current_type = a_current_type
		end

feature -- Access

	feature_name: ET_FEATURE_NAME
			-- Name of feature used with implicit argument passing

	position: ET_POSITION is
			-- Position of attachment
		do
			Result := feature_name.position
		end

	description: STRING is "agent implicit actual argument"
			-- Kind of attachment

invariant

	feature_name_not_void: feature_name /= Void

end
