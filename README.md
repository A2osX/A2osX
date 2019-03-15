# A2osX (0.93) Multi-Tasking OS for Apple II  

## Introduction...

A2osX is an operating, programming and execution environment for the 128K Enhanced Apple //e and Apple //gs series of computers.  While layered atop of ProDOS, taking advantage of all ProDOS block devices and MLI calls; A2osX is much more than an application or command shell. Written in 65C02 assembly for speed of execution and efficient memory management; A2osX is a multitasking and yes multiuser development environment bringing many of today's server operating system features to our venerable vintage 8-bit systems. 

The foundation of A2osX enabling its multiuser multitasking capabilities is a reusable set of APIs and LIBs (written in Assembly) that all programs can and do use which make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different brand LAN cards via a set of drivers.  Key here is that multiple programs can be using the network at the same time such as the TELNETD server and the TELNET client.  One of the key benefits is code for doing each program is smaller because the network API is doing a great deal of the work.  With CORE APIs like printf and LIBs such as Network only loaded once (much like a DLL in Windows) memory is conserved, providing more resources to support your A2osX programs.

A2osX is designed to work on any "stock" 128k Apple //e, with no additional hardware with a 65C02 or newer processor.

See the **[documentation](#documentation)** section below to find the other resources available for learning how to install, use, develop and test A2osX.
 
## Latest News 2019-02-19

Major updates have occured to the kernel and many of the APIs to support an enhanced shell with support of many new scripting capabilities, the ability to redirect and eventually piping output.  Current kernel also supports multiple virtual terminals as well as TCP (via TELNETD) and serial (SSC driver) terminals.

If you would like to read all the past news articles for A2osX, you can read the news article found **[here](.Docs/News.md)**.

# **Visit us at [A2osX](http://www.a2osx.com)**

This is just a place holder and plug for our A2osx internet site.  Stay tuned here for news about this site.

## Disk images :

  

+ **A2OSX.BOOT.po**   :  **(0.92)**  140k BOOT disk image with all binaries  
+ **A2OSX.DEV.po**    :  **(0.92)**  140k disk image with ASM binaries, Debug Tools & INClude files  
+ **A2OSX.BUILD.po**  :  **(0.92)**  800k BOOT disk image with S-C MASM 3.0 and all binaries (BOOT+DEV)  
+ **A2OSX.SRC.po**    :  **(0.92)**  800k disk image with all sources  

## Requires :
Enhanced IIe (65c02 cpu) with 128k, //c, IIgs

## Documentation

Much work being done to expand and enhance the documentation for A2osX.  Some of this documentations are still in the rough draft stage but are being provided to bring you as much information about A2osX as soon as possible.  We happily welcome any help and contributions from others to this or any area of the A2osX project.

### User Guide

A draft of the first A2osX User Guide can be found on GitHub **[here](.Docs/User%20Guide.md)**.


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

## General Information:

Kernel API is confined in Aux LC Bank 1 & 2 to leave enough room at $EOOO for Drivers.
Network drivers, Mouse, DHGR.DRV can load and fit in Aux LC.
Now it's time to make all external BINs use new API, then GUI development will resume.

OApple+1,OApple+2,OApple+3 to switch between screens : Kernel Log, text, DHGR.
(OApple+shift+1,OApple+shift+2,OApple+shift+3 on FR keyboard)

## Misc

### S-C MASM color scheme for Notepad++
...drop _Tools/userDefineLang.xml in %APPDATA%\Notepad++
;-)

