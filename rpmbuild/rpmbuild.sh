#!/bin/bash
RPMBUILD_DIR=`pwd`;
#make the needed dirs in rpm build dir
mkdir -p "$RPMBUILD_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS} &&
#ensure %_topdir path macro is in repo
echo "%_topdir $RPMBUILD_DIR/" > .rpmmacros && rm -f $HOME/.rpmmacros && ln -s "$RPMBUILD_DIR/.rpmmacros" $HOME/.rpmmacros &&
#download source rpms in SRPMS dir
cd SRPMS && sudo dnf download dwm-6.1-3.fc24 --source && cd .. &&
#rebuild src rpms creating rpms and sources dir
rpmbuild --rebuild SRPMS/dwm-6.1-3.fc24.src.rpm > ../logs/rebuild.log 2>&1 &&
# install the source rpms, creating spec file and sources
rpm  -ivh SRPMS/dwm-6.1-3.fc24.src.rpm > ../logs/install-source.log 2>&1 &&
#produce patch
tar -xzvf SOURCES/dwm-6.1.tar.gz && 
  mkdir a/ && mv dwm-6.1/ a/dwm-6.1/ && mkdir -p b/ && cp -ar a/dwm-6.1/ b/ && cp -a ../config.def.h b/dwm-6.1/ &&
    diff -uNr a/dwm-6.1 b/dwm-6.1 > SOURCES/modkey4-and-nofloating.patch;
#clean up
rm -rf a/ b/;
#replace spec file with one containing patch
cp -a ../dwm_sasheto.spec SPECS/dwm.spec &&
#build the patched binary rpms
rpmbuild -ba SPECS/dwm.spec > ../logs/rebuild-patched-binaries.log 2>&1
#install these with force replace for the files with the new ones
sudo rpm -i --force ./RPMS/x86_64/*.rpm
