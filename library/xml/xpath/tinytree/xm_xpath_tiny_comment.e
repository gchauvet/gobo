indexing

	description:

		"Tiny tree Comment nodes"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_TINY_COMMENT

inherit

	XM_XPATH_COMMENT

	XM_XPATH_TINY_NODE
		undefine
			local_part
		end

creation

	make

feature {NONE} -- Initialization

	make (a_document: XM_XPATH_TINY_DOCUMENT; a_node_number: INTEGER) is
		require
			valid_document: a_document /= Void
			valid_node_number: a_node_number > 1 and a_node_number <= a_document.last_node_added
		do
			document := a_document
			node_number := a_node_number
			node_type := Comment_node
		ensure
			document_set: document = a_document
			node_number_set: node_number = a_node_number
		end

feature -- Access

	string_value: STRING is
			-- String-value
		local
			an_index, a_length: INTEGER
		do
			an_index := document.alpha_value (node_number)
			a_length  := document.beta_value (node_number)
			Result := document.comment_buffer.substring (an_index, an_index + a_length)
		end

feature {XM_XPATH_NODE} -- Resricted

	is_possible_child: BOOLEAN is
			-- Can this node be a child of a document or element node?
		do
			Result := True
		end

end
