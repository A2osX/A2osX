# A2osX (0.92) Multi-Tasking OS for Apple II  

## Latest News 2019-02-19

Major updates have occured to the kernel and many of the APIs to support an enhanced shell with support of many new scripting capabilities, the ability to redirect and eventually piping output.  Current kernel also supports multiple virtual terminals as well as TCP (via TELNETD) and serial (SSC driver) terminals.

## Latest News 2018-11-10

My loneliness has been cured, new resources have signed onto the project.  I welcome Patrick Kloepfer
who is helping with product management, recruitment, testing and feedback. 

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

