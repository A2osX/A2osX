# A2osX User Guide

A2osX is already much more then a "primitive" command line operating system.  While A2osX runs on top of ProDos, leveraging its support for block devices such as floppy drives, hard drives, SmartPort drives, etc.; it adds a preemptive multitasking kernel with a greatly enhanced shell that supports arguments, redirection, piping, and probably the biggest enhancement, a full scripting language.  In addition, at its core, the A2osX supports multiple virtual terminals (i.e. OA-1 OA-2 gets you different sessions) as well as concurrent external terminals via SSC (getty on SSC serial) or network (TELNETD).  A GUI interface is being built and will be part of a future release.

A core element at the foundation of A2osX that enables its multiuser multitasking capabilities is its reusable set of APIs and Libraries (written in Assembly) that all programs can and do use that make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different LAN cards via drivers.  A significant feature is that multiple programs can be using the network at the same time such as the TELNETD server, the HTTPD server and/or the TELNET client.  A key benefit is that the code for doing each program is smaller because the network API is doing a lot of the work.  And since CORE APIs like printf and libraries such as Network loaded only once, much like a DLL in Windows, significant memory is conserved providing the resources needed to support multitasking and multiple users.

The core of A2osX is written entirely in 65C02 Assemnbly and built using the S-C Macro Assembler.  Assembly was chosen because at end of day it provides for the most strict and stringent memory management as well as the fastest performance of any language on the Apple II.  Work is underway to provide ASM running under A2osX (see Current and Future Development Process sections below).  There is also an entire shell scripting language (see below) and in the future we plan a CSH (C-Shell) which is the first step to an Interactive C interpreter and then a Compilter that will make C feed to built-in assembler.  Yes, that is a lot on our development plan, but the only way to make it feasible is by building the core using assembly to provide enough memory and processing sources to enable such features.

## Developing for A2osX

There has been a significant uptick in interest in A2osX and its development.  That's great!  Along with that has come a lot of questions and requests for documentation.  Besides this new user guide, which we hope will answer many of your questions, we have also written an extensive  **[Developers Guide](.Docs/Developers%20Guide.md).**  That guide explains our current development process (GitHub to delivery media) as well as our future plans.

The Developers Guide is all about developing the core of A2osX, its drivers, utilities, libraries, etc. that is all done in Assembly.  There is another aspect of A2osX that will interest many developers and users alike and that is its significant scripting engine or Shell (./BIN/SH).

### The A2osX Shell (SH)

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), DATE, TIME, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.

It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example  

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 

### File System Layout of A2osX

The following are the primary sub-directories used by A2osX.  While A2osX supports all standard ProDOS media/volumes and you can use its commands and utilities (like cp [copy] ls [catalog] rm [delete]) on these volumes, A2osX and its modules, commands, scripts, etc. must be installed under one directory that has these directories (at their related files) stored under it.  Below where you see a ./ (dot slash) in front of each path, think of that as the volume name or directory name where you have installed A2osX.  For example, on the media we supplied called BOOT, which has a volume name of /A2OSX.BOOT/, you will find directories named BIN and ETC.  The full path name for those dirs would be /A2OSX.BOOT/BIN/ and /A2OSX.BOOT/ETC/.  If you installed A2OSX on your own harddrive called /MYVOL1 in a directory called A2OSX, then your ./ would refer to /MYVOL1/A2OSX/ and your BIN would be /MYVOL1/A2OSX/BIN/.  See the installation section for more information on using A2osX with your own volumes.

| Path | Use |
| ---- | --- |
| ./ | is the root directory|
|./bin/ and ./usr/bin/ |store user commands.|
|/dev/| contains device files, note this directory does not actually exist|
|./etc/| is where configuration files and scripts are located.|
|./home/| is the default location for users home directories.|
|./lib/ and ./usr/lib/ |hold library files used by programs in /bin/ and /sbin/.|
|/mnt/ |holds the mount points for file systems that were mounted after boot.  A2OSX does not use this directory at this time, but may in the future.|
|./opt/ |is used primarily for installation and uninstallation of third-party software. Holds optional files and programs.|
|./root/ |is the home directory of the superuser "root"|
|./sbin/ and ./usr/sbin/ |store system commands.|
|./sys/| contains files used for system start-up including the kernel.|
|./tmp/ |is the system temporary directory. All users have read+write access to /tmp/.|
|./usr/ |contains files related to users such as application files and related library files |
|./var/ | holds files and directories that are constantly changing such as printer spools and log files.|

## A2osX Boot Process

