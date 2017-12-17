note

	description:

		"ECF setting names"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2011-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_SETTING_NAMES

feature -- Names

	address_expression_setting_name: STRING = "address_expression"
			-- Name of setting "address_expression"
			--
			-- Values: true|false

	array_optimization_setting_name: STRING = "array_optimization"
			-- Name of setting "array_optimization"
			--
			-- Values: true|false

	automatic_backup_setting_name: STRING = "automatic_backup"
			-- Name of setting "automatic_backup"
			--
			-- Values: true|false

	check_for_void_target_setting_name: STRING = "check_for_void_target"
			-- Name of setting "check_for_void_target"
			--
			-- Values: true|false

	check_generic_creation_constraint_setting_name: STRING = "check_generic_creation_constraint"
			-- Name of setting "check_generic_creation_constraint"
			--
			-- Values: true|false

	check_vape_setting_name: STRING = "check_vape"
			-- Name of setting "check_vape"
			--
			-- Values: true|false

	console_application_setting_name: STRING = "console_application"
			-- Name of setting "console_application"
			--
			-- Values: true|false

	concurrency_setting_name: STRING = "concurrency"
			-- Name of setting "concurrency"
			--
			-- Values: none|thread|scoop
			--
			-- Note: superseded by the capability "concurrency" in ECF 1.16.0.

	cls_compliant_setting_name: STRING = "cls_compliant"
			-- Name of setting "cls_compliant"
			--
			-- Values: true|false

	dead_code_removal_setting_name: STRING = "dead_code_removal"
			-- Name of setting "dead_code_removal"
			--
			-- Values: true|false

	dotnet_naming_convention_setting_name: STRING = "dotnet_naming_convention"
			-- Name of setting "dotnet_naming_convention"
			--
			-- Values: true|false

	dynamic_runtime_setting_name: STRING = "dynamic_runtime"
			-- Name of setting "dynamic_runtime"
			--
			-- Values: true|false

	enforce_unique_class_names_setting_name: STRING = "enforce_unique_class_names"
			-- Name of setting "enforce_unique_class_names"
			--
			-- Values: true|false

	exception_trace_setting_name: STRING = "exception_trace"
			-- Name of setting "exception_trace"
			--
			-- Values: true|false

	executable_name_setting_name: STRING = "executable_name"
			-- Name of setting "executable_name"

	external_runtime_setting_name: STRING = "external_runtime"
			-- Name of setting "external_runtime"

	force_32bits_setting_name: STRING = "force_32bits"
			-- Name of setting "force_32bits"
			--
			-- Values: true|false

	il_verifiable_setting_name: STRING = "il_verifiable"
			-- Name of setting "il_verifiable"
			--
			-- Values: true|false

	inlining_setting_name: STRING = "inlining"
			-- Name of setting "inlining"
			--
			-- Values: true|false

	inlining_size_setting_name: STRING = "inlining_size"
			-- Name of setting "inlining_size"
			--
			-- Values: Integers >= 0

	java_generation_setting_name: STRING = "java_generation"
			-- Name of setting "java_generation"

	library_root_setting_name: STRING = "library_root"
			-- Name of setting "library_root"

	line_generation_setting_name: STRING = "line_generation"
			-- Name of setting "line_generation"
			--
			-- Values: true|false

	metadata_cache_path_setting_name: STRING = "metadata_cache_path"
			-- Name of setting "metadata_cache_path"

	msil_assembly_compatibility_setting_name: STRING = "msil_assembly_compatibility"
			-- Name of setting "msil_assembly_compatibility"

	msil_classes_per_module_setting_name: STRING = "msil_classes_per_module"
			-- Name of setting "msil_classes_per_module"

	msil_clr_version_setting_name: STRING = "msil_clr_version"
			-- Name of setting "msil_clr_version"

	msil_culture_setting_name: STRING = "msil_culture"
			-- Name of setting "msil_culture"

	msil_generation_setting_name: STRING = "msil_generation"
			-- Name of setting "msil_generation"
			--
			-- Values: true|false
			--
			-- Note: this was supposed to be superseded by the capability 'code'
			-- in ECF 1.16.0, but ISE does not support the capability 'code' yet
			-- and still uses the setting 'msil_generation'.

	msil_generation_type_setting_name: STRING = "msil_generation_type"
			-- Name of setting "msil_generation_type"
			--
			-- Values: exe|dll

	msil_key_file_name_setting_name: STRING = "msil_key_file_name"
			-- Name of setting "msil_key_file_name"

	msil_use_optimized_precompile_setting_name: STRING = "msil_use_optimized_precompile"
			-- Name of setting "msil_use_optimized_precompile"
			--
			-- Values: true|false

	multithreaded_setting_name: STRING = "multithreaded"
			-- Name of setting "multithreaded"
			--
			-- Values: true|false
			--
			-- Note: superseded by "concurrency" in ECF 1.7.0.

	old_feature_replication_setting_name: STRING = "old_feature_replication"
			-- Name of setting "old_feature_replication"
			--
			-- Values: true|false

	old_verbatim_strings_setting_name: STRING = "old_verbatim_strings"
			-- Name of setting "old_verbatim_strings"
			--
			-- Values: true|false

	platform_setting_name: STRING = "platform"
			-- Name of setting "msil_generation"
			--
			-- Values: windows|unix|macintosh|vxworks
			--
			-- Note: this was supposed to be superseded by the capability 'platform'
			-- in ECF 1.16.0, but ISE does not support the capability 'platform' yet
			-- and still uses the setting 'platform'.

	shared_library_definition_setting_name: STRING = "shared_library_definition"
			-- Name of setting "shared_library_definition"

	total_order_on_reals_setting_name: STRING = "total_order_on_reals"
			-- Name of setting "total_order_on_reals"
			--
			-- Values: true|false

	use_cluster_name_as_namespace_setting_name: STRING = "use_cluster_name_as_namespace"
			-- Name of setting "use_cluster_name_as_namespace"
			--
			-- Values: true|false

	use_all_cluster_name_as_namespace_setting_name: STRING = "use_all_cluster_name_as_namespace"
			-- Name of setting "use_all_cluster_name_as_namespace"
			--
			-- Values: true|false

feature -- Values

	dll_setting_value: STRING = "dll"
			-- Value "dll"
			--
			-- Used in "msil_generation_type".

	exe_setting_value: STRING = "exe"
			-- Value "exe"
			--
			-- Used in "msil_generation_type".

	false_setting_value: STRING = "false"
			-- Value "false"

	finalize_setting_value: STRING = "finalize"
			-- Value "finalize"
			--
			-- Use in condition "build"

	macintosh_setting_value: STRING = "macintosh"
			-- Value "macintosh"
			--
			-- Used in "platform".


	none_setting_value: STRING = "none"
			-- Value "none"
			--
			-- Used in "concurrency".

	scoop_setting_value: STRING = "scoop"
			-- Value "scoop"
			--
			-- Used in "concurrency".

	thread_setting_value: STRING = "thread"
			-- Value "thread"
			--
			-- Used in "concurrency".

	true_setting_value: STRING = "true"
			-- Value "true"

	unix_setting_value: STRING = "unix"
			-- Value "unix"
			--
			-- Used in "platform".

	vxworks_setting_value: STRING = "vxworks"
			-- Value "vxworks"
			--
			-- Used in "platform".

	windows_setting_value: STRING = "windows"
			-- Value "windows"
			--
			-- Used in "platform".

	workbench_setting_value: STRING = "workbench"
			-- Value "workbench"
			--
			-- Use in condition "build"

end
