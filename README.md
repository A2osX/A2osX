# A2osX  (0.9)
Multi-Tasking OS for Apple II  
  
## Requires :  
Enhanced IIe (65c02 cpu) with 128k, //c, IIgs  
## Introduction...  
A2osX is a cooperative, event-driven multitasking kernel (meaning it is applications that are responsible to give back control to kernel)  
Its principal goal is to collect all "genius" 65c02 pieces of code ever written here and there, concentrated in the same environment.  
(including IP Stack & HTTPD/TELNETD..., GUI & graphical tools...)  
"Complete working place", no needing any more to reboot to switch between tons of diskettes!!!  
  
A2osX is designed to work on any "stock" 128k Apple //e with no hardware modification. As VBL signal is NOT available as an IRQ on //e (it is on //c & IIgs)  
it makes preemptive multitasking impossible.  
(Well, GSosX, 16 bits equivalent for IIgs, another project which is "cooking" in my mind, could do it!)  
Kernel, loading in Aux LC on top of ProDOS provide API inspired from Linux/Unix World to allow writing applications & command line tools on top of it.  
This kernel provides an advanced "Memory Manager" able to relocate 65c02 code.  
"Event Manager" makes TCPIP stack able to listen on several ports, manage ARP,DNS...cache expiration and any background processes.  
"Task Manager" is responsible to "distribute" CPU time to several loaded processes.  
"Device Manager" handles event collected from builtin devices as well as devices added by loadable drivers.  
  
If you're 65c02 or Z80 code writer, how to contribute ?  
  
Several subprojects are now indentified :  
  
+ Hardware Support : adding drivers to support more & more hardware (RAM cards, storage....)  
+ Z80 support : Kernel could pass control to any Z80 detected on the system.
+ TCPIP stack : TCP still missing!  
+ AppleTalk Support  
+ GUI & Printing  
+ Archive, Disk Image transfer tools (ADT client!)...  
+ Question : Pascal or C Compiler?  
+ ...sure there is some more!  
  
## Screenshots  
  
