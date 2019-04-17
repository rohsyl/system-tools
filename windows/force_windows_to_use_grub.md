# How to force Windows to use GRUB

> How to force Windows to use GRUB instead of Windows Boot Manager

In the Windows Command Prompt run the following command:

```
bcdedit /set {bootmgr} path \EFI\ubuntu\shimx64.efi
```