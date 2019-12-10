
# A2osX Shell Developers Guide

### Updated December 8, 2019

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  Using the interactive part of the shell, you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BIN or executable) commands.  Internal commands include CD (change directory), MD (make directory), PWD, DATE, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.  It is even possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts) such as:

	FOR FILE IN `LS -C CT*`; CAT ${FILE}; NEXT

In this example, the system will generate a list of files found in the current directory which match the CT* wild card and perform the CAT operation on each.  The semicolons act as line separators allowing you to type in multiple commands, or short scripts on a single line.

This Developers Guide will cover the basic operation of the interactive shell, the internal shell commands and creation of complex scripts that can be run by the shell.  For information on external commands consult the **[A2osX Command Guide](Command%20Guide.md)**.

## About the A2osX Shell (SH)

The default A2osX Shell **./BIN/SH** is an external command program like many others included with A2osX.  It is probably the most complex and capable, as suggested by its size compared to other commands (7K vs 1K for TELNET).  It is the primary tool for interacting with the A2osX system.  The SH shell is based loosely on the Linux BASH shell, to the extent possible on an 8-bit machine.  Alternative shells are planned for the future and will be announced as they become available.

As the primary mechanism for working with A2osX, the shell (SH) is launched automatically when you log into A2osX.  In the case where no ./ETC/PASSWD file is present, A2osX automatically logs you in as the ROOT user.  When a user login occurs and SH is launched, it looks for a file called PROFILE in the users HOME directory and if found, executes that script.  The information below on writing scripts applies to PROFILE script files.

## Interacting with the Shell

To interact with the A2osX shell, you type commands at the prompt, which ends with a **$** character.  The prompt usually includes your current working directory such as **/FULLBOOT/ROOT/$**.  You can change the prompt by changing the **$PS1** variable (see below).  At the **$** prompt you can enter any of the valid internal shell commands, an external program file name or a script file name.  For external programs and scripts, A2osX will search in the directories specified in the **$PATH** variable and then in the current directory.  

### Special Keys

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

## Internal Commands

The A2osX Shell contains an advanced set of internal commands.  Several of these commands are typically used interactively (at the $ prompt) while others are typically used in scripts.  Technically all of these commands can be used both interactively or in scripts, though many really only show their power in scripts you develop or run.

Whether in scripts or typed in at the interactive Shell prompt ($), most commands support, or even require, one or more *\<arguments\>* and/or *\<options\>*.  Commands typically use *\<values\>* as their *\<arguments\>* and *\<switches\>* as their *\<options\>*, however in some cases you may use *\<expressions\>*  or *<conditions\>*.  A full command line may be in the form of

	command <switch> <value> <switch> argument argument   or
	command [ <condition> ]

where in the first nomenclature a **command** performs an action with or on the objects passed as *\<arguments\>*, modifying its behavior (the action it performs) based on *\<switches\>* if present.  For example in the case of **LS -L /MYVOL** the command is **LS**, the option or switch is **-L** and the argument (target of the operation) is **/MYVOL**, which in this case the command would print a long listing of the root directory fo the ProDOS volume named /MYVOL.  The second nomenclature is used with the logic/control commands **IF** and **WHILE** where a *\<condition\>* is evaluated and the result is processed by the command to effect program flow.

> A note on command line structure for internal and external commands: When passing a command a series of arguments, you must include a space between each argument.  In addition, if a command has an option that requires an argument, there must also be a space between the option and its argument.  For example, when using the READ command which has the -S -P and -N options, the -P and -N options both require an argument so the full use of the command would be **READ -S -N 3 -P "My Prompt" AVAR**.  Do not use -N3 as you might in Linux or DOS as you will generate a Syntax Error and the command will fail to execute.  Also note, for many commands the order of the arguments is important (i.e. CP sourcefile destfile, order critical), however the order of Options is not.  **READ -S -N 3 -P "MyPrompt" AVAR** is the same as **READ -P "MyPrompt" AVAR -S -N 3 ** as well as **READ -S AVAR -N 3 -P "MyPrompt"**.  What is critical here is that you **must** have a number immediately after -N and a string after -P which will be the prompt.

### Arguments

As briefly discussed above, almost all commands take and most even require an argument which affects the command's behavior.  For example the **SLEEP** command requires that you pass it an argument that indicates the amount of time to SLEEP.  Arguments come in many forms; each of these is discussed here.  

#### \<conditions\>

The shell features a lot of built-in checks and comparisons called \<conditions\> throughout this guide.  This particular form of an argument is used exclusively by the **IF** and **WHILE** commands where the \<condition\> is evaluated and result is used to control program flow with in the defined **IF-ELSE-FI** or **WHILE-LOOP** block.  All conditions must be encloded with in brackets **[]**.  In addition to the capabilities found in the extensive list of checks and comparisons listed below, conditional execution can be enhanced by negating with an ! in front of a condition and/or compounding with AND and OR between two or more conditions.  The following scripts show examples of the possible conditions 
 can use while writing your own scripts.

> Note: 	The examples below make use of the **;** directive which allows you to put multiple statements on one line.  So for example

	IF [ condition ] ; ECHO result ; ELSE ; ECHO message ; FI
 
> Is the same as 

	IF [ condition ]
		ECHO result
	ELSE
		ECHO message
	FI

> The single line notation allows these sample scripts to be significantly shorter; their operation is not affected.  Also note, you are not limited to a single command line between the IF/ELSE/FI statements.  See the documentation of the IF command for more information.

