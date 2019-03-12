# A2osX (0.92) Multi-Tasking OS for Apple II  

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
| BREAK      |  | |
| CD        | Working | Improved syntax : now, 'CD ../BIN' works |
| conditions | Working |[ -d direxists ] |
|           |         | [ -e fileordirexists ] |
|           |         | [ -f fileexists ] |
|           |         | [ -n $VAR variable is not empty ] |
|           |         | [ -z $VAR variable is empty ] |
|           |         | [ string1 = string2 ] |
|           |         | [ string1 != string2 ] |
|           |         | [ string1 .< string2 ] |
|           |         | [ string1 <= string2 ] |
|           |         | [ string1 .> string2 ] |
|           |         | [ string1 >= string2 ] |
|           |         | [ int32 -eq int32 ] |
|           |         | [ int32 -ne int32 ] |
|           |         | [ int32 -lt int32 ] |
|           |         | [ int32 -le int32 ] |
|           |         | [ int32 -gt int32 ] |
|           |         | [ int32 -ge int32 ] |
| CONTINUE   |  | |
| DATE      | Working | |
| ECHO      | Working | \b,\e,\f,\n,\\\ and \\% supported |
|           |         | -N : Suppress \r\n |
| ELSE      | Working | Optional branch for IF block |
| EXIT      | Working | exit shell |
| FI        | Working | Terminator for IF block |
| IF        | Working | [ (condition) ] |
| LOOP      | Working | Terminator for WHILE block |
| MD        | Working | Create a directory |
| NOHUP     | Working | Start a process with PPID=PS0 (Daemon) |
| PAUSE     | Working | Wait until CR |
| POPD      | Working | Restore previously saved working directory |
| PUSHD     | Working | Save actual working directory |
|           |         | PUSHD <dir> do aslo a CD to <dir> |
| PWD       | Working | Print Working Directory |
| RD        | Working | Delete an empty directory |
| READ      | Working | -S : no echo (password) |
|           |         | -P : "prompt message"   |
| REN       | Working | Rename a file, directory or volume |
| SET       | Working | -X toggle debug mode |
|           |         | -C toggle Control-C break mode |
| SHIFT     | Working | Remove $1 from cmd line |
| SLEEP     | Working | Wait <count> 10th sec |
| TIME      | Working | |
| WHILE     | Working | [ (condition) ] |

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
| ----  | ------  | ------- |
| . | Working | use same env |
| & | Working | start proc |
| \| | Working | pipe |
| <    | Working | StdIn redirection |
| >    | Working | StdOut redirection |
| >>    | Working | Append StdOut  |
| 1>>    | Working |  |
| 1>   | Working |  |
| 2>>    | Working | StdErr redirection |
| 2>     | Working |  |

## DRV,Drivers:

| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| Console.DRV | Working | ANSI support in Progress. | 0.92 |
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
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| CAT | Working | -A : Show All non printable caracters | 0.92 |
| | | -N : Number all output lines | |
| | | -S : Suppress repeated empty output lines | |
| CHGRP | In Progress | -C : Continue On Error | 0.9 |
| | | -R : Recurse subdirectories | |
| CHMOD | In Progress | -C : Continue On Error | 0.9 |
| | | -R : Recurse subdirectories | |
| CHOWN | In Progress | -C : Continue On Error | 0.9 |
| | | -R : Recurse subdirectories | |
| CHTYP | Working | -C : Continue On Error | 0.92 |
| | | -R : Recurse subdirectories | |
| CP | Working | -C : Continue On Error | 0.92 |
| | | -Q : Quiet | |
| | | -R : Recurse subdirectories | |
| | | -Y : Dont't Prompt For Override | |
| EDIT | Working | still missing : find/replace | 0.92 |
| FORMAT | In Progress | FORMAT \<BLOCKDEV\> [VOLUME.NAME] | 0.92 |
| | | -L : Low-Level Format *not currently supported | |
| | | -1..9 : Catalog Size (block count) | |
| KILL | Working | KILL \<signal\> PID | 0.92 |
| | | -0 : No Signal | |
| | | -1 : SIGQUIT | |
| LS | Working | -A : Print . & .. | 0.92 |
| | | -C : Single column listing | |
| | | -F : Single column, includes full path | |
| | | -L : long listing with size/date... | |
| | | -R : Recurse subdirectories | |
| LSDEV | Working | Dump device Drivers | 0.92 |
| LSOF | Working | List Open Files | 0.92 |
| MD5 | Working | MD5 \[ -D : String \| file \] | 0.92 |
| MEM | Working | Old dump behavior is now MEMDUMP.  New MEM command displays MEMSTAT (Main, Aux & Kernel Memory) | 0.92 |
| MKDIR | Working | Make Directory| 0.92 |
| MORE | Working | MORE \<File\> | 0.92 |
| | | -H : This help screen | |
| | | -N : Number all output lines | |
| | | -P : Page mode, no scroll | |
| | | -S : Process ESC codes | |
| NSCUTIL | Working | NSCUTIL DD/MM/YY,hh:mm:ss | 0.92 |
| | | Tool for setting time in NSC/DL1216E | |
| MV | Working | -C : Continue On Error | 0.92 |
| | | -Q : Quiet | |
| | | -R : Recurse subdirectories | |
| | | -Y : Dont't Prompt For Override | |
| PS | Working | List Processes| 0.92 |
| RM | Working | RM \[File/Dir, *,? wildcards allowed\] | 0.92 |
| | | -C : Continue On Error | |
| | | -Q : Quiet | |
| | | -R : Recurse subdirectories | |

## Network (TCPIP) tools:
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| ARP | Working | dump ARP cache, setup a static ARP entry | 0.92 |
| DNSINFO | Working | dump DNS cache, setup a static DNS entry | 0.92 |
| HTTPGET | In Progress | HTTPGET <ip\|host> [port] | 0.93 |
| | | -U Url | |
| | | -F UrlFile | |
| IPCONFIG | Working | -D : Try to get IP address from DHCP | 0.92 |
|  |  | -E : Read ETC files |  |
|  |  | -S : Set/Reset TCPIP configuration (-E, then -D if required) |  |
| NETSTAT | Working | | 0.92 |
| PING | Working | PING <ip\|host> | 0.92 |
| | | -1..9 : Ping Count | |
| TELNET | Working | TELNET <ip\|host> [port] | 0.92 |

## DEV tools:
| Name | Status | Comment | K.Ver |
| ---- | ------ | ------- | ----- |
| ASM | In Progress | S-C MASM based multi CPU assembler | 0.9.1 |
| MEMDUMP | Working | Tool to track memory leak| 0.92 |
| ---- | ------ | ------- | ----- |
| RPCDUMP | In Progress | tool based on UDP socket API, renamed from RPCINFO | 0.92 |
| | | RPCDUMP <ip\|host> | |

