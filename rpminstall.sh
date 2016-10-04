#!/bin/bash
#install these with force replace for the files with the new ones
for rpm in ./RPMS/x86_64/*.rpm; do 
  sudo rpm --force -Uvh $rpm;
done;