The shell includes several "checks" that can be used to easily determine if certain \<conditions> are true or false.  The format of a check is **[ -CHECK \<value> ]** where -CHECK is one **-D** (is a directory), **-E** (is a directory or a file), **-F** (is a file), **-I** (is an integer), **-N** (is a null), **-X** (is a defined function) or **-Z** (is not null) and where \<value> is a variable or literal on which to perform the check.  This script demonstrates the usage of these "Check" Conditions.

    #!/bin/sh
	#
	#   IF [ -CHECK <value> ] Examples
	#
	#	Echo "Found" if their is a subdirectory TEST is in the current directory
	#	If TEST is not present, or is present but a file, this Check would fail
	IF [ -D TEST ] ; ECHO "Found" ; FI
	#	If -D using a variable
	SET FNAME = "TEST" ; IF [ -D $FNAME ] ; ECHO "Found" ; FI
	#	Echo "Found" if a file or a subdirectory named TEST is in the current directory
	IF [ -E TEST ] ; ECHO "Found" ; FI
	#	Echo "Found" if the file PROFILE is in the top most directory of the volume MYVOL
	#   IF PROFILE were a directory name and not a file, this Check would fail
	IF [ -F /MYVOL/PROFILE ] ; ECHO "Found" ; FI
	#	Echo "True" if the <value> is an Integer
	SET ABC = 123 ; IF [ -I $ABC ] ; ECHO "True" ; FI ;		# Would Echo True
	SET ABC = "Hello" ; IF [ -I $ABC ] ; ECHO "True" ; FI ;		# False no Echo
	IF [ -I 123.456 ] ; ECHO "True" ; ELSE ; ECHO "False" ; FI ;	# Echo False
	#	Note the next two -N and -Z are in affect opposites of each other ![ -N ] = [ -Z ]
	#	Echo "True" if the variable is not empty (non-null)
	SET ABC = "Hello" ; IF [ -N $ABC ] ; ECHO "True" ; FI ;		# True
	#	Echo "True" if a function named MYFUNC has been defined
	#	See the section on functions for more information on this check
	IF [ -X MYFUNC ] ; ECHO "True" ; FI ;				# False
	#	Echo "True" if the variable is empty/does not exist (null)
	SET ABC =  ; IF [ -Z $ABC ] ; ECHO "True" ; FI ;		# True
	SET ABC = "Hello" ; IF [ -Z $ABC ] ; ECHO "True" ; FI ;		# False

