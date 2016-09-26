#!/bin/bash
rpmbuild --rebuild SRPMS/dwm-6.1-3.fc24.src.rpm > logs/rebuild.log 2>&1
rpm -ivh SRPMS/dwm-6.1-3.fc24.src.rpm > logs/install-source.log 2>&1
