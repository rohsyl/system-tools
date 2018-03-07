# How to edit the `hosts` file on Android

## Prerequisites

- Enable Developper Options and USB debuging on the Android device
- Install ADB on the PC

## Edit `hosts`

- Connect your phone to your PC
- Open a terminal
- Check if your phone is correctly connected

```
adb devices
```

- Get a copy of the `hosts` file from the phone

```
adb pull /system/etc/hosts C:\hosts
```

- Edit the `C:\hosts` file and save it

- Copy it back to the phone

```
adb push C:\hosts /system/etc/
```

- That's all folks !