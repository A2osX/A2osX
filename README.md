# A2osX (0.92) Multi-Tasking OS for Apple II  

## Disk images :  

+ **A2OSX.BOOT.po**   :  **(0.92)**  140k BOOT disk image with all binaries  
+ **A2OSX.DEV.po**    :  **(0.92)**  140k disk image with ASM binaries, Debug Tools & INClude files  
+ **A2OSX.BUILD.po**  :  **(0.92)**  800k BOOT disk image with S-C MASM 3.0 and all binaries (BOOT+DEV)  
+ **A2OSX.SRC.po**    :  **(0.92)**  800k disk image with all sources  

## Latest News 2019-02-19

Major updates have occured to the kernel and many of the APIs to support an enhanced shell with support of many new scripting capabilities, the ability to redirect and eventually piping output.  Current kernel also supports multiple virtual terminals as well as TCP (via TELNETD) and serial (SSC driver) terminals.

## Requires :
Enhanced IIe (65c02 cpu) with 128k, //c, IIgs

## Introduction...
A2osX is a cooperative, event-driven multitasking kernel (meaning it is applications that are responsible to give back control to kernel)
Its principal goal is to collect all "genius" 65c02 pieces of code ever written here and there, concentrated in the same environment.
(including IP Stack & HTTPD/TELNETD..., GUI & graphical tools...)
"Complete working place", no needing any more to reboot to switch between tons of diskettes!!!

A2osX is designed to work on any "stock" 128k Apple //e, with no additional hardware. As VBL signal is NOT available as an IRQ on //e (it is on //c & IIgs)
it makes preemptive multitasking impossible.

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

