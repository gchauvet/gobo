indexing

	description:

		"Strings as source of XML documents"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_STRING_SOURCE

inherit

	XM_SOURCE

feature -- Output

	out: STRING is
			-- Textual representation
		once
			Result := "STRING"
		end
	
end
