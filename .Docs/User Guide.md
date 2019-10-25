# A2osX User Guide

### Updated October 24, 2019

This Guide provides information on getting started with A2osX.  This Guide helps you understand the basic features, capabilities and operation of A2osX.  This should be the first document you read before, or soon after, installing or running A2osX.

## What is A2osX?

It is a new operating environment, layered on top of ProDOS, that brings a powerful new way of building and running programs on the venerable Apple // platform. A2osX is a pre-emptive multitasking and multi-user system that employs libraries and drivers to provide multiple applications consistent access to system resources such as terminals, network, and files.

Part of what makes A2osX different, is that all programs, utilities, drivers and libraries are made re-entrant and relocatable so that they can be run concurrently and do not depend on a set memory location.  One of the clear benefits is that multiple users can run the same program and it is only loaded once, and more significantly, drivers and libraries for resources such as networking are only loaded once and can be used my multiple applications at the same time.

A2osX is already much more then a "primitive" command line operating system.  While A2osX runs on top of ProDos, leveraging its support for block devices such as floppy drives, hard drives, SmartPort drives, etc.; it adds a preemptive multitasking kernel with a greatly enhanced shell that supports arguments, redirection, piping, and probably the biggest enhancement, a full scripting language.  In addition, at its core, the A2osX supports multiple virtual terminals (i.e. OA-1 OA-2 gets you different sessions) as well as concurrent external terminals via SSC (getty on SSC serial) or network (TELNETD).  A GUI interface is being built and will be part of a future release.

A core element at the foundation of A2osX that enables its multi-user multitasking capabilities is its reusable set of APIs and Libraries (written in Assembly) that all programs can and do use that make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different LAN cards via drivers.  A significant feature is that multiple programs can be using the network at the same time such as the TELNETD server, the HTTPD server and/or the TELNET client.  A key benefit is that the code for doing each program is smaller because the network API is doing a lot of the work.  And since CORE APIs like printf and libraries such as Network loaded only once, much like a DLL in Windows, significant memory is conserved providing the resources needed to support multitasking and multiple users.

The core of A2osX is written entirely in 65C02 Assembly and built using the S-C Macro Assembler.  Assembly was chosen because at end of day it provides for the most strict and stringent memory management as well as the fastest performance of any language on the Apple II.  Work is underway to provide ASM running under A2osX (see Current and Future Development Process sections below).  There is also an entire shell scripting language (see below) and in the future we plan a CSH (C-Shell) which is the first step to an Interactive C interpreter and then a Compiler that will make C feed to built-in assembler.  Yes, that is a lot on our development plan, but the only way to make it feasible is by building the core using assembly to provide enough memory and processing sources to enable such features.

### Developing for A2osX

There has been a significant uptick in interest in A2osX and its development.  That's great!  Along with that has come a lot of questions and requests for documentation.  Besides this new user guide, which we hope will answer many of your questions, we have also written an extensive  **[Developers Guide](.Docs/Developers%20Guide.md).**  That guide explains our current development process (GitHub to delivery media) as well as our future plans.

The Developers Guide is all about developing the core of A2osX, its drivers, utilities, libraries, etc. that is all done in Assembly.  There is another aspect of A2osX that will interest many developers and users alike and that is its significant scripting engine or Shell (./BIN/SH).

### The A2osX Shell (SH)

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), DATE, TIME, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.

It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example

```
FOR FILE IN `LS -C CT*`; CAT ${FILE}; NEXT
```

In this example, the system will generate a list of files found in the current directory that match the CT* wildcard and perform the CAT operation on each.  The semicolons act as a line separator allowing you to type in multiple commands, or short scripts, to execute as an inline script.

An entire Shell Developers Guide is being written to help you with both using and writing scripts for the A2osX Shell.  It can be found **[Here](.Docs/Shell%20Developers%20Guide.md).**

### File System Layout of A2osX

To get the most out of the use of files and directories you need to understand the concept of a hierarchical file system.  This section introduces the A2osX file system and shows you how to work with files and directories using several A2osX commands.

