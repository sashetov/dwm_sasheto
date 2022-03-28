export BASE_DIR=`readlink -f .`
export LOGS_DIR="${BASE_DIR}/logs"
export RPMBUILD_DIR="${BASE_DIR}/RPMBUILD"
export DIFF_WORKDIR="/tmp/diff"
export SRPM_NAME='dwm-6.3.module_f35_sasheto.src.rpm'
export SRC_TARGZ='dwm-6.3'
export SPEC_NAME='dwm_sasheto'
export PATCHES_DIR="${BASE_DIR}/patches/"
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
  cp "${BASE_DIR}/srpm/${SRPM_NAME}" "${RPMBUILD_DIR}/SRPMS/" \
    && rpmbuild -rp "${RPMBUILD_DIR}/SRPMS/${SRPM_NAME}"
  set +x
}
function prep_from_src_dir {
  set -x
  cp ${BASE_DIR}/src/{dwm-start,dwm-user.desktop,dwm-start.1,dwm.desktop,dwm-6.3.tar.gz} "${RPMBUILD_DIR}/SOURCES/" && \
  cp "${BASE_DIR}/src/dwm.spec" "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec" && \
  tar -xzvf "${BASE_DIR}/src/${SRC_TARGZ}.tar.gz" -C "${RPMBUILD_DIR}/BUILD/"
  set +x
}
function prep_build_from_spec {
  set -x
  cp ${BASE_DIR}/src/*.patch "${RPMBUILD_DIR}/SOURCES/" && \
  cp ${PATCHES_DIR}/*.patch "${RPMBUILD_DIR}/SOURCES/" && \
  cp "${BASE_DIR}/${SPEC_NAME}.spec" "${RPMBUILD_DIR}/SPECS/${SPEC_NAME}.spec"
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
