Notes for Developers



Use Notepad++ which you can download from....

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
