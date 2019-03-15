# A2osX User Guide


DRAFT USER GUIDE HOLDER

A2osX is already much more then a "primitive" command line operating system.  While A2osX runs on top of ProDos, leveraging its support for block devices such as floppy drives, hard drives, SmartPort drives, etc., it adds a preemptive multitasking kernel with a greatly enhanced shell that supports arguments, redirection, piping, and probably the biggest enhancement, a full scripting language.  In addition, at its core, the OS supports multiple virtual terminals (i.e. OA-1 OA-2 gets you different sessions) as well as concurrent external terminals via SSC (getty on SSC serial) or network (TELNETD).  A GUI interface is being built and will be part of a future release.

A core element at the foundation of A2osX that enabling its multiuser  multitasking capabilities is that it is build on a reusable set of APIs and LIBs (written in Assembly) that all programs can and do use which make them very lean and fast.  For instance, there is one network API that any program can call which in turn handles the I/O to different LAN cards via drivers.  Key here is that multiple programs can be using the network at the same time such as the TELNETD server and the TELNET client.  A key benefit is that the code for doing each program is smaller because the network API is doing a lot of the work.  And with CORE APIs like printf and LIBs such as Network only loaded once, much like a DLL in Windows, significant memory is conserved providing the resources needed to support multitasking and multiple users.

Its because of the Uthernet2 that I got hooked on A2osX and joined on to supported the project.  Not only does it have a telnet client, it has other net centric tools and more being added.  I will be honest, there is more that needs to be done, but it progressing rapidly and seems like a great foundation for building net apps on an Apple 2.
Next post
I agree with edward, that the constraint tends to be memory and not processor (we can wait that extra second). But 64K is a tight squeeze. A2osX does make use of 128k (requires it) of ram instead of just 64K and it still is pretty lean in that after ProDOS then A2osX loaded, you have 26K of main mem free.  The fact that Core APIs and Libs are shared helps a lot.  Having said that, don't expect that you are going to write an AppleWorks size App running under A2osX, that would probably be a strectch, though it does come with a VI or EDIT type editor

ASM is needed because at end of day its the most strict mem mgmt (the language that allows you to be stringy on mem use)  so of course the core of A2osX is in ASM.  however after we make out own ASM that makes the OS self making (we talked about this) we plan a CSH which is first step to Interactive C and then a BIn that will make C feed to ASM (the point of 23) so we will get there, but hey stupid, the CORE has to be ASM to be tight with mem


# Notes for Developers

There has been a significant uptick in interest in A2osX and its development.  That's great!  Along with that has come a lot of questions and requests for documentation.  This document hopes to answer many, or at least some, of those questions.  While this document attempts to describe the current process, we are certainly open to easier or better development work flows that will speed the creation of what we believe will be a great Operating Environment for Apple IIs.  Feel free to post your comments or open issues on GitHub with any feedback you have on A2osX.

## Current Development Process

>This section mentions the names of Software products some of use in the A2osX development process.  Other than the Assembler, which is core, the other products could be replaced by similar software of the users choosing.  Below, more information is providing on these products and as alternatives become know to us, we will update this document to make you aware of them.

In the purest sense, the development of A2osX is at its core an Apple II centric process.  All the programs that make up A2osX are Assembled on an Apple II computer using a ProDOS-based assembler made by S-C Software Corporation.  The reality of the development workflow is a little more nuanced.  So lets talk about the actual process, starting with the place that brought you here, GitHub(GH).  GH is our repository for code and files used to create A2osX.  You can browse all of these files on GH, presumably you are reading this file from the root directory of the A2osX repository.

Currently, all of the active developers of A2osX use a SVN (Subversion) client to create, maintain and update files in the repository.  Many of us use TortoiseSVN, but other clients are available, including some GitHub specific desktop apps.  Using SVN, we can download updates from other developers and submit updates we have made.  TortoiseSVN happens to integrate well with Windows Explorer.

Most of our developers are using Notepad++ to edit the files stored in the repository.  Any plain text editor can be used, but we have created a special helper file for Notepad++ the highlights the syntax/special words used in 6502 assembly.  This is discussed further below.

So how do we get from a source text file on GH to a running binary on an Apple...that magic or rather our current particular flow is achieved by combining two tools, the **S-C Macro Assembler running under ProDos** hosted on **The AppleWin Emulator** running on Windows.  If you were to look at any (well most) of our source files in the GH repository you will see non-source like extras at the top and bottom of each file.  These are actually S-C Assembler directives.  If in AppleWin (AW) you mount and boot from the current BUILD media (found in .Floppies) the default behavior is to load the S-C Macro Assembler (you see the : prompt).  In our source files you will see at the top directives such as AUTO 4,1 which means start automatic line numbering at 4 incrementing by 1.  At the bottom of the file are directives such as TEXT SRC/LS.S which means save the source listing to the ProDOS disk in directory SRV as file LS.S.

What we do in our current work flow, we edit the file with Notepad++, save locally to sync with GH, and then we select all text in the file (Ctrl-A), Copy (control-C) and then switch to AW with the S-C : prompt and paste (Shift-Insert in AW).  That types the source into the assembler and the other bits at the top and bottom of the file which Assembles and saves everything to the BUILD disk image.  To test our new program (bin), you type -RUN which is the same as -A2OSX.SYSTEM which loads A2osX.   