To help you install, configure, run and maintain your A2osX system, this section delineates the A2osX boot process.  This discussion is based on a standard installation and configuration of A2osX on a bootable drive named /A2OSX.  As will be discussed below, it is possible to run A2osX from drive other then the boot device.  For example, if you have a hard drive with 2 partitions named HD1 and HD2; you can boot from HD1 and then load and run A2osX that is stored on HD2.  Reading this section and the section on installation will help you with this type of configuration.

>Please note, this section mentions many directories/sub-directories used by the A2osX system.  Please see the section on the A2osX File System for more information about each of these directories.  The most important thing to note is that when you start A2osX your Prefix should be set to the location of A2OSX.SYSTEM and the file system for A2osX should be located in the directory set by PREFIX.  In the example discussed below, when the disk A2OSX first boots, its Prefix is set to /A2OSX.

First, let's walk through the most standard and likely boot process of A2osX using a volume names /A2OSX that is presented to the Apple as your boot drive (i.e. its a hard drive image that appears in Slot 7 as Drive 1, or its a floppy inserted in Drive 1 of the Slot 6 controller).

- PRODOS is loaded
- The first SYSTEM program found on the volume is loaded.  Typically if you have a no slot clock (NSC), you will have NS.CLOCK.SYSTEM on the disk.  This will load a NSC patch for ProDOS and then it loads the 2nd SYSTEM file it finds which should be A2OSX.SYSTEM.
- A2OSX.SYSTEM will then load and run all the KM.* files it finds in the ./SYS sub-directory.  These are Kernel Modules that configure ProDOS before the main Kernel of A2osX loads.  See the section on KMs for more information on what each module does.
- A2OSX.SYSTEM then installs a new QUIT CODE routine
- The new QUIT CODE routine loads and runs KERNEL found in ./SYS.
- KERNEL then executes the boot script stored in ./ETC/INIT
- KERNEL starts GETTY Process (./SBIN/GETTY) for each configured virtual terminal
- Each GETTY process starts a LOGIN process (./SBIN/LOGIN)
- When a user logs in LOGIN starts a shell process (./BIN/SH)
- This shell process executes the script PROFILE found in the users home directory.

Some notes on the above:
- A2osX has been tested on ProDOS versions 2.0.3 and 2.4.2.  We welcome testing and feedback on using A2osX with other versions.
- The NS.CLOCK.SYSTEM is not needed by A2osX because there is a Kernel Module that accomplishes the same thing, please see the section on KMs.  A user may want the NS.CLOCK.SYSTEM file if they are running other applications (i.e. AppleWorks) from the same volume so that the NSC patch gets enabled for their apps use of the clock.
- There are enhancements planned for the QUIT CODE routine.  In the future, we hope to allow you to execute another SYSTEM file from the Shell in A2osX whereby QC routine will unload A2osX, load your other SYSTEM program (again i.e. AppleWorks) and then when you quit that application, the QC routine will reload A2osX.
- When the KERNEL first starts, if the user presses Control-R a special maintenance mode is enabled.  This is discussed in detail below.
- Currently the entire User/Group system is incomplete.  As such we have temporarily set GETTY to automatically login each Terminal as user ROOT and execute the profile stored in ./ROOT.  This may change prior to release.
- The ./ETC/INIT file can be used to automatically start the SSC.DRV and GETTY process for an external terminal.  It can also be used to load network drivers and processes at boot.
- The ./${HOME}/PROFILE file can be used to change a users default $PATH, run a Shell Script or load a particular program when a user logs in.

If you decide to install/copy A2osX to your own existing Hard Drive or volume, you just need to be sure to keep the A2osX file system structure in tact.  To start A2osX "manually" as it were, you just need to change your PREFIX to the appropriate sub-directory and then load A2OSX.SYSTEM.  So for example, if you had a CFFA card that booted to a volume called /HD1, you could make a subdirectory on this disk called A2OSX.  You would then set your PREFIX to /HD1/A2OSX and launch A2OSX.SYSTEM and the rest of the boot process outlined above would be followed.  Please see the section on Installation for more information on putting A2OSX on your own media.

### Kernel Modules

As stated above, when A2OSX first launches, it looks in the ./SYS subdirectory and loads and runs all files that start with KM.. Currently the following Kernel Modules are available:

| Name  | Comment | 
| -------    | ------- |
| KM.APPLETALK  | AppleTalk Support for ProDOS |
| KM.NSC        | No-Slot-Clock/DS1216E |
| KM.RAMWORKS   | AE-Ramworks I,II,III  |
| KM.VSDRIVE    | ADTPro Virtual Drive for SSC |

