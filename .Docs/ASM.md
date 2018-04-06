# A2osX Macro Assembler (0.9.1)

## Description

Multi-CPU macro assembler based on S-C MASM 3.0 dialect

## Directives

| Code | Description | Compatibility | Status | Syntax | Comment |
|-|-|-|-|-|-|
| .AC  | Ascii Compressed string| S-C           | NOT IMPL.   |             | As strings are supposed to be printed with A2osX API, Printf cannot handle 'AC' compressed strings |
| .AS  | Ascii String | S-C,A2osX     | Working     |  `.AS dTEXTd` where d is any delimiter `.AS -"TEXT"`produce ascii code with b7=1             | |
| .AT  | Ascii string Terminated | S-C,A2osX     | Working     | (same as above) | |
| .AZ  | Ascii string Zero terminated (C String) | S-C,A2osX     | Working     | (same as above) | |
| .BS  | Block Storage | S-C,A2osX     | Working     |             | |
| .DA  | Data | S-C,A2osX     | Working |             | |
| .DO  | conditional start | S-C,A2osX     | Working |             | |
| .DU,.DUMMY | begin DUmmy section | S-C,A2osX     | Working |             | |
| .ED  | End Dmmy section | S-C,A2osX     | Working |             | |
| .DA  | DAta | S-C,A2osX     | Working |             | |
| .ELSE | conditional ELSE | S-C,A2osX     | Working |             | |
| .EM  | End Macro | S-C,A2osX     | Working |             | |
| .EN  | ENd of source code | S-C,A2osX     | In Progress |             | |
| .EP  | End Phase | S-C,A2osX     | Working |             | |
| .EQ  | EQuate | S-C,A2osX     | Working |             | |
| .FIN | conditional end| S-C,A2osX     | Working |             | |
| .PH  | PHase start| S-C,A2osX     | Working |             | |
| .HS  | Hex String | S-C,A2osX     | Working | `HS FE1A78`     delimiter allowed : `HS 00.11,22`            | |
| .IN,.INB,.INBx | | S-C,A2osX     | Working |             | |
| .LI,.LIST  | | S-C,A2osX     | Working |             | |
| .MA  | MAcro deffinition | S-C,A2osX     | Working |             | |
| .OP  | OPCode | S-C,A2osX     | Working | `.OP cpu` where cpu is one of 6502,65C02,65R02,65816,Z80,SW16           | |
| .OR  | ORigin | S-C,A2osX     | Working |             | |
| .PG  | PaGe control | S-C,A2osX     | IGNORED |             | |
| .PH  | PHase | S-C,A2osX     | Working |             | |
| .SE  | | S-C,A2osX     | Working |             | |
| .TA  | Target Address| S-C,A2osX     | IGNORED |             | |
| .TF  | Target File | S-C,A2osX     | Working |             | |
| .TI  | TItle | S-C,A2osX     | IGNORED |             | |
| .US  | USer defined | S-C,A2osX     | IGNORED |             | |


 