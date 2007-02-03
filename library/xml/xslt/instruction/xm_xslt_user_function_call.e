indexing

	description:

		"Compile-time references to xsl:functions"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_USER_FUNCTION_CALL

inherit

	XM_XPATH_FUNCTION_CALL
		redefine
			pre_evaluate, evaluate_item, create_iterator, display,
			mark_tail_function_calls, compute_intrinsic_dependencies,
			is_tail_recursive, create_node_iterator
		end

	XM_XPATH_ROLE

create

	make

feature {NONE} -- Initialization

	make (a_fingerprint: INTEGER; some_arguments: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION]) is
			-- Establish invariant.
		require
			strictly_positive_fingerprint: a_fingerprint > 0
			arguments_not_void: some_arguments /= Void
		do
			arguments := some_arguments
			arguments.set_equality_tester (expression_tester)
			fingerprint := a_fingerprint
			compute_static_properties
			initialized := True
		ensure
			arguments_set: arguments = some_arguments
			fingerprint_set: fingerprint = a_fingerprint
		end

feature -- Access

	is_tail_recursive: BOOLEAN
			-- Is `Current' a tail recursive function call?

	item_type: XM_XPATH_ITEM_TYPE is
			-- Data type of the expression, where known
		do
			if static_type = Void then

				-- Not known yet

				Result := any_item
			else
				Result := static_type.primary_type
			end
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	is_type_error: BOOLEAN
			-- Has a type error been detected on an argument?

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		local
			a_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
		do
			std.error.put_string (indentation (a_level))
			std.error.put_string ("Call function ")
			std.error.put_string (expanded_name)
			if is_tail_recursive then
				std.error.put_string (" (tail call) ")
			end
			std.error.put_new_line
			a_cursor := arguments.new_cursor
			from
				a_cursor.start
			variant
				arguments.count + 1 - a_cursor.index				
			until
				a_cursor.after
			loop
				a_cursor.item.display (a_level + 1)
				a_cursor.forth
			end
		end

	compute_intrinsic_dependencies is
			-- Determine the intrinsic dependencies of an expression.
		do
			set_intrinsically_depends_upon_user_functions
		end

feature -- Status setting
	
	mark_tail_function_calls is
			-- Mark tail-recursive calls on stylesheet functions.
		do
			is_tail_recursive := True
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Iterator over the values of a sequence
		local
			l_execution_context: XM_XSLT_EVALUATION_CONTEXT
			l_value: DS_CELL [XM_XPATH_VALUE]
		do
			l_execution_context ?= a_context
			check
				execution_context: l_execution_context /= Void
				-- as this is an XSLT function
			end
			create l_value.make (Void)
			call (l_value, l_execution_context)
			if l_value.item.is_error then
				if is_node_sequence then
					create {XM_XPATH_INVALID_NODE_ITERATOR} last_iterator.make (l_value.item.error_value)
				else
					create {XM_XPATH_INVALID_ITERATOR} last_iterator.make (l_value.item.error_value)
				end
			elseif l_value.item.is_function_package then
				create {XM_XPATH_SINGLETON_ITERATOR [XM_XPATH_ITEM]} last_iterator.make (l_value.item.as_atomic_value)
			else
				l_value.item.create_iterator (Void)
				last_iterator := l_value.item.last_iterator
			end
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT) is
			-- Create an iterator over a node sequence.
		local
			l_execution_context: XM_XSLT_EVALUATION_CONTEXT
			l_value: DS_CELL [XM_XPATH_VALUE]
			l_package: XM_XSLT_FUNCTION_CALL_PACKAGE
		do
			l_execution_context ?= a_context
			check
				execution_context: l_execution_context /= Void
				-- as this is an XSLT function
			end
			create l_value.make (Void)
			call (l_value, l_execution_context)
			if l_value.item.is_error then
				create {XM_XPATH_INVALID_NODE_ITERATOR} last_node_iterator.make (l_value.item.error_value)
			elseif l_value.item.is_function_package then
				l_package ?= l_value.item
				l_package.create_node_results_iterator (l_execution_context)
				last_node_iterator := l_package.last_node_iterator
			else
				l_value.item.create_node_iterator (Void)
				last_node_iterator := l_value.item.last_node_iterator
			end
		end

	evaluate_item (a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item
		local
			l_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
			l_execution_context: XM_XSLT_EVALUATION_CONTEXT
			l_value: DS_CELL [XM_XPATH_VALUE]
		do
			l_execution_context ?= a_context
			check
				execution_context: l_execution_context /= Void
				-- as this is an XSLT function
			end
			create l_value.make (Void)
			call (l_value, l_execution_context)
			if l_value.item.is_atomic_value then
				last_evaluated_item := l_value.item.as_atomic_value
			else
				l_value.item.create_iterator (a_context)
				l_iterator := l_value.item.last_iterator
				if l_iterator.is_error then
					create {XM_XPATH_INVALID_ITEM} last_evaluated_item.make (l_iterator.error_value)
				else
					l_iterator.start
					if l_iterator.is_error then
						create {XM_XPATH_INVALID_ITEM} last_evaluated_item.make (l_iterator.error_value)
					elseif not l_iterator.after then
						last_evaluated_item := l_iterator.item
					end
				end
			end
		end

	pre_evaluate (a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Pre-evaluate `Current' at compile time.
		do
			--	do_nothing
		end

