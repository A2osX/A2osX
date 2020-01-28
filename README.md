# A2osX (0.93) Multi-Tasking OS for Apple II  

### Updated January 27, 2020

## A2osX Release Candidate now available

See the **[news](#news)** section below for more information.

![](./.screen-shots/ScreenShot.Logo.png)

If you would like to see more screen shots of A2osX click **[here](.Docs/Screen%20Shots.md)**.

## Introduction...

A2osX is an operating, programming and execution environment for the 128K Enhanced Apple //e and Apple //gs series of computers.  While layered atop of ProDOS, taking advantage of all ProDOS block devices and MLI calls; A2osX is much more than an application or command shell. Written in 65C02 assembly for speed of execution and efficient memory management; A2osX is a multitasking and yes multi-user development environment bringing many of today's server operating system features to our venerable vintage 8-bit systems. 

The foundation of A2osX enabling its multi-user multitasking capabilities is a reusable set of APIs and LIBs (written in Assembly) that all programs can and do use which make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different brands of LAN cards via a set of drivers.  In addition, multiple programs can be using the network at the same time such as the TELNETD server and the TELNET client.  A key benefit is that code for each program is smaller because the network API is doing a great deal of the work.  With CORE APIs like printf and LIBs such as Network loaded only once (much like a DLL in Windows) memory is conserved, providing more resources to support your A2osX programs.

## Requires...

A2osX is designed to work on any 128k Enhanced Apple //e or newer computer.  Specifically, A2osX relies on the enhanced instruction set found in the 65C02 processor (this includes the 65C816 found in the //GS).  A2osX will not run on an Apple ][ or ][+, a non enhanced //e or on systems without at least 128K of memory.  A2osX does not require any special hardware cards, but does support and its operation can be enhanced with the presence of a mass storage devices (any ProDOS block device), a network card, Super Serial Card and/or a Time Card.

Consult the **[documentation](#documentation)** section below to find other resources available to you for learning how to install, use, develop and test A2osX.  The Hardware section of the User Guide contains more information on tested and supported hardware.

## News...

**2020-01-27** - **Major update to A2osX 0.93**

The A2osX team is proud to announce the availability of two new versions of ProDOS, one with a very minor tweak and the other a major update/overhaul.  There is ProDOS 2.03tc which is an 8 byte patch to ProDOS 2.03 to update the year table to support years through 2023 and ProDOS FX, a **F**aster and e**X**tended version, that adds many new features including lower case file, directory and volume name support.   These new versions are already being included in the latest **Stable** media and will become the versions of ProDOS supplied on all future media.  The team added a new Document to our repository that covers these and other publically available versions of ProDOS and their use with A2osX.

A2osX now act actually has for quite some time supports lower case in file, directory and volume names as long as this capability is available in the version of ProDOS you are running.  Consult the new **[A2osX and ProDOS](.Docs/ProDOS.md)** document for more information and a table on which versions of ProDOS provide this capability to A2osX.

The *EDIT* utility has undergone a major update.  We need your testing and feedback.  Please make sure to open issues on any anomalies you discover.

Kernel/Shell rewrite to move more things to AUX freeing main mem.  with 2 tty used to be 22K free.  Now. 26.5K  with 1TTY 28.4K.  of course with 8 TTY  17.5K

Speaking of changing the number of virtual TTYs, A2osX has been enhanced to now support up to 8 virtual terminals on the console, configurable with the KCONFIG utility.  Consult the User Guide for more information.  Note that with 8 virutal TTYs defines, available main memory drops to 17.5K.  Open Apple 1 through 8 is used to be switched between the virtual terminals, Open Apple-0 is still used to access the A2osX Console (displays system errors and information) and Open Apple-9 is reserved for future use of DHGR (Double High-res Graphics).

A new bell option (**Echo \a**) has been added to the *echo* command in the shell (*/bin/sh*) to ring a bell on VT-100 connected terminals (via the SSC driver or the TELNETD deamon).  The bell has no affect on the console.

Multiple bugs have been address from issues posted on GitHub including updates to *cut*, *format*, *sh* (for internal command), *nscutil*, *ping*, *wc*, and many more.  Users can check the status of issues or create new ones for A2osX on **[Github](https://github.com/burniouf/A2osX/issues)**.

A great new networking utility, *wget* is now available which can be used to access/post to web servers.  This utility can be used in combination with services like IFTTT to send tweets from A2osX, or send message to apps like Slack.

If you would like to read all the past news articles for A2osX, you can read the news article found **[here](.Docs/News.md)**.

## **Visit us at [A2osX](http://www.a2osx.com)**

This is just a place holder and plug for our [A2osX](http://www.a2osx.com) internet site.  Stay tuned here for news about this site.  We have created a Page to discuss A2osX on **[Facebook](https://www.facebook.com/A2osx-372512896625840/)** and have a new **[Twitter](https://twitter.com/A2Osx)** handle to test new A2osX features which will soon be used as a messaging channel, so please follow.

## Disk images...

You can use and/or install A2osX from the media in our Media directory found **[here](.Floppies)**.  Provided media includes **Release**, **RC** (Release Candidate), **Stable** and **Bleed** (Cutting Edge) editions in 140K, 800K and 32MB images.  Please consult our **[Media Guide](.Docs/Media%20Guide.md)** for more information.

## Documentation...

The A2osX team is pleased to report that great strides have been made in terms of documentation.  While much of it is in draft form, there is a new **[Users Guide](.Docs/User%20Guide.md)**, **[Developers Guide](.Docs/Developers%20Guide.md)**, **[Shell Developers Guide](.Docs/Shell%20Developers%20Guide.md)**, **[Technical Spec](.Docs/Technical%20Spec.md)** and **[Command Guide](.Docs/Command%20Guide.md)**.   Work continues to expand and enhance the documentation for A2osX.  While still under construction, it is provided to you to bring you as much information about A2osX as quickly as possible.  We happily welcome any help and contributions from others to this or any area of the A2osX project.  The repository all A2osX documentation can be found **[here](.Docs)**.  This directory includes the system generated specifications for all the A2osX APIs as well as all our other documentation. 

### Technical Documentation...

There are two types of Technical Documentation available.  First there is the Automatically Generated Documentation that is created from the source code of A2osX.  These documents capture all the internal A2osX APIs and system calls available to the A2osX programmer.  Developers should scan through these documents before beginning any A2osX project.  In addition, please make sure you look at the programming template file that is the best start to any A2osX program; it can be found **[here](.Docs/.TEMPLATE.S.txt)**.

In addition, there is the developer generated Technical Specifications that document the internal and external A2osX commands, utilities and shell language.  The master technical spec file can be found **[here](.Docs/Technical%20Spec.md)**.

## How You Can Help

The A2osX Team welcomes your help in making this the best operating enviroment for the Apple 2!  Specifically, the more users who can test the most current RELEASE, CANDIDATE or STABLE media on their unique and report back their findings, the better A2osX becomes.  In additions, comments on, suggestions, or contributions to our documentation are greatly appreciated.  Lastly, A2osX would not be what it is without our great core development team. We could certainly use more developers, especially in Assembly (S-C Assembler familiar even better) to contribute new utilities, applications and features for A2osX.

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

Copyright 2015 - 2020, Remy Gibert and the A2osX contributors.
