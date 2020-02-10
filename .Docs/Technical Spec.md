# A2osX (0.93) Multi-Tasking OS for Apple II

### Updated February 10, 2020

This is the functional specification for A2osX and its system modules, internal and external commands and shell language.  Please refer to the other A2osX documentation such as the User Guide, Notes for Developers and Shell Programming Guide for more information on the use of these commands and modules.

## SYS/KM* Supported Hardware At Kernel Level (ProDOS):

| KM.Name      | Status  | Comment | K.Ver |
| -------      | ------  | ------- | ------|
| KM.APPLETALK | Future | AppleTalk Support for ProDOS |  |
| KM.NSC       | Working | No-Slot-Clock/DS1216E | 0.93 |
| KM.RAMWORKS  | Working | AE-Ramworks I,II,III  | 0.93 |
| KM.VSDRIVE   | Working | ADTPro Virtual Drive for SSC | 0.93 |

## SBIN,Daemons/Commands:

| Name     | Status      | Comment | K.Ver |
| ----     | ------      | ------- | ------|
| GETTY    | Working     | -E : Exit on remote close | 0.93 |
| HTTPD    | Partial      | Web Page Server Daemon | 0.94 |
| INITD    | Future      | Run Level Manger     | 0.94 |
| INSDRV   | Working     | Loads HW Drivers        | 0.93 |
| KCONFIG  | Working     | Kernel Configuration Utility | 0.93 |
| LOGIN    | Working     | Authorization using /etc/passwd       | 0.93 |
| NETWORKD | Working     | TCP/IP Network Stack | 0.93 |
| TELNETD  | Working     | Telnet Server Daemon <br> TELNETD xxxx to listen on alternate port xxxx | 0.93 |

## DRV,Drivers:

| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| DHGR.DRV | Future | 560x192 Mono/16 colors Mixed-Mode support | 0.94 |
| LanCeGS.DRV | Working | Ethernet Network Interface | 0.93 |
| Mouse.DRV | Future | Apple Mouse Card/Mouse Port | |
| PIC.DRV | Future | Apple "Parallel Interface Card" Driver, renamed from PPIC.DRV |  |
| SSC.DRV     | Working | Apple "Super Serial Card" Driver | 0.93 |
| SSC.I.DRV   | Working | Apple "Super Serial Card" Driver (IRQ enabled) | 0.93 |
| Uthernet.DRV  | Working |  Ethernet Network Interface | 0.93 |
| Uthernet2.DRV | Working | Ethernet Network Interface | 0.93 |
| Uther2.AI.DRV | In Progress | Network Interface With ARP/IP Offloading | 0.93 |

