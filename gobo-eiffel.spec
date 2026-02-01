# Spec file for Gobo Eiffel - Compatible with OpenMandriva, Fedora, RHEL
# Dynamic version from git: can be overridden with --define "version YY.MM.DD"
# On OpenMandriva: uses Clang (preferred compiler), other distributions use GCC
# Build: sudo dnf install rpm-build && ./.cicd/build_rpm.sh
%{!?version: %global version %(git show -s --date=format:'%y.%m.%d' --format=%cd 2>/dev/null || echo "26.02.01")}
%{!?commit: %global commit %(git rev-parse --short HEAD 2>/dev/null || echo "snapshot")}

# Disable debug packages (no debug sources in Eiffel compiled code)
%global debug_package %{nil}

Name:           gobo-eiffel
Version:        %{version}
Release:        1.%{commit}%{?dist}
Summary:        Portable Eiffel tools and libraries
Group:          Development/Eiffel
License:        MIT
URL:            https://www.gobosoft.com/
# Source from GitHub - the pipeline already clones the repo so Source0 is optional
Source0:        https://github.com/gobo-eiffel/gobo/archive/%{commit}.tar.gz#/%{name}-%{version}.tar.gz

# OpenMandriva prefers Clang, other distributions use GCC
%if 0%{?is_openmandriva}
BuildRequires:  clang
Requires:       clang
# OpenMandriva uses lib64gc-devel on x86_64
%ifarch x86_64 aarch64
BuildRequires:  lib64gc-devel
%else
BuildRequires:  gc-devel
%endif
%else
BuildRequires:  gcc
Requires:       gcc
# Other distributions can use pkgconfig
BuildRequires:  pkgconfig(bdw-gc)
%endif
BuildRequires:  make
# Required for Gobo bootstrap
BuildRequires:  bash
BuildRequires:  coreutils
BuildRequires:  sed
# On OpenMandriva, use lib64gc or gc depending on architecture
%if 0%{?is_openmandriva}
%ifarch x86_64 aarch64
Requires:       lib64gc
%else
Requires:       gc
%endif
%else
Requires:       pkgconfig(bdw-gc)
%endif

%description
The Gobo Eiffel Project provides the Eiffel community with free and 
portable Eiffel tools and libraries. The package includes:

Libraries:
- Argument Library (command-line parsing)
- Kernel Library (portable kernel classes)
- Structure Library (data structures)
- Lexical Library (lexical analyzers)
- Parse Library (parsing tools)
- Pattern Library (design patterns)
- Regexp Library (regular expressions)
- Math Library (mathematical functions)
- String Library (string handling)
- Test Library (testing framework)
- Time Library (date and time)
- Tools Library (development tools)
- Utility Library (utility classes)
- XML Library (XML processing)

Tools:
- gec (Gobo Eiffel Compiler)
- geant (Gobo Eiffel Ant - build tool)
- gelex (Gobo Eiffel Lex - lexical analyzer generator)
- geyacc (Gobo Eiffel Yacc - parser generator)
- getest (Gobo Eiffel Test - testing tool)
- gexslt (Gobo Eiffel XSLT Processor)
- gelint (Gobo Eiffel Lint - code analyzer)
- gepp (Gobo Eiffel Preprocessor)
- gedoc (Gobo Eiffel Documentation generator)
- gecop (Gobo Eiffel Code Pretty-printer)

%package devel
Summary:        Development files for GOBO Eiffel
Group:          Development/Eiffel
Requires:       %{name} = %{version}-%{release}

%description devel
This package contains the Eiffel library sources and configuration files
needed to develop applications using GOBO Eiffel libraries.

%package doc
Summary:        Documentation for GOBO Eiffel
Group:          Documentation
BuildArch:      noarch

%description doc
This package contains the documentation for GOBO Eiffel libraries and tools.

%prep
# Note: when building from the pipeline, this step can be omitted
# as the source code is already cloned by CI/CD
%setup -q -n gobo-%{commit}

