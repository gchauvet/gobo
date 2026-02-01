#!/bin/bash
#
# Build RPM package for Gobo Eiffel
#
# Usage: build_rpm.sh
#
# Copyright: "Copyright (c) 2026, Eric Bezault and others"
# License: "MIT License"
#

set -e  # Exit on error

echo "======================================"
echo "Building RPM package for Gobo Eiffel"
echo "======================================"

# Extract version from git (format YY.MM.DD)
GOBO_DATE=$(git show -s --date=format:'%y.%m.%d' --format=%cd)
if [ $? -ne 0 ]; then
	echo "Error: Failed to get git date" >&2
	exit 1
fi
echo "Version: $GOBO_DATE"

# Extract short commit SHA
GOBO_COMMIT=$(git rev-parse --short HEAD)
if [ $? -ne 0 ]; then
	echo "Error: Failed to get git commit" >&2
	exit 1
fi
echo "Commit: $GOBO_COMMIT"

# Full version name
GOBO_FULL_VERSION="$GOBO_DATE-1.$GOBO_COMMIT"
echo "Full version: $GOBO_FULL_VERSION"

# Create directory structure for rpmbuild
RPMBUILD_DIR="$HOME/rpmbuild"
mkdir -p "$RPMBUILD_DIR"/{SOURCES,SPECS,BUILD,RPMS,SRPMS}
echo "RPM build directory: $RPMBUILD_DIR"

# Create source archive from git repo
REPO_DIR=$(git rev-parse --show-toplevel)
if [ $? -ne 0 ]; then
	echo "Error: Failed to find git repository root" >&2
	exit 1
fi
echo "Repository directory: $REPO_DIR"

# Create source tarball
TARBALL="gobo-eiffel-$GOBO_DATE.tar.gz"
echo "Creating source tarball: $TARBALL"

cd "$REPO_DIR"
git archive --format=tar.gz --prefix="gobo-$GOBO_COMMIT/" -o "$RPMBUILD_DIR/SOURCES/$TARBALL" HEAD
if [ $? -ne 0 ]; then
	echo "Error: Failed to create source tarball" >&2
	exit 1
fi

echo "Source tarball created successfully"

# Copy spec file
cp "$REPO_DIR/gobo-eiffel.spec" "$RPMBUILD_DIR/SPECS/"
echo "Spec file copied to $RPMBUILD_DIR/SPECS/"

# Build RPM with defined macros
echo "Building RPM package..."
echo "Using version: $GOBO_DATE"
echo "Using commit: $GOBO_COMMIT"

# Check that rpmbuild is installed
if ! command -v rpmbuild &> /dev/null; then
	echo "Error: rpmbuild not found. Please install rpm-build package." >&2
	echo "On OpenMandriva: sudo dnf install rpm-build" >&2
	echo "On Fedora/RHEL: sudo dnf install rpm-build" >&2
	echo "On Ubuntu/Debian: sudo apt install rpm rpm-build" >&2
	exit 1
fi

# Build RPM (binary + source)
rpmbuild -ba \
	--define "version $GOBO_DATE" \
	--define "commit $GOBO_COMMIT" \
	"$RPMBUILD_DIR/SPECS/gobo-eiffel.spec"

if [ $? -ne 0 ]; then
	echo "Error: RPM build failed" >&2
	exit 1
fi

echo ""
echo "======================================"
echo "RPM build completed successfully!"
echo "======================================"
echo ""
echo "Binary RPMs located in: $RPMBUILD_DIR/RPMS/"
echo "Source RPM located in: $RPMBUILD_DIR/SRPMS/"
echo ""

# List generated packages
echo "Generated packages:"
find "$RPMBUILD_DIR/RPMS" -name "gobo-eiffel-*.rpm" -exec echo "  - {}" \;
find "$RPMBUILD_DIR/SRPMS" -name "gobo-eiffel-*.src.rpm" -exec echo "  - {}" \;

echo ""
echo "To install the package:"
echo "  sudo dnf install $RPMBUILD_DIR/RPMS/x86_64/gobo-eiffel-$GOBO_FULL_VERSION*.rpm"
echo ""

exit 0
