# A2osX Command Guide

This Guide provides information on all the A2osX commands and utilities.  This Guide helps you not only learn the purpose of each command but also what options a command supports and what arguments it either supports or requires.

A2osX comes with a nice variety of system, file, network and data utilities -- what we refer to as external commands.  This just means that each of the following commands or utilities is built as a separate BIN or executable file that runs under A2osX.  The source for all of these external commands is readily available, so you can make your own or modify these as your needs dictate.

>Note: there are some **internal** commands built into the shell (the interactive prompt) such as CD (change directory) or PWD (print working directory).  Those commands are discussed in-depth in the **[Shell Developers Guide](.Docs/Shell%20Developers%20Guide.md).**  

## System Commands

Typcically, you will not directly use the System group commands; they are more commonly found in A2osX system scripts such as ./ETC/INIT or they are launched by the A2osX Kernel itself.  All of these commands are found in **./SBIN/** letting you know they are special system commands.

### CIFSD

| Command  |
| ---  |
| CIFSD  \< ip \| host \> sharename mountpoint |

CIFSD is a utility for mounting CIFS shares as volumes on A2osX.  This utility is in development and is targeted for a future release of A2osX.

### GETTY

| Command | Options |
| --- | --- |
| GETTY | -E : Exit upon disconnect |

GETTY, short for "get tty", is a system process for A2osX that manages physical or virtual terminals (TTYs). When it detects a connection, it prompts for a username and then loads the system process LOGIN to authenticate the user.  Each GETTY process creates a pseudo file such as /DEV/TTY1 or /DEV/TTY2 to allow A2osX pass input/output streams between processes and connected users.

GETTY handles 3 types of connections:
  * *virtual terminals* presented and controlled by your Apple Screen and Keyboard.  One GETTY process serves one virtual terminal.  You can configure the number of virtual terminals on your A2osX system using the KCONFIG utility.  Please see **[KCONFIG](#kconfig)**.
  * *serial terminals* (or emulated terminals i.e. a PC running a VT-100 emulator) connected to your Apple via a Super Serial Card.  One GETTY process serves one terminal.  See the User Guide for setup and configuration information on connecting Physical Terminals.
  * *internet terminals* connected to your Apple via the internet using the A2osX TCP networking suite.  This suite includes a TELNETD server process that listens for requests from the internet and when such a request is initiated, TELNETD will launch a GETTY process to support that user.  One GETTY process will launch for each TELNET user and will exit when then user disconnects (the TELNETD process calls GETTY with the -E option). 

### HTTPD

| Command |
| ---- |
| HTTPD |

This is a stub, or a placeholder, for a new service being added to A2osX.  It will provide simple web services.  Full implementation is targeted for 0.94.

### INITD

| Command |
| ---- |
| INITD RunLevel |

This is a stub, or a placeholder, for a new routine being added to A2osX.  It will replace part of the startup process and allow for different run levels to be initiated included RunLevel 0 or shutdown.  Full implementation is targeted for 0.94.

### INSDRV

| Command |
| ---- |
| INSDRV Driver |

INSDRV, short for "install driver", is a system process that loads and initializes hardware drivers for A2osX.  Drivers are available for the Apple Mouse, Super Serial Card, and a range of Ethernet cards.  Please see the Hardware section of the User Guide for more complete information on the drivers available for A2osX and enabling them in your system.

### KCONFIG

| Command |
| ---- |
| KCONFIG |

![](../.screen-shots/ScreenShot.KCONFIG.png)

KCONFIG, short for "Kernel Configuration" Utility, is a system program that allows the A2osX administrator to configure various settings of their A2osX system.  Any changes to your system configuration are stored in ${ROOT}/A2OSX.KCONFIG.  When A2osX boots and loads the KERNEL process, it looks for this file, and if not present it initializes the KERNEL with A2osX defaults.

In KCONFIG you can set:
- Machine Timing, either 60 (Default) or 50Hz.  If you change this RGXX will happen.
- CHRoot to /RAMx, either Disabled (Default) or Enabled.  Enabling does RGXX.
- Preemptive Mode, either Disabled (Default) or Enabled.  Enabling does RGXX.
- TTYs, between 1 and 4, default is 2.  This is the number of Virtual Terminals configured on your system.  Please note, increasing and decreasing the number of virtual terminals can have a significant impact on the amount of memory used by the system, which in turns impacts the amount of free memory available to run your A2osX programs and scripts.
- Slots 1-7, Enabled (Default) or Disabled.  If you disable a slot this RGXX will happen.

### LOGIN

| Command |
| ---- |
| LOGIN |

LOGIN is a system process for A2osX that authenticates users against the A2osX User Database stored in ./ETC/PASSWD.  Once a user is authenicated, LOGIN then loads the SH (./BIN/SH) process passing it the PROFILE script found in the users ${HOME} directory.

### NETWORKD

| Command |
| ---- |
| NETWORKD networklibrary [networklibrary] ... |

This system command loads one or more network libraries to provide network services to A2osX applications and utilities such as Telnet, TelnetD and HTTPD.  Note, the appropriate Ethernet card driver must first be loaded before attempted to load network libraries.  In most cases, network services will be started with a script or as part of the boot process that will load the appropriate drivers, libraries and service programs in the right order.  Consult the User Guide for more information on A2osX networking.

### TELNETD

| Command | Options |
| ----- | --- |
| TELNETD | -d [port] : Specify optional port |

TELNETD is a server process that listens for incoming requests to connect to your A2osX system.  By default it listens on Port 23.  You can change the Telnet Server port by starting the TELNETD process with the --d option and specifying an alternate port.  Typically this would be used to get around local firewall or port restrictions.  One example, is if you are running yoru server at home on a DSL or Cable connection your provider might block port 23.  In addition, if you are running in an environment with only one public IP address and you have another system at that site already running a Telnet server, you can use this option to move your Apple to alternate port.

When TELNETD detects an incoming request it starts a GETTY process and creates a virtual internet terminal for the user and begins the LOGIN process same as the system would for a hardwired terminal.  Note TELNETD requires that you have a supported ethernet card and have configured your system for a network appropriately.

## BIN,External Shell commands:

### BMP2PIX

| Command | Options |
| ----- | --- |
| BMP2PIX BMP-File | -V : Versbose Mode |

BMP2PIX is a graphics conversion utility that will make PIX format files from standard PC format BMP graphics files.  The PIX format is used by A2osX to display logos and icons.

### CAT

| Command | Options |
| --- | --- |
| CAT filename | -A : Show All non printable caracters <br> -N : Number all output lines <br> -S : Suppress repeated empty output lines |

The CAT command is used to display the contents of files stored on any ProDOS volume.  While the primary use of this tool is to display the contents of TEXT or TXT files, it can be used to display the contents of other files by using the -A option, which will substitute non-printable characters with readable and displayable values such as [EOF] for End of File (Hex x04) or [LF] for Line Feed (Hex x0A).  In addition you can use the -N option to display the listing of a file with line numbers.

As an example, if you had a text file called CATTEXT with the following lines:

    Start of Cattext
	
	
	End of Cattext

Then if you executed at the A2osX prompt:

    /A2OSX/ROOT/$ CAT -N CATTEXT

You would get:

----------
>      1: Start of Cattext
> 	   2:
> 	   3:
> 	   4: End of Cattext
----------

If you did CAT -N -S CATTEXT to suppress the extra blank lines you would see:

----------
>      1: Start of Cattext
> 	   2:
> 	   4: End of Cattext
----------

Note that the numbering of the lines didn't change, because that is their true number in f the file, but CAT removed the redundant blank lines.  Whether there are 2 or 200 blank lines in a row, they will be reduced to just 1.

### CUT

| Command | Options |
| --- | --- |
| CUT \<opt\> "line"   or  <br>  CMD \| CUT \<opt\> |  -H : This help screen <br> -F nn : Output field nn <br> -M nn : Output starting at nn <br> -N nn : Output Ending at nn <br> -S ch : Change default SPACE separator to 'ch' |

The CUT command is used to extract a subpart or portion of a string.  Use this command to simply extract substrings much like Basic's MID, LEFT, or RIGHT might be used. It can also be used within the powerful FOR NEXT construct to process fields of columns from files or the output of processes.

As an example, normally when you execute the **LS -L /** command you get output similar to:

    /A2OSX.BUILD/ROOT/$ LS -L /                               
    /RAM3            S3D2 Blocks Used:8 Total:16000                               
    /A2OSX.BUILD     S7D1 Blocks Used: 3230 Total:65535                               
    /MAKE            S7D2 Blocks Used:48946 Total:65535                               

Now, if instead we execute the follow command at the shell prompt:

    /A2OSX.BUILD/ROOT/$ FOR F IN `LS -L /`;ECHO $F;NEXT                                
    /RAM3            S3D2 Blocks Used:8 Total:16000                                
    /A2OSX.BUILD     S7D1 Blocks Used: 3230 Total:65535                                
    /MAKE            S7D2 Blocks Used:48946 Total:65535                                

It looks like the same results, but from now instead of LS simply outputting all of its results at once, each line is being passed to the FOR loop (as VAR $F) where we simply ECHO it.  Now imagine if instead we passed $F to CUT, we can display only specific columns of information as seen in these two examples:

    /A2OSX.BUILD/ROOT/$ FOR F IN `LS -L /`;CUT -M 00 -N 15 $F;NEXT                  
    /RAM3                                                                           
    /A2OSX.BUILD                                                                    
    /MAKE                                                                           

    /A2OSX.BUILD/ROOT/$ FOR F IN `LS -L /`;CUT -M 17 -N 21 $F;NEXT                  
    S3D2                                                                            
    S7D1                                                                            
    S7D2                                                                            

### CHGRP

| Command | 
| --- | 
| CHGRP |

This command is not currently implemented.

### CHMOD

| Command |
| --- | 
| CHMOD |

This command is not currently implemented.

### CHOWN

| Command | Options |
| --- | --- |
| CHOWN | -C : Continue On Error <br> -R : Recurse subdirectories |

This command is not currently implemented.

### CHTYP

| Command | Options |
| --- | --- |
| CHTYP  File Type| -C : Continue On Error <br> -R : Recurse subdirectories |

This utility allows you to change the type of a file to a standard files types such as SYS or TXT or to any 2-byte hex code.

### CMP

| Command | Options |
| --- | --- |
| CMP File1 File2 [SKIP1 [SKIP2]]| -A : Shows All differences <br> -V : Verbose Mode |

CMP  will compare two files to determine if they are byte for byte equal.  If the files are equal CMP exits normally with an exit code of 0.  If the files have one or more bytes that are different, CMP will exit with an application error code of 223 (hex E0).  By using the Verbose option you can see the offset and values of the first different byte.  With the Verbose and All options you can see the list of all offsets and values that are different.  The SKIP options allow you specify a number of bytes to skip in the file(s) before starting the comparison.  CMP A B 100 200 would skip to the 100th byte of A and the 200th byte of B before starting the byte by byte comparison.  Note then that B would need to be 100 bytes larger then A for the comparison to ever end without error.

### CP

| Command | Options |
| --- | --- |
| CP | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override | 0.93 |

CP, which stands for Copy, is one of the most powerful commands in A2osX.  Not only can it copy files from one ProDOS volume to another, it can copy entire directories or even directory trees from volume to volume, or to another location on the same volume.  This recursive nature allows you to use a single command to copy the contents of an entire ProDOS volume with a single command.  CP also supports wild cards so that you can copy just those files matching a pattern.

### CSH

| Command |
| --- |
| CSH Script |

CSH is one of the interactive and script processing shells under development for A2osX. The CSH is similar to the C Shell in Linux and uses the C syntax structure for scripting.  This shell is under development.  A CSH Shell Developers Guide will be available when a release candidate for this shell becomes available.

### EDIT

| Command | 
| --- | 
| EDIT [filename] | 

The EDIT command allows the user to interactive read and edit standard text files in A2osX.  If you do not specify a file name on the command line, you will be prompted to enter one when you save your work (control-S).  Consult the help screen below for a list of the special keys that can be used while editing a file.

![](../.screen-shots/ScreenShot.EDIT.png)

There is a help screen

![](../.screen-shots/ScreenShot.EDIT%20Help.png)

### FORMAT

| Command | Options |
| --- | --- |
| FORMAT \<BLOCKDEV\> [VOLUME.NAME] | -L : Low-Level Format *not currently supported <br> -1..9 : Catalog Size (block count) | 

The FORMAT command will erase an existing volume and update its name to the VOLUME.NAME supplied.  FORMAT does not currently support low level formatting.  The Volume/Device to be formatted must already be formatted.  Specifically this means that FORMAT cannot format a new (never been formatted) floppy disc.

### GREP

| Command | Options |
| --- | --- |
| GREP \<opt\> PATTERN FILE <br>  CMD \| GREP \<opt\> PATTERN | -H : This help screen <br> -I : Ignore Case <br> -N : Print line Number | 0.93 |

The GREP command parses multiple lines of input (either from a file or from the redirected output of another command) and only outputs those lines that contain the PATTERN.  In this way, you can thing of the GREP command as a filter.  You can use the -I option to force GREP to ignore case in the PATTERN and the INPUT lines (i.e. it capitalizes both the source and the PATTERN before doing the compare) though it still outputs the actual lines of content that match (their original capitalization is preserved.

Examples

> /A2OSX.BUILD/ROOT/$ LS -L / | GREP S7                                           
> /A2OSX.BUILD     S7D1 Blocks Used: 3230 Total:65535                             
> /MAKE            S7D2 Blocks Used:48946 Total:65535                             
>
> /A2OSX.BUILD/ROOT/$ GREP :1000: ../ETC/PASSWD
> guest:084e0343a0486ff05530df6c705c8bb4:1000:1000:Guest Account:/home/guest:/bin/sh
>
> /A2OSX.BUILD/ROOT/$ GREP ROOT ../ETC/PASSWD                                     
>
> /A2OSX.BUILD/ROOT/$ GREP -I ROOT ../ETC/PASSWD                                  
> root:1cedeaefaffab15fd23d7a282c6610b1:0:0:A2osX Root:/root:/bin/sh              

In the first example, only those volumes that are attached to Slot 7 are listed.  In the second, you can see that the user account for user 1000 is displayed from the PASSWD file.  In the third, you can see nothing is listed, but once we add the case insensitive option (-I) the root account is listed.

### KILL

| Command | Options |
| --- | --- |
| KILL \<signal\> PID | -0 : No Signal <br> -1 : SIGQUIT | 0.93 |

The KILL command kills or terminates a running process.  This can be most useful when you have a running process that is stuck (perhaps you are debugging a program or script); you can switch to another virtual terminal (by pressing Open Apple-1) and executing the PS command to list currently running processes and then executing the KILL command on the errand process (i.e. KILL 27 to terminate process 27).

### LS

| Command | Options |
| --- | --- |
| LS [filespec] | -A : Print . & .. <br> -C : Single column listing <br> -F : Single column, includes full path <br> -L : long listing with size/date... <br> -R : Recurse subdirectories |

The LS command is probably the most used and useful of all commands available to the A2osX user.  LS allows you to list the names of the files (with or without extended file info such as modification date and size with the -L option) in a directory or even an entire tree using the Recurse (-R) option.  You can pass the LS command a filespec that includes a directory name and or wildcard spec for filtering the listing.  For example the command `LS ../MYDIR/FT*` would only list files that begin with FT and are found in the MYDIR sub directory of the parent of the current directory.

![](../.screen-shots/ScreenShot.LS.png)

### LSDEV

| Command |
| --- | 
| LSDEV | 

Displays a listing of the currently defined devices in the running A2osX system as seen in the screenshot below.

![](../.screen-shots/ScreenShot.LSDEV.png)

### LSOF

| Command | 
| --- | 
| LSOF |

Displays a listing of the currently open files in a running A2osX system.  This utility is particularly useful to run from another virtual terminal (TTY).  Consult the A2osX User Guide for information on using and switching between virtual terminal sessions on your Apple.

### MD5

| Command |
| --- |
| MD5 \[ -D : String \| file \]

This utility will generated an MD5 hash on a file or on the text string passed with the -D option.

### MEM

| Command | 
| --- | 
| MEM | 

The MEM command displays the available memory and other stats of the Main, Aux and Kernel memory spaces.

### MKDIR

| Command | 
| --- | 
| MKDIR filespec | 

MKDIR will create a new empty directory based on the filespec.  If a simple filespec is provided (i.e. mydir or test1) a new directory of that name will be created in the current directory.  Optionally, you can pass a fully qualified or relative filespec such as ../../mmdir in which case a new empty directory will be created called mmdir and place in the current directory's parent parent.

### MORE

| Command | Options |
| --- | --- |
| MORE \<File\> or <br> CMD\|MORE \<opt\> | -H : This help screen <br> -N : Number all output lines <br> -P : Page mode, no scroll <br> -S : Process ESC codes

The MORE utility allows you to scroll through the output of a file or command one screenfull or line at a time.  You can use MORE on existing text files, or in conjunction with the PIPE facility (\|)  you can direct the output of a command or script to MORE to page through that output.  This can be very useful for long directory listings `LS -L | MORE`.

### MV

| Command | Options |
| --- | --- |
| MV filespec destination| -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override

### NSCUTIL

| Command |
| --- |
| NSCUTIL DD/MM/YY,hh:mm:ss |

Tool for setting the time of a No Slot Clock or DL1216E.

### PAK

| Command | 
| --- | 
| PAK |


### PS

| Command | 
| --- | 
| PS |

List Processes

### RM

| Command | Options |
| --- | --- |
| RM \[File/Dir, *,? wildcards allowed\] | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories 

### SH

| Command |
| ---- |
| SH Script |

### USERADD

| Command | Options |
| --- | --- |
| USERADD username | -c Comment : GECOS comment<br> -d HD : Home Directory <br> -p PW : Password <br> -s SH : Shell|

### USERDEL

| Command | Options |
| --- | --- |
| USERDEL username | -r : Force removes files in home directory |

###WC

| Command |
| ----- |
| WC |

###WHO

| Command |
| ----- |
| WHO |

## Network Tools

###ARP

| Command |
| ----- |
| ARP |

Dump ARP cache, setup a static ARP entry
 
### DNSINFO

| Command |
| ----- |
| DNSINFO -a option to add host???? |

dump DNS cache, setup a static DNS entry

### HTTPGET 

| Command | Options |
| --- | --- |
|HTTPGET <ip\|host> [port]| -U Url <br> -F UrlFile|


### IPCONFIG 

| Command | Options |
| --- | --- |
|IPCONFIG |-D : Try to get IP address from DHCP <br> -E : Read ETC files <br> -S : Set/Reset TCPIP configuration (-E, then -D if required) |

### NETSTAT 

| Command |
| ----- |
| NETSTAT |

Display socket status

### PING 

| Command |
| ----- |
| PING <ip\|host> <br> -1..9 : Ping Count |

### TELNET

| Command |
| ----- |
| TELNET <ip\|host> [port] |

### DHCPCLNT

| Command |
| ----- |
| DHCPCLNT |

I am not sure if this command is even used any more.  RGXX??

### HTTPD

| Command |
| ----- |
| HTTPD |

HTTPD is a server process thats listens for incomming requests to server web pages from your A2osX system.  It listens for these requests on port 80.  This server process is in development and is in fact being used for test purposes only right now.  Further document and options will be made available in a future A2osX release.

### TCPIPD

| Command |
| ----- |
| TCPIPD |

This is the main network command.  RGXX needs to explain it to us all.

ARP,IP,ICMP,UDP & TCP ok

## Developer Tools

While almost every command and program that comes with A2osX can be considered a developer tool, there are a few that are very specifically created to be used for developer.  This section discusses those tools.

### ASM

| Command |
| ----- |
| ASM |

ASM is A2osX's table driven multi-pass macro assembler.  This assembler is still in development and will be released shortly.  Technical documentation for the assembler and its language can be found in **[ASM](./ASM.md)**.  A Guide to using ASM will be forthcoming.

### MEMDUMP

| Command |
| ----- |
| MEMDUMP |

![](../.screen-shots/ScreenShot.MEMDUMP.png)

MEMDUMP is a program that allows the developer to display the contents of all of the memory that A2osX is currently using to aide with the debugging of your programs.

RGXX you need to support more info on MEMDUMP and what the columns mean and how to look for mem that your particular program is using.

### RPCDUMP

| Command |
| ----- |
| RPCDUMP |

Tool based on UDP socket API, renamed from RPCINFO <br> RPCDUMP <ip\|host>

RGXX we need more info on this command.

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
