export SRC_DIR=`readlink -f .`
export LOGS_DIR="${SRC_DIR}/logs"
export RPMBUILD_DIR="${SRC_DIR}/RPMBUILD"
export DIFF_WORKDIR="/tmp/diff"
export SRPM_NAME='dwm-6.1-3.fc24.src.rpm'
export SRC_TARGZ='dwm-6.1'
export PATCH_NAME='dwm_sasheto'
export SPEC_NAME='dwm_sasheto'
export DEBUG=
function prep_logs {
  mkdir -p "${LOGS_DIR}" \
    && mkdir -p "${RPMBUILD_DIR}"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
}

function prep_rpmbuild {
  echo "%_topdir $RPMBUILD_DIR/" > "${RPMBUILD_DIR}/.rpmmacros" \
    && rm -f "${HOME}/.rpmmacros" \
    && ln -s "${RPMBUILD_DIR}/.rpmmacros" "${HOME}/.rpmmacros"
}

function prep_from_srpm {
  cp "${SRC_DIR}/srpm/${SRPM_NAME}" "${RPMBUILD_DIR}/SRPMS/" \
    && rpmbuild -rp "${RPMBUILD_DIR}/SRPMS/${SRPM_NAME}"
}

function make_patch {
  mkdir $DIFF_WORKDIR \
    && cd $DIFF_WORKDIR \
    && tar -xzvf "${RPMBUILD_DIR}/SOURCES/$SRC_TARGZ.tar.gz" \
    && mkdir a/ && mv "$SRC_TARGZ/" a/ \
    && mkdir b/ && cp -ar a/$SRC_TARGZ/ b/ \
    && cp -a "$SRC_DIR/config.def.h" "b/$SRC_TARGZ/" \
    && cp -a "$SRC_DIR/dwm.c" "b/$SRC_TARGZ/" \
    && diff -uNr "a/${SRC_TARGZ}" \
      "b/${SRC_TARGZ}" > $DIFF_WORKDIR/$PATCH_NAME.patch
    # for some reason diff doesn't return a good exit status for a successful
    # diff, so I'm not requiring the && here as it breaks the build
    return 0
}

function prep_build_from_spec {
  cp -a "${DIFF_WORKDIR}/${PATCH_NAME}.patch" \
   "${RPMBUILD_DIR}/SOURCES/${PATCH_NAME}.patch" \
    && cp -a "${SRC_DIR}/${SPEC_NAME}.spec" \
      "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec"
}

function build_new_patched_rpms {
  rpmbuild  -ba "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec" --nocheck
}

function clean_rpmbuild {
  rm -f "${HOME}/.rpmmacros" \
    && rm -rf "${RPMBUILD_DIR}"
}

function clean_logs {
  rm -rf "${LOGS_DIR}"
}

function clean_patch {
  rm -rf "${DIFF_WORKDIR}"
}

function clean_all {
  clean_rpmbuild
  clean_patch
  clean_logs
}

