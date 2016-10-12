#!/bin/bash
. rpmbuild.inc.sh
prep_logs \
  && prep_rpmbuild > $LOGS_DIR/00_prep_rpmbuild.log 2>&1 \
  && prep_from_srpm > $LOGS_DIR/01_prep_from_srpm.log 2>&1\
  && make_patch  > $LOGS_DIR/02_make_patch.log 2>&1 \
  && prep_build_from_spec  > $LOGS_DIR/03_prep_build_from_spec.log 2>&1 \
  && build_new_patched_rpms > $LOGS_DIR/04_build_new_patched_rpms.log 2>&1
