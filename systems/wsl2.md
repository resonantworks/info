# WSL2

- [WSL2](#wsl2)
  - [Access USB device within WSL2](#access-usb-device-within-wsl2)
  - [STM32](#stm32)
    - [ST-LINK without usbipd (ST-LINK GDB server - non-admin)](#st-link-without-usbipd-st-link-gdb-server---non-admin)
    - [J-LINK without usbipd (J-LINK GDB server - non-admin)](#j-link-without-usbipd-j-link-gdb-server---non-admin)

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

## STM32

### ST-LINK without usbipd (ST-LINK GDB server - non-admin)

- Install [STM32CubeCLT](https://www.st.com/en/development-tools/stm32cubeclt.html) on both Windows and within WSL2 ([Fedora example](fedora.md#stm32-clt))
- Change WSL2 networking to mirrored. Update `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
networkingMode=mirrored
```

- Restart WSL2

```sh
wsl --shutdown
```

- Add `launch.json` config:

```json
{
    "name": "ST-LINK (gdbserver)",
    "device": "<<MCU>>",
    "svdFile": "${env:STM32CLT_PATH}/STMicroelectronics_CMSIS_SVD/<<MCU>>.svd",
    "type": "cortex-debug",
    "cwd": "${workspaceRoot}",
    "executable": "${command:cmake.launchTargetPath}",
    "request": "launch",
    "servertype": "external",
    "gdbTarget": "localhost:61234",
    "armToolchainPath": "${env:STM32CLT_PATH}/GNU-tools-for-STM32/bin",
    "runToEntryPoint": "main",
    "overrideLaunchCommands": [
    "monitor halt",
    "load",
    "monitor reset",
    "monitor halt"
    ],
    "overrideRestartCommands": [
    "monitor reset",
    "monitor halt"
    ],
    "overrideResetCommands": [
    "monitor reset",
    "monitor halt"
    ],
    "liveWatch": {
    "enabled": true,
    "samplesPerSecond": 2
    }
},
```

- Run script file to start ST-LINK GDB server on Windows: [start-st-link-gdb-server.cmd](assets/stlink-gdb-server.cmd)
- Start debugging in VSCode -> WSL2

### J-LINK without usbipd (J-LINK GDB server - non-admin)

- Install [STM32CubeCLT](https://www.st.com/en/development-tools/stm32cubeclt.html) within WSL2 ([Fedora example](fedora.md#stm32-clt))
  - *Required for ST tweaked Arm GNU gdb and SVD files*
  - Can use vanilla [Arm GNU Toolchain](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain) instead
- Install [J-Link Software and Documentation Pack](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack) on Windows
  - Set the Windows user environment variable `JLINK_PATH`=`C:\Program Files\SEGGER\JLink_V???` (installation location of J-Link executables)
- Change WSL2 networking to mirrored. Update `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
networkingMode=mirrored
```

- Restart WSL2

```sh
wsl --shutdown
```

- Add `launch.json` config:

```json
{
  "name": "J-Link (gdbserver)",
  "device": "<<device ID>>",
  "svdFile": "${env:STM32CLT_PATH}/STMicroelectronics_CMSIS_SVD/<<device ID>>.svd",
  "type": "cortex-debug",
  "cwd": "${workspaceRoot}",
  "executable": "${command:cmake.launchTargetPath}",
  "request": "launch",
  "servertype": "external",
  "gdbTarget": "localhost:2331",
  "armToolchainPath": "${env:STM32CLT_PATH}/GNU-tools-for-STM32/bin",
  "runToEntryPoint": "main",
  "liveWatch": {
    "enabled": true,
    "samplesPerSecond": 2
  },
  "overrideLaunchCommands": [
    "monitor halt",
    "monitor reset",
    "load",
    "monitor reset",
    "monitor halt"
  ],
  "overrideRestartCommands": [
    "monitor reset",
    "monitor halt"
  ],
  "overrideResetCommands": [
    "monitor reset",
    "monitor halt"
  ]
},
```

- Run script file to start J-LINK GDB server on Windows: [jlink-gdb-server.cmd](assets/jlink-gdb-server.cmd) supplying the device as the only argument
  - Example: `jlink-gdb-server STM32L4S9ZI`
- Start debugging in VSCode -> WSL2
