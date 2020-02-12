# A2osX and ProDOS

### Updated February 11, 2020

As discussed in the **[Users Guide](.Docs/User%20Guide.md)**, A2osX runs on top of ProDOS, leveraging its support for block devices such as floppy drives, hard drives, SmartPort drives, etc.; it is limited in its ability to implement certain features based on the capabilities of the underlying operating system, in this case ProDOS.  This document will provide an overview of those features and their availability or absence from several versions of ProDOS including two new versions of ProDOS created by the makers of A2osX.

## History

ProDOS is the name of two similar operating systems for the Apple II series of personal computers. The original ProDOS, renamed ProDOS 8 in version 1.2, is the last official operating system usable by all 8-bit Apple II series computers, and was distributed from 1983 to 1993. The other, ProDOS 16, was a stop-gap solution for the 16-bit Apple IIgs that was replaced by GS/OS within two years.  As A2osX only runs under ProDOS 8, this document will largely concentrate on the various versions of that operating system.

ProDOS was marketed by Apple as meaning Professional Disk Operating System, and became the most popular operating system for the Apple II series of computers 10 months after its release in January 1983. The original Apple II operating system, DOS only had built-in support for 5.25" floppy disks and required patches to use peripheral devices such as hard disk drives and non-Disk-II floppy disk drives, including 3.5" floppy drives. ProDOS added a standard method of accessing ROM-based drivers on expansion cards for disk devices, expands the maximum volume size from about 400 kilobytes to 32 megabytes, introduced support for hierarchical sub directories (a vital feature for organizing a hard disk's storage space), and supports RAM disks on machines with 128kB or more of memory (or with special RAM based interface cards). ProDOS addresses problems with handling hardware interrupts, and includes a well-defined and documented programming and expansion interface, which Apple DOS had always lacked. Although ProDOS includes support for a real-time clock (RTC), this support went largely unused until the release of the Apple IIgs, the first in the Apple II series to include an RTC on board. Third-party clocks were available for the II Plus, IIe, and IIc, however.

## New A2osX ProDOS Versions

The A2osX team is proud to announce the availability of two new versions of ProDOS, one with a very minor tweak and the other a major update/overhaul.  These are discussed in detail below, but briefly there is ProDOS 2.03tc which is an 8 byte patch to ProDOS 2.03 to update the year table to support years through 2023 and ProDOS FX a **F**aster and e**X**tended version that adds many new features including lower case file, directory and volume name support.   These new versions are already being included in the latest **Stable** media and will become the versions of ProDOS supplied on all future media.  Please consult our **[Media Guide](.Docs/Media%20Guide.md)** for more information about which version is included on each media image.

>### **NOTE: AS WITH ANY NEW CRITICAL PIECE OF SOFTWARE SUCH AS AN OPERATING SYSTEM THAT HANDLES WRITING TO DISKS, YOU SHOULD TEST THIS SOFTWARE EXTENSIVELY BEFORE USING IT WITH ANY DISKS, VOLUMES, IMAGES, DATA CONTAINING VALUABLE INFORMATION** #

## Tested Versions

A2osX is regularly tested by the development team with the supplied ProDOS 2.03tc, ProDOS FX and the paked version of ProDOS FX.  It is also occasionally tested with other versions of ProDOS such as 2.03, 2.4.2 and the ProDOS 2.5 alpha (2.5.0a8).  You can use the version you like.  Consult the A2osX User Guide on installing A2osX on your own hard drive.  You can also replace the version of ProDOS found on the supplied media with another version.  The A2osX team is planning for an upcoming release an “INSTALL” image set to put A2osX on your own media.  In this method Install will create a subdirectory, copy the necessary files and make any changes to A2osX config files needed so you can run A2osX off your own hard drive using your preferred ProDOS version.

## Version Overview Chart

The following chart lists all the known (to the author) versions of ProDOS and 

| Version | Status | Lower <br>Case | Clock | Remapping | File<br>Size |Notes |
| --- | --- | --- | --- | --- | --- | --- |
| 1.0 | Not Tested | No | TC | No| 15360| |
| 1.0.SEP | Not Tested  | No | TC |No | 14336| |
| 1.0.NOV |  Not Tested | No | TC | No|15360 | |
| 1.0.1 | Not Tested  | No | TC |No |15360 | |
| 1.0.2 | Not Tested  | No | TC |No | 15360| |
| 1.1.1 | Not Tested  | No | TC |No |14848 | |
|ProDOS 8  /<br>  1.2 | Not Tested | No | TC 1991|Simple |15485 | |
| 1.3 | Not Tested  | No | TC 1991|Simple |15485 | |
| 1.4 |  Not Tested | No | TC 1991|Simple |15485 | |
| 1.5 | Not Tested  | No | TC 1991|Simple |15485 | |
| 1.6 | Not Tested  | No | TC 1991|Simple |15485 | |
| 1.7 | Not Tested  | No | TC 1991|Simple |15485 | |
| 1.8 | Not Tested  | No | TC 1991|Simple |15741 | |
| 1.9 | Not Tested  | No | TC 1991|Simple |16509 | |
|2.0.1 | Not Tested  | No | TC 1999|Enhanced|17128 | |
| 2.0.2 | Not Tested  | No | TC 1999 |Enhanced| 17128| |
| 2.0.3 |Working | No | TC 1999 |Enhanced |17128 | Date/Years not current |
| 2.0.3tc |Working | No | TC 2023|Enhanced |17128 | |
| 2.4 | Not Tested | No | TC 1999|Enhanced |17128 | |
| 2.4.1 | Not Tested | No | TC 1999| Enhanced| 17128| |
| 2.4.2 |Working | No | TC 2023| Enhanced|17128 | |
| 2.5.0a8 |Working w/ Issues | Yes | TC 2924|Advanced | 16616| |
| FX |Working| Yes | TC 2023<br>NSC<br>GS/Cortland | Advanced| 15244| |
| FX Paked |Working| Yes | TC 2023<br>NSC<br>GS/Cortland | Advanced|13295 | |

### Drive Remapping

With the release of ProDOS 8 (Version 1.2) Apple Modified the ProDOS 8 loader code to automatically install up to four drives in slot 5 if a SmartPort device is found using slot 2 for the extra 2 drives.  With ProDOS 8 Version 2.0.1, ProDOS supports more than two SmartPort devices per slot by remapping the third device and beyond to different slots. There's still a limit of 14 devices altogether, though.  ProDOS FX supports the same extensive drive remapping to work with devices such as the CFFA or Booti to map multiple volumes.  ProDOS 2.5 introduces a new remapping agent that will map up to 8 drives per slot, supporting a max of 34 drives.  Unfortunately, A2osX (as with most ProDOS software) expects only 2 drives (D1 and D2) per slot so the display of results from some commands may be different then ProDOS 2.5's mapping.  For instance if you do ***ls -l /***  which lists all online volumes, you might see multiple D1 and D2's per slot as a "ProDOS" D4 or D6 would appear as D2.  For the most part, this is just a display anomaly.  However, you need to be very careful with the *format* command with takes a device name in the form of SxDy where x is a slot from 1 to 7 and y is a drive, either 1 or 2.  If ProDOS has mapped 8 CFFA volumes to Slot 7 D1 through D8, what you would see if you listed devices (lsdev command) is 8 drives, but you would see 4 pairs of S7D1 and S7D2.  If you then did a *format s7d1 /newvol* it would format the first device, even if you intended it to be 5th one (which appears as S7D1 too!).

### Clock Support

ProDOS will provide the date and time to A2osX if a supported clock device is found.  By default, only the ThunderClock is supported by ProDOS.  ProDOS FX adds support for No Slot Clock and the built-in clock on the Apple //gs.  ProDOS 2.5 also supports date/time functions, however the API for retrieving the date time from ProDOS was changed which breaks compatibility with all ProDOS applications (including BASIC.SYSTEM).  If you are running ProDOS 2.5, display of date and time in file listings (using the *ls* command) will show as **no date** but the date and times on files will be updated correctly by ProDOS.

## ProDOS Versions

Technical documentation for all versions of ProDOS can be found **[HERE](/https://prodos8.com/docs/)**.

### ProDOS 1.0

https://prodos8.com/releases/prodos-10/

Original Release of new Apple II operating system from Apple that features:
- ProDOS runs up to eight times faster than DOS when accessing 5.25” disks.
- Support for a hardware clock has been added, allowing file date and time stamping.
- Hardware interrupts are supported.
- Memory can be protected from being overwritten by the actions of ProDOS.

### ProDOS 2.03

https://prodos8.com/releases/prodos-203/

This is the final release of ProDOS from Apple Computer.

### ProDOS 2.03tc

This version of ProDOS includes an updated ThunderClock year table to support dates through the year 2023.  ProDOS 2.03tc is included on the 800K media images listed above and provides the maximum compatibility with existing systems.

### ProDOS.FX:

ProDOS FX is a branch new version of ProDOS built by the A2osX team from a significantly enhanced branch of the ProDOS source.  ProDOS FX is a **F**aster and e**X**tended version that adds many new features including lower case file, directory and volume name support.  Speed was improved by removing a redundant read at boot, optimizing XRW, a reduced size that speeds loading, etc.

>### **Repeating this note because it is important: As with any new critical piece of software such as an operating system that handles writing to disks, you should test this software extensively before using it with any disks, volumes, images, data containing valuable information!** #


FX supports extended syntax for filenames
1st char in  . _ a-z A-Z
char 2-15 in . _ a-z A-Z 0-9

"Faster, eXtended"

How is it faster?
redundant read removed at boot.....
optimized XRW planned
size is lower...so helps fast booting

if you want to keep your ProDOS volume still readable from 203.....no DUP files....and no extended syntax files (.profile...etc...)
and no /lowercasevol
2.5 has same limitation but only because they do /lowercasevol
they dont do case sensitivity nor extended syntax
because they implemented case sensitivity differently and they hit many imcompatibilites

removed support for machine < //e Enh ROM
remove support for machine < 128k
remove 40col Quit code
removed relocator and added UNPAK code
Enhanced IRQ manager (does NOT support //e OLD roms)

a lot of old code in loader was removed
before prodos ran on 48k ok 64k systerms
so there were a relocator, i removed it

FX supported clocks  : NSC, TClock ->2023 & Cotland Clock

FX remap more devs......once i fix bugs for your SCSI board
*more than 203
but different way than 2.5
better support for legacy apps
old IRQ manager also

add a note about FX smaller on disk...only 13k
--->even smaller if paked  (what size)

Added NSC clock support
TCLOCK year -> 2023

Added SmartPort remap from any slot to any slot, up to 14 devices

i'm changing lot of thing everywhere so that everything works the same with or without lowercase
so basically, everything in now internally lowercased....if run under 203, prodos make it uppercase
if run under FX, it is now natively case sensitive
so the ruse is:
type everything in your script in lowervcase, including #!/bin/sh
internal SH commads are still CI
so ECHO & echo works
but ls in now lowercase
if under 203
LS works
ls works to
if FX, only ls works
LS = file not found

and in your BUILD scripts:
if 14 dev mounted, /RAM wont install

Added support for "." and "_" in filenames
only restriction is filename 1st char != 0..9

Added lowercase support

Patrick Kloepfer  8:46 AM
On the SP remap… lets say you have a Ramworks III with 512K, an Apple Slinky 1meg in S4, a CFFA in S5 with 8 devices and a MDT with 4 block mode devices in Slot 7.  What happens?  (that totals 14, but how do you deal with /RAM3 and /RAM4.  What happens if same cards but CFFA set to 12 devices?  Also, what if 5.25 controller in S6 when cffa set either to 8 or 16.

it remaps where there is room for
if you have 4 devs is S7 and 2 in S6....it will remap 2 extra in slot 7 trying to find room starting at S5, then S4...3...2..1....
if 14 devs already mapped....it wont try to install /RAM3
and you wont be able to install Ramworks' /RAM3

so in the above….4 devs from card in 7, it takes the 2 for 7, now finds room for other 2, looks at 6 sees floppies taking both, moves to 5 (does it take 2 here and force card to fend for itself next or see that 5 is a SP card itself and move on).  when either card sees slinky in 4 (as /RAM4 as S4D1) does it take the S4D2 spot that can be mapped?  if the numbers would work such that RWIII gets an S3D2, will anything ever get mapped to S3D1 (I think you are saying yes)

if S4D2 is free it will be used by remap....so S3D1....

The ProDOS FX version is included on the 32MB media images which are designed to be standalone bootable images.  In addition, there is a very special ProDOS FX PAKED version, that is the same as the standard FX image once running, but the file has been compressed and contains a special loader to uncompress ProDOS as it initializes.  This version uses less disk space and is used on 140K media where space is at a premium. 

### ProDOS 2.4

https://prodos8.com/releases/prodos-24/

For the first time, the features and improvements of ProDOS 2.x are available on 6502-based Apple ][, Apple ][+, and un-enhanced Apple //e computers.
All Apple II computers with modern USB storage devices or hard drives can now support up to 14 ProDOS volumes per device.

### ProDOS 2.4.1

https://prodos8.com/releases/prodos-241/

ProDOS 2.4.1 is a minor release with bug fixes and updates replacing ProDOS 2.4.

### ProDOS 2.4.2

https://prodos8.com/releases/prodos-242/

ProDOS 2.4.2 is a minor release with bug fixes and updates.
ProDOS 2.4.2 replaces the previous ProDOS 2.4 and ProDOS 2.4.1.

### ProDOS 2.5

https://prodos8.com/releases/prodos-25/

- Extended Date format which breaks date display in dir listings in A2osX (and BASIC.SYSTEM).  See the section on **[Clock Support](#clock-support)**.
- Drive remapping for cards that support many volumes has been changed/enhanced.  There are some side affects with A2osX.  See the section on **[Drive Mapping](#drive-remapping)** for more information.
- 51-file limit on root directory removed (not tested with A2osX yet).
- Adds the ability to use lowercase in file names which is fully supported in A2osX.

### ProDOS 16 / GSOS

ProDOS 16 / GSOS are versions of the ProDOS operating system that run only on Apple //GS computers.  At this time, A2osX  is not supported under these operating systems because of A2OSX.SYSTEM's very sensitive IRQ management required by the multitasking multiuser nature of A2osX.  To run A2osX on an Apple //GS you must first switch to one of the supported ProDOS 8 versions such as the supplied ProDOS 2.03tc or ProDOS FX.

## Requirements

ProDOS 8 requires 64kB of memory to run. The original ProDOS (8) 1.0 through 1.0.2 requires only 48kB for the kernel, but nearly all programs, including the BASIC.SYSTEM needing to use Applesoft BASIC, require 64kB, making a 48kB system useless for ProDOS as a practical matter, and support for 48kB machines was removed in version 1.1.

ProDOS 8 version 2.x requires a 65C02 or later (65802, 65816) CPU. ProDOS 8 2.x runs in 64kB, but the utility programs on the system disk require 128kB. Systems with a 6502 CPU instead of a 65C02 must use ProDOS 8 versions prior to version 2.0.

ProDOS 8 2.4 and 2.5 removes the 65C02 requirement and will run on all Apple II computers with at least 64 KB of RAM, although BASIC.SYSTEM still requires an Applesoft ROM.

ProDOS 16 requires an Apple IIGS.

ProDOS 2.03tc has the exact same requirements as ProDOS 2.03 since its only difference are the eight patched bytes to the date/year table.

ProDOS FX requires a 128KB 65c02 or later CPU.  ProDOS FX will not run on a Apple ][ or ][+ or unenhanced //e.  This is the same requirements for A2osX.

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

Copyright 2015 - 2020, Remy Gibert and the A2osX contributors.
