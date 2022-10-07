# Explanation of the files in the MAKE directory.

### There are 4 categories here:

- **Preparation Scripts:** these are scripts which are used to get things ready for the "Media Maker" scripts. In general, they copy files to the staging area that is sourced by the various media maker scripts.

- **Media Maker Scripts:** these will format a target drive (s7d2 or s6d1 depending on media type), create directory structures, and copy files over. Mostly written to source "what files" from related "Data Files". These do NOT export the .po files or anything like that, as that appears to be a manual process after these scripts create the content of those .po images.

- **Data Files:** there are 3 kinds here: list of files that media makers will source (think 'for files in datafile' type routine), INIT files (customized to full/debug/mini/etc), and profile (only one; it is the default 'PROFILE' you find in /root that is sourced at login).

- **Unused / Unfinished / Useless:** scripts or files that are either unfinished, don't really do anything, or appear to be work-in-progress (abandoned?). Most likely these could be moved into an 'offline' subfolder or something to avoid confusion with usable files.



## Preparation Scripts

* **COPYBUILD** - makes /MAKE/BUILDS/BUILDnnnn and then copies all the files from /BUILD to that directory. Prerequisite for doing other things.

* **ADDEXTRAS** - adds adm, help, etc. Perhaps the functionality of this was built into the other media maker scripts.


## Media Maker Scripts

* **MAKE2C** - media maker for mini //c PPP builds; makes the mini //c PPP version (a.k.a. /PPPBOOT). Wants a proper /MAKE/BUILDS/BUILDnnn to exist. When it asks for Release, Candidate, Stable, it only affects /etc/issue text.

* **MAKEDEBUG** - media maker for debug builds.

* **MAKEFULL** - media maker for 800 FULLBOOT. Looks like it is complete, depends on /MAKE/BUILDS/BUILDnnn to exist. Will format s7d2!

* **MAKEFULL32** - media maker for 32MB FULLBOOT. Looks like it is complete, depends on /MAKE/BUILDS/BUILDnnn to exist. Will format s7d2!

* **MAKEINSTALL** - media maker for 140KB a2osxinstall and a2osxidisk2. Looks like it is complete, depends on /MAKE/BUILDS/BUILDnnn to exist. Will format s6d1 and s6d2!

* **MAKEMINI** - media maker for 140KB minibuild. Looks like it is complete, depends on /MAKE/BUILDS/BUILDnnn to exist. Will format s6d1!

* **MAKENETINST** - media maker for 140KB network installer A2osxNetInst. Looks like it is complete, depends on netinstfiles and /MAKE/BUILDS/BUILDnnn to exist. Will format s6d1!

* **MAKETD** - media maker for 32MB /tdboot. Looks like it is complete, depends on fullfiles and /MAKE/BUILDS/BUILDnnn to exist. Will format s7d2! Not sure what this is?

* **MAKEUPDATE** - makes a dir /MAKE/update and puts (updatefiles) into it and then PAKs it. Doesn't put it anywhere for the net pull?

* **MAKEIMAGES** - media maker; not sure if this is complete, but attempts to make builds into /RAM3 ... doesn't appear to do anything with them after PAK'ing.


## Data Files

### Media Maker Sources

* **DEBUGFILES** - a list of files that is sourced by MAKEIMAGES and MAKEDEBUG

* **FULLFILES** - a list of all the files that should be in a2osx build. sourced by MAKEIMAGES, MAKEFULL, MAKEFULL32, MAKETD.K

* **M2CPPPFILES** - list of files that would go into the Apple //c PPP build? sourced by MAKEINSTALL

* **MINIFILES** - list of files for MAKEMINI.

* **NETINSTFILES** - list of files for MAKENETINST.

* **UPDATEFILES** - list of files for MAKEUPDATE.

### Init Files

* **DEBUGINIT** - default /etc/init for debug builds. some getty into sbin/login.

* **INITBOOT** - same as DEBUGINIT, but has more getty; seems to be copied as a target into /etc/init by MAKEIMAGES, MAKEFULL, MAKEFULL32, MAKEMINI, MAKE2C.

* **TDBOOTINIT** - same as DEBUGINIT, but has more getty; seems to be copied as a target into /etc/init by MAKETD.

### Profile

* **PROFILE** - default profile dropped into /root for media




## Unused / Unfinished / Useless Scripts

* **BUILD** - does nothing useful.
* **EMPTYFS** - makes all the subdirectories on specified target volume but doesn't copy anything? not called by anything.
* **INITINSTALL** - calls installscriot?
* **INITNETINSTALL** - calls NetInstall.
* **NETINSTALL** - the start of a script for network install, but unfinished and doesn't do anything.
* **INSTALLSCRIPT** - unfinished, doesn't do anything.
* **INSTBFILES** - small list of files, sourced by MAKEINSTALL
* **MAKE** - cd's to /MAKE/USR/SHARE/MAKE
* **MAKEDISKS** - looks like the start of a media creation script, asks a lot of questions as to what you want to build, but ultimately doesn't do anything.
* **MAKELOGO** - creates ASCII art A2OSXLOGO file.
* **MAKEMENU** - looks like the start of a menu driven way to launch various build management scripts, but appears very unfinished (calls nonexistent scripts).
* **RC** - garbage.
* **RELEASE** - garbage.
* **STABLE** - garbage.
* **TCPIPCONF** - looks like tcpip.conf source, but everything is commented out. Doesn't appear to be used by anything.
* **FIXINFFILES** - looks like it might have been a one-off to correct the filename case of a bunch of .i files? Not referenced by anything.





