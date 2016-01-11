# A2osX
Multi-Tasking OS for Apple II
## Requires :
Enh IIe (65c02 cpu) with 128k, //c, IIgs
## General Information:
**A2OSX.BOOT.DSK** : 140k A2osX boot disk will all binaries  
**A2OSX.SRC.po** : 800k S-C MASM boot disk with all sources  
  
OApple+1,OApple+2,OApple+3 to switch between screens : Kernel Log, text, DHGR.  
(OApple+shift+1,OApple+shift+2,OApple+shift+3 on FR keyboard)  
  
## Internal Shell commands:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| CD | | |
| SET | | |
| DATE | | |
| TIME | | |
| EXIT | | |
| TYPE | | |
| PAUSE | | |
| ECHO | | |
## External Shell commands:  
| Name | Status | Comment |
| ---- | ------ | ------- |
| INSDEV | | |
| LS | | |
| MEM | | |
| LSDEV | | |
| MD | | |
| RM | | |
| NETINFO | | |
| PS | | |
| ARP | | |
| PING | | |
| DNSINFO | | |
| EDIT | | |

## Supported Hardware At Kernel Level (ProDOS):
| KM.Name | Status | Comment |
| ------- | ------ | ------- |
| KM.NSC | Working | No-Slot-Clock |
| KM.RAMWORKS | Working | AE-Ramworks I,II,III |

## Drivers:  
| Name.DRV | Status | Comment |
| -------- | ------ | ------- |
| Console.DRV | Working | ANSI support in Progress. |
| PPIC.DRV | | |
| SSC.DRV | | |
| SSC.I.DRV | | |
| Mouse.DRV | Working | |
| Uthernet.DRV | Working | |
| UthernetII.DRV | In Progress | |
| LanCeGS.DRV | In Progress | |
  
  