A2osX organizes information in files and directories.  A directory is a special file that can contain other files and directories.  Because a directory can contain other directories, this method of organizing files gives rise to a hierarchical structure.  This organization of files is the file system.

Folks who use and are accustomed to working with Linux or Unix will find familiarity with A2osX.  Many of the commands and much of the Shell interface follows the User Interface (UI) presented by Linux.  There is however, one key difference, that makes A2osX adhere more to the ProDOS model which is the support for multiple distinct volumes.  In Linux there is only one root represented by / (typically the boot volume) with all other drives appearing as sub directories of this volume.  A2osX instead continues to present each volume separately by their name as does ProDOS.  A2osX does present a BOOT/SYSTEM directory (where A2OSX.SYSTEM was loaded from) and uses this for finding critical system directories and files such as BIN and ETC.

You move around the file sytesm with CD and PWD will tell you were you are.  Your default prompt includes your current path.

The following are the primary sub-directories used by A2osX.  While A2osX supports all standard ProDOS media/volumes and you can use its commands and utilities (like cp [copy] ls [catalog] rm [delete]) on these volumes, A2osX and its modules, commands, scripts, etc. must be installed under one directory that has these directories (and their related files) stored under it.  Below where you see a ./ (dot slash) in front of each path, think of that as the volume name or directory name where you have installed A2osX.  For example, on the media we supplied called BOOT, which has a volume name of /A2OSX.BOOT/, you will find directories named BIN and ETC.  The full path name for those dirs would be /A2OSX.BOOT/BIN/ and /A2OSX.BOOT/ETC/.  If you installed A2OSX on your own hard drive called /MYVOL1 in a directory called A2OSX, then your ./ would refer to /MYVOL1/A2OSX/ and your BIN would be /MYVOL1/A2OSX/BIN/.  See the installation section for more information on using A2osX with your own volumes.

| Path | Use |
| ---- | --- |
| ./ | is the root directory|
|./bin/ and ./usr/bin/ |store user commands.|
|/dev/| contains device files, note this directory does not actually exist|
|./etc/| is where configuration files and scripts are located.|
|./home/| is the default location for users home directories.|
|./lib/ |holds library files used by programs in /bin/ and /sbin/.|
|/mnt/ |holds the mount points for file systems that were mounted after boot.  A2OSX does not use this directory at this time, but may in the future.|
|./opt/ |is used primarily for installation and installation of third-party software. Holds optional files and programs.|
|./root/ |is the home directory of the superuser "root"|
|./sbin/ |store system commands.|
|./sys/| contains files used for system start-up including the kernel.|
|./tmp/ |is the system temporary directory. All users have read+write access to /tmp/.|
|./usr/ |contains files related to users such as application files and related library files |
|./usr/share/| holds files and directories for optional packages such as MAN, MAKE, TEST and ADMIN |
|./usr/share/admin|This directory contains the scripts used to Administer A2osX|
|./usr/share/make|This directory contains the scripts used to build the various floppies and disk images that are distributed as part of A2osX |
|./usr/share/test|This directory contains the scripts used to test A2osX after each new build |
| ./usr/src/ | holds source code files for A2osX and other programs |
|./var/ | holds files and directories that are constantly changing such as printer spools and log files or data for installed applications.|
| ./var/log/ | holds log files for various programs and scripts |

Please note that not all of the above directories are found on every disk or image for A2osX.  Several of them are optionally installed or omitted from systems during initial configuration and may be added or removed at a later time.

### A2osX Boot Process

To help you install, configure, run and maintain your A2osX system, this section delineates the A2osX boot process.  This discussion is based on a standard installation and configuration of A2osX on a bootable drive named /A2OSX.  As will be discussed below, it is possible to run A2osX from drive other then the boot device.  For example, if you have a hard drive with 2 partitions named HD1 and HD2; you can boot from HD1 and then load and run A2osX that is stored on HD2.  Reading this section and the section on installation will help you with this type of configuration.

>Please note, this section mentions many directories/sub-directories used by the A2osX system.  Please see the section on the A2osX File System for more information about each of these directories.  The most important thing to note is that when you start A2osX your Prefix should be set to the location of A2OSX.SYSTEM and the file system for A2osX should be located in the directory set by PREFIX.  In the example discussed below, when the disk A2OSX first boots, its Prefix is set to /A2OSX.

