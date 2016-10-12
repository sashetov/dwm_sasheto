#!/bin/bash
source rpmbuild.inc.sh
for RPM in $RPMBUILD_DIR/RPMS/x86_64/*.rpm; do 
  sudo rpm --force -Uvh $RPM
done;