>In case you are wondering why there appears to be extra semicolons (;) in the lines above, unlike other languages (i.e. C, BASH, VB) you cannot put a comment on the same line as a command.  A comment must start with pound (#) at the start of a line.  Remember from the note above, that the semicolon allows you to concatenate multiple lines onto one, but they are treated as separate lines.  Here, that allows a comment to appear on the same line as executable statements, but to the shell its treated as its only line that starts with a #.

This script demonstrates the usage of the various String evaluation Conditions.  They are equals (=), not equals (!=), less than (.<), less than or equal (<=), greater than (.>) and greater than or equal (>=).

    #!/bin/sh
	#
	#   IF [ String <comparator> String ] <conditions> Examples
	#
	SET A = "ABC"
	SET B = "DEF"
	IF [ $A  = $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE
	IF [ $A != $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A .< $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A <= $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A .> $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE
	IF [ $A >= $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE

> Note if you set A = 123 and B = "DEF" and do those tests you will get an error on some of the tests since one of the variables is an integer and both variables should be strings.  

This script demonstrates the usage of the various Integer evaluation Conditions.  They are equals (-eq), not equals (-ne), less than (-lt), less than or equal (-le), greater than (-gt) and greater than or equal (-ge).

    #!/bin/sh
	#
	#   IF [ Int32 <comparator> Int32 ] <conditions> Examples
	#
	SET A = 123
	SET B = 456
	IF [ $A -eq  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE
	IF [ $A -ne  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A -lt  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A -le  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# True  - HI
	IF [ $A -gt  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE
	IF [ $A -ge  $B ] ; ECHO HI ; ELSE ; ECHO BYE ; FI ;		# False - BYE

> Note if you set A = 123 and B = "Hello" and do those tests you will get an error since one of the variables is string and both variables must be integers.  

To help simplify scripts in some cases, you can modify any of the above \<conditions\> by preceding it with an exclamation (!) or NOT symbol.  For instance you might have a script that creates a temporary file that normally would be stored in **${ROOT}TMP/**.  Before attempting to create a file in this directory you might check to see if it exists and if not create it.  This script would do that:

    #!/bin/sh
	#
	#   Check for TMP and create if missing
	#
	IF [ -D ${ROOT}/TMP ]
	ELSE
		MD ${ROOT}/TMP
	FI

Notice that the work being done here is in the ELSE block, or when the check fails.  You may find it better to use the NOT (!) modifier and write the script this way:

    #!/bin/sh
	#
	#   Check for TMP and create if missing
	#
	IF ![ -D ${ROOT}/TMP ]
		MD ${ROOT}/TMP
	FI

You can further extend \<conditions\> by building complex evaluations that consist of multiple check or comparison \<conditions\> joined by AND and/or OR.  The following are examples using AND and OR.

    #!/bin/sh
	#
	#   IF <conditions> with AND and OR Examples
	#
	SET A = 123
	SET B = 456
	# With AND you can test 2 or more things at once
	IF [ $A -eq 123 ] AND [ $B -eq 456 ]
		ECHO HI
	ELSE
		ECHO BYE
	FI	 ;		# True  - HI
	# Test that 3 conditions are ALL true
	IF [ $A -eq 123 ] AND [ $B -eq 456 ] AND [ $C = "Your Name" ]
		ECHO HI
	ELSE
		ECHO BYE
	FI	 ;		# False - BYE  (because 3rd condition not met)
	# With OR you can test if either condition is met 
	IF [ $A -eq 123 ] OR [ $B -eq 456 ]
		ECHO HI
	ELSE
		ECHO BYE
	FI	 ;		# True  - HI
	IF [ $A -eq 999 ] OR [ $B -eq 456 ]
		ECHO HI
	ELSE
		ECHO BYE
	FI	 ;		# True  - HI	(2nd condition is met)

When using multiple of these joiners with a single command such as **IF**, care should be made  in the structuring of your \<condition\> statements.  The shell processes command lines linearly from left to right and is very binary in nature.  Consider first a math example of **SET A = 1 + 2 * 3 - 4 * 8 + 2 / 2**, the result placed into **A** is 42 (process the calculations like a calculator would, one at a time, there is no precedence).  When evaluating a set of \<conditions\>, the shell processes them one at a time the same way and when it encounters an AND or an OR it evaluates the current "state" to determine if it should return a result or continue to evaluate the conditions ont he line.  Let us say you have 4 conditions, A, B, C and D (each one represents something like [ -d adir ]), and you are doing something like IF A AND B OR C AND D.  The Shell will determine a result for A (for example that [ -d adir]) and then it sees "AND", at that moment if A is false all processing ends there because it does not matter what else is on the command line (The IF fails).  Now assume A and B are both true and it gets to that OR, again processing stops be cause there is already a true case on one side of the OR (The IF succeeds).  As you can see, its easy to predict the behavior of constructs like IF A and B and C and D (all must be true) as well as IF A or B or C (any one need be true), but complex IF A or B and C or D and E need to be tested that they perform as you imagined.  Once mastered though, you will see that when structured correctly you can perform very complex \<condition\> sets.  Say you wanted to do IF ( A and B ) or C, realizing there is no actual groupings (parens) in conditions, if you simply structure your if as IF C OR A AND B, it will have the effect you wanted.  There is an example of complex compound conditions that you can run and even modify to test different patterns/structures of complex conditions.  It can be found at **[ANDORTESTS](../EXAMPLES/ANDORTESTS.txt)**.

#### \<expression\>

The A2osX shell contains an expression evaluator that can perform simple integer math operations using the **\+ \- \* \/** and **MOD** operators.  Expressions are a form of an argument used by only a handful of commands, most notably SET (to store the result of the expression into a variable) and CASE/SWITCH.

    #!/bin/sh
	#
	#   Shell Expressions Example
	#
	SET A = 123
	SET B = 10
	SET C = A + B		# 133
	SET C = A - B		# 113
	SET C = A * B		# 1230
	SET C = A / B		# 12
	SET C = A MOD B		# 3
	SET C = 100 * 2 / 4 + 2 / 13 * 4 	# 16

#### \<op\>

\<Op\> are operators, the simple integer math functions that can be performed in the shell.  They are a special kind of argument used only in \<Expressions\>, see above.   The valid \<Ops\> are \+ (addition) \- (subtraction) \* (multiplication) \/ (division) and MOD.  See the script above in the \<expression> section for examples of \<ops>. 

#### \<switch\>

A switch is a special type of argument to internal and external commands that changes the behavior of that command.  For instance, the standard ECHO command ends its output with a carriage return (ASCII 13), adding the -N switch to ECHO (i.e. ECHO -N "Hello") will cause ECHO to omit the CR.  All switches begin with hyphen (-) and are immediately followed by a valid single character (in the case of ECHO -N is the only valid switch) and then a space (or carriage return if the end of the line). There should be no space between the hyphen (-) and the switch character, and if the switch itself requires an argument, then switch must be followed by a space and then the argument for that switch (see the READ command for an example). Please make sure you read the note at the start of this section regarding command line structure and the ordering of arguments, in particular with switches that themselves require arguments. 

#### \<value\>

Values are the simplest form of arguments, usually a string or an integer, which may be presented literally or in the form of a variable.  

Please note, that the shell does string substitution when processing \<values>.  This is done when the shell finds a variable within the string (a set of characters that begin with a $). For example if you had a variable called $BOOTVOL that is set to "/MYVOL/" and you passed a command the \<value> "${BOOTVOL}AFILE", it would get expanded to "/MYVOL/AFILE".  Notice the use of braces **{}** surrounding the variable name, they are needed here otherwise the SHELL would look for the variable $BOOTVOLAFILE.  See the script below for the **ECHO** command for more examples of values that contain variables. Also look at the section on the **SET** command and the section below on **Variables**.

### AND

	[ <expression> ] AND [ <expression> ]...

The **AND** reserved word is used to join 2 or more conditions together to create complex logic statements.  See \<condition\> section above for more information on **AND** and examples of its usage.  In addition, look at **[ANDORDEMO](EXAMPLES/ANDORDEMO.txt)**, a complete script using **AND** and **OR**.

### BREAK

	BREAK

The **BREAK** command is used to exit or end a block of statements that were optionally executed for a particular **CASE** as part of a **SWITCH** script block.  See the **SWITCH** command below for more information and example of using **BREAK**. 

### CALL 

	CALL function [ <argument> ]...

The **CALL** command is used to execute a previously defined and loaded function.  When calling a function with the **CALL** command, you may pass one or more arguments which can then be used by the function during execution.  See the **FUNCTION** command below for more information on creating and calling functions including examples.

### CASE

	CASE <expression>

The **CASE** command is used at the start of a block of statements to be optionally executed based on the evaluation of \<expression\> as part of a **SWITCH** script block. See the **SWITCH** command below for more information and example of using **CASE**.

### CD

	CD <value>

The **CD** command is used to change the current working directory.  You must supply the **CD** command a valid relative or absolute path.  Examples of relative paths include SUBDIR1 (a sub-directory in the current directory), ../SUBDIR2 (a sub-directory in the parent of the current directory), and SUBDIR1/SUBDIR3 ( a sub-directory in the sub-directory SUBDIR1 of the current directory).  An absolute path always begins with a / and includes the volume name of the disk drive to which change the current working directory such as /MYVOL1/VAR/LOGS (the sub-directory LOGS in the directory VAR on the disk with a volume label of MYVOL1).  You can use the **PWD** command to display the current working directory if your prompt (**$**) does not automatically display it on the command line (the default, set in your PROFILE).  The current working directory is used my the shell to look for scripts not located in one of the directories specified by **$PATH** or as the directory for reading and writing files when no path is provided by a command.  For example, if you execute the **LS** command without arguments, **LS** assumes to list the files in the current working directory.  Similarly, if you specify a file without a path, for example the command **ECHO Hello > outfile**, shell will place the file outfile in the current working directory.  See the related **POPD** and **PUSHD** commands. 

### DATE

	DATE [ <expression> ]

The **DATE** command outputs the current date and time.  A supported clock card is needed to return accurate DATE and TIME values.  **DATE** accepts an optional \<expression> that should be a string that can contain any text as well as the following format options: 
- %a : Abbreviated weekday name : Thu
- %A : Full weekday name : Thursday
- %b : Abbreviated month name : Aug
- %B : Full month name : August
- %d : Day of the month, zero-padded (01-31)
- %H : Hour in 24h format (00-23) 14
- %I : Hour in 12h format (01-12) 02
- %m : Month as a decimal number (01-12) 08
- %M : Minute (00-59) 55
- %p : AM or PM designation PM
- %S : Second (00-61) 02
- %w : Weekday as a decimal number with Sunday as 0 (0-6)
- %y : Year, last two digits (00-99)
- %Y : Year four digits 2001

The following script highlights sample \<expressions> you can pass the **DATE** command.

    #!/bin/sh
	#
	#   DATE Command Examples
	#
	DATE						' Wednesday, November 20 2019 22:53:00
	DATE "Time: %I:%M %p"		' Time: 10:53 PM
	DATE "Today is %A %B %d %Y"	' Today is Wednesday November 20 2019
	DATE "%b-%d-%y"				' Nov-20-19

### DEFAULT

	DEFAULT

The **DEFAULT** commands is used to select the block of commands to execute for the Default Case for the **SWITCH** command.  Structured appropriately, the commands after the **DEFAULT** keyword are executed when no other **CASE** was valid.  See the section on **CASE** and **SWITCH** for more information and complete examples for creating your own **SWITCH** execution blocks. 

### ECHO

	ECHO [-N] <value>...

The **ECHO** command is used to print <values> to an output device, by default the screen.  The **ECHO** command optional switch **-N** causes **ECHO** to suppress output of the carriage return that normally occurs.  Technically the format of the ECHO command is **ECHO [-N] [\<value\> ...]**.  This means that the ECHO command can be followed by the optional switch -N and one or more optional \<values\>.  In the case of ECHO, it is these \<values\> that are output by the command.  Here, values are separated by spaces, so you can do ECHO $A HELLO $B and echo will output the value stored in the variable A and then the world HELLO and then the value stored in B.  Please see \<values> for more information on how values are processed, especially in the handling of variables ($VAR) contained in a \<value>.

A word about values, command lines and spaces: **ECHO Hello World** is not the same as **ECHO "Hello World"**.  In the first case ECHO treats Hello and World as separate values and in the second, "Hello World" as one value.  Since ECHO takes multiple values, you might not notice the difference, but in the case of **IF [ $A = "Hello World" ]** if you omitted the quotes you would get a syntax error because the = operator only accepts one value on each side.  In addition, when not enclosed in quotes, extra spaces are removed so **ECHO Hello&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;World** would be output as **Hello World** as ECHO would treat Hello and World as values and output value space value. 

In addition to the usual variable substitution that occurs with \<values> (see \<value> above), the **ECHO** command performs some special character substitutions while sending output to the screen or terminal.  If placed inside a value like a string, **ECHO** will automatically substitute a backspace for the sequence **\b**, substitute an escape for **\e**, clear the screen for **\f**, send a newline for **\n**, send a \ for **\\\\** and send a % for **\\%**.  The **\e** (escape) code is useful for sending VT100 escape sequences to the screen/terminal (see the VT100 example script).  The **\\\\** and **\\%** are necessary to send those chars to the screen since normally those characters are interpreted as special command line arguments.    There is also a special **\xHH** option, that will send explicitly the char represented by the HEX value HH to the output device (screen or file).

    #!/bin/sh
	#
	#   ECHO Command Examples
	#
	ECHO Hello    World		'Hello World	#Note SH treats as 2 <values>
	ECHO "Hello    World"   	'Hello    World
	ECHO \f				'Clears Screen
	ECHO "\fHello"			'Clears Screen puts Hello on first line
	ECHO "\n\nHello'		'Sends to Carraige Returns then Hello to output
	SET A$ = HELLO
	ECHO A$				'HELLO
	ECHO "$A, How are you?"		'HELLO, How are you?
	ECHO "$AB, fine!"		', fine!		#Note AB is not defined
	ECHO "${A}B, fine!"		'HELLOB, fine!	#Brackets ensure A substitution
	ECHO "123\b\b456"		'1456			#two backspaces (\b) over the 23
	ECHO -N "\xFF\xFF" > afile	'Create file called afile and put exactly the
					'bytes Hex FF and Hex FF into it.

Consult the subsection below on Advanced Display Techniques for more examples of using **ECHO** and additional VT100 escape sequences that can be used to control the display of output.

#### Advanced Display Techniques

A2osX provides advanced screen handling capabilities for the Apple console (keyboard/screen) as well as terminals connected directly (via Super Serial Cards) or remotely (via Telnet using a supported network card and the TELNETD server daemon).  These features are based on the VT100 Terminal definition and scripts you develop can pass VT100 codes (via the ECHO command) to enhance the appearance of your scripts.  In addition to VT100 codes, ECHO has been augmented with some short codes to perform the more common and to help display special characters.  The examples below will help you understand what is possible with ECHO.  For a fuller listing of the available VT100 Terminal Codes, consult the **[A2osX Terminal Codes Guide](.Docs/TERM.md).**

    #!/bin/sh
	#	ECHO / Advanced Display Techniques Examples
	#	Note codes are CASE SENSITVE.  \F is not the same as \f
	#   Clear the Screen (\f)
	ECHO \f
	#   Clear the Screen and Display text in the top left corner
	ECHO "\fThis line will appear on the first line of your Apple"
	#	ECHO on a line byself will create a blank line (moving the cursor down one line)
    #	Multiple ECHOs in a row, will skip multiple lines.  The \n shortcode makes this easier.
	#	This example is the same as ECHO; ECHO; ECHO "HELLO"; ECHO; ECHO; ECHO "WORLD"
	ECHO "\n\nHELLO\n\nWORLD"
	#	Backspace shortcode \b moves the cursor one space to the left.
	#	This example would print ABEF on the screen.  The two \b overwrite the CD.
	ECHO "ABCD\b\bEF"
	#	Turn Inverse on: \e[7m		off: \e[0m
	#	This example displays HELLO INVERSE WORLD with the word INVERSE in inverse.
	ECHO "HELLO \e[7mINVERSE\e[0m WORLD"
	#	Print a backslash (\).  Since \ is a special character, you need a way to print it.
	ECHO "\\"
	#	Print a percent (%).  Since % is a special character, you need a way to print it.
	ECHO "\%"
	#	Supress Newline (-N).  ECHO -N allows you to print multiple things on the same line
	#	This code segment will print ONE TWO THREE all on one line.
	ECHO -N ONE
	ECHO -N TWO
	ECHO -N THREE
	#	Move cursor to beginning of current line (\r)
	#	This example will print WORLD HELLO, note spaces.
	ECHO "      HELLO\rWORLD"
	#	Scroll Screen Down 1 Line (\eM)
	ECHO \eM
	#	Scroll the Screen Up 1 Line (\eD)
	ECHO \eD
	#	Clear Screen VT100 Code alternative, same as \f (\ec)
	ECHO \ec
	#	Move cursor to [x,y] \e[x;yH
	#	Move cursor to row 5 and col 15 and print I AM HERE
	ECHO "\e[05;15HI AM HERE"
	#	Move to home position [0,0] (\e[H)
	ECHO \e[H
	#	Clear from cursor to end of line (\e[K)
	ECHO \e[K
	#	Clear from cursor to beginning of line (\e[1K)
	ECHO \e[1K
	#	Clear line (\e[2K)
	ECHO \e[2K
	#	Clear line 15
	ECHO \e[15;01H\e[2K

### ELSE

	ELSE

The **ELSE** command is used to add an optional branch to an **IF** block.  See the **IF** command below for more information and examples of using **ELSE** as part of **IF** program blocks.

### END

	END

The **END** command is used at the end of a **SWITCH** script block. See the **SWITCH** command below for more information and example of using **END** as part of **SWITCH**.

### EXIT 

	EXIT [int32]

The **EXIT** command is used to immediately end the processing of a script or function.  **EXIT** accepts an optional argument that sets the return code (**$?**) which may be checked by a calling script.  If no argument is provided the return code is set to 0 (No Error).  The following script demonstrating the use of the EXIT command can be found in the [EXAMPLES](../EXAMPLES) folder.

    #!/bin/sh
	#
	#   EXIT Command Examples
	#
	# This example shows the use of EXIT from a function with a return code
	#
	FUNCTION DIVIDE
	{
		IF ![ -I $A ] AND ![ -I $B ]
			# Error not vars not integers
			EXIT 3
		FI
		IF [ $B -EQ 0 ]
			# Error Zero Divisor
			EXIT 7
		FI 
		SET $3 = $A / $B
	}
	READ -P "\nEnter a number: " $A
	READ -P "\nAnother number: " $B
	CALL DIVIDE $A $B C
	SWITCH $?
		CASE 0
			ECHO "\n$A divided by $B is $C\n"
			BREAK
		CASE 3
			ECHO "\nError: Input not Integers\n"
			BREAK
		CASE 7
			ECHO "\nError: Divide by Zero Prohibitied\n"
			BREAK
	END

>Besides the **EXIT** command, the example above also demonstrates how to check that input is a number rather then a string (-I), using newlines (\n) to properly format the screen (the READ command leaves the cursor on the line of input), and passing a variable name to a function (this is a clever way to get return values from commands).

### FI

	FI

The **FI** command is used at the end of an **IF** script block. See the **IF** command below for more information and example of using **FI** as part of **IF**.

### FUNCTION

	FUNCTION function_name
	{ 
		<body>
	}

The **FUNCTION** command is used to define a function that can be called one or more times in your scripts.  

>A note about the shell, memory usage and functions.  

if you SET -F, it will discard ALL previously learned FUNC in the current SH context
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

### IF

	IF [ <expression> ]...

### LOOP

	LOOP

The **LOOP** command is used at the end of a **WHILE** script block. See the **WHILE** command below for more information and example of using **LOOP** as part of **WHILE**.

### MD

	MD <value>

MD path or relative path <br> Create a directory |

### NOHUP

	NOHUP <value> [&]

| NOHUP     | Working | Start a process with PPID=PS0 (Daemon) |

### OR

	[ <expression> ] OR [ <expression> ]...
  
The **OR** reserved word is used to join 2 or more conditions together to create complex logic statements.  See \<condition\> section above for more information on **OR** and examples of its usage.  In addition, look at **[ANDORTESTS](EXAMPLES/ANDORTESTS.txt)**, a complete script using **OR**.

### PAUSE

	PAUSE

The **PAUSE** commands halts the execution of a script until the user presses the return key. 

### POPD

	POPD [ <value> ]

| POPD      | Working | Restore previously saved working directory |

### PUSHD

	PUSHD [ <value> ]

Save actual working directory <br> PUSHD \<dir\> do also a CD to \<dir\>

### PWD

	PWD

the **PWD** command prints the current working directory.  You can change the working directory with the **CD** command or with the **POPD** command is a working directory has been previously **PUSHD**.

### RD

	RD <value>

Remove the empty directory specified by \<value> which may be either a relative directory name such as ThisDir or ../SomeDir/ThisDir or it can be a full path name such as /MyVol/SomeDir/ThisDir.  The directory specified must be empty or an error will be thrown. To remove a non-empty directory (and all the files and subdirectories contained within) you can use the **RM** command with the **-R** switch.  See the **RM** for more information.

### READ

	READ [ -S ] [ -P <value> ] [ -N int32 ] <variable>

The READ command allows you to accept input from the user which can be used or evaluated in other commands.  For instance you can use the READ command to get the name of a file to copy, ask the user for confirmation (Proceed?) and evaluate their response with an IF command, etc.  READ has several powerful options including: Prompt, Suppress and NumChars. In all cases you must specify a variable in which to place the results of the READ command.

    #!/bin/sh
	#READ Command Examples
	#    Get Input from User and Store in Variable $A
	READ A
	#    Display a prompt, Get Input and Store in $A
	READ -P "Enter your name: " A
	#    Display a prompt, Get Suppressed Input and Store in $A
    #    The suppress option will keep any input from appearing but you can
	#    edit normally and $A will be correct.
	READ -S -P "Enter your name: " A
	#    Display a prompt, Get Input limited to 8 characters and Store in $A
	READ -N 1 -P "Enter your name: " A
	#    Display a prompt, Get Input limited to 1 characters and Store in $A
    #	 Special case of -N option.  As soon as the user types any character
    #    input will be ended and the single character will be stored in $A.
    #	 The user does NOT need to press return to accept the input.
	READ -N 1 -P "Proceed (Y/N): " A
	#    Get Input limited to 1 key press and Store the ASCII value of the key in $A
    #	 Special case of -N option.  As soon as the user types any key, input will
    #    be ended and the single key code will be stored in $A as an Integer.
    #	 This can be used to capture/process special keys like TAB, Arrows and DEL.
	#	 In this special case of READ, the character pressed is NOT echoed.
	READ -N 0 A
 
### REN

	REN <value> <value>

The REN command allows you to Rename a single file, directory or Volume.  It does not support wild cards.  While REN and MV may seem similar, they are very different commands and you should use each for its intended purpose.  In the case of REN, it changes the name of an item (Vol, Dir, File) in place; the item itself is not changed.  For those familiar with ProDOS file systems, REN changes the entry of an item in the CATALOG.  MV on the other hand actually copies files (and removes the original) to move them.  Obviously REN is more efficient at RENaming an item in its current location, whereas MV could be used to change the location of a file (MV it from one directory or even volume to another).  Yes you can use MV MYFILE NEWFILE to do the same thing as REN MYFILE NEWFILE, but since a copy must occur, it will be slower and you will have to have sufficient disk space free to make this copy.

    #!/bin/sh
	#REN Command Examples
	#    REName a Volume
	#	 Note How you need to use a full volume name as the Original Name and
	#	 the new name must not be proceeded by a slash (/).  The following
	#	 will rename the volume /MYVOL to NEWVOL.
	REN /MYVOL NEWVOL
	#    REName a Directory in the current working directory ($PWD)
	REN ADIR NEWDIR
	#    REName a Directory in another relative directory
	#	 In this example, the directory ADIR in SUBDIR will be renamed.
	#	 Notice that the new name does not contain a path.
	REN SUBDIR/ADIR NEWDIR
	#    REName a Directory using a full path
	#	 This example renames the dir MYDIR found in /FULLBOOT/TMP to YOURDIR.
	REN /FULLBOOT/TMP/MYDIR YOURDIR
	#	 REName File Examples
	#	 REName a file in the current directory
	REN MYFILE NEWFILENAME
	#	 REName a file in a relative (the parent) directory
	REN ../MYFILE NEWFILENAME
	#	 REName a file using a full path
	REN /FULLBOOT/TMP/MYFILE NEWFILENAME

### SET

	SET <switch>
	SET Variable = <value>
	SET Variable = <expression>
	SET Variable =

The **SET** command is used to set or clear the value of variables as well as to set or clear flags that change the behavior of the shell (**SH**) especially when running scripts.

#### Variables

The most simplistic form of set is **SET var = value** such as SET myVar = 6, where the shell will create a new variable called MyVar and in this case make it an Interger (32-bit) and set its value to 6.

As seen throughout this guide, scripts are very useful for automating many repetitive tasks.  To get the most out of scripts, you are likely going to want input from the user or gather existing data stored in your file system and then use this to control program flow.  To do this, you are likely going to want to use variables to store and process the data your script relies on.  This section will provide you with the information you need to get the most out of your own, as well as system provided, variables.

All variables have names, starting with xxx, can be any length, but longer is not better.  They are case sensitive so AVAR, Avar, aVar, and avar are actually 4 different variables.  There are only two kinds of variables internally, strings and integers.  
 



Variable overflow strings and ints
Ints only no real num it just ignore

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 

#### Special Variables

In addition to the variables you create, there are a number of predefined variables that you can use in scripts.  Several of these are set by **LOGIN** when a user logs on to A2osX.  These include $BOOT, $DRV, $LIB, $PATH, $ROOT and $TERM.

The **$BOOT** variable holds the full path of the ProDOS PREFIX when you started A2osX (**-A2OSX.SYSTEM).  The **$ROOT** variable contains the same full path.

>Note, while your PREFIX could be set to /MyVol/Adir and you can launch A2OSX.SYSTEM from another directory (i.e. -/MyVol/OtherDir/A2OSX.SYSTEM), A2osX will not fully load because it will look for support files in sub directories of PREFIX.  See the A2osX User Guide for more information on starting A2osX.

The **$DRV** variable holds the full path A2osX can find hardware driver files for A2osX such as the driver for a Super Serial Card (SSC).  **LOGIN** automatically sets this variable to ${BOOT}DRV/, which means it will look for drivers in the DRV sub directory found in the full path $BOOT is set to.  If you have made your own drivers and store them in a different location, you could change or add to this variable.  It is used like the standard $PATH variable where multiple directories can be listed (and searched) by separating them with a colon (:).  So for example you could **SET $DRV = ${BOOT}DRV/:/MYVOL/DRIVERS/** and when INSDRV attempts to install a driver name you specify it will first look for the driver file in the DRV sub directory of $BOOT and then look in the /MYVOL/DRIVERS/ directory.  Note that these paths must end with a slash (/) as shell looks for files by appending a file name to these search paths.

The **$GECOS** variable holds the Full Name (string) of the current user.  This variable is set by **LOGIN** and cannot be changed by the user.  Its value is taken from the ./etc/passwd file as set by the **USERADD** command.

The **$GID** variable holds the group id (integer) of the current user.  This variable is set by **LOGIN** and cannot be changed by the user.  Its value is taken from the ./etc/passwd file as set by the **USERADD** command.

The **$HOME** variable holds the full path of the logged in users HOME directory, the place where their personal files are stored.  This variable is set by **LOGIN** and its value is taken from the ./etc/passwd file as set by **USERADD**.

The **$LIB** variable holds the full path A2osX can find Library files for A2osX such as LIBCRYPT.  **LOGIN** automatically sets this variable to ${BOOT}LIB/, which means it will look for libraries in the LIB sub directory found in the full path $BOOT is set to.  If you have made your own libraries and store them in a different location, you could change or add to this variable.  It is used like the standard $PATH variable where multiple directories can be listed (and searched) by separating them with a colon (:).  So for example you could **SET $LIB = ${BOOT}LIB/:/MYVOL/LIBRARY/** and when your program attempts to load a library you specify it will first look for the library file in the LIB sub directory of $BOOT and then look in the /MYVOL/LIBRARY/ directory.  Note that these paths must end with a slash (/) as shell looks for files by appending a file name to these search paths.

The **$LOGNAME** variable holds the login id (string) of the current user.  This variable is set by **LOGIN** and cannot be changed by the user.  Its value is taken from the ./etc/passwd file as set by the **USERADD** command.

The **$PATH** variable holds the full paths the shell used to find external command or script files such as **LS** or **TELNET**.  **LOGIN** automatically sets this variable to ${BOOT}SBIN/:${BOOT}BIN/, which means it will look for commands/scripts in the SBIN and BIN sub directories found in the full path $BOOT is set to.  Shell will also look in the current working directory ($PWD) after looking at the directories listed in $PATH.  If you have a directory with your your own commands and scripts, you can change or add to this variable.  Just like the standard $PATH variable in linux, multiple directories can be listed (and searched) by separating them with a colon (:).  Note that these paths must end with a slash (/) as shell looks for files by appending a file name to these search paths.

The **$PS1** variable holds optional text to display as part of the interactive shell prompt.  This variable is usually set in a user's PROFILE script and by default is set to **'$PWD'**.  

>Note the single quotes surrounding $PWD.  If you look in you will see the full command is **SET PS1 = '$PWD'**.  Normally when you set one variable to include another, for example **SET PS1 = $PWD**, PS1 would get set to the value of $PWD as it is at the time it was set.  Meaning that as the user changes directories, the users prompt would never change.  By surrounding $PWD with single quotes, you are telling the shell to set PS1 not to the value of PWD, but to the variable itself (think pointer in C as a opposed to data).  In this way, every time the shell goes to display the prompt, it displays the current value stored in $PWD.

The **$PWD** variable holds the current working directory used by shell.  This variable is maintained by the shell and cannot be changed directory by the user (**SET $PWD = anything** will be ignored).  It is updated through the use of **CD** and **PUSHD**.  You can **ECHO $PWD**, however the internal shell command **PWD** does the same thing and is shorter to type.

The **$SHELL** variable holds the full path for the Shell process of the logged in user, the shell being run currently.  This variable is set by **LOGIN** and its value is taken from the ./etc/passwd file as set by **USERADD**.

The **$TERM** variable holds the name of the type of terminal codes used for screen handling and programming.  This is **always** set to **vt100** as that is the only terminal type A2osX supports. 

The **$UID** variable holds the user id (integer) of the current user.  This variable is set by **LOGIN** and cannot be changed by the user.  Its value is taken from the ./etc/passwd file as set by the **USERADD** command.

In addition to the variables defined above, there are a set of special variables updated by the shell that are particularly useful with scripts.  These variables are all a single character following the dollar sign (**$**).

The **$0** variable holds current commands full path.  In the case of scripts this would be the full path of the script (its file name preceded by the full path of the directory in which it is stored (i.e. /MyVol/usr/share/examples/ExampleScript).

The variables **$1** through **$9** hold the values of the first 9 arguments passed to a script or function.  If less then 9 arguments are passed the unused variables will be null.  If more then ten arguments are passed, you can use the **SHIFT** command to access the additional arguments.  See the **SHIFT** command for more information.

The **$*** variable is a string containing all the arguments passed to the script or function.  Since this is just a concatenation (space separated) of all the arguments, its usefulness is largely limited to debugging (i.e. **ECHO $* >> debuglog**).

The **$#** variable is an integer holding the total number of arguments pass to the script or function.  This variable can be used by a loop to process the passed arguments.  See the **SHIFT** command below for an example script using the **$#** variable.

The **$?** variable is an integer holding the return or exit code of the last executed command, function or script.  Scripts and functions can set the return code using the **EXIT** command (i.e. **EXIT 144** to set $? to 144).

The **$@** variable is an integer that holds the Process ID (**PID**) of the parent process that called this script.  If a script is run from the prompt (**$**), then the PID would be of the /BIN/SH process running for the current user.  If a script is run by another script, then the PID would be of the calling script (except if called with the . then the called script is actually running in the same process as the calling script).

The **$$** variable is an integer that holds the Process ID of the currently running process (**PID**), which is this scripts PID.

The **$!** variable is an integer that holds the Process ID (PID) of the last Child process created by the currently running process (this scripts PID).  Note internal shell commands such as ECHO or DATE do not create new processes, but external commands and running other scripts do.  So, if a script performs a **CP afile bfile**, then examining **$!** right after the command would give you the PID for the process that was run.

>Note, you can list the currently running processes and their IDs (PIDs), their parent PIDs and their child PID number using the **PS** command.  You can stop a running process by its PID by using the **KILL** command.  Running a command by using the **NOHUP** internal command (see **NOHUP** above) causes the command to be run with a parent PID of 0 (the system). Consult the Command Guide for more information on the **PS** and **KILL** commands. 

#### Shell Flags

There are a number of flags, or settings, for the shell that affect its behavior.  While these may be set interactively at the prompt (**$**), they have the most impact on scripts.  These flags/settings are: **-C** (Control-C break mode), **-E** (Error printing mode), **-F** ( Function Clear), and **-X** (Debug Mode).

##### Control-C Break Mode

This mode, set by the **-C** flag option of **SET**, allows you to change the shells behavior when a user presses Control-C (Break Key) while executing scripts.  Normally, when a script is running, the shell will stop execution of the script when the user presses Control-C (Break).  If Break Mode is set, then this will not occur.  This mode can be useful in scripts where it is important that the entire script is processed.  For example, if you modified a user's PROFILE file to always execute a particular application when the user logged in, then by putting **SET -C** at the top of the PROFILE script, you can ensure that the user cannot exit the PROFILE script before the application is run.

##### Error Printing Mode

This mode, set by the **-E** flag option of **SET**, allows you to change the shells behavior while executing scripts.  Normally the shell only outputs when it encounters a specific output command like **ECHO** or runs an external command (i.e. **LS**) that creates its out output.  It does not output to the screen the script itself during execution.

##### Clear Functions

**SET -F** is really more of a command, then a setting, and in this case, **SET -F** instructs the shell to forget or clear all functions from memory previously defined by **FUNCTION** commands.  Please see the **FUNCTION** section for more information on creating, using and clearing functions in the shell.

##### Debug Mode

This mode, set by the **-X** flag option of **SET**, allows you to change the shells behavior while executing scripts.  Normally the shell only outputs when it encounters a specific output command like **ECHO** or runs an external command (i.e. **LS**) that creates its own output.  It does not output to the screen the script itself during execution.  The **-X** changes this behavior.  When Debug Mode is set, the shell with echo to the screen each command line in a script as it is being executed.  These lines are proceeded by a **>** symbol to denote it is part of debug output.  If you are trying to debug a script, you can place one or more **SET -X** commands in your script to turn debug output on and off.

>A clever trick for using **SET -X** for short scripts.  At the prompt (**$**), type SET -X to turn on Debug mode.  Then, run your script by using the dot calling convention (**. myscript**).  This will run the script in the current environment (the one with Debug Mode set).  Remember, that when you run a script normally (**myscript**), no dot then space then script name, the shell creates an all new environment to run that script and all modes/flags/settings are set to their defaults (off).

### SHIFT

	SHIFT [int32]

The **SHIFT** command is used to remove the first argument ($1) and reorder the remaining arguments in the command line.  The **SHIFT** command is most useful when a script is passed more then nine (9) arguments and you need to process each one individually.  Since there are only special variables (see Variables above) for the first nine ($1 through $9), to process the data in arguments past nine, you first save off the early arguments then use **SHIFT** to be able to process the later arguments.  The **SHIFT** commands takes an optional argument which determines which arguments gets removed, so for examples **SHIFT 2** would remove the 2nd argument, moving arguments 3 and greater to the left.

The following script accesses and displays every argument passed to it, regardless of the number.

	#!/bin/sh
	SET numArgs = $#
	WHILE [ $numArgs -GT 0 ]
		ECHO $1
		SHIFT
		SET numArgs = $numArgs - 1
	LOOP 

### SLEEP

	SLEEP int32

The **SLEEP** command is used to pause the execution of a script for 1/10th of a second.  A2osX does a reasonably good job of determining processor speed (in Mhz) at start up so that **SLEEP 100** is a consistent 10 seconds across systems, however note, that with emulators running at artificial speeds these calculations can be affected.  Plan accordingly.

### SWITCH

	SWITCH <expression>

The **CASE** command is used at the start of a block of statements to be optionally executed based on the evaluation of \<expression\> as part of a **SWITCH** script block. See the **CASE** command below for more information and example of using **BREAK**.


The **SWITCH** statement is used at the start of a multiway program flow control block statement.  The **SWITCH** statement is really a different form of the **IF** statement that is a significant improvement over using **IF** with many nested **ELSE ; IF** blocks.  **SWITCH** provides an easy way to dispatch execution to different parts of code based on the value of the expression. Switch is a control statement that allows a value to change control of execution.


### WHILE

	WHILE <condition>

## Redirection

The shell 
| <      | Working | StdIn redirection |
| >      | Working | StdOut redirection |
| >>     | Working | Append StdOut  |
| 1>>    | Working |  |
| 1>     | Working |  |
| 2>>    | Working | StdErr redirection |
| 2>     | Working |  |

## Piping

| \|     | Working | pipe |

## Environment

| .      | Working | use same env |

## Processes

| &      | Working | start proc |

## Writing Scripts

Calling other scripts
calling scripts with . (dot space) before script name from within a script

talk about duplicating env (no dot) and using current env (dot) and how vars are treated.  and that . calling script is treated as an INCLUDE, dont even need the bin/sh at top

if using . you are using same ENV, like typing every line at the $, if not using . you start a new SH process with its own ENV (which gets tossed on exit).

note that if you call a script normally, and it is in its own ENV it only can access functions it loads/defines.  but if called by dot  . script then it can use any function that already exists in the current ENV.

loading functions this way

>A note on memory.  All scripts get loaded into and run from Main Memory.  

### Shell Environment

Copy Vars????, Different Context, own vars get lost, own funcs, when called with dot, is using the same env. 

### Line Separator

	<command> ; <command> ; <command> ; ...

The shell supports a line separator, the semicolon (;), that can be used to concatenate one or more lines on to a single line.  Many of the examples in this guide make use of this **;** directive which allows you to put multiple statements on one line.  For example

	IF [ condition ] ; ECHO result ; ELSE ; ECHO message ; FI
 
> Is the same as 

	IF [ condition ]
		ECHO result
	ELSE
		ECHO message
	FI

As far as the shell is concerned, it processes both syntax as a series of individual command lines.  For this guide, the **;** is used to make these sample scripts shorter to display.  In writing your own scripts, it may be easier to read and understand scripts that use the longer syntax.  The real benefit of the **;** line separator is on the interactive command line ($ prompt) where you can type in a mini-script at the prompt.  This is especially useful with command loops using **FOR** or **WHILE**.

### Comments

	#!/bin/sh
	#
	#  This is a comment.
	    #  This is a another comment.
	#LastComment

You add comments to your scripts by placing a pound sign at the start of the line of your script.  The # must be the first non-space character on the line, for the entire line to be treated as a comment.  As shown in the sample scripts throughout this guide, you can add a comment to a line containing a command (i.e.  ECHO "Hello") by using the semicolon to concatenate multiple lines (i.e. ECHO "Hello" ; # A Comment).

### Examples

In addition to the scripts in this document, there are many example scripts included with A2osX which can be found on the A2osX repository on GitHub.  Besides the [EXAMPLES](../EXAMPLES) folder, you may also want to look at the scripts in the [TESTS](../TESTS), [MAKE](../MAKE) and [ADMIN](../ADMIN) folders.  The scripts in the **TESTS** folder are used to test the various commands of A2osX with each release.  The **MAKE** folder contains scripts used to make the published disk images for A2osX.  The **ADMIN** folder contains scripts that are in the development stage that one day might be used to help administer an A2osX installation.  All of these are good for learning the capabilities available to the script developer.

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
