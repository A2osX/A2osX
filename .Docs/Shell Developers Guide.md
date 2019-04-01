# A2osX Shell Developers Guide

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), DATE, TIME, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.

It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example  

### The A2osX Shell (SH)

### Variables

Variable overflow strings and ints
Ints only no real num it just ignore

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 


The Shell
Enteracting with the Shell.
Special Keys
Internal Commands
External Commands
Variables
Special Variables
Scripts
Redirection

## Advanced Display Techniques

VT100 Codes
\f	Clear Screen
\b	backspace
\n	newline
\r	return (beginning of line with no new line)

\eM	Scroll Screen Down 1 Line
\eD	Scroll the Screen Up 1 Line
\ec	Clear Screen

\e[05;15H	Move cursor to row 5 and col 15
\e[H	Move to home position (0,0)
\e[K	Clear from cursor to end of line
\e[1K	Clear from cursor to beginning of line
\e[2K	Clear line
Plus Colors

###Examples

IFTTT Tweet using HTTPGET

where [ exp ] and [ condition ] allow to detail operators....


## Internal Shell commands:

| Name      | Status  | Comment |
| ----      | ------  | ------- |
| \<value\> | Working | $VAR \| string \| "string with SPACE" \| 123 \| -456 |
| \<expression\> | Working | \<value\> [\<op\> \<value\>] ... |
| \<op\> | Working | \+ signed int32 add <br> \- signed int32 sub <br>   \* <br> / <br> mod |
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
