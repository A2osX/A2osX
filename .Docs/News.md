# A2osX Multi-Tasking OS for Apple II  

## News 2024-01-21

A2osX 0.95 build 2666 has been released.

New features:

* First release of `netconfig` tool, a LIBTUI program for editing network configuration.
* First release of LIBTUI-based `man` tool, and a few man pages to go along with it.

Issues fixed:

* [#211 - INCLUDE needs to be set in release profiles](https://github.com/A2osX/A2osX/issues/211)
* [#210 - FOR loop crashes on LOOP ending](https://github.com/A2osX/A2osX/issues/210)
* [#209 - PAKME running out of memory compressing kernel)(https://github.com/A2osX/A2osX/issues/209)
* Several non-documented bugfixes and improvements.

Build 2666 is available as 32MB, 800KB, 140KB, and net update.

 

## News 2024-01-17

It has been a long time since the news has been updated, but that doesn't mean that development on A2osX has ceased in the last 4 years! We've actually had quite a number of releases over this time. In general, stability has been greatly improved but there have also been additions like BASIC.FX which is a ProDOS BASIC.SYSTEM environment which supports a number of ProDOS FX extensions (RamWorks III and extension commands for starters).

As far as where things are going now, development is underway on Kernel 1.0 which will finally bring support for breaking past the 128KB barrier of the //e series by supporting RamWorks-type memory cards. In the past, RamWorks boards were supported but would only allow for /RAM type storage. With Kernel 1.0, up to 8MB of RAM can now be used for code and applications! Early builds of the new kernel are expected in 1H 2024.

With current builds and all going forward, the distributions are only shipped with [ProDOS FX](ProDOS.md) by default. While 2.0.3tc is still available and can be used with A2osX, the recommendation is now to use FX because of the filename case handling in addition to the number of under-the-hood improvements that FX offers. Both FX and 2.0.3tc's clock tables have been updated for 2024.

We are currently looking for volunteers to help with flushing out the C libraries! A C89-compliant compiler is available, however, the API needs some work to be compliant and can result in changing the kernel's APIs too, so "the sooner, the better" as the saying goes. Want to help? Reach out on the Slack server!

Finally, we are always looking for people to help! A project as complicated at A2osX requires a lot of testing, but we always need help with creating new applications, libraries, and documentation. If you have some applicable skills, let us know!


## News February 10, 2020

A2osX Version 0.93 Release Candidate has been finalized.  Media for this release, based on Build 193x are now available.  Future STABLE and BLEED builds will be based on work to complete 0.94.  Work has already started to make the A2osX API fully C compliant.  This will allow a new CSH shell and CC compiler to be added to A2osX as well as an enhanced web server (*httpd*) that can serve active server pages formed by user created CSH scripts.  In addition, Double High Graphics Resolution (DHGR) and Mouse drivers are being finalized which will allow developers to create games and new user interfaces for their A2osX applications.

## News 2020-01-27

Major update to A2osX 0.93

The A2osX team is proud to announce the availability of two new versions of ProDOS, one with a very minor tweak and the other a major update/overhaul.  There is ProDOS 2.03tc which is an 8 byte patch to ProDOS 2.03 to update the year table to support years through 2023 and ProDOS FX, a **F**aster and e**X**tended version, that adds many new features including lower case file, directory and volume name support.   These new versions are already being included in the latest **Stable** media and will become the versions of ProDOS supplied on all future media.  The team added a new Document to our repository that covers these and other publically available versions of ProDOS and their use with A2osX.

A2osX now act actually has for quite some time supports lower case in file, directory and volume names as long as this capability is available in the version of ProDOS you are running.  Consult the new **[A2osX and ProDOS](ProDOS.md)** document for more information and a table on which versions of ProDOS provide this capability to A2osX.

The *EDIT* utility has undergone a major update.  We need your testing and feedback.  Please make sure to open issues on any anomalies you discover.

Kernel/Shell rewrite to move more things to AUX freeing main mem.  with 2 tty used to be 22K free.  Now. 26.5K  with 1TTY 28.4K.  of course with 8 TTY  17.5K

Speaking of changing the number of virtual TTYs, A2osX has been enhanced to now support up to 8 virtual terminals on the console, configurable with the KCONFIG utility.  Consult the User Guide for more information.  Note that with 8 virutal TTYs defines, available main memory drops to 17.5K.  Open Apple 1 through 8 is used to be switched between the virtual terminals, Open Apple-0 is still used to access the A2osX Console (displays system errors and information) and Open Apple-9 is reserved for future use of DHGR (Double High-res Graphics).

A new bell option (**Echo \a**) has been added to the *echo* command in the shell (*/bin/sh*) to ring a bell on VT-100 connected terminals (via the SSC driver or the TELNETD deamon).  The bell has no affect on the console.

Multiple bugs have been address from issues posted on GitHub including updates to *cut*, *format*, *sh* (for internal command), *nscutil*, *ping*, *wc*, and many more.  Users can check the status of issues or create new ones for A2osX on **[Github](https://github.com/burniouf/A2osX/issues)**.

A great new networking utility, *httpget* is now available which can be used to access/post to web servers.  This utility can be used in combination with services like IFTTT to send tweets from A2osX, or send message to apps like Slack.## Latest News 2019-12-05

Media have been updated based on Build 1784.

## News 2019-10-31

Media have been updated based on Build 1694.  This version fixes issues with Piping of commands, adds new READ functionality.  Please note, KM.NSC is no longer loaded by default on any media.  If you have a No Slot Clock in your system, you should move the file KM.NSC from ./SYS/KM into ./SYS which will make it load on boot.

## News 2019-10-26

Starting with Build 1675, the SH(ell) command **TIME** has been removed and the **DATE** command will now return both the Date and Time.  Additionally, if DATE command has been updated to support options for returning formatted strings with just the portions of the date and time you desire.  Consult the Shell Developers Guide for syntax.

## News 2019-10-24

Created STABLE images with Build 1669 with improvements to TCP networking.  There is also a new DEBUG 140k disk image.  See the media guide for more info.

## News 2019-10-22

Updated RC images to Build 1664 which fixed RESTART SYSTEM bug on //GS.

## News 2019-10-19

Updated RC images to Build 1653 which fixed bugs in CUT and includes a patched version of ProDOS 2.03 to correct year display for ThunderClocks.

## News 2019-10-18

Updated A2osX Release Candidate based on Build No 1650 is now available and can be found in our **[Media directory](.Floppies)**.  In addition, a new disk image **TDBOOT** has been created that is preconfigured to automatically load Uthernet2 driver, start network services and launch the TelnetD server process (hence name TD for TelnetD Boot).

## News 2019-10-15

**The first A2osX Release Candidate is now available and can be found in our [Media directory](.Floppies)**.  

## News 2019-04-19

Major updates have occurred to the kernel and many of the A2osX API's to support a greatly enhanced shell that boasts significant new scripting capabilities since 0.92.  Also added is the the ability to redirect input and output, including errors, and the ability to pipe (|) the output of one command or operation to another (i.e. **ls \* | more** ).  A2osX now provides for multiple virtual terminals as well as users/terminals via TCP (through TELNETD) and serial devices (through a SSC driver).

As great as the changes to A2osX itself, we are also please to report that great strides have been made in terms of documentation.  While much of it is in draft form, there is a new **[Users Guide](User%20Guide.md)**, **[Developers Guide](Developers%20Guide.md)**, **[Shell Developers Guide](Shell%20Developers%20Guide.md)**, **[Technical Spec](Technical%20Spec.md)** and **[Command Guide](Command%20Guide.md)**.  See the **[Documentation](#documentation)** Section below for more details.

## News 2019-02-19

Major updates have occurred to the kernel and many of the APIs to support an enhanced shell with support of many new scripting capabilities, the ability to redirect and eventually piping output.  Current kernel also supports multiple virtual terminals as well as TCP (via TELNETD) and serial (SSC driver) terminals.

## News 2018-11-10

My loneliness has been cured, new resources have signed onto the project.  I welcome Patrick Kloepfer who is helping with product management, recruitment, testing and feedback. 

## News 2018-09-06

0.92 stable enough to resume playing with.
Many 0.9.1 bugs already corrected in this version, please check & close opened issues.

## News 2018-07-20

Kernel & some BINs/SBINs migrated to 0.92.

## News 2018-06-17

Ok, as i'm still the lone developer here, i decided to break the kernel, HAHAHAHAHAHA!!!!
I updated the Calling Convention (see projects), i now setup the header in each KERNEL.S.* file accordingly to generate doc, then i change the code...

So ....nothing works anymore on the A2OSX.BUILD media...

## News 2018-06-13

Previous (relatively!) stable version 0.9.1 has been archived, see link above.  

Roadmap for 0.9.2:
 + Organize this roadmap in projects (anybody interested in a PM job ?)
 + Organize Testing (Testers wellcome)
 + NET : TCPIP Network services, AppleTalk (Coders wellcome)
 + GUI : Window Manager (Coders wellcome)
 + DEV : ASM, CSH, C compiler, someone suggested PLASMA (Coders wellcome)
 + release Version 1.0.0
 
Sub projects:
 + Finalize enhanced STDIO (Buffered IO)
 + Link UDP/TCP sockets to new STDIO
 + Rewrite Driver interface (SmartPort Protocol) and link to STDIO
 + establish parameter passing convention (C-like Stack frame)
 + Move all LIBs to this new convention to allow preemtive mode for LIBs
 + AT commands (Appletalk)
 + TELNETD/HTTPD/NFSD (STDIO)
 + GUI : Window Manager, Controls...
 + Assembler (AUX mem manager) will allow A2osX to build entirely itself every night!
 + Shell CSH (MATH API, AUX mem manager)
 + C compiler (Stack Frame, MATH API, AUX mem manager)
 + Disk II format (LIBBLKDEV)
 + Simple compression API (LIBPAK)
 + CSH+LIBPACK -> A2osX Installer
 + TCPIP+SSC DRV+LIBBLKDEV -> ADT Client
 + /etc/passwd (LIBCRYPT)

I need :
 + someone able to handle project management so i can focus on code writing
 + developers interested in one of these subjects above
 + someone able to build a test plan
 + ....ideas...help....support....beer, or something stronger! 

## News 2018-05-29

Time to work on STDIO : 

 + Buffered IO to link TCP/IP stream sockets properly to STDIN,STDOUT,STDERR (TELNETD)
 + Implement missing STDIO functions (Puts, FPuts...)
 + Faster Console output
 + Better 'C-Like' API

Scope : KERNEL.STDIO, All drivers, CDEV, FIFO,...

Goal : TELNETD & HTTPD working.

Wanna play ? 

## News 2018-04-29

Kernel 0.9.1 is now preemptive. 

It defaults to cooperative mode ('P'olling mode). For this, no particular hardware needed (except 65c02 and 128k, of course!)

If you want to enable preemptive mode, all you need is a "tick" source to get 'V'BL or 'C'lock Mode.
(see below for supported hardware)

Then you must explicitly ENABLE it using KCONFIG utility. (see screenshot below)

You can monitor the kernel state on the 'SYS' screen (OA-1, or SHIFT-OA-1 on french keyboards) and look at the upper right corner, you should see a blincking 'P', 'V' or 'C', showing you the current kernel state..

If you enabled preemptive mode, you should see an additional blinking 'S', each time the kernel switch from one PS to another.

Reminder : 
 + (SHIFT)-OA-1 : Kernel SYS Screen
 + (SHIFT)-OA-2 : Console Screen (Shell...)
 + (SHIFT)-OA-3 : DHGR Screen (if loaded)

For now, only SBIN/BIN executables are "switcheable". 

Roadmap is as follow: 

 + Check all BIN/SBIN sources to make them preemptive compliant, most of them are NOT. 
 + Add a way to make LIB also interruptible and reentrant.
 + Add more supported hardware for system clock.
 + ...and  still hoping finding few contributors.... :-(

## News 2017-11-08

Kernel 0.9.1 stable enough to resume building.

 + KM.APPLETALK module not crashing anymore  
   (Undocummented AtInit function, had to go further in official ATINIT disassembly) 

 + Improved Command Line editing and history. 
   (SUPPR key is emulated with Ctrl-X using //e keyboard)

 + New DevMgr enumeration strategy, now including /RAM and other virtual Block Devices 
 
 + Math API (Hacked from APPLESOFT ROM ;-)

 + CSH Script engine within Shell (In progress)
 
## News 2017-09-22

(once Kernel 0.9.1 stable enough, BOOT & DEV will be updated) __(done!)__

**0.9 has been archived, next Kernel Version is 0.9.1**  
   
 + More Standard C API compliance __(done!)__
 + API Cleanup, many functions still use shared space __(done!)__
 + Per process Stack Segment __(done!)__
 + Larger S.PS structure __(done!)__
 + ...
 + to allow...Preemptive!

__A new attempt using Mouse card VBL IRQ is targeted in 0.9.1.__

Kernel, loading in Aux LC on top of ProDOS provide API inspired from Linux/Unix World to allow writing applications & command line tools on top of it.
This kernel provides an advanced "Memory Manager" able to relocate 65c02 code.
"Event Manager" makes TCPIP stack able to listen on several ports, manage ARP,DNS...cache expiration and any background processes.
"Task Manager" is responsible to "distribute" CPU time to several loaded processes.
"Device Manager" handles event collected from builtin devices as well as devices added by loadable drivers.

If you're 65c02 or Z80 code writer, how to contribute ?

Several subprojects are now indentified :

+ Hardware Support : adding drivers to support more & more hardware (RAM cards, storage....)
+ Z80 support : Kernel could pass control to any Z80 detected on the system.
+ TCP/IP stack
+ AppleTalk Support
+ GUI & Printing
+ Archive, Disk Image transfer tools (ADT client!)...
+ Question : Pascal or C Compiler? 
+ --> Answer : C compiler....Next version of Kernel API will be closer to STDLIBC, Genralize the use of C-Strings
+ ...sure there is some more!

**"System Tick" sources for preemptive mode :**

| Hardware                 | Resolution | Status      | Comment |
| -------------------------| ---------- | ----------- | ------- |
| //c,//c+,IIgs Mouse port | 50/60 Hz   | Working     | Supported at Kernel level, no conflict with GUI's Mouse.DRV (not required to be loaded), requires setting "Machine Timing" properly in KConfig Utility |
| IIe Mouse Card           | 50/60 Hz   | Working     | (same as above) |
| ThunderClock Plus        | 64 Hz      | Working     | gave up fixing this faulty H/W, thanx to JACE emulator! |
| Super Serial Card |      ?      | Idea, from EtchedPixels | #31 |
| MockingBoard     |      ?      | Idea, from Michael |  |
| GOES Irq Card  |      ?      | Idea, from Oliver | #34 |
| ... Any Other suggestion ?     |            |             |  |

## !!!HELP NEEDED!!!

Thanx a lot for all positive comments i read here and there, but i definitively need contributors & testers.

Anybody wants to join this project ?

If you're interested on contributing, please send a message with your skills and in which area you are interested to work on (Network, Kernel, device drivers for additional hardware support, GUI, graphical resourses, command line tools....)

This is some sort of "last hope call", some of you were right, this project is really huge!!! 
Anyway, i'm convinced that a small team of developers could reach "version 1.0" with GUI & network support in few months....i'm working on it for...4 years now, spending the most of my free time fixing hardware to test this code instead of...writing it! 

Well, let me know if you can bring "fresh blood" to this stuff... 

## License
A2osX is licensed under the GNU General Public License.

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

Copyright 2015 - 2024, Remy Gibert and the A2osX contributors.
