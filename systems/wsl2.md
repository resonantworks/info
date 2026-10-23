# WSL2

- [WSL2](#wsl2)
  - [Install](#install)
  - [WSL Settings](#wsl-settings)
  - [Install distribution](#install-distribution)
  - [Distribution snapshots](#distribution-snapshots)
    - [Snapshot distribution](#snapshot-distribution)
    - [Restore distribution](#restore-distribution)
  - [Access USB device within WSL2](#access-usb-device-within-wsl2)
  - [Issues](#issues)
    - [Zone.Identifier Files when copying from Windows to WSL](#zoneidentifier-files-when-copying-from-windows-to-wsl)

## Install

- Admin command prompt:

```sh
wsl --install
wsl --update
```

## WSL Settings

Start menu > WSL Settings:

- Memory and processor
  - Processor Count: *Total core count if compiling, or nearest, otherwise half or quarter*
  - Memory Size: *50% total RAM size*
  - Swap Size: *100% total RAM size*
  - *(optional)* Swap file location: *Set to specific path (ie, `C:\wsl\swap.vhdx`)*
- File System
  - Default VHD Size: *Sensible limit (ie, `32768Mb`)*
-Networking
  - Networking mode: `NAT`
    - *or* `Mirrored` *if going to debug firmware using vscode:WSL --> Windows ST-LINK/J-LINK GDB server*
- Optional Features
  - Enable GUI applications: `ON`
  - Enable nested virtualisation: `ON`
  - Enable sparse VHD by default: `ON`

## Install distribution

Create folder to hold `vhdx` files (ie, `C:\wsl\ubuntu`)

Command prompt:

```sh
wsl --list --online                # <-- Note NAME of wanted distro

wsl --install NAME --location PATH
# wsl --install Ubuntu-26.04 --location "C:\wsl\ubuntu"

wsl --manage NAME --resize SIZE    # (optional) Only required when different to WSL Settings
# wsl --manage Ubuntu-26.04 --resize 64GB

wsl --set-default NAME
# wsl --set-default Ubuntu-26.04
wsl --list
```

## Distribution snapshots

### Snapshot distribution

1. Close all terminals/sessions to the instance
1. Command prompt:

```sh
wsl --shutdown
wsl --list --verbose                            # ensure instance STATE is Stopped
wsl --export NAME backup.tar.gz --format tar.gz # or 'tar.xz' - much slower!
# wsl --export Ubuntu-26.04 ubuntu-26.04.tar.gz --format tar.gz
```

### Restore distribution

1. Close all terminals/sessions to the instance
1. Command prompt:

```sh
wsl --shutdown
wsl --unregister NAME                 # remove existing instance
wsl --import NAME PATH backup.tar.gz  # restore instance from backup
# wsl --unregister Ubuntu-26.04
# wsl --import Ubuntu-26.04 C:\wsl\ubuntu ubuntu-26.04.tar.gz
```

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

## Issues

### Zone.Identifier Files when copying from Windows to WSL

To disable: *Control Panel > Network and Internet > Internet Options > Security > Local Intranet > Sites > Advanced*, then add `wsl.localhost` as a site.

See: <https://github.com/microsoft/WSL/issues/4609#issuecomment-4698956578>
