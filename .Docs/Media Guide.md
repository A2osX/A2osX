# A2osX Media Guide

### Updated February 13, 2020

We have changed the media set for A2osX.  New A2osX Users should download the most current version as shown in the table below.  **The FINAL set of RELEASE  edition media for A2osX 0.93 have been made available (highlighted below), you should choose one of the media options from this set.**  The Bleed media are the primary images used by the developers to hold the most current version of the A2osX binaries (and a copy of the source, although of course GitHub is the primary source repository) and may be unstable.  You should not use this media unless directed by the A2osX development team.

## Editions

| Edition | Description | Build No | Date |
| --- | --- | --- | --- |
| **RELEASE** | **This is a locked down set of media that will change infrequently, only upon a major update.** |**1951** | **Feb-13-2020** |
| RC | This is a RELEASE candidate, if available, for the next coming major release.  There should be very few RC releases before one of them becomes the actual RELEASE media.  RC releases should be relatively bug free and feature complete (to the scope planned for that release).  | 1951 | Feb-13-2020 |
| STABLE | Stable releases are significant updates over the last RELEASE but may not included in their own scope.  STABLE releases will be made from BLEED builds that have no significant bugs, but may have documented issues that have not yet been resolved, especially in new features.  This will likely become RC shortly. | 1951 | Feb-13-2020 |
| BLEED| The media in this edition are very cutting edge, changing almost daily, particularly A2OSX.BUILD.po.  This edition is targeted at core developers who are creating and maintaining A2osX.  For most users, it is recommended that you use one of the other editions.  |  | * |

* Note this is a new system of Editions and Disk Images.  A2osX 0.93 will be the first Release that uses this new system.  The final **RELEASE** set of media are now available and are based on build No 1951. 

## Disk images

You can use and/or install A2osX from the media found in our Media directory found **[here](../.Floppies)**.  The current set of available media includes:

| Image Name | Edition |ProDOS <br> Version| Description !
| --- | --- | --- | --- |
| [RC.140.po](../.Floppies/RC.140.po) | RC |FX Paked|An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.  |
| [RC.800.po](../.Floppies/RC.800.po) | RC |203.tc|An 800K 3.5" disk image containing A2osX system, utilities and application files for running A2osX.  |
| [RC.32MB.po](../.Floppies/RC.32MB.po) | RC |FX|A 32MB HD disk image containing A2osX system, utilities and applications; suitable for use with emulators such as AppleWin or for use with the CFFA card.  |
| [TDBOOT.po](../.Floppies/TDBOOT.po) | RC |FX|A special 32MB HD disk image, preconfigured to automatically load Uthernet2 driver, start network services and launch the TelnetD server process for use with the CFFA or similar card. |
| [DEBUG.po](../.Floppies/DEBUG.po) | RC |FX Paked|An 140K 5.25 disk image containing the main BOOT and support files for A2osX and preconfigured with the least options enabled.  This is intended to be used as a minimal boot to help identify hardware conflicts. |
| [STABLE.140.po](../.Floppies/STABLE.140.po) | STABLE |FX Paked|An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.  |
| [STABLE.800.po](../.Floppies/STABLE.800.po) | STABLE |203tc| An 800K 3.5" disk image containing the main BOOT and support files for running A2osX. |
| [STABLE.32MB.po](../.Floppies/STABLE.32MB.po) | STABLE |FX| A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin |
| A2OSX.BUILD.po | Bleed |203tc<br>FX| 32MB disk image with S-C MASM 3.0, all binaries and all source for A2osX <br> This is primary development media for A2osX, especially pre-launch of Release, Stable and official Build Media.  See below.|
| A2OSX.MAKE.po | Bleed |203tc<br>FX| 32MB disk image with S-C MASM 3.0, all binaries and all source for multiple BUILD versions of A2osX stored in directories on MAKE.  The image also includes the TEST, ADMIN, and EXAMPLE scripts being created to support A2osX. |
| A2OSX.B800.po | Bleed |FX| An 800K 3.5" disk image containing the main BOOT and support files for running A2osX. |
| A2OSX.TEST.po | Bleed |FX Paked| An 140K 5.25" disk image containing the main BOOT and support files for running A2osX. |
| BLANK32MB.po | Support |None| A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin |
| BLANK800.po | Support |None| A formatted empty ProDOS 3.5" 800K disk image, suitable for use with emulators such as AppleWin |
| BLANK140.po | Support |None| A formatted empty ProDOS 5.25" 140K disk image, suitable for use with emulators such as AppleWin |
| [RELEASE.140.po](../.Floppies/RELEASE.140.po) | RELEASE |NA|An 140K 5.25" disk image containing the main BOOT and support files for running A2osX.  |
| [RELEASE.800.po](../.Floppies/RELEASE.800.po) | RELEASE |NA|An 800K 3.5" disk image containing the main BOOT and support files for running A2osX.  |
| [RELEASE.32MB.po](../.Floppies/RELEASE.32MB.po) | RELEASE |NA| A formatted empty ProDOS 32MB HD disk image, suitable for use with emulators such as AppleWin  |

## ProDOS Versions

The A2osX team has developed and now includes on its media new versions of ProDOS for use with A2osX.  Please consult the document **[A2osX and ProDOS](ProDOS.md)** for detailed information on these versions.  Briefly there is ProDOS 2.03tc which is an 8 byte patch to ProDOS 2.03 to update the year table to support years through 2023 and ProDOS FX a **F**aster and e**X**tended version that adds many new features including lower case file, directory and volume name support.   These new versions are already being included in the latest **Stable** media and will become the versions of ProDOS supplied on all future media. The ProDOS 2.03tc version is included on the 800K media images listed above and provides the maximum compatibility with existing systems.  The ProDOS FX version is included on the 32MB media images which are designed to be standalone bootable images.  In addition, there is a very special ProDOS FX PAKED version, that is the same as the standard FX image once running, but the file has been compressed and contains a special loader to uncompress ProDOS as it initializes.  This version uses less disk space and is used on 140K media where space is at a premium. 

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
