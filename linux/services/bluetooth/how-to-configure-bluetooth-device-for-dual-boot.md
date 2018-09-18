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

7. Mount your Windows Partition
```
mount /dev/sda1 /media/rohs/SYSTEM
```
> Replace sda1 by your Windows partition

8. Run the script `export-ble-infos.py`
```
./export-ble-infos.py -s /media/rohs/SYSTEM/Windows/System32/config/SYSTEM
```
> This will generate a directory called `bluetooth` in your current directory.

9. Replace the Linux pairing key by the ones exported by the script `export-ble-infos.py`
    - Open the file `./bluetooth/xx:xx:xx:xx:xx/yy:yy:yy:yy:yy/info`
        ```
        nano ./bluetooth/xx:xx:xx:xx:xx/yy:yy:yy:yy:yy/info
        ```
    - Open in a second terminal the file located in `/var/lib/bluetooth/xx:xx:xx:xx:xx/yy:yz:yy:yy:yy/info`
        ```
        nano /var/lib/bluetooth/xx:xx:xx:xx:xx/yy:yz:yy:yy:yy/info
        ```
    - Copy the following value from the generated info file to the second one
        ```
        [IdentityResolvingKey]
        Key=
        
        [LocalSignatureKey]
        Key=
        
        [LongTermKey]
        Key=
        
        [LongTermKey]
        EDiv=
        Rand=
        ```
    - Close and save the files
    - Rename the directory `/var/lib/bluetooth/xx:xx:xx:xx:xx/yy:yz:yy:yy:yy` with the same name of the generated one `./bluetooth/xx:xx:xx:xx:xx/yy:yy:yy:yy:yy`
    - Restart the bluetooth service
        ```
        sudo service bluetooth force-reaload
        ```
        
> PS : `xx:xx:xx:xx:xx` is the MAC address of your bluetooth card. `yy:yy:yy:yy:yy` is the MAC of the mouse in the generated directory. `yy:yz:yy:yy:yy` is the MAC of the mouse in your /var/lib/bluetooth