![](https://github.com/burniouf/A2osX/blob/master/ScreenShot.LS.bmp)  
![](https://github.com/burniouf/A2osX/blob/master/ScreenShot.EDIT.bmp)  
  

## General Information:  
 
** Kernel 0.9 complete rewrite in progress **  
 
(Kernel 0.8 has been archived)  
It is confined in Aux LC Bank 1 & 2 to leave enough room at $EOOO for Drivers.
Network drivers, Mouse, DHGR.DRV can load and fit in Aux LC.  
Now it's time to make all external BINs use new API, then GUI development will resume.
  
**A2OSX.BOOT.po** : 140k BOOT disk image with all binaries  
**A2OSX.DEV.po**  : 140k disk image with ASM binaries, Debug Tools & INClude files  
**A2OSX.SRC.po**  : 800k S-C MASM boot disk image with all sources  
  
OApple+1,OApple+2,OApple+3 to switch between screens : Kernel Log, text, DHGR.  
(OApple+shift+1,OApple+shift+2,OApple+shift+3 on FR keyboard)  
  
### **** Developers WANTED ****  
  
!!! Help on writing this code should be greatly appreciated !!!  
  
...  
In Progress : Document API...  
In Progress : moving TCPIP to socket API  
...  

## SYS/KM* Supported Hardware At Kernel Level (ProDOS):
| KM.Name | Status | Comment |
| ------- | ------ | ------- |
| KM.NSC | Working | No-Slot-Clock/DS1216E |
| KM.RAMWORKS | Working | AE-Ramworks I,II,III |
| KM.VSDRIVE | Working | ADTPro Virtual Drive for SSC |
| KM.APPLETALK | Working | AppleTalk Support for ProDOS |
  
## SBIN,Daemons/Commands:  
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| INSDRV | Working | | 0.9 |
| GETTY | Working | | 0.9 |
| LOGIN | In Progress | no auth using /etc/passd yet | 0.9 |
| SHELL | Working | (See Internal Shell commands) | 0.9 |
| TCPIP | In Progress | New Socket API. ARP,IP,ICMP,UDP ok, TCP in progress | 0.9 |
| DHCPCLNT | Working | rewritten to use new Socket API | 0.9 |
| TELNETD |  |  |  |
| HTTPD |  |  |  |
  
## Internal Shell commands:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| CD/PWD | Working | Improved syntax : now, 'CD ../BIN' works |
| DATE | Working  | |
| ECHO | Working | \b,\e,\f,\n,\\ and \% supported |
| EXIT | Working | |
| IF | | |
| PAUSE | Working | |
| READ | Working | -S : no echo (password) |
| | | -P : "prompt message" |
| TIME | Working | |
| SET | Working | |
| STARTPROC | Working | Used in A2osX.startup |
  
## Shell variables:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| $PWD | Working | 'Working Directory' |
| $* | Working | All Args |
| $1-$9 | Working | Arg[n] |
| $# | Working | Arg Count |
| $? | Working | Return Code |
| $@ | Working | Parent PID |
| $$ | Working | PID |
| $! | Working | Child PID |  

note : '$VAR' does NOT expand Variable  

## DRV,Drivers:  
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| Console.DRV | Working | ANSI support in Progress. | 0.9 |
| PIC.DRV | In Progress | Apple "Parallel Interface Card" Driver, renamed from PPIC.DRV | 0.8 |
| SSC.DRV | In Progress | Apple "Super Serial Card" Driver | 0.8 |
| SSC.I.DRV | In Progress | Apple "Super Serial Card" Driver (IRQ enabled) | 0.8 |
| Mouse.DRV | Working | Apple Mouse Card,//c Mouse Port | 0.9 |
| DHGR.DRV | In Progress | except bitblt... | 0.8 |
| Uthernet.DRV | Working | | 0.9 |
| Uthernet2.DRV | Working | | 0.8 |
| Uther2.AI.DRV | In Progress | With ARP/IP Offloading | 0.8 | 
| LanCeGS.DRV | Working | | 0.8 |
  
## BIN,External Shell commands:  
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| MEM | Working | Old dump behavior is now MEMDUMP.  New MEM command displays MEMSTAT (Main, Aux & Kernel Memory) | 0.9 |
| LSDEV | Working | | 0.9 |
| PS | Working | | 0.9 |
| MD | Working | | 0.9 |
| LS | Working | -A : Do Not Print . & .. | 0.9 |
| | | -L : long listing with size/date... | |
| | | -R : Recurse subdirectories | |
| RM | Working | -C : Continue On Error | 0.8 |
| | | -R : Recurse subdirectories | |
| CP | In Progress | -C : Continue On Error | 0.8 |
| | | -R : Recurse subdirectories | |
| | | -Y : Dont't Prompt For Override | |
| MV | In Progress | -C : Continue On Error | 0.8 |
| | | -R : Recurse subdirectories | |
| | | -Y : Dont't Prompt For Override | |
| CAT | Working | -A : Show All non printable caracters | 0.9 |
| | | -N : Number all output lines | |
| | | -S : Suppress repeated empty output lines | |
| EDIT | Working | still missing : find/replace | 0.9 |
| NSCUTIL | Working | Tool for setting time in NSC/DL1216E | 0.8 |
| ARP | Working | dump ARP cache, setup a static ARP entry | 0.9 |
| PING | Working | | 0.8 |
| DNSINFO | Working | dump DNS cache, setup a static DNS entry | 0.9 |
| IPCONFIG | Working | renamed from NETINFO | 0.9 |
| NETSTAT | Working | | 0.9 |
  
## BIN,External DEV Shell commands:  
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| ASM | In Progress | S-C MASM based multi CPU assembler | |
| DEVDUMP |  | | 0.8 |
| MEMDUMP | Working | | 0.9 |
| RPCDUMP | Working | tool based on UDP socket API, renamed from RPCINFO | 0.9 |
  
## Misc  
### S-C MASM color scheme for Notepad++  
...drop _Tools/userDefineLang.xml in %APPDATA%\Notepad++  
;-)

