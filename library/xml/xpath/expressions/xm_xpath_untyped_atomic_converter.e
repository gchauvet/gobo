indexing

	description:

	"Objects that converts any xdt:untypedAtomic items in a sequence%
	%to a specified type, returning all other items unchanged"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_UNTYPED_ATOMIC_CONVERTER

inherit

	XM_XPATH_COMPUTED_EXPRESSION
		redefine
			sub_expressions, simplified_expression, promote, evaluate_item, iterator
		end

	XM_XPATH_MAPPING_FUNCTION

creation

	make

feature {NONE} -- Initialization

	make (a_sequence: XM_XPATH_EXPRESSION; a_required_type: INTEGER) is
			-- Establish invariant.
		require
			sequence_not_void: a_sequence /= Void
			target_type_valid: is_valid_type (a_required_type)
		do
			sequence := a_sequence
			target_type := a_required_type
			compute_static_properties
			initialize
		ensure
			static_properties_computed: are_static_properties_computed
			sequence_set: sequence = a_sequence
			target_type_set: target_type = a_required_type
			static_properties_computed: are_static_properties_computed
		end

feature -- Access
	
	item_type: INTEGER is
			--Determine the data type of the expression, if possible
		do
			Result := sequence.item_type
		end


	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION] is
			-- Immediate sub-expressions of `Current'
		do
			create Result.make (1)
			Result.set_equality_tester (expression_tester)
			Result.put (sequence, 1)
		end
			
feature -- Status report

	display (a_level: INTEGER; a_pool: XM_XPATH_NAME_POOL) is
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), "convert untyped atomic items to ")
			a_string := STRING_.appended_string (a_string, type_name (target_type))
			std.error.put_string (a_string)
			if is_error then
				std.error.put_string (" in error%N")
			else
				std.error.put_new_line
				sequence.display (a_level + 1, a_pool)
			end
		end

feature -- Optimization	

	simplified_expression: XM_XPATH_EXPRESSION is
			-- Simplified expression as a result of context-independent static optimizations
		local
			a_result_expression: XM_XPATH_UNTYPED_ATOMIC_CONVERTER
		do
			a_result_expression := clone (Current)
			a_result_expression.set_sequence (sequence.simplified_expression)
			if a_result_expression.sequence.is_error then
				a_result_expression.set_last_error (a_result_expression.sequence.error_value)
			end
			Result := a_result_expression
		end

	analyze (a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Perform static analysis of an expression and its subexpressions
		local
			a_type: INTEGER
		do
			mark_unreplaced
			sequence.analyze (a_context)
			if sequence.was_expression_replaced then
				set_sequence (sequence.replacement_expression)
			end
			if sequence.is_error then
				set_last_error (sequence.error_value)
			else
				a_type := sequence.item_type
				if not is_sub_type (a_type, Any_node) then
					if not (a_type = Any_item or else a_type = Atomic_type or else a_type = Untyped_atomic_type) then

						-- The sequence can't contain any untyped atomic values,
						--  so there's no need for a converter

						set_replacement (sequence)
					end
				end
			end
		end


	promote (an_offer: XM_XPATH_PROMOTION_OFFER) is
			-- Promote this subexpression.
		do
			sequence.promote (an_offer)
			if sequence.was_expression_replaced then set_sequence (sequence.replacement_expression) end
		end


feature -- Evaluation

	evaluate_item (a_context: XM_XPATH_CONTEXT) is
			-- Evaluate `Current' as a single item
		local
			an_untyped_atomic_value: XM_XPATH_UNTYPED_ATOMIC_VALUE
		do
			sequence.evaluate_item (a_context)
			if sequence.last_evaluated_item = Void then
				last_evaluated_item := Void
			elseif sequence.last_evaluated_item.is_error then
				last_evaluated_item := sequence.last_evaluated_item
			else
				an_untyped_atomic_value ?= sequence.last_evaluated_item
				if an_untyped_atomic_value /= Void then
					last_evaluated_item := an_untyped_atomic_value.convert_to_type (target_type)
				else
					last_evaluated_item := sequence.last_evaluated_item
				end
			end
		end

	iterator (a_context: XM_XPATH_CONTEXT): XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM] is
			-- An iterator over the values of a sequence
		local
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
		do
			an_iterator := sequence.iterator (a_context)
			if an_iterator.is_error then
				Result := an_iterator
			else
				create {XM_XPATH_MAPPING_ITERATOR} Result.make (an_iterator, Current, Void, Void)
			end
		end
	
	map (an_item: XM_XPATH_ITEM; a_context: XM_XPATH_CONTEXT; an_information_object: ANY): XM_XPATH_MAPPED_ITEM is
			-- Map `an_item' to a sequence
		local
			an_untyped_atomic_value: XM_XPATH_UNTYPED_ATOMIC_VALUE
		do
			an_untyped_atomic_value ?= an_item
			if an_untyped_atomic_value /= Void then
				create Result.make_item (an_untyped_atomic_value.convert_to_type (target_type))
			else
				create Result.make_item (an_item)
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted
	
	compute_cardinality is
			-- Compute cardinality.
		do
			clone_cardinality (sequence)
		end

	sequence: XM_XPATH_EXPRESSION
			-- Base expression 

	set_sequence (a_sequence: XM_XPATH_EXPRESSION) is
			-- Set `sequence'
		require
			sequence_not_void: a_sequence /= Void
		do
			sequence := a_sequence
		ensure
			sequence_set: sequence = a_sequence
		end

	target_type: INTEGER
			-- Target type 

invariant

	sequence_not_void: sequence /= Void
	target_type_valid: is_valid_type (target_type)

end