The KM.NSC module gives you the same functionality as the NS.CLOCK.SYSTEM routine found in the Boot volume of ProDOS.  You do not need both files.  If you are running NS.CLOCK.SYSTEM to support other applications, you can remove the KM.NSC module.  Conversly, if you are only running A2osX off this booted volume, you can remove NS.CLOCK.SYSTEM and just use our KM since it is smaller in size (saving disk space).

The KM.RAMWORKS is needed only on systems with greater then 128K of memory.  It turns any additional memory into a ram disk /RAM3.

The KM.VSDRIVE module helps you connect to an ADTPRO server via a Super Serial Card (SSC).

The KM.APPLETALK module helps ProDOS talk to APPLETALK, though at the moment A2osX cannot use this facility until we complete the ATLOGIN/Mount programs.  On most of our media you will find this KM stored in a subdirectory of ./SYS which means it is not loaded at start up.

### Maintenance mode

A2osX supports a special maintenance mode that you can invoke while A2osX is loading.  As the system begins to load, press Control-R (hold down the Control Key and press R) to enable ROOT Mode.  In this mode, A2osX starts up in a special mode that

1. by-passes the login process, so if you have changed or forgotten your ROOT password, you can boot the system (only at the console) in ROOT mode to correct this.
2. does not load the ETC/INIT, in case you have made some change to this file that is causing boot issues.
3. does not load the root users PROFILE, in case you have made some change to this file that is causing ROOT login issues. 

In maintenance mode, you still have access to all A2osX utilities and scripts, so you can run programs such as EDIT to make changes to any needed text file reconfigure the system before booting normally.

## Devices

A2osX supports a number of block or file devices for input and output (I/O).  Devices should not be confused with hardware, though many devices correspond to actual hardware and not all hardware is presented as an A2osX device.  For example, while A2osX supports getting the date and time from ProDOS, there is no "time" device; and while your Apple has a screen and keyboard, with A2osX a user interacts with a Terminal Device (i.e. /DEV/TTY1).  This section discusses the devices with witch users or A2osX programs can interact.  Please see the Hardware Section of this User guide for a fuller discussion of the hardware A2osX supports.

### Null Device

There is a standard Null device that you can use in your scripts, typically to redirect error messages.  This device is /DEV/NULL.

### Block Devices

A2osX supports all the ProDOS block devices including floppy drives, hard drives and Ram Disks.  It has been tested to work with both 140K and 800K floppy drives, the FloppyEMU (both floppy types), the CFFA3000 and the ReActiveMicro Turbo as well as RAMWorks and Apple 1MB Memory cards.  While these drives may be listed with the device identifier (i.e. S6D2 or S7D1) they are reference using their ProDOS names and pathing (i.e. /BOOT or /RAM3).

### Virtual Terminals

A2osX supports multiple virtual terminals on your a single Apple system.  By default the system is configured to support 2 virtual terminals (/DEV/TTY1 and /DEV/TTY2).  This will be configurable in the future using the KCONFIG utility.  In addition to these virtual terminals there is also a console device (/DEV/CONSOLE) and in the future a Double-High Graphics Resolution (/DEV/DHGR??) display.  You can switch between these various devices by using the special Open-Apple key.

| Device | Open Apple Combo |
| --- | --- |
| Console | Open Apple 0 |
| TTY1 | Open Apple 1 |
| TTY2 | Open Apple 2 |
| TTY3 | Open Apple 3 |
| TTY4 | Open Apple 4 |
| DHGR | Open Apple 5 |
 
Note: if only 2 virtual terminals are configured then OA-3 and OA-4 will have no effect.  Once terminals are configurable in KCONFIG, please note that increasing and reducing the number of virtual terminals impacts the amount of memory used by A2osX.

### Physical Terminals

A2osX supports physical terminals (or a PC running a terminal emulator) via a Super Serial Card and the A2osX SSC.DRV driver.  You will need to set the switches on your SSC and the parameters of your terminal emulator to match and of course you will need the appropriate null modem cable.  The terminal type supported is VT-100, so please set your emulator to VT-100 mode.  A2osX does not support modems connected to your SSC at this time.

### Internet Terminals

A2osX supports multiple internet connected terminals via a TELNETD server process.  The TELNETD process supports VT-100 terminals, so you should set your Telnet client (i.e. PuTTY) to use VT-100 emulation.  Of course you can use another Apple running A2osX and the TELNET client to connect to an Apple running A2osX and the TELNETD server.
