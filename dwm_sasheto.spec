Name:           dwm
Version:        6.3
Release:        8%{?dist}
Summary:        Dynamic window manager for X
%global         _dwmsourcedir       %{_usrsrc}/dwm-user-%{version}-%{release}
Group:          User Interface/Desktops
License:        MIT
URL:            http://dwm.suckless.org/
Source0:        http://dl.suckless.org/dwm/%{name}-%{version}.tar.gz
# dwm-start script and its manpage
Source1:        dwm-start
Source2:        dwm-start.1
# Desktop files
Source3:        dwm.desktop
Source4:        dwm-user.desktop
# Fedora notes referring to dwm-user in dwm(1)
Patch1:         dwm-5.8.2-user-notes.patch
# PATCHES FOR DWM_SASHETO:
Patch2:         config.def.h_sasheto.patch
Patch3:         dwm-keypressrelease-6.3.patch
Patch4:         dwm-pertag-6.3.patch
Patch5:         dwm-gaplessgrid-6.3.patch
Patch6:         dwm-fibonacci-6.3.patch
Patch7:         dwm-xdgautostart-6.3.patch
BuildRequires:  binutils
BuildRequires:  coreutils
BuildRequires:  fontconfig-devel
BuildRequires:  gcc
BuildRequires:  libX11-devel
BuildRequires:  libxcb-devel
BuildRequires:  libXft-devel
BuildRequires:  libXinerama-devel
BuildRequires:  make
BuildRequires:  sed
Requires:       dmenu
Requires:       st


%description
dwm is a dynamic window manager for X. It manages windows in tiled, monocle and
floating layouts. All of the layouts can be applied dynamically, optimizing
the environment for the application in use and the task performed.

%package user
Summary:        Dynamic window manager sources and tools for user configuration
Group:          User Interface/Desktops
License:        MIT
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:       binutils
Requires:       coreutils
Requires:       findutils
Requires:       fontconfig-devel
Requires:       gcc
Requires:       libX11-devel
Requires:       libxcb-devel
Requires:       libXft-devel
Requires:       libXinerama-devel
Requires:       make
Requires:       patch
Requires:       redhat-rpm-config

%description user
dwm sources and dwm-start script for individual user configuration. dwm-start
reads user's header file and creates custom dwm build for user to use on
the fly.

%prep
%autosetup
# Nuke the silent build.
sed -i -e 's|\t@|\t|' Makefile
# Insert optflags
sed -i -e 's|-Os|%{optflags}|' config.mk
# No strip for debuginfo, and insert ldflags to enhance the security.
sed -i -e 's|-s ${LIBS}|%{?__global_ldflags} ${LIBS}|' config.mk
# X includedir path fix
sed -i -e 's|X11INC = .*|X11INC = %{_includedir}|' config.mk
# libdir path fix
sed -i -e 's|X11LIB = .*|X11LIB = %{_libdir}|' config.mk

%build
make %{?_smp_mflags}

%install
%make_install PREFIX="%{_prefix}"
install -m755 %{SOURCE1} %{buildroot}%{_bindir}/dwm-start
sed -i "s/version=VERSION/version=%{version}/" %{buildroot}%{_bindir}/dwm-start
sed -i "s/release=RELEASE/release=%{release}/" %{buildroot}%{_bindir}/dwm-start
install -m644 %{SOURCE2} %{buildroot}%{_mandir}/man1/dwm-start.1
sed -i "s/VERSION/%{version}/" %{buildroot}%{_mandir}/man1/dwm-start.1
sed -i "s/RELEASE/%{release}/" %{buildroot}%{_mandir}/man1/dwm-start.1
mkdir -p %{buildroot}%{_dwmsourcedir}
install -m644 -p -t %{buildroot}%{_dwmsourcedir} \
	config.def.h \
	config.mk \
	drw.c \
	drw.h \
	dwm.1 \
	dwm.c \
	dwm.png \
	Makefile \
	transient.c \
	util.c \
	util.h
mkdir -p %{buildroot}%{_datadir}/xsessions
install -m644 %{SOURCE3} %{buildroot}%{_datadir}/xsessions/dwm.desktop
install -m644 %{SOURCE4} %{buildroot}%{_datadir}/xsessions/dwm-user.desktop

%files
%license LICENSE
%doc README
%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1*
%{_datadir}/xsessions/dwm.desktop

%files user
%{_bindir}/%{name}-start
%{_mandir}/man1/%{name}-start.1*
%{_datadir}/xsessions/dwm-user.desktop
%{_dwmsourcedir}

%changelog
# Fri Oct 28 2022 sashetov's release <alexander@vassilevski.com> - 6.3
- added autostart patch on Fedora 36

* Mon Mar 28 2022 sashetov's release <alexander@vassilevski.com> - 6.3
- Rebuilt my sashetov with dwm 6.3 sources for fedora 35 with custom patches

