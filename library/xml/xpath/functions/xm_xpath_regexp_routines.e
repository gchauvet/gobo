indexing

	description:

		"Routines that support XPath regular expression functions"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_REGEXP_ROUTINES

inherit

	XM_XPATH_REGEXP_CACHE_ROUTINES

	XM_XPATH_SHARED_REGEXP_CACHE

	XM_XPATH_SHARED_EXPRESSION_TESTER

	XM_XPATH_STANDARD_NAMESPACES

	XM_XPATH_ERROR_TYPES

feature {NONE} -- Implementation

	regexp_cache_entry: XM_XPATH_REGEXP_CACHE_ENTRY
			-- Cached regular expression

	regexp_error_value: XM_XPATH_ERROR_VALUE
			-- Possible error set by `try_to_compile'

	try_to_compile (a_flag_argument_position: INTEGER; arguments: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION]) is
			-- Attempt to compile `regexp'.
		require
			flag_argument_number: a_flag_argument_position = 0
				or else ( a_flag_argument_position > 2 and then a_flag_argument_position <= arguments.count)
				arguments: arguments /= Void and then arguments.equality_tester.is_equal (expression_tester)
		local
			a_flags_string, a_key: STRING
			a_string_value: XM_XPATH_STRING_VALUE
		do
			regexp_error_value := Void
			if a_flag_argument_position = 0 then
				a_flags_string := ""
			else
				a_string_value ?= arguments.item (a_flag_argument_position)
				if a_string_value /= Void then
					a_flags_string := normalized_flags_string (a_string_value.string_value)
				end
			end
			if a_flags_string /= Void then
				a_string_value ?= arguments.item (2) -- the pattern
				if a_string_value /= Void then
					a_key := composed_key (a_string_value.string_value, a_flags_string)
					regexp_cache_entry :=  shared_regexp_cache.item (a_key)
					if regexp_cache_entry = Void then
						create regexp_cache_entry.make (a_string_value.string_value, a_flags_string)
						if regexp_cache_entry.is_error then
							regexp_cache_entry := Void
						else
							shared_regexp_cache.put (regexp_cache_entry, a_key)
						end
					end
					if regexp_cache_entry /= Void then
						if regexp_cache_entry.regexp.matches ("") then
							create regexp_error_value.make_from_string ("Regular expression matches zero-length string", Xpath_errors_uri, "FORX0003", Static_error)
						end
					end
				end
			end
		end
	
end
	
