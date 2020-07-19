# dwm_sasheto

## dwm_sasheto.spec
- This is my version of dwm for fedora dists.
- The code for this version is in the base dir and is patched with various patches from that site.
- After a successfull build you can see the diff from fedora default rmp appear in: RPMBUILD/SOURCES/dwm_sasheto.patch

## build instructions
==================
- As the file's name USE_MAKERPM_SCRIPT seems to suggest, you have to run ./makerpm
- After its run RPMs should appear in RPMBUILD/RPMS/x86_64/, or whichever your arch is. If they don't, something went wrong and you can check logs/* for details.

## install instructions
====================
- Run ./rpminstall.sh and enjoy. This may fail with some error about rpm name of depends being different, in which case you can copy the directory trees of the filesystems inside the CPIO file inside the RPM files to / and enjoy from there.


## FEDORA 32 Build/Install INSTRUCTIONS
```bash
cd srpm;
wget ftp://ftp.ntua.gr/pub/linux/fedora/linux/updates/32/Modular/SRPMS/Packages/d/dwm-6.2-2.module_f32+7511+d019be5a.src.rpm
cd ../rpms;
wget 'ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/d/dmenu-4.9-4.fc32.x86_64.rpm'
wget 'ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/s/st-0.8.1-6.fc32.x86_64.rpm'
sudo rpm --force -Uvh ./dmenu-4.9-4.fc32.x86_64.rpm st-0.8.1-6.fc32.x86_64.rpm;
sudo dnf -y install rpm-build fontconfig-devel libXft-devel libXinerama-devel
# see diff of commit 2a4dac13b41018267a2ac570f2a60374b0edf8c8 for more details on fedora-specific changes
./makerpm
./rpminstall.sh
```
