<#
.SYNOPSIS
	Build RPM package for Gobo Eiffel.

.DESCRIPTION
	Build RPM package for Gobo Eiffel using rpmbuild with dynamic version from git.

.PARAMETER CiTool
	CI tool (azure, github, gitlab).

.EXAMPLE
	# Build Gobo Eiffel RPM from the GitHub Actions pipeline:
	build_rpm.ps1 github

.NOTES
	Copyright: "Copyright (c) 2026, Eric Bezault and others"
	License: "MIT License"
#>

param
(
	[Parameter(Mandatory=$true)]
	[ValidateSet("azure", "github", "gitlab")]
	[string] $CiTool
)

$ErrorActionPreference = "Stop"

Write-Host "======================================"
Write-Host "Building RPM package for Gobo Eiffel"
Write-Host "======================================"

# Extract version from git (format YY.MM.DD)
$GOBO_DATE = git show -s --date=format:'%y.%m.%d' --format=%cd
if ($LastExitCode -ne 0) {
	Write-Error "Failed to get git date"
	exit $LastExitCode
}
Write-Host "Version: $GOBO_DATE"

# Extract short commit SHA
$GOBO_COMMIT = git rev-parse --short HEAD
if ($LastExitCode -ne 0) {
	Write-Error "Failed to get git commit"
	exit $LastExitCode
}
Write-Host "Commit: $GOBO_COMMIT"

# Full version name
$GOBO_FULL_VERSION = "$GOBO_DATE-1.$GOBO_COMMIT"
Write-Host "Full version: $GOBO_FULL_VERSION"

# Create directory structure for rpmbuild
$HOME = $env:HOME
if (-not $HOME) {
	$HOME = "~"
}
$RPMBUILD_DIR = "$HOME/rpmbuild"
New-Item -ItemType Directory -Force -Path "$RPMBUILD_DIR/SOURCES" | Out-Null
New-Item -ItemType Directory -Force -Path "$RPMBUILD_DIR/SPECS" | Out-Null
New-Item -ItemType Directory -Force -Path "$RPMBUILD_DIR/BUILD" | Out-Null
New-Item -ItemType Directory -Force -Path "$RPMBUILD_DIR/RPMS" | Out-Null
New-Item -ItemType Directory -Force -Path "$RPMBUILD_DIR/SRPMS" | Out-Null

Write-Host "RPM build directory: $RPMBUILD_DIR"

# Create source archive from git repo
# Use current directory as base
$REPO_DIR = git rev-parse --show-toplevel
if ($LastExitCode -ne 0) {
	Write-Error "Failed to find git repository root"
	exit $LastExitCode
}
Write-Host "Repository directory: $REPO_DIR"

# Create source tarball
$TARBALL = "gobo-eiffel-$GOBO_DATE.tar.gz"
Write-Host "Creating source tarball: $TARBALL"

Push-Location $REPO_DIR
try {
	# Create archive from git (includes only tracked files)
	git archive --format=tar.gz --prefix="gobo-$GOBO_COMMIT/" -o "$RPMBUILD_DIR/SOURCES/$TARBALL" HEAD
	if ($LastExitCode -ne 0) {
		Write-Error "Failed to create source tarball"
		exit $LastExitCode
	}
} finally {
	Pop-Location
}

Write-Host "Source tarball created successfully"

# Copy spec file
Copy-Item "$REPO_DIR/gobo-eiffel.spec" "$RPMBUILD_DIR/SPECS/" -Force
Write-Host "Spec file copied to $RPMBUILD_DIR/SPECS/"

# Build RPM with defined macros
Write-Host "Building RPM package..."
Write-Host "Using version: $GOBO_DATE"
Write-Host "Using commit: $GOBO_COMMIT"

# Check that rpmbuild is installed
$rpmbuildPath = Get-Command rpmbuild -ErrorAction SilentlyContinue
if (-not $rpmbuildPath) {
	Write-Error "rpmbuild not found. Please install rpm-build package."
	Write-Host "On OpenMandriva: sudo dnf install rpm-build"
	Write-Host "On Fedora/RHEL: sudo dnf install rpm-build"
	Write-Host "On Ubuntu/Debian: sudo apt install rpm rpm-build"
	exit 1
}

# Build RPM (binary + source)
rpmbuild -ba `
	--define "version $GOBO_DATE" `
	--define "commit $GOBO_COMMIT" `
	"$RPMBUILD_DIR/SPECS/gobo-eiffel.spec"

if ($LastExitCode -ne 0) {
	Write-Error "RPM build failed"
	exit $LastExitCode
}

Write-Host ""
Write-Host "======================================"
Write-Host "RPM build completed successfully!"
Write-Host "======================================"
Write-Host ""
Write-Host "Binary RPMs located in: $RPMBUILD_DIR/RPMS/"
Write-Host "Source RPM located in: $RPMBUILD_DIR/SRPMS/"
Write-Host ""

# Lister les RPMs créés
Write-Host "Generated packages:"
Get-ChildItem -Path "$RPMBUILD_DIR/RPMS" -Recurse -Filter "gobo-eiffel-*.rpm" | ForEach-Object {
	Write-Host "  - $($_.FullName)"
}
Get-ChildItem -Path "$RPMBUILD_DIR/SRPMS" -Filter "gobo-eiffel-*.src.rpm" | ForEach-Object {
	Write-Host "  - $($_.FullName)"
}

Write-Host ""
Write-Host "To install the package:"
Write-Host "  sudo dnf install $RPMBUILD_DIR/RPMS/x86_64/gobo-eiffel-$GOBO_FULL_VERSION*.rpm"
Write-Host ""

exit 0
