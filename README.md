# dwm_sasheto Builder (for Fedora)

- Project that builds dwm RPM packages (current base is 6.3 on F36) for Fedora dists.
- It will build all the Fedora dwm packages for the current (36) version Fedora even if the official repos don't have it yet.

## dwm_sasheto.spec
- Caviats: It will apply my patches (located in patches/ dir):
```
  dwm-keypressrelease-6.3.patch
  dwm-pertag-6.3.patch
  dwm-gaplessgrid-6.3.patch
  config.def.h_sasheto.patch
  dwm-fibonacci-6.3.patch
  dwm-xdgautostart-6.3.patch
```
- If you don't want these, just edit the .spec file and remove them
- To install on your system you will need to remove any older package versions of dwm packages.


## Build/Install on Fedora 36
```bash
./makerpm
./rpminstall.sh
```