## BIN,External Shell commands:
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| ARP | Working | dump ARP cache, setup a static ARP entry | 0.93 | 
| ASM | In Progress | S-C MASM based multi-CPU assembler | 0.94 |
| CAT | Working | -A : Show All non printable caracters <br> -N : Number all output lines <br> -S : Suppress repeated empty output lines | 0.93 |
| CHGRP | Future | -C : Continue On Error <br> -R : Recurse subdirectories |  |
| CHMOD | Future | -C : Continue On Error <br> -R : Recurse subdirectories |  |
| CHOWN | Future | -C : Continue On Error <br> -R : Recurse subdirectories |  |
| CHTYP | Working | -C : Continue On Error <br> -R : Recurse subdirectories | 0.93 |
| CMP | Working | CMP File1 File2 [SKIP1 [SKIP2]] <br> -A : Shows All differences <br> -V : Verbose Mode | 0.93 |
| CP | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override | 0.93 |
| CUT | Working | CUT \<opt\> "line" or CMD \| CUT \<opt\> <br> -F nn : Output field nn <br> -M nn : Output starting at nn <br> -N nn : Output Ending at nn <br> -S ch : Change default SPACE separator to 'ch' | 0.93 |
| DNSINFO | Working | dump DNS cache, setup a static DNS entry |  0.93 |
| EDIT | Working | still missing : find/replace | 0.93 |
| FORMAT | In Progress | FORMAT \<BLOCKDEV\> [VOLUME.NAME] <br> -B Blocks : Force number of blocks to format <br> -L : Low-Level Format *not currently supported <br> -1..9 : Catalog Size (block count) | 0.93 |
| GREP | Working | GREP \<opt\> PATTERN FILE or CMD \| GREP \<opt\> PATTERN <br> -I : Ignore Case <br> -N : Print line Number | 0.93 |
| HTTPGET | Working | HTTPGET <ip\|host> [port] <br> -U Url <br> -F UrlFile | 0.93 |
| IPCONFIG | Working | -D : Try to get IP address from DHCP <br> -E : Read ETC files <br> -S : Set/Reset TCPIP configuration (-E, then -D if required) | 0.93 |
| KILL | Working | KILL \<signal\> PID <br> -0 : No Signal <br> -1 : SIGQUIT <br> -2 : SIGKILL  | 0.93 |
| LS | Working | -A : Print . & .. <br> -C : Single column listing <br> -F : Single column, includes full path <br> -L : long listing with size/date... <br> -R : Recurse subdirectories | 0.93 |
| LSDEV | Working | List device Drivers | 0.93 | 
| LSOF | Working | List Open Files |  0.93 |
| MD5 | Working | MD5 \[ -D : String \| file \] | 0.93 | 
| MEM | Working | Displays Main, Aux & Kernel Memory |  0.93 |
| MEMDUMP | Working | Tool to track memory leak|  0.93 |
| MKDIR | Working | Make Directory|  0.93 |
| MORE | Working | MORE \<File\> or CMD\|MORE \<opt\> <br> -N : Number all output lines <br> -P : Page mode, no scroll <br> -S : Process ESC codes | 0.93 |
| MV | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override | 0.93 |
| NETSTAT | Working | Display socket status |  0.93 |
| NSCUTIL | Working | NSCUTIL DD/MM/YY,hh:mm:ss <br> Tool for setting time in NSC/DL1216E | 0.93 |
| PAK | Working| PAK Archive [File/Dir, *,? wildcards allowed\] <br> -A: Append to Archive<br> -R: Recurse subdirectories | 0.93 |
| PING | Working | PING <ip\|host> <br> -1..9 : Ping Count | 0.93 |
| PS | Working | List Processes|  0.93 |
| RM | Working | RM \[File/Dir, *,? wildcards allowed\] <br> -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories | 0.93 |
| RPCDUMP | In Progress | Tool based on UDP socket API, renamed from RPCINFO <br> RPCDUMP <ip\|host> | 0.93 |
| SH    | Working     | Shell Command Processor<br>(See Internal Shell commands) | 0.93 |
| TELNET | Working | TELNET <ip\|host> [port] |  0.93 |
| TERM | Working | TERM \<device\> | 0.93 |
| UNPAK | Working | UNPAK archive | 0.93 |
| USERADD | Working | USERADD username <br> -c Comment : GECOS comment<br> -d HD : Home Directory <br> -p PW : Password <br> -s SH : Shell | 0.93 |
| USERDEL | Working | USERDEL username <br> -r : Force removes files in home directory | 0.93 |
| WC | Working | WC File(s) (*,? wildcards allowed) <br> -C: Continue on error<br> -R: Recurse Subdirectories<br> -M: Print CHAR counts<br> -L: Print LINE counts<br> -W: Print WORD counts | 0.93 |
| WHO | Working | List Users Online | 0.93 |

## Internal Shell commands:

