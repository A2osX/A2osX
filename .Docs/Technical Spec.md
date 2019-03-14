# A2osX (0.92) Multi-Tasking OS for Apple II

This is the functional specification for A2osX, its system modules, internal and external commands and shell language.  Please refer to the other A2osX documentation such as the User Guide, Notes for Developers and Shell Programming Guide for more information.

## SYS/KM* Supported Hardware At Kernel Level (ProDOS):

| KM.Name      | Status  | Comment |
| -------      | ------  | ------- |
| KM.APPLETALK | Working | AppleTalk Support for ProDOS |
| KM.NSC       | Working | No-Slot-Clock/DS1216E |
| KM.RAMWORKS  | Working | AE-Ramworks I,II,III  |
| KM.VSDRIVE   | Working | ADTPro Virtual Drive for SSC |

## SBIN,Daemons/Commands:

| Name    | Status      | Comment | K.Ver |
| ----    | ------      | ------- | ------|
| DHCPCLNT| Working     | rewritten to use new Socket API | 0.92 |
| GETTY   | Working     | -E : Exit on remote close | 0.92 |
| HTTPD   | In Progress |  | 0.9 |
| INSDRV  | Working     |         | 0.92 |
| KCONFIG | Working     | Kernel Configuration Utility | 0.92 |
| LOGIN   | In Progress | no auth using /etc/passwd yet | 0.92 |
| SHELL   | Working     | (See Internal Shell commands) | 0.92 |
| TCPIPD  | Working     | ARP,IP,ICMP,UDP & TCP ok | 0.92 |
| TELNETD | Working  |  | 0.92 |

## Internal Shell commands:

| Name      | Status  | Comment |
| ----      | ------  | ------- |
| \<value\> | Working | $VAR \| string \| "string with SPACE" \| 123 \| -456 |
| \<expression\> | Working | \<value\> [\<op\> \<value\>] ... |
| \<op\> | Working <br> --- <br> Planned | \+ signed int32 add <br> \- signed int32 sub <br> --- <br>  \* <br> div <br> mod |
| \<condition\> | Working |[ -D direxists ] <br> [ -E fileordirexists ] <br> [ -F fileexists ]<br> [ -N $VAR variable is not empty ] <br> [ -Z $VAR variable is empty ] <br> [ string1 = string2 ] <br> [ string1 != string2 ] <br> [ string1 .< string2 ] <br> [ string1 <= string2 ] <br> [ string1 .> string2 ] <br> [ string1 >= string2 ] <br> [ int32 -eq int32 ] <br> [ int32 -ne int32 ] <br> [ int32 -lt int32 ] <br> [ int32 -le int32 ] <br> [ int32 -gt int32 ] <br> [ int32 -ge int32 ] |
| BREAK     | Working | Exit CASE of SWITCH |
| CASE      | Working | CASE <expression> |
| CD        | Working | CD path or relative path |
| DATE      | Working | |
| DEFAULT   | Working | Default CASE for SWITCH |
| ECHO      | Working | \b,\e,\f,\n,\\\ and \\% supported <br> -N : Suppress \r\n |
| ELSE      | Working | Optional branch for IF block |
| END       | Working | End of SWITCH Statement |
| EXIT      | Working | exit script or shell |
| FI        | Working | Terminator for IF block |
| FUNC      | In Progress | FUNC fonction_name <br>   \<body\> <br>   END |
| IF        | Working | [ \<condition\> ] |
| LOOP      | Working | Terminator for WHILE block |
| MD        | Working | MD path or relative path <br> Create a directory |
| NOHUP     | Working | Start a process with PPID=PS0 (Daemon) |
| PAUSE     | Working | Wait until CR |
| POPD      | Working | Restore previously saved working directory |
| PUSHD     | Working | Save actual working directory <br> PUSHD \<dir\> do also a CD to \<dir\> |
| PWD       | Working | Print Working Directory |
| RD        | Working | Delete an empty directory |
| READ      | Working | -S : no echo (password) <br> -P : "prompt message"   |
| REN       | Working | Rename a file, directory or volume |
| RETURN    | In Progress | Exit function with return code |
| SET       | Working | -X : toggle debug mode <br> -C : toggle Control-C break mode |
| SHIFT     | Working | Remove $1 from cmd line |
| SLEEP     | Working | Wait \<count\> 10th sec |
| SWITCH    | Working | SWITCH <expression> |
| TIME      | Working | |
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
| .      | Working | use same env |
| &      | Working | start proc |
| \|     | Working | pipe |
| <      | Working | StdIn redirection |
| >      | Working | StdOut redirection |
| >>     | Working | Append StdOut  |
| 1>>    | Working |  |
| 1>     | Working |  |
| 2>>    | Working | StdErr redirection |
| 2>     | Working |  |