First, let's walk through the most standard and likely boot process of A2osX using a volume names /A2OSX that is presented to the Apple as your boot drive (i.e. its a hard drive image that appears in Slot 7 as Drive 1, or its a floppy inserted in Drive 1 of the Slot 6 controller).

- PRODOS is loaded
- The first SYSTEM program found on the volume is loaded.  Typically if you have a no slot clock (NSC), you will have NS.CLOCK.SYSTEM on the disk.  This will load a NSC patch for ProDOS and then it loads the 2nd SYSTEM file it finds which should be A2OSX.SYSTEM.
- A2OSX.SYSTEM will then load and run all the KM.* files it finds in the ./SYS sub-directory.  These are Kernel Modules that configure ProDOS before the main Kernel of A2osX loads.  See the section on KMs for more information on what each module does.
- A2OSX.SYSTEM then installs a new QUIT CODE routine
- The new QUIT CODE routine loads and runs KERNEL found in ./SYS.
- QUIT CODE loads Kernel Parameters stored in ./A2OSX.KCONFIG if the file exists.
- KERNEL then executes the boot script stored in ./ETC/INIT
- KERNEL starts GETTY Process (./SBIN/GETTY) for each configured virtual terminal
- Each GETTY process starts a LOGIN process (./SBIN/LOGIN)
- When a user logs in LOGIN starts a shell process (./BIN/SH)
- This shell process executes the script PROFILE found in the users home directory.

Some notes on the above:
- A2osX has been tested on ProDOS versions 2.0.3 and 2.4.2.  We welcome testing and feedback on using A2osX with other versions.
- The NS.CLOCK.SYSTEM is not needed by A2osX because there is a Kernel Module that accomplishes the same thing, please see the section on KMs.  A user may want the NS.CLOCK.SYSTEM file if they are running other applications (i.e. AppleWorks) from the same volume so that the NSC patch gets enabled for their apps use of the clock.
- There are enhancements planned for the QUIT CODE routine.  In the future, we hope to allow you to execute another SYSTEM file from the Shell in A2osX whereby QC routine will unload A2osX, load your other SYSTEM program (again i.e. AppleWorks) and then when you quit that application, the QC routine will reload A2osX.
- When A2OSX.SYSTEM starts, it initializes the system in stages as described above (load KMs, load Kernel, execute INIT, etc.).  If during this process you hold down the Open-Apple key, A2osX will stop at the end of each stage until you press another key.  You can use this to debug startup problems/hardware conflicts.
- When the KERNEL first starts, if the user presses Control-R a special maintenance mode is enabled.  This is discussed in detail below.
- Currently the entire User/Group system is incomplete.  As such we have temporarily set GETTY to automatically login each Terminal as user ROOT and execute the profile stored in ./ROOT.  This may change prior to release.
- The ./ETC/INIT file can be used to automatically start the SSC.DRV and GETTY process for an external terminal.  It can also be used to load network drivers and processes at boot.
- The ./${HOME}/PROFILE file can be used to change a users default $PATH, run a Shell Script or load a particular program when a user logs in.

If you decide to install/copy A2osX to your own existing Hard Drive or volume, you just need to be sure to keep the A2osX file system structure in tact.  To start A2osX "manually" as it were, you change your PREFIX to the appropriate sub-directory and then load A2OSX.SYSTEM.  So for example, if you had a CFFA card that booted to a volume called /HD1, you could make a subdirectory on this disk called A2OSX.  You would then set your PREFIX to /HD1/A2OSX and launch A2OSX.SYSTEM and the rest of the boot process outlined above would be followed.  Please see the section on Installation for more information on putting A2OSX on your own media.

### A2osX Kernel Modules

As stated above, when A2OSX first launches, it looks in the ./SYS subdirectory and loads and runs all files that start with KM.. Currently the following Kernel Modules are available:

| Name  | Comment | 
| -------    | ------- |
| KM.APPLETALK  | AppleTalk Support for ProDOS |
| KM.NSC        | No-Slot-Clock/DS1216E |
| KM.RAMWORKS   | AE-Ramworks I,II,III  |
| KM.VSDRIVE    | ADTPro Virtual Drive for SSC |

