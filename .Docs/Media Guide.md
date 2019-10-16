# A2osX Media Guide

## Editions

| Edition | Description | Build No | Date |
| --- | --- | --- | --- |
| RELEASE | This is a locked down set of media that will change infrequently, only upon a major update. | | * |
| **RC** | **This is a RELEASE candidate, if available, for the next coming major release.  There should be very few RC releases before one of them becomes the actual RELEASE media.  RC releases should be relatively bug free and feature complete (to the scope planned for that release).**  | **1600** | **Oct-6-2019** |
| STABLE | Stable releases are significant updates over the last RELEASE but may not included in their own scope.  STABLE releases will be made from BLEED builds that have no significant bugs, but may have documented issues that have not yet been resolved, especially in new features.  | | * |
| BLEED| The media in this edition are very cutting edge, changing almost daily, particularly A2OSX.BUILD.po.  This edition is targeted at core developers who are creating and maintaining A2osX.  For most users, it is recommended that you use one of the other editions.  |  | * |

* Note this is a new system of Editions and Disk Images.  A2osX 0.93 will be the first Release that uses this new system.  The first **RC** set of media are now available and are based on build No 1600.  If no significant issues are found with **RC**, a set of **RELEASE** media will be made available based on this build (the RC media will then be removed until a 0.94 RC is ready).  

## Disk images :

You can use and/or install A2osX from the media found in our Media directory found **[here](../.Floppies)**.  The current set of available media includes:

| Image Name | Edition | Description !
| --- | --- | --- |
| **[RC.140.po](../.Floppies/RC.140.po)** | **RC** |**An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.**  |
| **[RC.800.po](../.Floppies/RC.800.po)** | **RC** |**An 800K 3.5" disk image containing the main BOOT and support files for running A2osX.**  |
| **[RC.32MB.po](../.Floppies/RC.32MB.po)** | **RC** |** A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin **  |
| A2OSX.BUILD.po | Bleed | 32MB disk image with S-C MASM 3.0, all binaries and all source for A2osX <br> This is primary development media for A2osX, especially pre-launch of Release, Stable and official Build Media.  See below.|
| A2OSX.MAKE.po | Bleed | 32MB disk image with S-C MASM 3.0, all binaries and all source for multiple BUILD versions of A2osX stored in directories on MAKE.  The image also includes the TEST, ADMIN, and EXAMPLE scripts being created to support A2osX. |
| A2OSX.B800.po | Bleed | An 800K 3.5" disk image containing the main BOOT and support files for running A2osX. |
| A2OSX.BOOT.po | Bleed | An 140K 5.25" disk image containing the main BOOT and support files for running A2osX. |
| BLANK32MB.po | Support | A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin |
| BLANK800.po | Support | A formatted empty ProDOS 3.5" 800K disk image, suitable for use with emulators such as AppleWin |
| BLANK140.po | Support | A formatted empty ProDOS 5.25" 140K disk image, suitable for use with emulators such as AppleWin |
| RELEASE.140.po | RELEASE |An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.  |
| RELEASE.800.po | RELEASE |An 800K 3.5" disk image containing the main BOOT and support files for running A2osX.  |
| RELEASE.32MB.po | RELEASE | A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin  |
| STABLE.140.po | STABLE |An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.  |
| STABLE.800.po | STABLE | An 800K 3.5" disk image containing the main BOOT and support files for running A2osX. |
| STABLE.32MB.po | STABLE | A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin |

Please note, we plan to change the media set once 0.93 is officially released.  Currently, the BUILD media is the primary image used by the developers to hold the most current version of the A2osX binaries (and a copy of the source, although of course GitHub is the primary source repository). You can download the BUILD image and run in your favorite Apple II emulator or copy to CFFA, MicroTurbo or other Hard Disk emulator to boot, run, test and develop programs for A2osX.  Once 0.93 is released, we plan to update the media to include RELEASE, STABLE and BUILD editions of the media, like other projects you might find on GitHub; and each of these will include BOOT, INSTALL, SOURCE and EXTRA type media so that users and developers can BOOT or INSTALL A2osX to existing systems as they see fit.

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
