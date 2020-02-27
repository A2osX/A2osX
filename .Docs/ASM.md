# A2osX Macro Assembler (0.94)

## Description

Multi-CPU macro assembler based on S-C MASM 3.0 dialect

## Difference with S-C MASM 3.0

Symbols are case sensitive  
no .AC support

## Directives

| Code | Description | Compatibility | Status | Syntax | Comment |
|-|-|-|-|-|-|
| .AC  | Ascii Compressed string| S-C           | NOT IMPL.   |             | As strings are supposed to be printed with A2osX API, Printf cannot handle 'AC' compressed strings |
| .AS  | Ascii String | S-C,A2osX     | Working     |  `.AS dTEXTd`  where d is any delimiter  `.AS -"TEXT"`produce ascii code with b7=1             | |
| .AT  | Ascii string Terminated | S-C,A2osX     | Working     | (same as above) | |
| .AZ  | Ascii string Zero terminated (C String) | S-C,A2osX     | Working     | (same as above) | |
| .BS  | Block Storage | S-C,A2osX     | Working     | .BS x[,b]  | |
| .DA  | Data | S-C,A2osX     | Working |             | |
| .DO  | conditional start | S-C,A2osX     | Working |             | |
| .DU,.DUMMY | begin DUmmy section | S-C,A2osX     | Working |             | |
| .ED  | End Dummy section | S-C,A2osX     | Working |             | |
| .DA  | DAta | S-C,A2osX     | Working |             | |
| .ELSE | conditional ELSE | S-C,A2osX     | Working |             | |
| .EM  | End Macro | S-C,A2osX     | Working |             | |
| .EN  | ENd of source code | S-C,A2osX     | IGNORED |             | |
| .EP  | End Phase | S-C,A2osX     | Working |             | |
| .EQ  | EQuate | S-C,A2osX     | Working |             | |
| .FIN | conditional end| S-C,A2osX     | Working |             | |
| .PH  | PHase start| S-C,A2osX     | Working |             | |
| .HS  | Hex String | S-C,A2osX     | Working | `HS FE1A78`     delimiter allowed : `HS 00.11,22`            | |
| .IN,.INB,.INBx | | S-C,A2osX     | Working | .INB MYFILE  | |
| .LI,.LIST  | | S-C,A2osX     | Working | .LIST ON/OFF CON/COFF MON/MOFF XON/XOFF  | |
| .MA  | MAcro deffinition | S-C,A2osX | Working | .MA >MYMACRO  | |
| .OP  | OPCode | S-C,A2osX     | Working | `.OP cpu` where cpu is one of 6502,65C02,65R02,65816,Z80,SW16           | |
| .OR  | ORigin | S-C,A2osX     | Working | .OR $2000 | |
| .PG  | PaGe control | S-C,A2osX     | IGNORED |             | |
| .PH  | PHase | S-C,A2osX     | Working |             | |
| .SE  | | S-C,A2osX     | Working |             | |
| .TA  | Target Address| S-C,A2osX     | IGNORED |             | |
| .TF  | Target File | S-C,A2osX     | Working | .TF TargetFile[,Txxx] | only ,TSYS supported  |
| .TI  | TItle | S-C,A2osX     | IGNORED |             | |
| .US  | USer defined | S-C,A2osX     | IGNORED |             | |

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