The KM.NSC module gives you the same functionality as the NS.CLOCK.SYSTEM routine found in the Boot volume of ProDOS.  You do not need both files.  If you are running NS.CLOCK.SYSTEM to support other applications, you can remove the KM.NSC module.  Conversly, if you are only running A2osX off this booted volume, you can remove NS.CLOCK.SYSTEM and just use our KM since it is smaller in size (saving disk space).

The KM.RAMWORKS is needed only on systems with greater then 128K of memory.  It turns any additional memory into a ram disk /RAM3.

The KM.VSDRIVE module helps you connect to an ADTPRO server via a Super Serial Card (SSC).  This module will use the first Super Serial Card in your system set with Interrupts off.  It is also best if you set this SSC at a baud rate of 115200.  If you have more then one SSC system and you are using the others for terminals you should fully understand how to configure the cards, Kernel Modules, and the SSC drivers for optimal performance.


- PK Note: Fill in actual details of confirmed Apple //e and GS setup for VSDRIVE with and without terminals as well.

The KM.APPLETALK module helps ProDOS talk to APPLETALK, though at the moment A2osX cannot use this facility until we complete the ATLOGIN/Mount programs.  On most of our media you will find this KM stored in a subdirectory of ./SYS which means it is not loaded at start up.

### A2osX Maintenance mode

A2osX supports a special maintenance mode that you can invoke while A2osX is loading.  As the system begins to load, press Control-R (hold down the Control Key and press R) to enable ROOT Mode.  In this mode, A2osX starts up in a special mode that

1. by-passes the login process, so if you have changed or forgotten your ROOT password, you can boot the system (only at the console) in ROOT mode to correct this.
2. does not load the ETC/INIT, in case you have made some change to this file that is causing boot issues.
3. does not load the root users PROFILE, in case you have made some change to this file that is causing ROOT login issues. 

In maintenance mode, you still have access to all A2osX utilities and scripts, so you can run programs such as EDIT to make changes to any needed text file reconfigure the system before booting normally.

### A2osX Preemptive Mode

A2osX is a multiuser multitasking operating system.  As with any such operating system running on a single core single CPU system such as an Apple II with the 6502, A2osX switches between all of the running processes automatically ensuring that each gets serviced in a reasonable time. It is the A2osX Kernel that performs this task in 1 of 2 manners: Cooperative or Preemptive mode.  In Cooperative mode, the default, switching between processes occurs whenever an application makes a "blocking" API call (i.e. waiting for a key press or a network frame) or cooperatively relinquishes control (by explicitly calling >SLEEP, see the A2osX Developers Guide).  In Preemptive Mode, set by option in the KCONFIG utility (see A2osX Command Guide), the kernel switches between "sleeping" processes automatically at 1/10th-second intervals.  In order to use Preemptive Mode, your system must have supported hardware that generates an interrupt used by A2osX such as an Apple II Mouse or ThunderClock interface.

### A2osX Devices

A2osX supports a number of block or file devices for input and output (I/O).  Devices should not be confused with hardware, though many devices correspond to actual hardware and not all hardware is presented as an A2osX device.  For example, while A2osX supports getting the date and time from ProDOS, there is no "time" device; and while your Apple has a screen and keyboard, with A2osX a user interacts with a Terminal Device (i.e. /DEV/TTY1).  This section discusses the devices with witch users or A2osX programs can interact.  Please see the Hardware Section of this User guide for a fuller discussion of the hardware A2osX supports.

#### Null Device

There is a standard Null device that you can use in your scripts, typically to redirect error messages.  This device is /DEV/NULL.

#### Block Devices

A2osX supports all the ProDOS block devices including floppy drives, hard drives and Ram Disks.  It has been tested to work with both 140K and 800K floppy drives, the FloppyEMU (both floppy types), the CFFA3000 and the ReActiveMicro Turbo as well as RAMWorks and Apple 1MB Memory cards.  While these drives may be listed with the device identifier (i.e. S6D2 or S7D1) they are reference using their ProDOS names and pathing (i.e. /BOOT or /RAM3).

