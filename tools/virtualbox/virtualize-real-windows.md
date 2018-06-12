# How to virtualize a real Windows installation

**IT DOES'NT WORK FINALLY, LOL...**

> This tutorial will show you how to start a real windows installation (installed on real drive) into Virtualbox from a Linux system.

## Prerequisites

- A running Linux system
- A running Windows system
- virtualbox and virtualbox-dkms packages must be installed

## Determine the partitions that the VM will need to access

> Execute this command to determine the partitions that the VM will need to access.

```
fdisk -l
```

Result :

```
Disque /dev/nvme0n1 : 477 GiB, 512110190592 octets, 1000215216 secteurs
Unités : sectors of 1 * 512 = 512 octets
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 37876C06-4FEB-4FA2-B7F7-450D1B4950C0

Périphérique       Start        Fin  Secteurs   Size Type
/dev/nvme0n1p1      2048     534527    532480   260M EFI System
/dev/nvme0n1p2    534528     567295     32768    16M Microsoft reserved
/dev/nvme0n1p3    567296  502274047 501706752 239.2G Microsoft basic data
/dev/nvme0n1p4 502274048  966916095 464642048 221.6G Linux filesystem
/dev/nvme0n1p5 998166528 1000214527   2048000  1000M Windows recovery environmen
/dev/nvme0n1p6 966916096  998166527  31250432  14.9G Partition d'échange Linux
```

In my case it's the partitions  /dev/nvme0n1p1, /dev/nvme0n1p2, /dev/nvme0n1p3 and /dev/nvme0n1p5

## Create the "raw disk"

> Use this command (with your own filename / disk / partitions specified) to create the "raw disk", which is effectively a file that acts as a pointer to a disk / partition on which an OS is installed

```
sudo VBoxManage internalcommands createrawvmdk \
-filename "/path/to/win8.vmdk" -rawdisk /dev/nvme0n1 \
-partitions 1,2,3,5
```

## Create the VM

- Create a new VM in the VirtualBox GUI, with the OS and version that correspond to your install of Windows. In the "Storage" settings for the VM, add a hard disk (when prompted, click "Choose existing disk"), and point it to the .vmdk file that you created.
- Start up your VM. You should see the same desktop that you have when you boot Windows natively!
- Install VirtualBox Guest Additions as you would for a normal Windows VM, in order to get the usual VM bells and whistles (i.e. resizable window, mouse / clipboard integration, etc).
- After you've been running your "real" Windows in the VM for a while, it will ask you to "Activate Windows". It will do this even if your Windows install is already activated when running natively. This is because Windows sees itself running within the VM, and sees "different hardware" (i.e. it thinks it's been installed on a second physical machine). You will have to activate Windows a second time within the VM (e.g. using a corporate bulk license key, by calling Microsoft, etc).

## Enjoy !