feature -- Element change

	set_static_type (a_static_type: like static_type) is
			-- Set static type.
		require
			static_type_not_void: a_static_type /= Void
		do
			static_type := a_static_type
		ensure
			static_type_set: static_type = a_static_type
		end

	set_function (a_source_function: XM_XSLT_FUNCTION; a_compiled_function: XM_XSLT_COMPILED_USER_FUNCTION; a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Create reference to callable function, and validate consitency.
		require
			source_function_not_void: a_source_function /= Void
			compiled_function_not_void: a_compiled_function /= Void
		local
			an_argument_count, an_index: INTEGER
			a_role: XM_XPATH_ROLE_LOCATOR
			a_type_checker: XM_XPATH_TYPE_CHECKER
			some_required_types: DS_ARRAYED_LIST [XM_XPATH_SEQUENCE_TYPE]
		do
			function := a_compiled_function
			some_required_types := a_source_function.argument_types
			from
				an_argument_count := a_source_function.arity; an_index := 1
			variant
				an_argument_count + 1 - an_index
			until
				is_type_error or else an_index > an_argument_count
			loop
				create a_role.make (Function_role, expanded_name, an_index, Xpath_errors_uri, "XTTE0790")
				create a_type_checker
				a_type_checker.static_type_check (a_context, arguments.item (an_index), some_required_types.item (an_index), False, a_role)
				if a_type_checker.is_static_type_check_error then
					set_last_error (a_type_checker.static_type_check_error)
					is_type_error := True
				else
					 arguments.replace (a_type_checker.checked_expression, an_index)
				end
				an_index := an_index + 1
			end
		end

feature {XM_XPATH_FUNCTION_CALL} -- Local

	check_arguments (a_context: XM_XPATH_STATIC_CONTEXT) is
			-- Check arguments during parsing, when all the argument expressions have been read.
		do
			-- These checks are in set_function, at the time when the function
			-- call is bound to an actual function.
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality is
			-- Compute cardinality.
		do
			if static_type = Void then

				-- actual type is not known yet, so we return an approximation
				
				set_cardinality_zero_or_more
			else
				set_cardinality (static_type.cardinality)
			end
		end
	
feature {NONE} -- Implementation

	static_type: XM_XPATH_SEQUENCE_TYPE
			-- Static type of returned result

	function: XM_XSLT_COMPILED_USER_FUNCTION
			-- Compiled function

	name: STRING is
			-- Local name of function
		do
			Result := shared_name_pool.local_name_from_name_code (fingerprint)
		end

	namespace_uri: STRING is
			-- Namespace uri for `name'
		do
			Result := shared_name_pool.namespace_uri_from_name_code (fingerprint)
		end

	expanded_name: STRING is
			-- Expanded name of function
		do
			if namespace_uri.is_empty then
				Result := name
			else
				Result := expanded_name_from_components (namespace_uri, name)
			end
		end

	call (a_return_value: DS_CELL [XM_XPATH_VALUE]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Call the function.
			-- Result returned as `a_return_value.item'.
		require
			a_return_value_not_void: a_return_value /= Void
			return_value_is_void: a_return_value.item = Void
			context_not_void: a_context /= Void
			fixed_up: function /= Void
		local
			l_actual_arguments: ARRAY [XM_XPATH_VALUE]
			l_function_call_package: XM_XSLT_FUNCTION_CALL_PACKAGE
			l_clean_context: XM_XSLT_EVALUATION_CONTEXT
		do
			create l_actual_arguments.make (1, arguments.count)
			process_call_loop (a_return_value, l_actual_arguments, a_context)
			if a_return_value.item /= Void then
				-- error - do nothing
			elseif is_tail_recursive then
				create l_function_call_package.make (function, l_actual_arguments, arguments.count, a_context)
				a_return_value.put (l_function_call_package)
			else
				l_clean_context := a_context.new_clean_context
				function.call (a_return_value, l_actual_arguments, arguments.count, l_clean_context, True)
			end
		ensure
			called_value_not_void: a_return_value.item /= Void -- but may be an error value
		end

	process_call_loop (a_return_value: DS_CELL [XM_XPATH_VALUE]; a_actual_arguments: ARRAY [XM_XPATH_VALUE]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Process body of `call'.
		require
			a_return_value_not_void: a_return_value /= Void
			return_value_is_void: a_return_value.item = Void
			arguments_not_void: a_actual_arguments /= Void
			corect_number_of_arguments: a_actual_arguments.count = arguments.count
			context_not_void: a_context /= Void
			fixed_up: function /= Void
		local
			l_reference_count, l_parameter_count: INTEGER
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XPATH_EXPRESSION]
			l_expression: XM_XPATH_EXPRESSION
			l_empty_sequence: XM_XPATH_EMPTY_SEQUENCE
		do
			from
				l_parameter_count := function.parameter_definitions.count
				check
					corect_number_of_parameters: l_parameter_count = arguments.count
					-- static_typing
				end
				l_cursor := arguments.new_cursor; l_cursor.start
			variant
				arguments.count + 1 - l_cursor.index
			until
				l_cursor.after
			loop
				l_expression := l_cursor.item
				l_reference_count := function.parameter_definitions.item (l_cursor.index).reference_count
				if l_expression.is_value then
					if l_expression.is_error then
						a_return_value.put (l_expression.as_value)
						l_cursor.go_after
					else
						a_actual_arguments.put (l_expression.as_value, l_cursor.index)
					end
				else

					-- determine which kind of lazy evaluation to use

					if l_reference_count = 0 then
						create l_empty_sequence.make
						a_actual_arguments.put (l_empty_sequence, l_cursor.index)
					elseif l_expression.depends_upon_user_functions then

						-- If the argument contains a call to a user-defined function, then it might be a recursive call.
                  -- It's better to evaluate it now, rather than waiting until we are on a new stack frame, as
						--  that can blow the stack if done repeatedly.

						l_expression.eagerly_evaluate (a_context)
						if l_expression.last_evaluation.is_error then
							a_return_value.put (l_expression.last_evaluation)
							l_cursor.go_after
						else
							a_actual_arguments.put (l_expression.last_evaluation, l_cursor.index)
						end						
					else
						l_expression.lazily_evaluate (a_context, l_reference_count)
						if l_expression.last_evaluation.is_error then
							a_return_value.put (l_expression.last_evaluation)
							l_cursor.go_after
						else
							a_actual_arguments.put (l_expression.last_evaluation, l_cursor.index)
						end
					end
				end
				if not l_cursor.after and then l_reference_count > 1 and then a_actual_arguments.item (l_cursor.index).is_closure and then
					not a_actual_arguments.item (l_cursor.index).is_memo_closure then
					a_actual_arguments.item (l_cursor.index).reduce
					a_actual_arguments.put (a_actual_arguments.item (l_cursor.index).last_reduced_value, l_cursor.index)
				end
				if not l_cursor.after then l_cursor.forth end
			end
		end

invariant

	strictly_positive_fingerprint: fingerprint > 0
	arguments_not_void: initialized implies arguments /= Void

end
	
