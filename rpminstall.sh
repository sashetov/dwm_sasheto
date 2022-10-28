#!/bin/bash
source rpmbuild.inc.sh
sudo dnf -y remove dwm dwm-user
for RPM in $RPMBUILD_DIR/RPMS/x86_64/*.rpm; do 
  sudo rpm --force -Uvh $RPM
done;