>As stated at the very beginning, technically this Assemble/BUILD is a native Apple II process.  Technically, you could run any ProDOS text editor, edit your source files and if using the right S-C Assembler commands you could Assemble binaries all in AW or on real Apple Hardware.  We do not do this ourselves as it would then break the GH/SVN part of the workflow which we believe has value.  This document does not cover the Apple only dev process, but read the Planned Development Process for what is coming in that area.

## Planned Development Process

ASM program hosted in A2osX.
Second part of plan is a AppleTalk over Ethernet Libray (LIBETALK) for A2osX that will allow the system to mount a remote file system on your Apple or Apple Emulator.  The plan is to have this file system be the same folder synced via SVN with GitHub containing the A2osX source code.  This would allow you to edit source code on either the Apple using A2osX EDIT or from your PC/MAC using a native text editor on those systems.  Not only will you be able to ASM any A2osX drivers, libraries or programs this way, we will create MAKE scripts that run on A2osZ that can create new builds automatically.

## Developing for A2osX

### The A2osX Shell (SH)

One of the most significant parts of A2osX is its shell which can perform both interactive and scripted tasks.  With the interactive part of the shell you can perform many common and complex tasks using both built-in (native or internal to shell) and external (BINs or executables) commands.  Internal commands include CD (change directory), MD (make directory), DATE, TIME, etc.  External commands include CP (copy), RM (remove), CAT (display file contents), TELNET, etc.


It should be noted, that it is possible to create and execute short scripts right on the interactive command line (these are run once and not saved like true scripts).  An example  

The 32-bit int data type can hold integer values in the range of −2,147,483,648 to 2,147,483,647.  If you add to or subtract from INTs that would cause a RANGE error, you actually get a result that wraps around the range, so if you add 1 to 2,147,483,647 you will get −2,147,483,648.

Strings can be up to 255 characters in length.  Note, like INTs, if you try to store more then 255 chars in a string, you get the same wraparound affect where the first 255 chars are tossed out the string is set to the remaining chars, so if you concatenate 3 strings of 100 chars the resulting string will be the last 45 chars of the 3rd original string. 


### File System Layout of A2osX

| Path | Use |
| ---- | --- |
| / | is the root directory|
|/bin/ and /usr/bin/ |store user commands.|
|/boot/| contains files used for system startup including the kernel.|
|/dev/| contains device files|
|/etc/| is where configuration files and directories are located.|
|/home/| is the default location for users‟ home directories.|
|/lib/ and /usr/lib/ |hold library files used by programs in /bin/ and /sbin/.|
|/mnt/ |holds the mount points for file systems that were mounted after boot.|
|/opt/ |is used primarily for installation and unintallation of third-party software. Holds optional files and programs.|
|/root/ |is the home directory of the superuser "root"|
|/sbin/ and /usr/sbin/ |store system commands.|
|/tmp/ |is the system temporary directory. All users have read+write access to /tmp/.|
|/usr/ |contains files related to users such as application files and related library files ("usr" is an acronym that stands for UNIX system resources).|
|/var/ | holds files and directories that are constantly changing such as printer spools and log files.|

## A2osX Boot Process

On a Drive dedicated to A2osX, likely your boot process would be:
Prodos
nsc.sys if present and you have one of those
a2osx.system
new quit code (what is different?)
    if no parameter loads KERNEL
    if a param sent, load param
    idea is passing a .SYSTEM file, then once .SYSTEM file is QUITting, the QC will reload KERNEL this could allow launching .SYSTEM files at $
This then loads KMs then INIT
GETTY, LOGIN, SHELL PROFILE


### Maintenance mode



## Tools A2osX Developers Use

### S-C Macro Assembler

by the S-C Software Corporation

You can find more information about this assembler here: http://www.txbobsc.com/scsc/scassembler/index.html


### Github

### TortoiseSVN

We use TortoiseSNV to pull/push changes to GitHUb (commit/update).  Specifically we use version 1.10.2.28392 because we have found later versions have conflicts with GitHub.  There are other software packages available, many of them public domain, that can be used to manage GitHub respositories on your desktop.

### Notepad++

### MarkdownPad 2

MD is a standard language for making documentation files.  We use MarkdownPad 2/Pro to edit our MD files, but there are many many alternatives, including some in the Public Domain.  In fact, ATOM is a standard alternate utilized by many in the GitHub community.

If you decide to use MarkdownPad 2 as we do, you may want to add support for GitHub Tables in Live preview you need to go into Options and change the Markdown Processor to GitHub Flavor and then you need to fix GitHub login because it it only supports SSL/TLS 1.0 which is not enabled by default in Windows.   to fix that you have to change some registry settings.

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


__S-C MASM color scheme for Notepad++__
...drop _Tools/userDefineLang.xml in %APPDATA%\Notepad++
;-)



THere is a userDefinedLang.xlm file in the .Tools dir that you will want to copy to Notepad... then when editing ASM files (.S) you can change your language to S-C MASM 65C02 and notepad++ will do the proper highlighting.

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