* Thu Jul 12 2018 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-8
- Rebuilt for https://fedoraproject.org/wiki/Fedora_29_Mass_Rebuild

* Wed Feb 07 2018 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-7
- Rebuilt for https://fedoraproject.org/wiki/Fedora_28_Mass_Rebuild

* Wed Aug 02 2017 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-6
- Rebuilt for https://fedoraproject.org/wiki/Fedora_27_Binutils_Mass_Rebuild

* Wed Jul 26 2017 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-5
- Rebuilt for https://fedoraproject.org/wiki/Fedora_27_Mass_Rebuild

* Fri Feb 10 2017 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-4
- Rebuilt for https://fedoraproject.org/wiki/Fedora_26_Mass_Rebuild

* Fri Aug 12 2016 Petr Šabata <contyk@redhat.com> - 6.1-3
- The user subpackage now properly requires redhat-rpm-config

* Wed Feb 03 2016 Fedora Release Engineering <releng@fedoraproject.org> - 6.1-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_24_Mass_Rebuild

* Mon Nov 16 2015 Petr Šabata <contyk@redhat.com> - 6.1-1
- 6.1 bump
- This release uses Xft for font rendering
- Drop the Mod4 patch, use the upstream default
- The default terminal is now st
- Alter build configuration with sed rather than patches

* Thu Sep 17 2015 Petr Šabata <contyk@redhat.com> - 6.0-14
- Fix the config patch to enable full RELRO

* Thu Jun 25 2015 Petr Šabata <contyk@redhat.com> - 6.0-13
- Correct the dep list
- Modernize the spec

* Wed Jun 17 2015 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-12
- Rebuilt for https://fedoraproject.org/wiki/Fedora_23_Mass_Rebuild

* Sat Aug 16 2014 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-11
- Rebuilt for https://fedoraproject.org/wiki/Fedora_21_22_Mass_Rebuild

* Thu Jun 26 2014 Petr Šabata <contyk@redhat.com> - 6.0-10
- Minor enhancements for the dwm-start manpage

* Sat Jun 07 2014 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-9
- Rebuilt for https://fedoraproject.org/wiki/Fedora_21_Mass_Rebuild

* Wed Oct 23 2013 Petr Šabata <contyk@redhat.com> - 6.0-8
- dwm-user should require patch explicitly (#1022154)

* Fri Oct 11 2013 Petr Šabata <contyk@redhat.com> - 6.0-7
- Sort the discovered patches before applying (#1017774)

* Sat Aug 03 2013 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-6
- Rebuilt for https://fedoraproject.org/wiki/Fedora_20_Mass_Rebuild

* Wed Feb 13 2013 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-5
- Rebuilt for https://fedoraproject.org/wiki/Fedora_19_Mass_Rebuild

* Mon Jan 21 2013 Petr Šabata <contyk@redhat.com> - 6.0-4
- dwm-start: Copy the config file before applying patches (#902239)
- dwm-start: Don't overwrite the default dwm config file (#902239)
- dwm-start: Don't require a user config file for rebuilding
- dwm-start: Use $() instad of backticks

* Wed Jul 18 2012 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-3
- Rebuilt for https://fedoraproject.org/wiki/Fedora_18_Mass_Rebuild

* Fri Jan 13 2012 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 6.0-2
- Rebuilt for https://fedoraproject.org/wiki/Fedora_17_Mass_Rebuild

* Wed Dec 21 2011 Petr Šabata <contyk@redhat.com> - 6.0-1
- 6.0 bump

* Mon Jul 11 2011 Petr Sabata <contyk@redhat.com> - 5.9-1
- 5.9 bump

* Mon Jun 27 2011 Petr Sabata <contyk@redhat.com> - 5.8.2-9
- Remove now obsolete defattr
- Move dwm-start(.1) substitutions to install section since we don't want to
  modify sources in place
- Change the prefix patch to generic config patch; we now respect Fedora
  RPM_OPT_FLAGS

* Mon Apr 04 2011 Petr Sabata <psabata@redhat.com> - 5.8.2-8
- Switch to Terminus (upstream default, anyway)

* Wed Feb 09 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 5.8.2-7
- Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild

* Fri Nov 26 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-6
- dwm-start now supports user patches via ~/.dwm/patches directory
- dwm-start now supports -f option

* Thu Nov 18 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-5
- dwm-start update, rhbz#654571

* Tue Oct 19 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-4
- dwm(1) Fedora notes update

* Tue Oct 19 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-3
- dwm-start(1) fix

* Mon Oct 18 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-2
- Description spelling changed to US english
- Changed /usr/src to _usrsrc macro, dwmsourcedir changed to _dwmsourcedir
- Added BuildRequires for Xinerama and xcb
- Added dwm and dwm-users desktop files

* Fri Oct 15 2010 Petr Sabata <psabata@redhat.com> - 5.8.2-1
- New package