## DRV,Drivers:

| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| DHGR.DRV | Working | 560x192 Mono/16 colors Mixed-Mode support | 0.9.1 |
| LanCeGS.DRV | Working | | 0.92 |
| Mouse.DRV | Working | Apple Mouse Card,//c Mouse Port | 0.9.1 |
| PIC.DRV | In Progress | Apple "Parallel Interface Card" Driver, renamed from PPIC.DRV | 0.9 |
| SSC.DRV     | Working | Apple "Super Serial Card" Driver | 0.92 |
| SSC.I.DRV   | Working | Apple "Super Serial Card" Driver (IRQ enabled) | 0.92 |
| Uthernet.DRV  | Working | | 0.92 |
| Uthernet2.DRV | Working | | 0.92 |
| Uther2.AI.DRV | In Progress | With ARP/IP Offloading | 0.92 |

## BIN,External Shell commands:
| Name | Status | Comment | 
| ---- | ------ | ------- | 
| CAT | Working | -A : Show All non printable caracters <br> -N : Number all output lines <br> -S : Suppress repeated empty output lines |
| CUT | Working | CUT \<opt\> "line" or CMD\|CUT \<opt\> <br> -H : This help screen <br> -F nn : Output field nn <br> -M nn : Output starting at nn <br> -N nn : Output Ending at nn <br> -S ch : Change default SPACE separator to 'ch' |
| CHGRP | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories |
| CHMOD | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories |
| CHOWN | In Progress | -C : Continue On Error <br> -R : Recurse subdirectories |
| CHTYP | Working | -C : Continue On Error <br> -R : Recurse subdirectories |
| CP | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override |
| EDIT | Working | still missing : find/replace | 
| FORMAT | In Progress | FORMAT \<BLOCKDEV\> [VOLUME.NAME] <br> -L : Low-Level Format *not currently supported <br> -1..9 : Catalog Size (block count) |
| GREP | Working | GREP \<opt\> PATTERN FILE or CMD\|GREP \<opt\> PATTERN <br> -H : This help screen <br> -I : Ignore Case <br> -N : Print line Number |
| KILL | Working | KILL \<signal\> PID <br> -0 : No Signal <br> -1 : SIGQUIT |
| LS | Working | -A : Print . & .. <br> -C : Single column listing <br> -F : Single column, includes full path <br> -L : long listing with size/date... <br> -R : Recurse subdirectories |
| LSDEV | Working | Dump device Drivers | 
| LSOF | Working | List Open Files | 
| MD5 | Working | MD5 \[ -D : String \| file \] | 
| MEM | Working | Old dump behavior is now MEMDUMP.  New MEM command displays MEMSTAT (Main, Aux & Kernel Memory) | 
| MKDIR | Working | Make Directory| 
| MORE | Working | MORE \<File\> or CMD\|MORE \<opt\> <br> -H : This help screen <br> -N : Number all output lines <br> -P : Page mode, no scroll <br> -S : Process ESC codes |
| NSCUTIL | Working | NSCUTIL DD/MM/YY,hh:mm:ss <br> Tool for setting time in NSC/DL1216E |
| MV | Working | -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories <br> -Y : Dont't Prompt For Override |
| PS | Working | List Processes| 
| RM | Working | RM \[File/Dir, *,? wildcards allowed\] <br> -C : Continue On Error <br> -Q : Quiet <br> -R : Recurse subdirectories |

## Network (TCPIP) tools:
| Name | Status | Comment | 
| ---- | ------ | ------- | 
| ARP | Working | dump ARP cache, setup a static ARP entry | 
| DNSINFO | Working | dump DNS cache, setup a static DNS entry | 
| HTTPGET | In Progress | HTTPGET <ip\|host> [port] <br> -U Url <br> -F UrlFile |
| IPCONFIG | Working | -D : Try to get IP address from DHCP <br> -E : Read ETC files <br> -S : Set/Reset TCPIP configuration (-E, then -D if required) |
| NETSTAT | Working | Display socket status | 
| PING | Working | PING <ip\|host> <br> -1..9 : Ping Count |
| TELNET | Working | TELNET <ip\|host> [port] | 

## DEV tools:
| Name | Status | Comment | 
| ---- | ------ | ------- | 
| ASM | In Progress | S-C MASM based multi CPU assembler | 
| MEMDUMP | Working | Tool to track memory leak| 
| RPCDUMP | In Progress | Tool based on UDP socket API, renamed from RPCINFO <br> RPCDUMP <ip\|host> | |