#### Virtual Terminals

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

#### Physical Terminals

A2osX supports physical terminals (or a PC running a terminal emulator) via a Super Serial Card and the A2osX SSC.DRV driver.  You will need to set the switches on your SSC and the parameters of your terminal emulator to match and of course you will need the appropriate null modem cable.  The terminal type supported is VT-100, so please set your emulator to VT-100 mode.  A2osX does not support modems connected to your SSC at this time.

A2osX supports as many physical terminals as you have SSC cards and memory to load drivers for each card and support those users.  Note that if you are running the KM.VSDRIVE module, it takes the first SSC card that is not configured for interrupts (likely slot 1 or 2).  So if you INSDRV SSC.DRV with KM.VSDRIVE loaded, then it will use the next card.  You have to load a driver for each card you want to handle as a terminal.  You also have to start the GETTY process for each terminal.  The Terminals will be named /DEV/COMx where x is the slot the card is in. 

#### Internet Terminals

A2osX supports multiple internet connected terminals via a TELNETD server process.  The TELNETD process supports VT-100 terminals, so you should set your Telnet client (i.e. PuTTY) to use VT-100 emulation.  Of course you can use another Apple running A2osX and the TELNET client to connect to an Apple running A2osX and the TELNETD server.

Please note, if you are using Telnet Client Software such as PuTTY for Windows and see random garbled characters (odd graphics symbols), you may need to change your **Remote Character Set** to something other than **UTF-8**, such as **ISO-8859-1:1998 (Latin-1, West Europe)**.

### Hardware

#### Hardware Requirements

*Minimum Hardware Requirements*<br>
128K Enhanced (65C02) Apple //e<br>
Apple //c<br>
Apple //GS<br>
Minimum 140K 5.25 disk drive, 800K 3.5 strongly recommended.

#### Supported Hardware

Any ProDOS Block Device (5.25 & 3.5 Floppy Drives, SmartPort Hard Drive and Ram Disks)<br>
NoSlot Clock or ThunderClock<br>
Super Serial Card<br>
Mouse Card<br>
Network Card (Uthernet I or II, LanCEgs)

## Getting Started

To get started with A2osX, the very first thing you need to do is download a disk image from GitHub.  Images are available in multiple versions from cutting edge developer seeds to release candidates as well as in multiple sizes suitable for placing on Disk II drives, 3.5 drives or hard drives of for use with emulators.  Please consult the **[A2osX Media Guide](.Docs/Media%20Guide.md).** for detailed information on the available images. 

### Using AppleWin

Download one of the available 32MB images from GitHub.  Open AppleWin and then click on the  configuration icon.  When the configuration screen appears, select the Disk tab.  Next, make sure the **Enable Hard disk controller in slot 7** box is checked and set the **HDD 1** to the image you downloaded.  Click OK to save your changes and finally boot the emulated Apple by clicking on the colored Apple icon.  Suggestion: on the configuration screen, for Video Mode, select Color (RGB Monitor).  You may also want to setup AppleWin for Ethernet as A2osX has many features that make use of the emulated Uthernet I card supplied by AppleWin (consult AppleWin documentation for more information on enabling this feature). 

### Installing on Your Apple

First check that your system meets the minimum hardware requirements.  Download one of the available images from GitHub.  Images are available in 140K (5 1/4 floppy), 800K (3.5 floppy) and 32MB (suitable for use with hard drive emulators).  You will need to use ADTPro to convert an image to physical media or a device such as a FloppyEMU or CFFA to load/boot one of these images on a real Apple.  If you are using a device such as the FloppyEMU or CFFA, you should use either the 800K or 32MB images (ProDOS volume name: FULLBOOT) as the smaller 140K image (ProDOS volume: MINIBOOT) is a pared down copy of A2osX that omits several utilities to fit in 140K.

>If you have your own hard drive, you can install A2osX on your drive.  The best way to accomplish this is to first start A2osX from one of the supplied media and use its built in commands to copy A2osX to your own drive.  For instance, if you have a bootable ProDOS-8 volume on your system named **/MYHD** and one of the A2osX images named **/FULLBOOT** follow these steps:
>

