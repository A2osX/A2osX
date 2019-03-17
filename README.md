# A2osX (0.93) Multi-Tasking OS for Apple II  

![](./.screen-shots/ScreenShot.LS.png)

If you would like to see more screenshots of A2osX click **[here](.Docs/Screen%20Shots.md)**.

## Introduction...

A2osX is an operating, programming and execution environment for the 128K Enhanced Apple //e and Apple //gs series of computers.  While layered atop of ProDOS, taking advantage of all ProDOS block devices and MLI calls; A2osX is much more than an application or command shell. Written in 65C02 assembly for speed of execution and efficient memory management; A2osX is a multitasking and yes multiuser development environment bringing many of today's server operating system features to our venerable vintage 8-bit systems. 

The foundation of A2osX enabling its multiuser multitasking capabilities is a reusable set of APIs and LIBs (written in Assembly) that all programs can and do use which make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different brand LAN cards via a set of drivers.  Key here is that multiple programs can be using the network at the same time such as the TELNETD server and the TELNET client.  One of the key benefits is code for doing each program is smaller because the network API is doing a great deal of the work.  With CORE APIs like printf and LIBs such as Network only loaded once (much like a DLL in Windows) memory is conserved, providing more resources to support your A2osX programs.

A2osX is designed to work on any "stock" 128k Apple //e, with no additional hardware with a 65C02 or newer processor.

See the **[documentation](#documentation)** section below to find other resources available to you for learning how to install, use, develop and test A2osX.
 
## Latest News 2019-02-19

Major updates have occurred to the kernel and many of the A2osX API's to support a greatly enhanced shell that boasts significant new scripting capabilities since 0.92.  Also added is the the ability to redirect input and output, including errors, and the ability to pipe (|) the output of one command or operation to another (i.e. **ls \* | more** ).  A2osX now provides for multiple virtual terminals as well as users/terminals via TCP (through TELNETD) and serial devices (through a SSC driver).

If you would like to read all the past news articles for A2osX, you can read the news article found **[here](.Docs/News.md)**.

# **Visit us at [A2osX](http://www.a2osx.com)**

This is just a place holder and plug for our A2osx internet site.  Stay tuned here for news about this site.

## Disk images :

You can use and/or install A2osX from the media found in our Media directory found **[here](.Floppies)**.  The current set of available media includes:

| Image Name | Description !
| --- | --- |
| **A2OSX.BUILD.po** | 32MB disk image with S-C MASM 3.0, all binaries and all source for A2osX <br> This is primary development media for A2osX, especially pre-launch of Release, Stable and official Build Media.  See below.|
| A2OSX.MAKE.po | 32MB disk image with S-C MASM 3.0, all binaries and all source for multiple BUILD versions of A2osX stored in directories on MAKE.  The image also includes the TEST, ADMIN, and EXAMPLE scripts being created to support A2osX. |
| A2OSX.B800.po | An 800K 3.5" disk image containing the main BOOT and support files for running A2osX. |
| A2OSX.BOOT.po | An 140K 5.25" disk image containing the main BOOT and support files for running A2osX. |
| A2OSX.DEV.po | A 140K ProDOS disk image containing source code for A2osX.  Use is being discontinued. |
| BLANK32MB.po | A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin |
| BLANK800.po | A formatted empty ProDOS 3.5" 800K disk image, suitable for use with emulators such as AppleWin |
| BLANK140.dsk | A formatted empty ProDOS 5.25" 140K disk image, suitable for use with emulators such as AppleWin |

Please note, we plan to change the media set once 0.93 is officially released.  Currently, the BUILD media is the primary image used by the developers to hold the most current version of the A2osX binaries (and a copy of the source, although of course GitHub is the primary source repository). You can download the BUILD image and run in your favorite Apple II emulator or copy to CFFA, MicroTurbo or other Hard Disk emulator to boot, run, test and develop programs for A2osX.  Once 0.93 is released, we plan to update the media to include RELEASE, STABLE and BUILD editions of the media, like other projects you might find on GitHub; and each of these will include BOOT, INSTALL, SOURCE and EXTRA type media so that users and developers can BOOT or INSTALL A2osX to existing systems as they see fit.

## Requires :
Enhanced IIe (65c02 cpu) with 128k, //c, IIgs

## Documentation

A lot of work is being done to expand and enhance the documentation for A2osX.  Some of this documentation is still in the rough draft stage, but is being provided to bring you as much information about A2osX as quickly as possible.  We happily welcome any help and contributions from others to this or any area of the A2osX project.

The repository all A2osX documentation can be found **[here](.Docs)**.  This directory includes the system generated specifications for all the A2osX APIs as well as all our other documentation. 

### Technical Documentation

There are two types of Technical Documentation available.  First there is the Automatically Generated Documentation that is created from the source code of A2osX.  These documents capture all the internal A2osX APIs and system calls available to the A2osX programmer.  Developers should scan through these documents before beginning any A2osX project.  In addition, please make sure you look at the programming template file that is the best start to any A2osX program; it can be found **[here](.Docs/.TEMPLATE.S.txt)**.

In addition there is the developer generated Technical Specifications that document the internal and external A2osX commands, utilities and shell language.  The master technical spec file can be found **[here](.Docs/Technical%20Spec.md)**.

### User Guide

A draft of the first A2osX User Guide can be found on GitHub **[here](.Docs/User%20Guide.md)**.

### Notes for Developers

A draft of the first A2osX Notes for Developers can be found on GitHub **[here](.Docs/Notes%20for%20Developers.md)**.

