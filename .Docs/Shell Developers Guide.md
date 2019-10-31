# A2osX Shell Developers Guide

### Updated October 26, 2019

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), PWD, DATE, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.

It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example

```
FOR FILE IN `LS -C CT*`; CAT ${FILE}; NEXT
```

In this example, the system will generate a list of files found in the current directory that match the CT* wild card and perform the CAT operation on each.  The semicolons act as a line separator allowing you to type in multiple commands, or short scripts on a single line, to execute as a script.

This Developers Guide will cover the basic operation of the interactive shell, the available commands as well as creating and using complex scripts that can be run by the shell.

## The A2osX Shell (SH)

The default A2osX Shell, ./BIN/SH, is an A2osX external command program like many others included with A2osX.  It is probably the most complex and capable, as suggested by its size compared to other commands (7K vs 1K for TELNET), and is the primary tool for interacting with the A2osX system.  The SH shell is based somewhat on the Linux BASH shell, to the extend possible on an 8-bit machine.  Alternative shells are planned for the future and will be announced as they become available.

As the primary mechanism for working with A2osX, the SH shell is launched automatically when you log into A2osX.  In the case where no ./ETC/PASSWD file is present, A2osX automatically logs you in as the ROOT user.  When a user login occurs and SH is launched, it looks for a file called PROFILE in the users HOME directory and if found executes that script, so the information below on writing scripts applies to the PROFILE file.

### Interacting with the Shell

To interact with the A2osX shell, you type commands at the presented prompt, which ends with a **$** character.  The prompt usually includes your current working directory such as **/FULLBOOT/ROOT/$**.  You can change the prompt by changing the **$PS1** variable (see below).  At the **$** you can enter any of the valid internal shell commands or an external program name.  For external programs, A2osX will search in the current directory and then in the directories specified in the **$PATH** variable.  

#### Special Keys

While entering commands at the A2osX shell prompt, you can use the following special keys to edit the command line:

| Key | Usage |
| -- | -- |
| DELETE | Deletes character to left of cursor and moves cursor/rest of line to the left |
| Control-C | Erases entire command line |
| Control-D | Exits Shell and if the top most Shell logs you out of your session |
| Control-Z | Deletes character under the cursor |
| Up Arrow | Displays previous command from history.  Multiple Up Arrows scrolls progressively through history |
| Down Arrow | Displays next command from history.  Multiple Down Arrows scrolls progressively through history |
| Left Arrow | Moves cursor to the left to edit current command |
| Right Arrow | Moves cursor to the right to edit current command |

In addition to the editing keys above, you can use the following special keys while running scripts or executing commands:

| Key | Usage |
| -- | -- |
| Control-C | Interrupts running command or script |
| Open Apple-0 | Switches you to the console display |
| Open Apple-1 to 4 | Switches you to Virtual Terminals 1 through 4 if so configured |

#### Internal Commands

CD
DATE
ECHO
EXIT
MD
NOHUP
POPD
PUSHD
PWD
RD
REN
SET
SLEEP
TIME

A note on arguments, for internal and external commands: When passing a command a series of arguments, you must include between each argument.  In addition, if a command has an option that requires an argument, there must also be a space between the option and its argument.  For example, when using the READ command which has the -S -P and -N options, the -P and -N options both require an argument so the full use of the command would be **READ -S -N 3 -P "My Prompt" AVAR**.  Do not use -N3 as you might in Linux or DOS as you will generate a Syntax Error and the command will fail to execute.

#### Redirection


### Writing Scripts

Calling other scripts
calling scripts with . (dot space) before script name from within a script
loading functions this way


#### Variables

Variable overflow strings and ints
Ints only no real num it just ignore

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 

##### Special Variables

$BOOT
$ROOT
$PATH
$TERM
$PS1
$DRV
$LIB

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

Also look at Microsoft Flow and Integromat and Automate.io


where [ exp ] and [ condition ] allow to detail operators....


anywhere you can have [ exp ] you can have ![ exp ] which means NOT exp.


    while ![ $total -eq 0 ]
    loop
    
is the same thing as 

    while [ $total -ne 0 ]
    loop

Just like

    IF [ A -GT 5 ]
      DO X
    ELSE
      DO Y
    FI

is the same as

    IF ![ A -LE 5 ]
      DO Y
    ELSE
      DO X
    FI

