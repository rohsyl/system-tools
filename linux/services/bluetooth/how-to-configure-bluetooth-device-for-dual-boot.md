# Pair bluetooth device on two OS

> Sources : https://cat.devbra.in/pair-a-bluetooth-le-device-with-a-dualboot-of-linux-windows-10-2/

This tutorial will explain you how to pair the Microsoft Designer Mouse with your 2 OS in your dual boot.

1. Boot into Linux
2. Pair the mouse
3. Boot into Windows
4. Pair the mouse
5. Boot back into Linux again
6. Install a registry editor
```
apt-get install chntpw
```

6. Mount your Windows Partition

```
mount /dev/sda1 /media/rohs/SYSTEM
```

> Replace sda1 by your Windows partition

7. Run the script `export-ble-infos.py`

```
./export-ble-infos.py -s /media/rohs/SYSTEM/Windows/System32/config/SYSTEM
```

This will generate a directory called `bluetooth` in your current directory.

8. Replace the Linux pairing key by the ones exported by the script `export-ble-infos.py`

