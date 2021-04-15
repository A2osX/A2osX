# A2osX Forth Words (0.94)

## Description

This document lists all of the **Forth Words** supported in the A2osX implementation of **FigForth**.  Note that not all **Words** are implemented at this time, please check the *Status* and *Comment* Columns.  Currently only an interpreter is available (*../bin/forth*) | | though a compiler is planned |

## Words

| Word | Syntax | Status | Description | Comment |
|-|-|-|-|-|
| DUP | ( n - n n ) | Working | Duplicate top of stack |
| DROP | ( n - ) | Working | Discard top of stack |
| SWAP | ( n1 n2 - n2 n1 ) | Working | Reverse top two stack items |
| OVER | ( n1 n2 - n1 n2 n1 ) | Working | Copy second item to top |
| ROT | ( n1 n2 n3 - n2 n3 n1 ) | Working | Rotate third item to top |
| -DUP | ( n - n ? ) | Working | Duplicate only if non-zero |
| >R | ( n - ) | | Move top item to return stack |
| R> | ( - n ) | | Retrieve item from return stack |
| R | ( - n ) | Working | Copy top of return stack onto stack |
| + | ( n1 n2 - sum ) | Working | Add |
| D+ | ( d1 d2 - sum ) | Working | Add double-precision numbers |
| - | ( n1 n2 - diff ) | Working | Subtract (n1-n2) | | |
| * | ( n1 n2 - prod ) | Working | Multiply |
| / | ( n1 n2 - quot ) | Working | Divide (n1/n2) | | |
| MOD | ( n1 n2 - rem ) | Working | Modulo (remainder from division) | | |
| /MOD | ( n1 n2 - rem quot ) | Working | Divide, giving remainder and quotient |
| */MOD | ( n1 n2 n3 - rem quot ) | | Multiply, then divide (n1*n2/n3), with double-precision intermediate |
| */ | ( n1 n2 n3 - quot ) |  | Like */MOD, but give quotient only |
| MAX | ( n1 n2 - max ) | Working | Maximum |
| MIN | ( n1 n2 - min ) | Working | Minimum |
| ABS | ( n - absolute ) | Working | Absolute value |
| DABS | ( d - absolute ) | | Absolute value of double-precision number |
| MINUS | ( n - -n ) | Working | Change sign |
| DMINUS | ( d - -d ) | Working | Change sign of double-precision number |
| AND | ( n1 n2 - and ) | Working | Logical bitwise AND |
| OR | ( n1 n2 - or ) | Working | Logical bitwise OR |
| XOR | ( n1 n2 - xor ) | Working | Logical bitwise exclusive OR |
| < | ( n1 n2 - f ) | Working | True if n1 less than n2 |
| > | ( n1 n2 - f ) | Working | True if n1 greater than n2 |
| = | ( n1 n2 - f ) | Working | True if n1 equal to n2 |
| 0< | ( n - f ) | Working | True if top number negative |
| 0= | ( n - f ) | Working | True if top number zero |
| . | ( n - ) | Working | Print number |
| U. | ( u - ) | Working | Print UNSIGNED number |
| .R | ( n u - ) | | Print number, right-justified in u column |
| D. | ( d - ) | | Print double-precision number |
| D.R | ( d u - ) | | Print double-precision number in u column |
| CR | ( - ) | Working | Do a carriage-return |
| SPACE | ( - ) |Working  | Type one space |
| SPACES | ( u - ) | Working | Type u spaces |
|'."' | ( - ) |Working  | Print message (terminated by ") | | |
| DUMP | ( addr u - ) | | Dump u numbers starting at address |
| TYPE | 	( addr u - ) | | Type u characters starting at address |
| COUNT | ( addr - addr+1 u ) | | Change length byte string to TYPE form |
| ?TERMINAL | ( - f ) | | True if terminal break request present |
| KEY | ( - c ) | Working | Read key, put ASCII value on stack |
| EMIT | ( c - ) | Working | Type ASCII character from stack |
| EXPECT | ( addr u - ) | | Read u characters (or until carriage-return) | | from input device to address |
| WORD | ( c - ) | | Read one word from input stream, delimited by c |
| NUMBER | ( addr - d ) | | Convert string at address to double number |
| <# | ( - ) | | Start output string |
| # | ( d1 - d2 ) | | Convert one digit of double number and add character to	output string |
| #S | ( d - 0 0 ) | | Convert all significant digits of double number to output string |
| SIGN | 	( n d - d ) | | Insert sign of n to output string |
| #> | ( d - addr u ) | | Terminate output string for TYPE |
| HOLD | ( c - ) | | Insert ASCII character into output string |
| DECIMAL | ( - ) | | Set decimal base |
| HEX | ( - ) | | Set hexadecimal base |
| OCTAL | ( - ) | | Set octal base |
| SP@ | ( - addr ) | Working  | Return the address of the top of the stack, just before SP@ was executed |
| @ | ( addr - n ) | Working  | Replace word address by contents |
| ! | ( n addr - ) | Working | Store second word at address on top |
| C@ | ( addr - b ) | Working | Fetch one byte only |
| C! | ( b addr - ) | Working | Store one byte only |
| ? | ( addr - ) |Working  | Print contents of address |
| +! | ( n addr - ) | Working | Add second number to contents of address |
| CMOVE | ( from to u - ) | | Move u bytes in memory |
| FILL | ( addr u b - ) | Working | Fill u bytes in memory with b beginning at address |
| ERASE | ( addr u - ) | Working | Fill u bytes in memory with zeros |
| BLANKS | ( addr u - ) | Working | Fill u bytes in memory with blanks |
| HERE | ( - addr ) | Working | Return address above dictionary |
| PAD | ( - addr ) | Working | Return address of scratch area |
| ALLOT | ( u - ) | Working | Leave a gap of n bytes in the dictionary |
| , | ( n - ) | | Compile number n into the dictionary |
| ' | ( - addr ) | | Find address of next string in dictionary |
| FORGET | ( - ) | | Delete all definitions above and including the following definition |
| DEFINITIONS | ( - ) | | Set current vocabulary to context vocabulary |
| VOCABULARY | ( - ) | | Create new vocabulary |
| FORTH | ( - ) | | Set context vocabulary to Forth vocabulary |
| EDITOR | ( - ) | | Set context vocabulary to Editor vocabulary |
| ASSEMBLER | ( - ) | | Set context vocabulary to Assembler |
| VLIST | ( - ) | | Print names in context vocabulary |
| VARIABLE | ( n - ) | Working | Create a variable with initial value n |
| CONSTANT | ( n - ) | Working | Create a constant with value n |
| : | ( - ) | Working | Begin a colon definition |
| ; | ( - ) | Working | End of a colon definition |
| CODE | ( - ) | | Create assembly-language definition |
| ;CODE | ( - ) | | Create a new defining word, with runtime code routine in high-level Forth |
| DO | ( end+1 start - ) | Working | Set up loop, given index range |
| LOOP | ( - ) | Working | Increment index, terminate loop if equal to limit |
| +LOOP | ( n - ) | Working | Increment index by n. Terminate loop if outside limit |
| I | ( - index ) | Working | Place loop index on stack |
| LEAVE | ( - ) | Working | Terminate loop at next LOOP or +LOOP |
| IF | ( f - ) | Working | If top of stack is true, execute true clause |
| ELSE | ( - ) | Working | Beginning of the false clause |
| ENDIF | ( - ) | Working | End of the IF-ELSE structure |
| BEGIN | ( - ) | Working | Start an indefinite loop |
| UNTIL | ( f - ) | Working | Loop back to BEGIN until f is true |
| REPEAT | ( - ) | Working | Loop back to BEGIN unconditionally |
| WHILE | ( f - ) | Working | Exit loop immediately if f is false |
| ( | ( - ) | | Begin comment, terminated by ) | |

## License
A2osX is licensed under the GNU General Pulic License |

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) | | any later version |

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details |

The full A2osX license can be found **[Here](../LICENSE)** |

## Copyright

Copyright 2015 - 2019, Remy Gibert and the A2osX contributors |
