# WSL2

- [WSL2](#wsl2)
  - [Access USB device within WSL2](#access-usb-device-within-wsl2)

## Access USB device within WSL2

- Install latest [usbipd-win](https://github.com/dorssel/usbipd-win/releases)
- Enroll device for attachment, *admin cmd*:

```sh
usbipd list
usbipd bind --busid <BUS ID of USB device>
```

> To permanently attach to WSL use `usbipd attach --wsl --busid <ID> --auto-attach`

- Attach device to WSL, *user cmd*:

```sh
usbipd attach --wsl --busid <BUS ID of USB device>
```

- Detach device from WSL, *user cmd*:

```sh
usbipd detach --wsl --busid <BUS ID of USB device>
```

- Verify usb device attached, *WSL bash*:

```sh
lsusb
# Bus 001 Device 002: ID 0483:374b STMicroelectronics ST-LINK/V2.1
```