Notice that the DO X and DO Y logic is swapped between the two cases.

## Internal Shell commands:

| Name      | Status  | Comment |
| ----      | ------  | ------- |
| \<value\> | Working | $VAR \| string \| "string with SPACE" \| 123 \| -456 |
| \<expression\> | Working | \<value\> [\<op\> \<value\>] ... |
| \<op\> | Working | \+ signed int32 add <br> \- signed int32 sub <br>   \* <br> / <br> mod |
| \<condition\> | Working |[ -D direxists ] <br> [ -E fileordirexists ] <br> [ -F fileexists ]<br> [ -N $VAR variable is not empty ] <br> [ -Z $VAR variable is empty ] <br> [ string1 = string2 ] <br> [ string1 != string2 ] <br> [ string1 .< string2 ] <br> [ string1 <= string2 ] <br> [ string1 .> string2 ] <br> [ string1 >= string2 ] <br> [ int32 -eq int32 ] <br> [ int32 -ne int32 ] <br> [ int32 -lt int32 ] <br> [ int32 -le int32 ] <br> [ int32 -gt int32 ] <br> [ int32 -ge int32 ]|
| BREAK     | Working | Exit CASE of SWITCH |
| CALL      | Working | CALL function <arg> ... |
| CASE      | Working | CASE <expression> |
| CD        | Working | CD path or relative path |
| ..        | Working | CD .. |
| DATE      | Working | %a : Abbreviated weekday name : Thu <br> %A : Full weekday name : Thursday <br> %b : Abbreviated month name : Aug <br> %B : Full month name : August <br> %d : Day of the month, zero-padded (01-31) <br> %H : Hour in 24h format (00-23) 14 <br> %I : Hour in 12h format (01-12) 02 <br> %m : Month as a decimal number (01-12) 08 <br> %M : Minute (00-59) 55 <br> %p : AM or PM designation PM <br> %S : Second (00-61) 02 <br> %w : Weekday as a decimal number with Sunday as 0 (0-6) <br> %y : Year, last two digits (00-99) <br> %Y : Year four digits 2001 |
| DEFAULT   | Working | Default CASE for SWITCH |
| ECHO      | Working | \b,\e,\f,\n,\\\ and \\% supported <br> -N : Suppress \r\n |
| ELSE      | Working | Optional branch for IF block |
| END       | Working | End of SWITCH Statement |
| EXIT      | Working | exit function, script or shell |
| FI        | Working | Terminator for IF block |
| FUNCTION  | Working | FUNCTION function_name { <br> \<body\> <br> } |
| IF        | Working | [ \<condition\> ] <br> ![ \<condition\> ]|
| LOOP      | Working | Terminator for WHILE block |
| MD        | Working | MD path or relative path <br> Create a directory |
| NOHUP     | Working | Start a process with PPID=PS0 (Daemon) |
| PAUSE     | Working | Wait until CR |
| POPD      | Working | Restore previously saved working directory |
| PUSHD     | Working | Save actual working directory <br> PUSHD \<dir\> do also a CD to \<dir\> |
| PWD       | Working | Print Working Directory |
| RD        | Working | Delete an empty directory |
| READ      | Working | -S : no echo (password) <br> -P : "prompt message" <br> -N maxchar  |
| REN       | Working | Rename a file, directory or volume |
| SET       | Working | -X : toggle debug mode <br> -C : toggle Control-C break mode <br> -E : toggle error printing mode <br> -F : delete all declared functions |
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


## Stuff to work on

if [] && []   is AND
if [] || []   is OR


### functions

if you SET -F, it will discard ALL previously learnt FUNC in the current SH context
if . FUNCS1 file add 3
then . FUNCS2 file add 2
all 5 are available until an set -X is met
if you launch . MYFILE1, the code within MYFILE1 can CALL all 5 functions
but MYFILE1 (wthout dot) will run in a separate SH process, so no access to the 5 functions known by parent SH
functions bodies are stored in AUX ram
so you can put around 30k of code in AUX ram then do a short MYFILE1 that calls a lot of FUNC 
in AUX
FUNCs recursion is allowed (until you explode the stack!)

CORE.STACK.MAX = 128....so each CALL consumes about 7 bytes of stack (return Ctx/Ptr, ArgVC,hArgV and CALL keywordID)

* DIV/MOD

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
