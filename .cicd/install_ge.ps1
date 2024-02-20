<#
.SYNOPSIS
	Install Gobo Eiffel tools.

.DESCRIPTION
	Install Gobo Eiffel tools.

.PARAMETER CiTool
	CI tool (azure, github, gitlab).

.PARAMETER CCompiler
	C Compiler (zig, gcc, clang, msc).

.EXAMPLE
	# Install Gobo Eiffel tools from the GitHub Actions pipeline:
	install_ge.ps1 github zig

.NOTES
	Copyright: "Copyright (c) 2021-2024, Eric Bezault and others"
	License: "MIT License"
#>

param
(
	[Parameter(Mandatory=$true)]
	[ValidateSet("azure", "github", "gitlab")] 
	[string] $CiTool,
	[Parameter(Mandatory=$true)]
	[ValidateSet("zig", "gcc", "clang", "msc")] 
	[string] $CCompiler
)

. "$PSScriptRoot/before_script.ps1" $CiTool $CCompiler

switch ($GOBO_CI_OS) {
	"linux" {
		# See limitations (Permission Loss) in https://github.com/actions/download-artifact
		Get-ChildItem "$env:GOBO/bin/ge*" | ForEach-Object {
			bash -c "chmod a+x '$_'"
		}
	}
	"macos" {
		# See limitations (Permission Loss) in https://github.com/actions/download-artifact
		Get-ChildItem "$env:GOBO/bin/ge*" | ForEach-Object {
			bash -c "chmod a+x '$_'"
		}
	}
}

gec --version