- Boot your system.
- If the A2osX media is set as the boot device, A2osX will load automatically.
- If your volume, say /MYHD boots to ProDOS and then BASIC.SYSTEM you can then type PREFIX /FULLBOOT and press return and then -A2OSX.SYSTEM and press return, this will load A2osX.
- If your volume boots to a Program selection, simply change the Volume to /FULLBOOT and select A2OSX.SYSTEM to run, A2osX will load.
- Once A2osX fully loads, you will be greeted as the the Root User and presented a shell prompt.

You can then enter these commands to put A2osx on your Volume **/MYHD**  (replace MYHD in this example with your actual volume name).

    /FULLBOOT/ROOT/$ MD /MYHD/A2OSX
	/FULLBOOT/ROOT/$ CD ..
	/FULLBOOT/$ CP -R * /MYHD/A2OSX
	/FULLBOOT/$ ECHO "PREFIX /MYHD/A2OSX" > /MYHD/AOSX
	/FULLBOOT/$ ECHO "-A2OSX.SYSTEM" >> /MYHD/AOSX

All of the commands above are documented in the A2osX Command Guide or the Shell Developers Guide, but briefly:
- MD creates a sub-directory on your volume named A2OSX
- CD .. moves up one directory level.  The ROOT subdirectory is the home directory for the root user.  We move up to the FULLBOOT volumes main directory so that the CP (copy) command issued next will copy all the files on this volume. 
- CP copies files and in this case recursively (-R option) selecting all files (* wildcard) and puts them in the destination we created early /MYHD/A2OSX
- The next two lines create a bat file, or in ProDOS/BASIC terms an EXEC file that will first change the PREFIX to our new A2OSX subdirectory and then launch A2osX.  Note the first line use > which will create a file and the 2nd uses >> which appends to a file.  Also note that we named the file AOSX and not A2OSX as the laters name is already used by the sub-directory we created. 

### Configuring A2osX

### Exploring A2osX

### Networking

install the drivers for the hardware (uther, lances, ssc, etc.)
then NETWORKD lib lib  (and the libs are tcpip or etalk maybe) libs are protocalls here
  in the LIB directory now are LIBTCPIP and LIBETALK
NETWORKD will read ETC/NETWORK will load network programs
  right now it contains IPCONFIG, you can also add to it HTTPD TELNETD etc, they are loaded in order and each needs to complete its full load before next one happens (assuring IPCONFIG happends before TELNETD tries to load)
IPCONFIG will then look for ETC/TCPIP.CONF, if found uses those settings, if not does dhcp.  in addition ipconfig uses ETC/HOSTNAME and ETC/HOSTS for setting hostname and doing DNSloopups

Hardware Drivers
	MAC Address
TCPIPD
Fixed IP
	TCPIP.CONF file
	Internet Addresses
DHCP
HOSTS file
HOSTNAME file
Configuring Network at Boot Time
	ETC/INIT
Configuring Network on Demand
	NET script
Telnet Server
Telnet Client
PING
ARP
NETSTAT
HTTPGET
dhcpclnt
Telnetd
httpd


### Utilities

#### Using Text Editors
EDIT

#### Commands for navigating the file system
CD
CD ..
PWD
PATH
PUSHD
POPD
LS
LS -L or L

#### Commands for working with files

MV
CP
RM

#### Commands for working with directories

MD
RD

## Error Messages

* No Error : $00
* User Script Error Codes : $01->$1F
	* Note this range may be used by multiple different scripts.
* ProDOS Error Codes : $20->$5F
* Kernel Error Codes : $60->$7F
* Lib Error Codes : $80->$BF
* Shell Error Codes : $C0->$DF
* BIN/External Command Error Codes : $ E0->$F8
	* Note this range may be reused by multiple BINs.
* Reserved for internal Kernel Use : $FA->$FF 

### No Error : $00

This is the normal or expected returned when the last command or script statement executed properly.

### User Script Error Codes : $01->$1F

This range of Error Codes may be used by Users/Developers in scripts.  Consult the Shell Developers Guide for more information.

