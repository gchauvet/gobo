indexing

	description:

		"Objects that represent XML tree parsers"

	library:	"Gobo Eiffel XML Library"
	author:		"Andreas Leitner <nozone@sbox.tugraz.at>"
	copyright:	"Copyright (c) 2001, Andreas Leitner and others"
	license:	"Eiffel Forum Freeware License v1 (see forum.txt)"
	date:		"$Date$"
	revision:	"$Revision$"

class XM_TREE_PARSER

inherit

	XM_PARSER
		redefine
			implementation
		end

creation

	make_from_implementation

feature {ANY} -- Access

	document: XM_DOCUMENT is
			-- Returns the document that has been generated by the parser.
		do
			Result := implementation.document
		end

	is_position_table_enabled: BOOLEAN is
			-- Will this parser generate a position table while 
			-- parsing an XML document?
		do
			Result := implementation.is_position_table_enabled
		end

	last_position_table: XM_POSITION_TABLE is
			-- Returns the last generated position table, which maps 
			-- xml nodes to their exact location in the source document.
		do
			Result := implementation.last_position_table
		end

feature {ANY} -- Basic opertations

	enable_position_table is
			-- Enable the creation of a position table while parsing 
			-- a document.
		do
			implementation.enable_position_table
		end

	disable_position_table is
			-- Disable the creation of a position table while parsing 
			-- a document.
		do
			implementation.disable_position_table
		end

feature {NONE} -- Implementation

	implementation: XI_TREE_PARSER

end -- class XM_TREE_PARSER
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999	Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------

