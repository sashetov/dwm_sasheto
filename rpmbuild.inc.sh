export SRC_DIR=`readlink -f .`
export LOGS_DIR="${SRC_DIR}/logs"
export RPMBUILD_DIR="${SRC_DIR}/RPMBUILD"
export DIFF_WORKDIR="/tmp/diff"
export SRPM_NAME='dwm-6.2-2.module_f32+7511+d019be5a.src.rpm'
export SRC_TARGZ='dwm-6.2'
export PATCH_NAME='dwm_sasheto'
export SPEC_NAME='dwm_sasheto'
export DEBUG=1
function prep_logs {
  set -x
  mkdir -p "${LOGS_DIR}" \
    && mkdir -p "${RPMBUILD_DIR}"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
  set +x
}
function prep_rpmbuild {
  set -x
  echo "%_topdir $RPMBUILD_DIR/" > "${RPMBUILD_DIR}/.rpmmacros" \
    && rm -f "${HOME}/.rpmmacros" \
    && ln -s "${RPMBUILD_DIR}/.rpmmacros" "${HOME}/.rpmmacros"
  set +x
}
function prep_from_srpm {
  set -x
  cp "${SRC_DIR}/srpm/${SRPM_NAME}" "${RPMBUILD_DIR}/SRPMS/" \
    && rpmbuild -rp "${RPMBUILD_DIR}/SRPMS/${SRPM_NAME}"
  set +x
}
function make_patch {
  set -x
  mkdir $DIFF_WORKDIR \
    && cd $DIFF_WORKDIR \
    && tar -xzvf "${RPMBUILD_DIR}/SOURCES/$SRC_TARGZ.tar.gz" \
    && mkdir a/ && mv "$SRC_TARGZ/" a/ \
    && mkdir b/ && cp -ar a/$SRC_TARGZ/ b/ \
    && cp -a "$SRC_DIR/config.mk" "b/$SRC_TARGZ/" \
    && cp -a "$SRC_DIR/config.def.h" "b/$SRC_TARGZ/" \
    && cp -a "$SRC_DIR/drw.c" "b/$SRC_TARGZ/" \
    && cp -a "$SRC_DIR/drw.h" "b/$SRC_TARGZ/" \
    && cp -a "$SRC_DIR/dwm.c" "b/$SRC_TARGZ/" \
    && diff -uNr "a/${SRC_TARGZ}" \
      "b/${SRC_TARGZ}" > $DIFF_WORKDIR/$PATCH_NAME.patch
    # for some reason diff doesn't return a good exit status for a successful
    # diff, so I'm not requiring the && here as it breaks the build
    set +x
    return 0
}
function prep_build_from_spec {
  set -x
  cp -a "${DIFF_WORKDIR}/${PATCH_NAME}.patch" \
   "${RPMBUILD_DIR}/SOURCES/${PATCH_NAME}.patch" \
    && cp -a "${SRC_DIR}/${SPEC_NAME}.spec" \
      "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec"
  set +x
}
function build_new_patched_rpms {
  set -x
  rpmbuild  -ba "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec" --nocheck
  set +x
}
function clean_rpmbuild {
  set -x
  rm -f "${HOME}/.rpmmacros" \
    && rm -rf "${RPMBUILD_DIR}"
  set +x
}
function clean_logs {
  set -x
  rm -rf "${LOGS_DIR}"
  set +x
}
function clean_patch {
  set -x
  rm -rf "${DIFF_WORKDIR}"
  set +x
}
function clean_all {
  set -x
  clean_rpmbuild
  clean_patch
  clean_logs
  set +x
}