| Name      | Status  | Comment |
| ----      | ------  | ------- |
| \<condition\> | Working |[ -D direxists ] <br> [ -E fileordirexists ] <br> [ -F fileexists ]<br> [ -I isaninteger ] <br> [ -N $VAR variable is not empty ] <br> [ -X functionexists ]<br> [ -Z $VAR variable is empty ] <br> [ string1 = string2 ] <br> [ string1 != string2 ] <br> [ string1 .< string2 ] <br> [ string1 <= string2 ] <br> [ string1 .> string2 ] <br> [ string1 >= string2 ] <br> [ int32 -eq int32 ] <br> [ int32 -ne int32 ] <br> [ int32 -lt int32 ] <br> [ int32 -le int32 ] <br> [ int32 -gt int32 ] <br> [ int32 -ge int32 ] |
| \<expression\> | Working | \<value\> [\<op\> \<value\>] ... |
| \<op\> | Working  | \+ : signed int32 add <br> \- : signed int32 subtract <br>  \* : signed int32 multiply<br> / : signed int32 divide <br> mod : signed int32 modulo |
| \<value\> | Working | $VAR \| string \| "string with SPACE" \| 123 \| -456 |
| !         | Working | ![ \<condition\> ] : Negate condition |
| ( )       | Working | Parens used define list as FOR argument |
| { }       | Working | Braces used to define FUNCTION body |
| AND       | Working | Add mandatory condition |
| BREAK     | Working | Exit CASE of SWITCH |
| CALL      | Working | CALL function \<arg\> ... |
| CASE      | Working | CASE <expression> |
| CD        | Working | CD path or relative path |
| DATE      | Working | %a : Abbreviated weekday name : Thu <br> %A : Full weekday name : Thursday <br> %b : Abbreviated month name : Aug <br> %B : Full month name : August <br> %d : Day of the month, zero-padded (01-31) <br> %H : Hour in 24h format (00-23) 14 <br> %I : Hour in 12h format (01-12) 02 <br> %m : Month as a decimal number (01-12) 08 <br> %M : Minute (00-59) 55 <br> %p : AM or PM designation PM <br> %S : Second (00-61) 02 <br> %w : Weekday as a decimal number with Sunday as 0 (0-6) <br> %y : Year, last two digits (00-99) <br> %Y : Year four digits 2001 |
| DEFAULT   | Working | Default CASE for SWITCH |
| ECHO      | Working | \b,\e,\f,\n,\\\ and \\% supported <br> -N : Suppress \r\n |
| ELSE      | Working | Optional branch for IF block |
| END       | Working | End of SWITCH Statement |
| EXIT      | Working | exit script or shell |
| FI        | Working | Terminator for IF block |
| FUNCTION  | Working | FUNCTION function_name { <br>   \<body\> <br> } |
| IF        | Working | [ \<condition\> ] |
| LOOP      | Working | Terminator for WHILE block |
| MD        | Working | MD path or relative path <br> Create a directory |
| NOHUP     | Working | Start a process with PPID=PS0 (Daemon) |
| OR        | Working | Add optional condition |
| PAUSE     | Working | Wait until CR |
| POPD      | Working | Restore previously saved working directory |
| PUSHD     | Working | Save actual working directory <br> PUSHD \<dir\> do also a CD to \<dir\> |
| PWD       | Working | Print Working Directory |
| RD        | Working | Delete an empty directory |
| READ      | Working | -N c : Limit input to c characters <br> -P : "prompt message" <br> -S : no echo (password) |
| REN       | Working | Rename a file, directory or volume |
| SET       | Working | -C : toggle Control-C break mode <br> -X : toggle debug mode <br> -F : remove all defined functions |
| SHIFT     | Working | Remove $1 from cmd line |
| SLEEP     | Working | Wait \<count\> 10th sec |
| SWITCH    | Working | SWITCH <expression> |
| WHILE     | Working | [ \<condition\> ] |

## Shell variables:

| Name  | Status  | Comment |
| ----  | ------  | ------- |
| $0    | Working | Command Full Path |
| $1-$9 | Working | Arg[n] |
| $*    | Working | All Args |
| $#    | Working | Arg Count |
| $?    | Working | Return Code |
| $@    | Working | Parent PID |
| $$    | Working | PID |
| $!    | Working | Child PID |
| $UID  | Working | PS Owner UID |
| $PWD  | Working | Working Directory |

note : '$VAR' does NOT expand Variable

## Shell I/O control/redirection:

| Token  | Status  | Comment |
| ----   | ------  | ------- |
| .      | Working | use same environment to run new script |
| &      | Working | start process |
| \|     | Working | pipe |
| <      | Working | StdIn redirection |
| >      | Working | StdOut redirection |
| >>     | Working | Append StdOut  |
| 1>>    | Working |  |
| 1>     | Working |  |
| 2>>    | Working | StdErr redirection |
| 2>     | Working |  |

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

Copyright 2015 - 2020, Remy Gibert and the A2osX contributors.
