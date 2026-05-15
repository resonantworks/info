# Ubuntu

- [Ubuntu](#ubuntu)
  - [Common tasks](#common-tasks)
  - [Install general development tools](#install-general-development-tools)
    - [Vim](#vim)
    - [Git](#git)
    - [General](#general)
    - [C/C++ - Default compiler versions](#cc---default-compiler-versions)
    - [C/C++ - Specific C/C++ compiler versions](#cc---specific-cc-compiler-versions)

## Common tasks

| Task    | Commands                              |
|---------|---------------------------------------|
| Update  | `sudo apt update && sudo apt upgrade` |
| Install | `sudo dnf install <package>`          |
| Search  | `apt search <package>`                |

## Install general development tools

### Vim

```sh
# vim
sudo apt install fzf ripgrep vim-nox
```

Follow [vim configuration setup](linux.md#vim).

### Git

```sh
sudo apt install git
```

Follow [Git configuration setup](/programming/git.md).

### General

```sh
# general, gcc
sudo apt install curl jq pipx
```

### C/C++ - Default compiler versions

```sh
# gcc, make, etc
sudo apt install build-essential cmake gdb ninja-build

# llvm
sudo apt install llvm clang lld lldb clang-tools clang-format clang-tidy clangd
sudo apt install libc++-dev libc++abi-dev libclang-rt-dev

# 32-bit support
sudo apt install gcc-multilib g++-multilib

# clangd-tidy
pipx install clangd-tidy
pipx ensurepath
```

### C/C++ - Specific C/C++ compiler versions

```sh
# gcc, make, etc
sudo apt install build-essential cmake gdb ninja-build

# gcc 13
sudo apt install -y gcc-13 g++-13

# llvm 20
sudo apt install -y clang-20 lld-20 lldb-20 llvm-20 clang-tools-20 clang-format-20 clang-tidy-20 clangd-20 llvm-20-dev libclang-rt-20-dev libc++-20-dev libc++abi-20-dev

# 32-bit support
sudo apt install -y gcc-multilib g++-multilib
sudo apt install -y gcc-13-multilib g++-13-multilib

# add alternative gcc 13 option
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130 \
    --slave   /usr/bin/g++ g++ /usr/bin/g++-13 \
    --slave   /usr/bin/gcov gcov /usr/bin/gcov-13 \
    --slave   /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-13 \
    --slave   /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-13 \
    --slave   /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-13

# add alternative clang 20 option
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 200 \
    --slave   /usr/bin/clang++ clang++ /usr/bin/clang++-20 \
    --slave   /usr/bin/clangd clangd /usr/bin/clangd-20 \
    --slave   /usr/bin/clang-format clang-format /usr/bin/clang-format-20 \
    --slave   /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-20 \
    --slave   /usr/bin/lld lld /usr/bin/lld-20 \
    --slave   /usr/bin/lldb lldb /usr/bin/lldb-20

sudo update-alternatives --config gcc
sudo update-alternatives --config clang

# verify compiler versions
gcc --version   # should be 13
clang --version # should be 20

# clangd-tidy
pipx install clangd-tidy
pipx ensurepath
```

<!-- ### STM32 CLT

Install dependencies:

```sh
sudo dnf install ncurses-compat-libs
```

Current versions of Fedora block installation due to new security policies.
> To use ST-LINK or J-LINK within WSL, see [WSL2 > Access USB device within WSL2](wsl2.md#access-usb-device-within-wsl2)

- Download RPM version of STM32CubeCLT
- Unzip, then:

```sh
# extract rpm files
sh st-stm32cubeclt_*_amd64.rpm_bundle.sh --target extracted_clt --noexec
sudo rpm -ivh --nodigest --nodeps st-stm32cubeclt_*.x86_64.rpm
```

- Remove injected paths added on start-up

```sh
sudo mv /etc/profile.d/cubeclt-bin-path_1.18.0.sh /etc/profile.d/cubeclt-bin-path_1.18.0.sh.disable
```

- Add environment variable used by CMake scripts to `~/.bashrc`

```sh
# STM32CubeCLT
export STM32CLT_PATH='/opt/st/stm32cubeclt_?.???.0'
``` -->
