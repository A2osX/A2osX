# A2osX Terminal Codes Guide

### Updated May. 14, 2023

A2osX terminal capabilities are based off of the standard VT-100 Terminal.  This applies to users connected via Super Serial Cards, Telnet (via TelnetD server daemon) and the Apple console (physical keyboard/screen).  All programs can use this facility to create rich interactive text mode applications.  This includes both programs written in Assembly or Scripts written for the Shell (SH).  The table below lists the codes you can use in your applications and their function.  Consult the A2osX Shell Developers Guide for information on using these codes in scripts.  Note, the Apple Console implementation only supports a subset of the VT-100 codes, these are noted in the last column as OK.

| Esc Sequence 	| Description | DEC Code | A2osX TERM | Comment    | 
|---------------|-------------|----------|------------|------------|
|Esc[20h 	   	|Set new line mode|LMN|OK||
|Esc[?1h 	   	|Set cursor key to application|DECCKM||  |
|Esc[?3h 	   	|Set number of columns to 132|DECCOLM||  |
|Esc[?4h 	   	|Set smooth scrolling|DECSCLM||  |
|Esc[?5h 	   	|Set reverse video on screen|DECSCNM|OK| | 
|Esc[?6h 	   	|Set origin to relative|DECOM||  |
|Esc[?7h 	   	|Set auto-wrap mode|DECAWM|OK|  |
|Esc[?8h 	   	|Set auto-repeat mode|DECARM||  |
|Esc[?9h 	   	|Set interlacing mode|DECINLM||  |
|Esc[?25h 	   	|Show cursor| 	DECTCEM  |OK||
|Esc[20l 	   	|Reset line feed mode|LMN|OK|  |
|Esc[?1l       	|Reset cursor key to cursor|DECCKM||  |
|Esc[?2l 	   	|Reset VT52 (versus ANSI) 	|DECANM||  |
|Esc[?3l 	   	|Reset number of columns to 80|DECCOLM  || |
|Esc[?4l 	   	|Reset jump scrolling| 	DECSCLM  || |
|Esc[?5l 	   	|Reset normal video on screen| 	DECSCNM  |OK||
|Esc[?6l 	   	|Reset origin to absolute| 	DECOM  || |
|Esc[?7l 	   	|Reset auto-wrap mode| 	DECAWM  |OK||
|Esc[?8l 	   	|Reset auto-repeat mode| 	DECARM  || |
|Esc[?9l 	   	|Reset interlacing mode| 	DECINLM  |||
|Esc[?25l 	   	|Hide cursor| 	DECTCEM  |OK||
|Esc= 			|Set alternate keypad mode| 	DECKPAM  |||
|Esc> 			|Set numeric keypad mode| 	DECKPNM  |||
|Esc(A 			|Set United Kingdom G0 character set| 	setukg0  |OK||
|Esc)A 			|Set United Kingdom G1 character set| 	setukg1  |OK||
|Esc(B 			|Set United States G0 character set| 	setusg0  |OK||
|Esc)B 			|Set United States G1 character set| 	setusg1  |OK||
|Esc(0 			|Set G0 special chars. & line set| 	setspecg0  |OK||
|Esc)0 			|Set G1 special chars. & line set| 	setspecg1  |OK||
|Esc(1 			|Set G0 alternate character ROM| 	setaltg0  |OK||
|Esc)1 			|Set G1 alternate character ROM| 	setaltg1  |OK||
|Esc(2 			|Set G0 alt char ROM and spec. graphics| 	setaltspecg0  |OK||
|Esc)2 			|Set G1 alt char ROM and spec. graphics| 	setaltspecg1  |OK||
|EscN 			|Set single shift 2| 	SS2  |||
|EscO 			|Set single shift 3| 	SS3  |||
|Esc[m 			|Turn off character attributes| 	SGR0  |OK||
|Esc[0m 		|Turn off character attributes| 	SGR0  |OK||
|Esc[1m 		|Turn bold mode on| 	SGR1  || |
|Esc[2m 		|Turn low intensity mode on| 	SGR2  || |
|Esc[4m 		|Turn underline mode on| 	SGR4  || |
|Esc[5m 		|Turn blinking mode on| 	SGR5  || |
|Esc[7m 		|Turn reverse video on| 	SGR7  |OK||
|Esc[8m 		|Turn invisible text mode on| 	SGR8  |||
|Esc[FG;BGm		|Set Text Color to FG and BG ||OK||
|Esc[Line;Liner |Set top and bottom lines of a window| 	DECSTBM |OK| |
|Esc[ValueA 	|Move cursor up n lines| 	CUU  |OK||
|Esc[ValueB 	|Move cursor down n lines| 	CUD  |OK||
|Esc[ValueC 	|Move cursor right n pos| CUF  |OK|  |
|Esc[ValueD 	|Move cursor left n pos|  CUB  |OK||
|Esc[H 			|Move cursor to upper left corner| 	CUP  |OK|  |
|Esc[Line;ColH 	|Move cursor to screen location v,h| 	CUP  |OK||
|Esc[f 			|Move cursor to upper left corner| 	HVP|OK|  |
|Esc[Line;Colf 	|Move cursor to screen location v,h| 	HVP|OK|  |
|EscD 			|Move/scroll window up one line| 	IND  |OK||
|EscE 			|Move to next line| 	NEL  |OK||
|EscM 			|Move/scroll window down one line| 	RI  |OK||
|Esc7 			|Save cursor position and attributes| 	DECSC  | OK ||
|Esc8 			|Restore cursor position and attributes| 	DECRC  | OK ||
|EscH 			|Set a tab at the current column| 	HTS  |||
|Esc[g 			|Clear a tab at the current column| 	TBC||  |
|Esc[0g 		|Clear a tab at the current column| 	TBC||  |
|Esc[3g 		|Clear all tabs| 	TBC|||
|Esc#3 			|Double-height letters, top half| 	DECDHL  |||
|Esc#4 			|Double-height letters, bottom half| 	DECDHL||  |
|Esc#5 			|Single width, single height letters| 	DECSWL||  |
|Esc#6 			|Double width, single height letters| 	DECDWL||  |
|Esc[K 			|Clear line from cursor right| 	EL0  |OK||
|Esc[0K 		|Clear line from cursor right| 	EL0  |OK||
|Esc[1K 		|Clear line from cursor left |	EL1  |OK||
|Esc[2K 		|Clear entire line| 	EL2  |OK||
|Esc[J 			|Clear screen from cursor down| 	ED0  |OK||
|Esc[0J 		|Clear screen from cursor down |	ED0  |OK||
|Esc[1J 		|Clear screen from cursor up |	ED1  |OK||
|Esc[2J 		|Clear entire screen |	ED2  |OK||
|Esc5n 			|Device status report |	DSR  |||
|Esc0n 			|Response: terminal is OK |	DSR||  |
|Esc3n 			|Response: terminal is not OK |	DSR||  |
|Esc6n 			|Get cursor position |	DSR  |OK||
|EscLine;ColR 	|Response: cursor is at v,h |	CPR  |OK||
|Esc[c 			|Identify what terminal type |	DA  |||
|Esc[0c 		|Identify what terminal type (another)| 	DA||  |
|Esc[?1;Value0c |Response: terminal type code n |	DA  |||
|Escc 			|Reset terminal to initial state| 	RIS  |OK||

## License
A2osX is licensed under the GNU General Public License.

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

Copyright 2015 - 2023, Remy Gibert and the A2osX contributors.