%build
# Set GOBO environment variables (consistent with CI/CD pipeline)
export GOBO=%{_builddir}/gobo-%{commit}
export PATH=$GOBO/bin:$PATH
export GOBO_CLI_GC=no
export GOBO_CLI_THREAD=0

# Bootstrap and build
# OpenMandriva uses Clang (preferred compiler), others use GCC
chmod +x bin/install.sh
%if 0%{?is_openmandriva}
./bin/install.sh clang
%else
./bin/install.sh gcc
%endif

# Verify that gec works
bin/gec --version --verbose

%install
# Create directory structure
install -d %{buildroot}%{_bindir}
install -d %{buildroot}%{_includedir}/gobo
install -d %{buildroot}%{_libdir}/gobo
install -d %{buildroot}%{_docdir}/%{name}

# Install binaries directly in /usr/bin (like gcc, make, etc.)
for tool in gec geant gelex geyacc getest gexslt gelint gepp gedoc gecop gecc; do
    if [ -f bin/$tool ]; then
        install -m 755 bin/$tool %{buildroot}%{_bindir}/$tool
    fi
done

# Install Eiffel clusters in /usr/include/gobo (similar to C headers)
# Each library gets its own directory structure
for lib in library/*; do
    if [ -d "$lib" ]; then
        libname=$(basename "$lib")
        # Copy the entire library structure preserving the cluster hierarchy
        cp -a "$lib" %{buildroot}%{_includedir}/gobo/
    fi
done

# Install library configuration files (ECF files)
find library -name "*.ecf" -exec install -D -m 644 {} %{buildroot}%{_libdir}/gobo/{} \;

# Install tools source for development (in /usr/lib/gobo for runtime resources)
cp -a tool %{buildroot}%{_libdir}/gobo/

# Install documentation files
install -m 644 History.md %{buildroot}%{_docdir}/%{name}/
install -m 644 Release_notes.md %{buildroot}%{_docdir}/%{name}/
# HTML versions if they exist
[ -f History.html ] && install -m 644 History.html %{buildroot}%{_docdir}/%{name}/
[ -f index.html ] && install -m 644 index.html %{buildroot}%{_docdir}/%{name}/

# Note: There's no example/ directory in the repository
# Examples would need to be created separately if needed

# Create environment setup script
install -d %{buildroot}%{_sysconfdir}/profile.d
cat > %{buildroot}%{_sysconfdir}/profile.d/gobo.sh << 'EOF'
# GOBO Eiffel environment variables
export GOBO=/usr
export GOBO_EIFFEL=%{_includedir}/gobo
export GOBO_LIBRARY=%{_includedir}/gobo
EOF
chmod 644 %{buildroot}%{_sysconfdir}/profile.d/gobo.sh

%files
%license License.txt
%doc Readme.md History.md
%{_bindir}/gec
%{_bindir}/geant
%{_bindir}/gelex
%{_bindir}/geyacc
%{_bindir}/getest
%{_bindir}/gexslt
%{_bindir}/gelint
%{_bindir}/gepp
%{_bindir}/gedoc
%{_bindir}/gecop
%{_bindir}/gecc
%{_libdir}/gobo/tool/
%config(noreplace) %{_sysconfdir}/profile.d/gobo.sh

%files devel
%{_includedir}/gobo/
%{_libdir}/gobo/library/

%files doc
%{_docdir}/%{name}/

%changelog
* Sat Jan 25 2025 Gobo CI/CD Pipeline <gobo-eiffel@github.com> - 26.02.01-1
- Version built automatically by CI/CD pipeline
- Dynamic versioning based on git (YY.MM.DD+commit)
- Integration with GitHub Actions and GitLab CI
- Spec file optimized for pipeline build
- OpenMandriva compatibility (lib64gc support, Clang compiler)
- Uses Clang on OpenMandriva (preferred compiler), GCC on other distributions
- Includes all GOBO Eiffel libraries and tools
- Added support for GOBO environment variables
