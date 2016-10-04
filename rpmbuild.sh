#!/bin/bash
SRC_DIR=`readlink -f .`
LOGS_DIR="${SRC_DIR}/logs"
RPMBUILD_DIR="${SRC_DIR}/RPMBUILD";

#make the needed dirs
mkdir l
mkdir -p "$RPMBUILD_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS} &&
  #ensure %_topdir path macro is in repo
  echo "%_topdir $RPMBUILD_DIR/" > .rpmmacros && 
  rm -f $HOME/.rpmmacros && 
  ln -s "$RPMBUILD_DIR/.rpmmacros" $HOME/.rpmmacros &&
  #download source rpms in SRPMS dir
  cd $RPMBUILD_DIR/SRPMS &&
  sudo dnf download dwm-6.1-3.fc24 --source &&
  cd .. &&
  #rebuild src rpms creating rpms and sources dir
  rpmbuild --rebuild $RPMBUILD_DIR/SRPMS/dwm-6.1-3.fc24.src.rpm  > \
   ${LOGS_DIR}/rebuild.log 2>&1 &&
  # install the source rpms, creating spec file and sources
  rpm  -ivh $RPMBUILD_DIR/SRPMS/dwm-6.1-3.fc24.src.rpm > ${LOGS_DIR}/install-source.log 2>&1 &&
  # produce te correct format patch..
  tar -xzvf $RPMBUILD_DIR/SOURCES/dwm-6.1.tar.gz &&
  mkdir a/ && mv dwm-6.1/ a/dwm-6.1/ &&
  mkdir b/ && cp -ar a/dwm-6.1/ b/ &&
  # TODO: generalize this
  cp -a ../config.def.h b/dwm-6.1/ &&
  diff -uNr a/dwm-6.1 b/dwm-6.1 \
> $RPMBUILD_DIR/SOURCES/dmw_sasheto.patch;

#clean up
rm -rf a/ b/;

#replace spec file with one containing patch
cp -a ${SRC_DIR}/dwm_sasheto.spec ${RPMBUILD_DIR}/SPECS/dwm.spec &&

#build the patched binary rpms
rpmbuild -ba ${RPMBUILD_DIR}/SPECS/dwm.spec > ${LOGS_DIR}/rebuild-patched-binaries.log 2>&1