### ProDOS or MLI Errors : $20->$5F

| Hex | Error Code | Error Message |
| --- | --- | --- |
| $21 |  33 | Invalid Status Code|
| $25 |  37 | Interrupt Table Full|
| $27 |  39 | I/O Error|
| $28 |  40 | No Device Connected|
| $2B |  43 | Write Protected|
| $2E |  46 | Disk Switched|
| $2F |  47 | Device Offline|
| $40 |  64 | Invalid Pathname|
| $42 |  66 | Maximum Number of Files Open|
| $43 |  67 | Invalid Reference Number|
| $44 |  68 | Directory Not Found|
| $45 |  69 | Volume Not Found|
| $46 |  70 | File Not Found|
| $47 |  71 | Duplicate File Name|
| $48 |  72 | Volume Full|
| $49 |  73 | Directory Full|
| $4A |  74 | Incompatible File Format|
| $4B |  75 | Unsupported Storage Type|
| $4C |  76 | End of File, No More Data|
| $4D |  77 | Beyond EOF|
| $4E |  78 | File Access Error, File Locked|
| $50 |  80 | File Already Open|
| $51 |  81 | Directory Structure Damaged|
| $53 |  83 | Invalid Parameter|
| $55 |  85 | Too Many Volumes|
| $56 |  86 | Bad Buffer Address|
| $57 |  87 | Duplicate Volume|
| $5A |  90 | File Structure Damaged|

### Kernel Errors : $ 60->$7F

| Hex | Error Code | Error Message |
| --- | --- | --- |
| $7F |   0 | Out Of Memory Error|
| $7E |   0 | Out Of Handle Error|
| $7D |   0 | Invalid Handle|
| $7C |   0 | Buffer Overflow|
| $7B |   0 | Bad Path|
| $7A |   0 | Bad Argument|
| $79 |   0 | No Such Process Error|
| $78 |   0 | Syntax Error|
| $77 |   0 | Environment is Full|
| $76 |   0 | Invalid BIN format|
| $75 |   0 | File Too Big Error|
| $74 |   0 | Out Of Bound|
| $73 |   0 | Invalid Numerical|
| $72 |   0 | Stack Error|
| $6F |   0 | Undefined Key|
| $6E |   0 | Duplicate Key|
| $6D |   0 | No Data|
| $6C |   0 | Data Length Mismatch|
| $68 |   0 | Invalid PWD database |
| $67 |   0 | Invalid User |

### Kernel Error Codes : $60->$7F

| Hex | Error Code | Error Message |
| --- | --- | --- |

### Shell Errors : $ C0->$D8

| Hex | Error Code | Error Message |
| --- | --- | --- |
| $03 | 0 |User Interrupt|
| $C0 | 0 |Command Syntax Error|
| $C1 | 0 |Expression Syntax Error|
| $C2 | 0 |Stack Error|
| $C3 | 0 |Stack Overflow|
| $C4 | 0 |LOOP Without WHILE|
| $C5 | 0 |NEXT Without FOR|
| $C6 | 0 |FI/ELSE Without IF|
| $C7 | 0 |Bad File Type|
| $C8 | 0 |Undefined Function|
| $C9 | 0 |Unexpected EOF|

### BIN/External Command Error Codes : $ E0->$F8

This range of error codes is used by all A2osX and User/Developer create BINs or application programs to denote some completion result, usually not fatal.  For example, the CMP command (./BIN/CMP) compares two files to see if they are equal. CMP will return 0 ($00) if the files compare equal and there is no other error; CMP will return 70 ($46) if one of the files is not found (a ProDOS error); and CMP will return 224 ($D0) if the files do not match, a not fatal error as the BIN did run, do its job, just the result was an "Application" mismatch error.

This range may be reused by multiple BINs so scripts checking these results should be aware of the BIN called and the valid return results for that BIN.

### Reserved for internal Kernel Use : $FA->$FF 


## License
A2osX is licensed under the GNU General Pulic License.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

The full A2osX license can be found **[Here](../LICENSE)**.

## Copyright

Copyright 2015 - 2019, Remy Gibert and the A2osX contributors.
