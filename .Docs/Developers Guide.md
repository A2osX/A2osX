# A2osX Developers Guide

### Updated February 10, 2020

This Guide provides information on the development process and tools used to build A2osX.  The core of A2osx is currently, and likely always will be, developed in 65C02 Assembly Language.  Assembly is used for the speed, compactness and efficient memory management necessary for the central core, or kernel, of A2osX.  Currently all of the programs distributed with A2osX are also written in Assembly, however, a it is expected that a C compiler or preprocessor that creates Assembly will be made available in the future.

## Notes for Developers

This Guide attempts to describe the current development and build process.  As with any project of this size, suggestions to enhance or streamline this process are welcome. Please post your comments or open issues on GitHub with any feedback you have on A2osX including the development work flow.

## Current Development Process

>This section mentions the names of Software products some of us use in the A2osX development process.  Other than the Assembler, which is core, the other products could be replaced by similar software of the users choosing.  Below, more information is providing on these products and as alternatives become know to us, we will update this document to make you aware of them.

In the purest sense, the development of A2osX is at its core an Apple II centric process.  All the programs that make up A2osX are Assembled on an Apple II computer using a ProDOS-based assembler made by S-C Software Corporation.  The reality of the development workflow is a little more nuanced.  So lets talk about the actual process, starting with the place that brought you here, GitHub(GH).  GH is our repository for code and files used to create A2osX.  You can browse all of these files on GH, presumably you are reading this file from the root directory of the A2osX repository.

Currently, all of the active developers of A2osX use a SVN (Subversion) client to create, maintain and update files in the repository.  Many of us use TortoiseSVN, but other clients are available, including some GitHub specific desktop apps.  Using SVN, we can download updates from other developers and submit updates we have made.  TortoiseSVN happens to integrate well with Windows Explorer.

Most of our developers are using Notepad++ to edit the files stored in the repository.  Any plain text editor can be used, but we have created a special helper file for Notepad++ that highlights the syntax/special words used in 6502 assembly.  This is discussed further below.

So how do we get from a source text file on GH to a running binary on an Apple...that magic or rather our current particular flow is achieved by combining two tools, the **S-C Macro Assembler running under ProDos** hosted on **The AppleWin Emulator** running on Windows.  If you were to look at any (well most) of our source files in the GH repository you will see non-source like extras at the top and bottom of each file.  These are actually S-C Assembler directives.  If in AppleWin (AW) you mount and boot from the current BUILD media (found in .Floppies) the default behavior is to load the S-C Macro Assembler (you see the : prompt).  In our source files you will see at the top directives such as AUTO 4,1 which means start automatic line numbering at 4 incrementing by 1.  At the bottom of the file are directives such as TEXT SRC/LS.S which means save the source listing to the ProDOS disk in directory SRC as file LS.S.

In our current work flow, we edit the file with Notepad++, save locally to sync with GH, and then we select all text in the file (Ctrl-A), Copy (control-C) and then switch to AW with the S-C : prompt and paste (Shift-Insert in AW).  That types the source into the assembler and the other bits at the top and bottom of the file which Assembles and saves everything to the BUILD disk image.  To test our new program (bin), you type -RUN which is the same as -A2OSX.SYSTEM which loads A2osX.   

>As stated at the very beginning, technically this Assemble/BUILD is a native Apple II process.  Technically, you could run any ProDOS text editor, edit your source files and if using the right S-C Assembler commands you could Assemble binaries all in AW or on real Apple Hardware.  We do not do this ourselves as it would then break the GH/SVN part of the work flow which we think has value.  This document does not cover the Apple only dev process, but read the Planned Development Process for what is coming in that area.

## Planned Development Process

**ASM program hosted in A2osX.**
One of the existing features of A2osX is its support for networking via drivers for the most popular Apple II ethernet network cards, a TCPIP stack, a library of network functions available to all programs and a handful of applications and utilities that use these libaries.  In the future we plan to extend that functionality to allow A2osX to mount remote file systems potentially via a file sharing protocol such as CIFS or AppleTalk/EtherTalk.  This would allow the developer to directly access files on a network synced with GH (by the file server)and be editable and compiled/assembled by the Apple.  Concurrently, a native to A2osX Assembler is being created (followed by a C compiler or pre-processor) that will allow the developer to fully edit and assemble an application directly in the A2osX operating environment. This setup would allow you to edit source code on either the Apple using A2osX EDIT or from your PC/MAC using a native text editor on those systems.  Not only will you be able to Assemble any A2osX drivers, libraries or programs this way, we will create MAKE scripts that run on A2osX that can create new builds automatically.

## Tools A2osX Developers Use

### S-C Macro Assembler

by the S-C Software Corporation

You can find more information about this assembler here: http://www.txbobsc.com/scsc/scassembler/index.html

### Github

### TortoiseSVN

We use TortoiseSNV to pull/push changes to GitHUb (commit/update).  Specifically we use version 1.10.2.28392 because we have found later versions have conflicts with GitHub.  There are other software packages available, many of them public domain, that can be used to manage GitHub respositories on your desktop.

### MarkdownPad 2

MD is a standard language for making documentation files.  We use MarkdownPad 2/Pro to edit our MD files, but there are many many alternatives, including some in the Public Domain.  In fact, ATOM is a standard alternate utilized by many in the GitHub community.

If you decide to use MarkdownPad 2 as we do, you may want to add support for GitHub Tables in Live preview you need to go into Options and change the Markdown Processor to GitHub Flavor and then you need to fix GitHub login because it it only supports SSL/TLS 1.0 which is not enabled by default in Windows.   to fix that you have to change some registry settings.

Documentation for A2osX is written in standard Github Markdown language.  There are many editors you can use to read/make these files.  THis includes Atom??? and our favorite MarkdownPad 2.  Note though to use this edititor you need 

Use MarkdownPad 2 Pro to edit Github Markdown files such as this one.  Note to fully use its features you need a pro license and you need to enable the Github markdown preview options.  If you have a GH account you will immediately get a login error because GH and Windows TLS settings are mismatched.  YOu should read this article: 
https://stackoverflow.com/questions/33761919/tls-1-2-in-net-framework-4-0/44153734#44153734

Basically you are going to have to use regedit to create the following keys:

| Registry Entry | Items |
| ----------- | ------------------- |
| [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319] | "SchUseStrongCrypto"=dword:00000001 |
| [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319] | "SchUseStrongCrypto"=dword:00000001|
| [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2] | |
| [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] | "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001 |
| [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] | "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001 |

### AppleWin

If you use AppleWin and want to enable support for networking (AW supports the UtherNet I network card protocol) you must install a network shim that enables AppleWin to talk to the Internet.  You can search with Google how to do this, but basically you need to install WinPcap 4.1.3.

VSDrive, Localhostmode ADTPro and setting this up...  
make a bat file called adtlocal.bat and put in it
@call "%~dp0adtpro.bat" localhost

### CiderPress 4.0.3

### PuTTY

To Telnet to A2osX running TELNETD.

### Notepad++

Use Notepad++ which you can download from....

#### S-C MASM color scheme for Notepad++
...drop _Tools/userDefineLang.xml in %APPDATA%\Notepad++

There is a userDefinedLang.xlm file in the .Tools dir that you will want to copy to Notepad... then when editing ASM files (.S) you can change your language to S-C MASM 65C02 and notepad++ will do the proper highlighting.

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

Copyright 2015 - 2020 Remy Gibert and the A2osX contributors.
