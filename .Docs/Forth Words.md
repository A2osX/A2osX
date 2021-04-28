# A2osX Forth Words (0.94)

## Description

This document lists all of the **Forth Words** supported in the A2osX implementation of **FigForth**.  Note that not all **Words** are implemented at this time, please check the *Status* and *Comment* Columns.  Currently only an interpreter is available (*../bin/forth*) | | | though a compiler is planned |

## Words

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| ! | ( n addr - ) | | Working | Store second word at address on top |
| # | ( d1 - d2 ) | | | Convert one digit of double number and add character to	output string |
| #> | ( d - addr u ) | | | Terminate output string for TYPE |
| #S | ( d - 0 0 ) | | | Convert all significant digits of double number to output string |
| ' | ( - addr ) | | | Find address of next string in dictionary |
| ( | ( - ) | | | Begin comment, terminated by ) | |
| * | ( n1 n2 - prod ) | | Working | Multiply |
| */ | ( n1 n2 n3 - quot ) |  | Like */MOD, but give quotient only |
| */MOD | ( n1 n2 n3 - rem quot ) | | | Multiply, then divide (n1*n2/n3), with double-precision intermediate |
| + | ( n1 n2 - sum ) | | Working | Add |
| +! | ( n addr - ) | | Working | Add second number to contents of address |
| +LOOP | ( n - ) | | Working | Increment index by n. Terminate loop if outside limit |
| , | ( n - ) | | | Compile number n into the dictionary |
| - | ( n1 n2 - diff ) | | Working | Subtract (n1-n2) | | | |
| -TRAILING |
| . | ( n - ) | | Working | Print number |
|'."' | ( - ) |Working  | Print message (terminated by ") | | | |
| / | ( n1 n2 - quot ) | | Working | Divide (n1/n2) | | | |
| /MOD | ( n1 n2 - rem quot ) | | Working | Divide, giving remainder and quotient |
| 0< | ( n - f ) | | Working | True if top number negative |
| 0= | ( n - f ) | | Working | True if top number zero |
0>
1+
1-
2+
2-
79-STANDARD
| : | ( - ) | | Working | Begin a colon definition |
| ; | ( - ) | | Working | End of a colon definition |
| < | ( n1 n2 - f ) | | Working | True if n1 less than n2 |
| <# | ( - ) | | | Start output string |
| = | ( n1 n2 - f ) | | Working | True if n1 equal to n2 |
| > | ( n1 n2 - f ) | | Working | True if n1 greater than n2 |
>IN
| >R | ( n - ) | | | Move top item to return stack |
| ? | ( addr - ) |Working  | Print contents of address |
?DUP
| @ | ( addr - n ) | | Working  | Replace word address by contents |
ABORT
| ABS | ( n - absolute ) | | Working | Absolute value |
| ALLOT | ( u - ) | | Working | Leave a gap of n bytes in the dictionary |
| AND | ( n1 n2 - and ) | | Working | Logical bitwise AND |
BASE
| BEGIN | ( - ) | | Working | Start an indefinite loop |
BLK
BLOCK
BUFFER
| C! | ( b addr - ) | | Working | Store one byte only |
| C@ | ( addr - b ) | | Working | Fetch one byte only |
| CMOVE | ( from to u - ) | | | Move u bytes in memory |
COMPILE
| CONSTANT | ( n - ) | | Working | Create a constant with value n |
CONVERT
CONTEXT
| COUNT | ( addr - addr+1 u ) | | | Change length byte string to TYPE form |
| CR | ( - ) | | Working | Do a carriage-return |
CREATE
CURRENT
| D+ | ( d1 d2 - sum ) | | Working | Add double-precision numbers |
| DECIMAL | ( - ) | | | Set decimal base |
| DEFINITIONS | ( - ) | | | Set current vocabulary to context vocabulary |
DEPTH
DNEGATE
| DO | ( end+1 start - ) | | Working | Set up loop, given index range |
DOES
| DROP | ( n - ) | | Working | Discard top of stack |
| DUP | ( n - n n ) | | Working | Duplicate top of stack |
| ELSE | ( - ) | | Working | Beginning of the false clause |
| EMIT | ( c - ) | | Working | Type ASCII character from stack |
EMPTY-BUFFERS
EXECUTE
EXIT
| EXPECT | ( addr u - ) | | | Read u characters (or until carriage-return) | | | from input device to address |
| FILL | ( addr u b - ) | | Working | Fill u bytes in memory with b beginning at address |
FIND
| FORGET | ( - ) | | | Delete all definitions above and including the following definition |
| FORTH | ( - ) | | | Set context vocabulary to Forth vocabulary |
| HERE | ( - addr ) | | Working | Return address above dictionary |
| HOLD | ( c - ) | | | Insert ASCII character into output string |
| I | ( - index ) | | Working | Place loop index on stack |
| IF | ( f - ) | | Working | If top of stack is true, execute true clause |
IMMEDIATE
J
| KEY | ( - c ) | | Working | Read key, put ASCII value on stack |
| LEAVE | ( - ) | | Working | Terminate loop at next LOOP or +LOOP |
LIST
LITERAL
LOAD
| LOOP | ( - ) | | Working | Increment index, terminate loop if equal to limit |
| MAX | ( n1 n2 - max ) | | Working | Maximum |
| MIN | ( n1 n2 - min ) | | Working | Minimum |
| MOD | ( n1 n2 - rem ) | | Working | Modulo (remainder from division) | | | |
MOVE
NEGATE
NOTE
| OR | ( n1 n2 - or ) | | Working | Logical bitwise OR |
| OVER | ( n1 n2 - n1 n2 n1 ) | | Working | Copy second item to top |
| PAD | ( - addr ) | | Working | Return address of scratch area |
PICK
QUERY
QUIT
| R> | ( - n ) | | | Retrieve item from return stack |
R@
| REPEAT | ( - ) | | Working | Loop back to BEGIN unconditionally |
ROLL
| ROT | ( n1 n2 n3 - n2 n3 n1 ) | | Working | Rotate third item to top |
SAVE-BUFFERS
SCR
SIGN
| SPACE | ( - ) |Working  | Type one space |
| SPACES | ( u - ) | | Working | Type u spaces |
STATE
| SWAP | ( n1 n2 - n2 n1 ) | | Working | Reverse top two stack items |
THEN
| TYPE | 	( addr u - ) | | | Type u characters starting at address |
U*
| U. | ( u - ) | | Working | Print UNSIGNED number |
U/MOD
U<
| UNTIL | ( f - ) | | Working | Loop back to BEGIN until f is true |
UPDATE
| VARIABLE | ( n - ) | | Working | Create a variable with initial value n |
| VOCABULARY | ( - ) | | | Create new vocabulary |
| WHILE | ( f - ) | | Working | Exit loop immediately if f is false |
| WORD | ( c - ) | | | Read one word from input stream, delimited by c |
| XOR | ( n1 n2 - xor ) | | Working | Logical bitwise exclusive OR |
[
[COMPILE]
]

Extension Word Sets

2!
2@
2CONSTANT
2CONSTANT
2DROP
2DUP
2OVER
2ROT
2SWAP
2VARIABLE
D+
D-
| D. | ( d - ) | | | Print double-precision number |
| D.R | ( d u - ) | | | Print double-precision number in u column |
D0=
D<
| DABS | ( d - absolute ) | | | Absolute value of double-precision number |
DMAX
DMIN
DNEGATE
DU<

Assembler Word Set

| ;CODE | ( - ) | | | Create a new defining word, with runtime code routine in high-level Forth |
| ASSEMBLER | ( - ) | | | Set context vocabulary to Assembler |
| CODE | ( - ) | | | Create assembly-language definition |

Reference Word Set
!BITS
**
+BLOCK
-'
-->
-MATCH
-TEXT
| .R | ( n u - ) | | | Print number, right-justified in u column |
/LOOP
1+!
1-!
2*
2/
;:
;S
<>
<BUILDS
<CMOVE
><
>MOVE<
@BITS
ABORT"
AGAIN
ASCII
ASHIFT
B/BUF
BELL
BL
| BLANKS | ( addr u - ) | | Working | Fill u bytes in memory with blanks |
C,
CHAIN
COM
CONTINUED
CUR
DBLOCK
DPL
| DUMP | ( addr u - ) | | | Dump u numbers starting at address |
| EDITOR | ( - ) | | | Set context vocabulary to Editor vocabulary |
| ERASE | ( addr u - ) | | Working | Fill u bytes in memory with zeros |
FLD
H.
| HEX | ( - ) | | | Set hexadecimal base |
I'
IFEND
IFTRUE
INDEX
INTERPRET
K
LAST
LINE
LINELOAD
LOADS
MAP0
MASK
MS
NAND
NOR
| NUMBER | ( addr - d ) | | | Convert string at address to double number |
O.
| OCTAL | ( - ) | | | Set octal base |
OFFSET
OTHERWISE
PAGE
READ-MAP
REMEMBER
REWIND
ROTATE
S0
SET
SHIFT
| SP@ | ( - addr ) | | Working  | Return the address of the top of the stack, just before SP@ was executed |
TEXT
THRU
U,R
USER
| VLIST | ( - ) | | | Print names in context vocabulary |
WHERE
\LOOP


| -DUP | ( n - n ? ) | | Working | Duplicate only if non-zero |
| R | ( - n ) | | Working | Copy top of return stack onto stack |
| MINUS | ( n - -n ) | | Working | Change sign |
| DMINUS | ( d - -d ) | | Working | Change sign of double-precision number |
| ?TERMINAL | ( - f ) | | | True if terminal break request present |
| SIGN | 	( n d - d ) | | | Insert sign of n to output string |
| ENDIF | ( - ) | | Working | End of the IF-ELSE structure |

## License
A2osX is licensed under the GNU General Pulic License |

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) | | | any later version |

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details |

The full A2osX license can be found **[Here](../LICENSE)** |

## Copyright

Copyright 2015 - 2019, Remy Gibert and the A2osX contributors |
