# A2osX Shell Developers Guide

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), DATE, TIME, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.

It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example  

## The A2osX Shell (SH)

### Variables

Variable overflow strings and ints
Ints only no real num it just ignore

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 


The Shell
Interacting with the Shell.
Special Keys

| Key | Usage |
| -- | -- |
| BACKSPACE | Deletes character under the cursor.  Note this key does not exist on Apple keyboards, but may on terminals connected via an SSC or through a Telnet Session |
| DELETE | Deletes character to left of cursor and moves cursor/rest of line to the left |
| Control-C | Erases entire command line |
| Control-D | Exits SHell and if the top most SHell logs you out of your session |
| Control-Z | Deletes character under the cursor |
| Up Arrow | Displays previous command from history.  Multiple Up Arrows scrolls progressively through history |
| Down Arrow | Displays next command from history.  Multiple Down Arrows scrolls progressively through history |
| Left Arrow | Moves cursor to the left to edit current command |
| Right Arrow | Moves cursor to the right to edit current command |
| Open Apple-0 | Switches you to the console display |
| Open Apple-1 to 4 | Switches you to Virtual Terminals 1 through 4 if so configured |

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
| DATE      | Working | |
| DEFAULT   | Working | Default CASE for SWITCH |
| ECHO      | Working | \b,\e,\f,\n,\\\ and \\% supported <br> -N : Suppress \r\n |
| ELSE      | Working | Optional branch for IF block |
| END       | Working | End of SWITCH Statement |
| EXIT      | Working | exit function, script or shell |
| FI        | Working | Terminator for IF block |
| FUNCTION  | Working | FUNCTION fonction_name { <br> \<body\> <br> } |
| IF        | Working | [ \<condition\> ] <br> ![ \<condition\> ]|
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
| SET       | Working | -X : toggle debug mode <br> -C : toggle Control-C break mode <br> -E : toggle error printing mode <br> -F : delete all declared functions |
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


## Stuff to work on

if [] && []   is AND
if [] || []   is OR


functions

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
