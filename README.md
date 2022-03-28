# dwm_sasheto

## dwm_sasheto.spec
- This is my version of building DWM packages (current base is 6.3 on F35) for Fedora dists.
- The code for this version is in the base dir and is patched with various patches from that site.
- After a successfull build you can see the diff from fedora default rmp appear in: RPMBUILD/SOURCES/dwm_sasheto.patch

## Build Instructions
==================
- As the file's name USE_MAKERPM_SCRIPT seems to suggest, you have to run ./makerpm
- After its run RPMs should appear in RPMBUILD/RPMS/x86_64/, or whichever your arch is. 
- If they don't, something went wrong and you can check logs/* for details.

## Install instructions Fedora 35
====================
```bash
./makerpm
./rpminstall.sh
```
