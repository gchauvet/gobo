indexing

	description:

		"Gobo Eiffel Lex: lexical analyzer generator"

	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1998, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class GELEX

inherit

	KL_SHARED_INPUT_STREAM_ROUTINES

	KL_SHARED_OUTPUT_STREAM_ROUTINES

	KL_SHARED_STANDARD_FILES

	KL_SHARED_EXCEPTIONS

	KL_SHARED_ARGUMENTS

creation

	execute

feature -- Processing

	execute is
			-- Start 'gelex' execution.
		local
			command_line: GELEX_COMMAND_LINE
		do
			Arguments.set_program_name ("gelex")
			!! error_handler.make_standard
			!! description.make
			!! command_line.make (error_handler)
			command_line.read_options (description)
			parse_input_file
			build_dfa
			print_scanner
			print_backing_up_report
		end

	parse_input_file is
			-- Parse input file.
		local
			parser: LX_LEX_PARSER
			filename: STRING
			a_file: like INPUT_STREAM_TYPE
			cannot_read: UT_CANNOT_READ_FILE_ERROR
		do
			!! parser.make_from_description (description, error_handler)
			filename := description.input_filename
			if filename /= Void then
				a_file := INPUT_STREAM_.make_file_open_read (filename)
				if INPUT_STREAM_.is_open_read (a_file) then
					parser.parse_file (a_file)
					INPUT_STREAM_.close (a_file)
				else
					!! cannot_read.make (filename)
					error_handler.report_error (cannot_read)
					Exceptions.die (1)
				end
			else
				parser.parse_file (std.input)
			end
			if not parser.successful then
				Exceptions.die (1)
			end
			description := parser.to_description
		end

	build_dfa is
			-- Build `dfa'.
		local
			compressed_dfa: LX_COMPRESSED_DFA
			rules: DS_ARRAYED_LIST [LX_RULE]
			an_error: LX_DANGEROUS_TRAILING_CONTEXT_ERROR
			a_filename: STRING
			i, nb: INTEGER
		do
			if description.full_table then
				!LX_FULL_DFA! dfa.make (description)
			else
				!! compressed_dfa.make (description)
				if not description.no_warning then
						-- Emit a warning message if rules contain
						-- "dangerous" variable trailing context.
					a_filename := description.input_filename
					if a_filename = Void then
						a_filename := "standard input"
					end
					rules := compressed_dfa.dangerous_variable_trail_rules
					nb := rules.count
					from i := 1 until i > nb loop
						!! an_error.make (a_filename, rules.item (i).line_nb)
						error_handler.report_warning (an_error)
						i := i + 1
					end
				end
				dfa := compressed_dfa
			end
		ensure
			dfa_not_void: dfa /= Void
		end

	print_scanner is
			-- Print scanner.
		require
			dfa_not_void: dfa /= Void
		local
			filename: STRING
			a_file: like OUTPUT_STREAM_TYPE
			cannot_write: UT_CANNOT_WRITE_TO_FILE_ERROR
		do
			filename := description.output_filename
			if filename /= Void then
				a_file := OUTPUT_STREAM_.make_file_open_write (filename)
				if OUTPUT_STREAM_.is_open_write (a_file) then
					dfa.print_scanner (a_file)
					OUTPUT_STREAM_.close (a_file)
				else
					!! cannot_write.make (filename)
					error_handler.report_error (cannot_write)
					Exceptions.die (1)
				end
			else
				dfa.print_scanner (std.output)
			end
		end

	print_backing_up_report is
			-- Print backing up report.
		require
			dfa_not_void: dfa /= Void
		local
			filename: STRING
			a_file: like OUTPUT_STREAM_TYPE
			cannot_write: UT_CANNOT_WRITE_TO_FILE_ERROR
		do
			if description.backing_up_report then
				filename := description.backing_up_filename
				if filename /= Void then
					a_file := OUTPUT_STREAM_.make_file_open_write (filename)
					if OUTPUT_STREAM_.is_open_write (a_file) then
						dfa.print_backing_up_report (a_file)
						OUTPUT_STREAM_.close (a_file)
					else
					!! cannot_write.make (filename)
					error_handler.report_error (cannot_write)
					Exceptions.die (1)
					end
				else
					dfa.print_backing_up_report (std.output)
				end
			end
		end

feature -- Access

	description: LX_DESCRIPTION
			-- Scanner description

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	dfa: LX_GENERATABLE_DFA 
			-- Generated DFA

invariant

	description_not_void: description /= Void
	error_handler_not_void: error_handler /= Void

end -- class GELEX
