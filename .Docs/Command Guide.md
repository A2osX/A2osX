# A2osX Command Guide

This Guide provides information on all the A2osX commands and utilities.  This Guide helps you not only learn the purpose of each command but also what options a command supports and what arguments it either supports or requires.

A2osX comes with a nice variety of system, file, network and data utilities or what we refer to as external commands.  This just means that each of the following commands or utilities is built as a separate BIN or executable file that runs under A2osX.  The source for all of these external commands is readily available, so you can make your own as your needs dictate.  Note, that there are some **internal** commands that are build into the shell (the interactive prompt) such CD (change directory) or PWD (print working directory).  Those commands are discussed in-depth in the **[Shell Developers Guide](.Docs/Shell%20Developers%20Guide.md).**  

## System Commands

You will usually not use these commands, they are more commonly found in A2osX system scripts such as ./ETC/INIT or they are launched by the A2osX Kernel itself.  All of these commands are found in ./SBIN/ letting you know they are special system commands.

### GETTY

| Command | Options |
| --- | --- |
| GETTY | -E : Exit upon disconnect |

### INSDRV

| Command |
| ---- |
| INSDRV Driver |

### KCONFIG

| Command |
| ---- |
| KCONFIG |

Kernel Configuration Utility writes to ${ROOT}/A2OSX.KCONFIG.

### LOGIN

| Command |
| ---- |
| INSDRV Driver |

### SH

| Command |
| ---- |
| SH Script |

### INITD

| Command |
| ---- |
| INITD InitLevel |

## BIN,External Shell commands:

### CAT

| Command | Options |
| --- | --- |
| CAT | -A : Show All non printable caracters <br> -N : Number all output lines <br> -S : Suppress repeated empty output lines |

The CAT command is used to display the contents of files stored on any ProDOS volume.  While the primary use of this tool is to display the contents of TEXT or TXT files, it can be used to display the contents of other files by using the -A option, which will substitute non-printable characters with readable and displayable values such as [EOF] for End of File (Hex x04) or [LF] for Line Feed (Hex x0A).

### CUT

| Command | Options |
| --- | --- |
| CUT | CUT \<opt\> "line" or CMD\|CUT \<opt\> <br> -H : This help screen <br> -F nn : Output field nn <br> -M nn : Output starting at nn <br> -N nn : Output Ending at nn <br> -S ch : Change default SPACE separator to 'ch' |

### CHGRP

| Command | Options |
| --- | --- |
| CHGRP | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories | - |


### CHMOD

| Command | Options |
| --- | --- |
| CHMOD | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories | - |


### CHOWN

| Command | Options |
| --- | --- |
| CHOWN | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories | - |


### CHTYP

| Command | Options |
| --- | --- |
| CHTYP | Working | -C : Continue On Error <br> -R : Recurse subdirectories | 0.92 |


### CP

| Command | Options |
| --- | --- |
| CP | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override | 0.93 |


### EDIT

| Command | Options |
| --- | --- |
| EDIT | Working | still missing : find/replace | 0.93 |


### FORMAT

| Command | Options |
| --- | --- |
| FORMAT | In Progress | FORMAT \<BLOCKDEV\> [VOLUME.NAME] <br> -L : Low-Level Format *not currently supported <br> -1..9 : Catalog Size (block count) | 0.92 |


### GREP

| Command | Options |
| --- | --- |
| GREP | Working | GREP \<opt\> PATTERN FILE or CMD\|GREP \<opt\> PATTERN <br> -H : This help screen <br> -I : Ignore Case <br> -N : Print line Number | 0.93 |


### KILL

| Command | Options |
| --- | --- |
| KILL | Working | KILL \<signal\> PID <br> -0 : No Signal <br> -1 : SIGQUIT | 0.93 |


### LS

| Command | Options |
| --- | --- |
| LS -A : Print . & .. <br> -C : Single column listing <br> -F : Single column, includes full path <br> -L : long listing with size/date... <br> -R : Recurse subdirectories |


### LSDEV

| Command | Options |
| --- | --- |
| LSDEV | Working | Dump device Drivers


### LSOF

| Command | Options |
| --- | --- |
| LSOF | Working | List Open Files


### MD5

| Command | Options |
| --- | --- |
| MD5 | Working | MD5 \[ -D : String \| file \]


### MEM

| Command | Options |
| --- | --- |
| MEM | Working | Old dump behavior is now MEMDUMP.  New MEM command displays MEMSTAT (Main, Aux & Kernel Memory)


### MKDIR

| Command | Options |
| --- | --- |
| MKDIR | Working | Make Directory


### MORE

| Command | Options |
| --- | --- |
| MORE | Working | MORE \<File\> or CMD\|MORE \<opt\> <br> -H : This help screen <br> -N : Number all output lines <br> -P : Page mode, no scroll <br> -S : Process ESC codes


### NSCUTIL

| Command | Options |
| --- | --- |
| NSCUTIL | Working | NSCUTIL DD/MM/YY,hh:mm:ss <br> Tool for setting time in NSC/DL1216E 


### MV

| Command | Options |
| --- | --- |
| MV | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override


### PS

| Command | Options |
| --- | --- |
| PS | Working | List Processes


### RM

| Command | Options |
| --- | --- |
| RM | Working | RM \[File/Dir, *,? wildcards allowed\] <br> -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories 

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

### HTTPD

| Command |
| ----- |
| HTTPD |

### TCPIPD

| Command |
| ----- |
| TCPIPD |

ARP,IP,ICMP,UDP & TCP ok

### TELNETD

| Command |
| ----- |
| TELNETD -d [port]??? |


## Developer Tools

While almost every command and program that comes with A2osX can be considered a developer tool, there are a few that are very specifically created to be used for developer.  This section discusses those tools.

### ASM

| Command |
| ----- |
| ASM |

S-C MASM based multi CPU assembler

### MEMDUMP

| Command |
| ----- |
| MEMDUMP |

Tool to track memory leak

### RPCDUMP

| Command |
| ----- |
| RPCDUMP |
Tool based on UDP socket API, renamed from RPCINFO <br> RPCDUMP <ip\|host>

