indexing

	description:

		"Objects that implement the XPath ceiling() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_CEILING

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			evaluate_item
		end

	MA_DECIMAL_MATH

	XM_XPATH_TOKENS

creation

	make

feature {NONE} -- Initialization

	make is
			-- Establish invariant
		do
			name := "ceiling"
			minimum_argument_count := 1
			maximum_argument_count := 1
			create arguments.make (1)
			arguments.set_equality_tester (expression_tester)
			compute_static_properties
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, where known
		do
			Result := arguments.item (1).item_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE is
			-- Type of argument number `argument_number'
		do
			create Result.make_optional_number
		end

feature -- Evaluation

	evaluate_item (a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item
		local
			an_atomic_value: XM_XPATH_ATOMIC_VALUE
			a_numeric_value: XM_XPATH_NUMERIC_VALUE
			a_zero: XM_XPATH_INTEGER_VALUE
		do
			arguments.item (1).evaluate_item (a_context)
			last_evaluated_item := arguments.item (1).last_evaluated_item
			if last_evaluated_item /= Void then
				an_atomic_value ?= last_evaluated_item
				check
					is_atomic: an_atomic_value /= Void
					-- static typing
				end
				a_numeric_value ?= an_atomic_value.primitive_value
				check
					is_numeric: a_numeric_value /= Void
					-- static typing
				end
				last_evaluated_item := a_numeric_value.ceiling
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_optional
		end

end
	