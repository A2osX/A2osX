# A2osX
Multi-Tasking OS for Apple II
## Requires :
Enh IIe (65c02 cpu) with 128k, //c, IIgs
## General Information:
**A2OSX.BOOT.DSK** : 140k A2osX boot disk will all binaries  
**A2OSX.SRC.po** : 800k S-C MASM boot disk with all sources  
  
OApple+1,OApple+2,OApple+3 to switch between screens : Kernel Log, text, DHGR.  
(OApple+shift+1,OApple+shift+2,OApple+shift+3 on FR keyboard)  
  
## Supported Hardware At Kernel Level (ProDOS):
| KM.Name | Status | Comment |
| ------- | ------ | ------- |
| KM.NSC | Working | No-Slot-Clock |
| KM.RAMWORKS | Working | AE-Ramworks I,II,III |
  
## SBIN,Daemons:  
| Name.DRV | Status | Comment |
| -------- | ------ | ------- |
| INSDEV | Working | |
| GETTY | Working | |
| LOGIN | In Progress | no auth using /etc/passd yet |
| TCPIP | In Progress | |
| DHCPCLNT | Working | |
| SHELL | Working | BUG: History nav|
  
## DRV,Drivers:  
| Name.DRV | Status | Comment |
| -------- | ------ | ------- |
| Console.DRV | Working | ANSI support in Progress. |
| PPIC.DRV | In Progress | |
| SSC.DRV | In Progress | |
| SSC.I.DRV | In Progress | |
| Mouse.DRV | Working | |
| Uthernet.DRV | Working | |
| UthernetII.DRV | In Progress | |
| LanCeGS.DRV | In Progress | |
| Mouse.DRV | Working | |
| DHGR.DRV | Working | |
  
## Internal Shell commands:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| CD | Working | |
| SET | Working  | |
| DATE | Working  | |
| TIME | Working  | |
| EXIT | Working  | |
| TYPE | Working  | |
| PAUSE | Working | |
| ECHO | Working | |
  
## BIN,External Shell commands:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| LS | Working  | BUG: ls <dir> does not list dir content |
| MEM | Working  | |
| LSDEV | Working | |
| MD | Working  | |
| RM | Working | |
| NETINFO | Working  | |
| PS | Working  | |
| ARP | Working  | |
| PING | Working | |
| DNSINFO | | |
| EDIT | In Progress | BUG: DEL |
  
