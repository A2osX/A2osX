# A2osX Macro Assembler (0.95)

## Description

Multi-CPU macro assembler based on S-C MASM 3.0 dialect

Supported CPUs:

+ 6502
+ 65C02
+ 65R02
+ 65816
+ Z80
+ SWEET16

Table-driven, add your favorite CPU creating a new CPU asm.xxxx file.

## Difference with S-C MASM 3.0

+ Symbols are case sensitive  
+ No .AC support
+ PC and global addresses are 32 bits
+ Local / Private labels are 16 bits range and from .1 to .255

## Directives

| Code | Description | Compatibility | Status | Syntax | Comment |
|-|-|-|-|-|-|
| .AC  | Ascii Compressed string| S-C           | NOT IMPL.   |             | As strings are supposed to be printed with A2osX API, Printf cannot handle 'AC' compressed strings |
| .AS  | Ascii String | S-C, A2osX     | Working     |  `.AS dTEXTd`  where d is any delimiter  `.AS -"TEXT"`produce ascii code with b7=1             | |
| .AT  | Ascii string Terminated | S-C, A2osX     | Working     | (same as above) | |
| .AZ  | Ascii string Zero terminated | S-C, A2osX     | Working     | (same as above) | |
| .BS  | Block (Byte) Storage | S-C, A2osX     | Working     | `.BS count[,value]` | Reserves `count` bytes in output and sets them to `value` (or zero if omitted) |
| .CS  | C-string | S-C 3.1, A2osX     | Working     | `.CS "text\a\b\e\f\n\r\n\r\t\v"` | |
| .CZ  | C-String Zero terminated| S-C 3.1, A2osX     | Working     | (same as above) | ZERO-terminated |
| .DA  | DAta value | S-C, A2osX     | Working | `.DA value` | 2-byte address: `.DA $1234` (see expressions) |
| .DO  | conditional start | S-C, A2osX     | Working |             | |
| .DU,.DUMMY | begin DUmmy section | S-C, A2osX     | Working |             | |
| .ED  | End Dummy section | S-C, A2osX     | Working |             | |
| .ELSE | conditional ELSE | S-C, A2osX     | Working |             | |
| .EM  | End Macro | S-C, A2osX     | Working |             | |
| .EN  | ENd of source code | S-C, A2osX     | IGNORED |             | |
| .EP  | End Phase | S-C, A2osX     | Working | `.EP` | Conclude temporary addressing range started with `.PH` and resume prior assembly addressing |
| .EQ  | EQuate | S-C, A2osX     | Working |             | |
| .FIN | conditional end| S-C, A2osX     | Working |             | |
| .HS  | Hex String storage | S-C, A2osX     | Working | `HS FE1A78`     delimiter allowed : `HS 00.11,22`            | |
| .HX  | Hex Nibble storage | S-C, A2osX     | Working | `HX EFA187`     delimiter allowed : `HS 00.11,22`            | |
| .IN,.INB,.INBx | INline source | S-C, A2osX     | Working | `.INB MYFILE`  | `.IN` inlines full text, `.INB` inlines 1 block at a time during assembly |
| .LI,.LIST  | | S-C, A2osX     | Working | `.LIST ON/OFF CON/COFF MON/MOFF XON/XOFF`  | |
| .MA  | MAcro deffinition | S-C, A2osX | Working | `.MA >MYMACRO`  | |
| .OP  | OPCode | S-C, A2osX     | Working | `.OP cpu` where cpu is one of 6502,65C02,65R02,65816,Z80,SW16           | |
| .OR  | ORigin | S-C, A2osX     | Working | `.OR address` | Set initial output address (only one allowed per assembly) |
| .PG  | PaGe control | S-C, A2osX     | IGNORED |             | |
| .PH  | PHase start | S-C, A2osX     | Working |  `.PH address` | Start a temporary addressing range |
| .PS  | Pascal-string | S-C 3.1, A2osX     | Working     |  | |
| .SE  | | S-C, A2osX     | Working |             | |
| .TA  | Target Address| S-C, A2osX     | IGNORED |             | |
| .TF  | Target File | S-C, A2osX     | Working | `.TF TargetFile[,Txxx]` | only ,TSYS supported  |
| .TI  | TItle | S-C, A2osX     | IGNORED |             | |
| .US  | USer defined | S-C, A2osX     | IGNORED |             | |

## Expressions

| Code | Description | Scope |
|-|-|-|
| \- | Negate : `.AS -"String"` output  | .AS .AT .AZ .CS .CZ |
| \' | Char, MSB=0 `lda #'a | OPCODES |
| \" | Char, MSB=1 `lda #"a | OPCODES |
| \# | Immediate LO byte : `.DA #$1234` output 34 | .DA |
| \/ | Immediate HI byte : `.DA /$1234` output 12 | .DA  
| \^ | Immediate 3rd byte : `.DA ^$123456` output 12 | .DA |
| \< | Force 24 bits output LO : `.DA <$123456` output 56 34 12 | .DA |
| \> | Force 32 bits output LO : `.DA >$123456` output 00 56 34 12 | .DA |
|-|-|-|
| \> | Force 16 bits operand : `ldx >ZP.A1L` output AE 3C 00 | OPCODES |
| \>\> | Force 24 bits operand : `lda >>ZP.A1L` output AF 3C 00 00 | OPCODES |
|-|-|-|
| \#\# | Immediate word LO : `lda ##IMMVAL` | 65816 OPCODES |
| \/\/ | Immediate word MID : `lda //IMMVAL` | 65816 OPCODES |
| \^\^ | Immediate word HI: `lda ^^IMMVAL` | 65816 OPCODES |

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

Copyright 2015 - 2024, Remy Gibert and the A2osX contributors.
