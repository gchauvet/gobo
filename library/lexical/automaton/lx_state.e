indexing

	description:

		"States of finite automata"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class LX_STATE

inherit

	ANY -- Needed for SE 2.1b1.

	KL_CLONABLE

feature -- Status report

	is_accepting: BOOLEAN is
			-- Is current state an accepting state?
		deferred
		end

end
