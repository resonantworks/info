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
# general
sudo apt install curl jq pipx
```

### C/C++ - Default compiler versions

```sh
# default gcc version, make, cmake ninja, etc
sudo apt install build-essential cmake gdb lcov ninja-build

# llvm
sudo apt install llvm clang lld lldb clang-tools clang-format clang-tidy clangd libc++-dev libc++abi-dev libclang-rt-dev

# 32-bit support
sudo apt install gcc-multilib g++-multilib
echo "unset DEBUGINFOD_URLS" >> ~/.bashrc # Disable fetching non-existent 32-bit debugging symbols (not served by ubuntu package source, causes hangs when attempting to debug)

# clangd-tidy
pipx install clangd-tidy
pipx ensurepath
```

### C/C++ - Specific C/C++ compiler versions

```sh
# default gcc version, make, cmake ninja, etc
sudo apt install build-essential cmake gdb lcov ninja-build

# gcc 13
sudo apt install gcc-13 g++-13

# 32-bit support
sudo apt install gcc-multilib g++-multilib
sudo apt install gcc-13-multilib g++-13-multilib
echo "unset DEBUGINFOD_URLS" >> ~/.bashrc # Disable fetching non-existent 32-bit debugging symbols (not served by ubuntu package source, causes hangs when attempting to debug)

# default llvm version
sudo apt install llvm clang lld lldb clang-tools clang-format clang-tidy clangd libc++-dev libc++abi-dev libclang-rt-dev

# llvm 20 - except lldb and few other packages which would autoremove default version
sudo apt install --no-install-recommends clang-20 clang-tools-20 clang-format-20 clang-tidy-20 clangd-20 lld-20 llvm-20 llvm-20-dev libclang-20-dev libclang-rt-20-dev

# !!! NOTE: gcc and llvm versions are for ubuntu 26.04 !!!
# add default gcc 15 option
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 150 \
  --slave /usr/bin/g++ g++ /usr/bin/g++-15 \
  --slave /usr/bin/gcov gcov /usr/bin/gcov-15 \
  --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-15 \
  --slave /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-15 \
  --slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-15

# add alternative gcc 13 option
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 130 \
  --slave /usr/bin/g++ g++ /usr/bin/g++-13 \
  --slave /usr/bin/gcov gcov /usr/bin/gcov-13 \
  --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-13 \
  --slave /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-13 \
  --slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-13

# add default llvm 21 option
sudo update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-21/bin/clang 210 \
  --slave /usr/bin/clang++ clang++ /usr/lib/llvm-21/bin/clang++ \
  --slave /usr/bin/clangd clangd /usr/lib/llvm-21/bin/clangd \
  --slave /usr/bin/clang-format clang-format /usr/lib/llvm-21/bin/clang-format \
  --slave /usr/bin/clang-tidy clang-tidy /usr/lib/llvm-21/bin/clang-tidy \
  --slave /usr/bin/lld lld /usr/lib/llvm-21/bin/lld \
  --slave /usr/bin/lldb lldb /usr/lib/llvm-21/bin/lldb \
  --slave /usr/bin/llvm-config llvm-config /usr/lib/llvm-21/bin/llvm-config \
  --slave /usr/bin/llvm-ar llvm-ar /usr/lib/llvm-21/bin/llvm-ar \
  --slave /usr/bin/llvm-nm llvm-nm /usr/lib/llvm-21/bin/llvm-nm \
  --slave /usr/bin/llvm-objdump llvm-objdump /usr/lib/llvm-21/bin/llvm-objdump

# add alternative llvm 20 option
sudo update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-20/bin/clang 200 \
  --slave /usr/bin/clang++ clang++ /usr/lib/llvm-20/bin/clang++ \
  --slave /usr/bin/clangd clangd /usr/lib/llvm-20/bin/clangd \
  --slave /usr/bin/clang-format clang-format /usr/lib/llvm-20/bin/clang-format \
  --slave /usr/bin/clang-tidy clang-tidy /usr/lib/llvm-20/bin/clang-tidy \
  --slave /usr/bin/lld lld /usr/lib/llvm-20/bin/lld \
  --slave /usr/bin/llvm-config llvm-config /usr/lib/llvm-20/bin/llvm-config \
  --slave /usr/bin/llvm-ar llvm-ar /usr/lib/llvm-20/bin/llvm-ar \
  --slave /usr/bin/llvm-nm llvm-nm /usr/lib/llvm-20/bin/llvm-nm \
  --slave /usr/bin/llvm-objdump llvm-objdump /usr/lib/llvm-20/bin/llvm-objdump

sudo update-alternatives --config gcc   # choose gcc-13 (manual mode)
sudo update-alternatives --config clang # choose llvm-20 (manual mode)

# verify compiler versions
gcc --version   # should be 13
clang --version # should be 20

# clangd-tidy
pipx ensurepath
pipx install clangd-tidy lcov_cobertura
```

### STM32 CLT

If the instructions below do not work, refer to the [UM3098 - STM32CubeCLT installation guide](https://www.st.com/resource/en/user_manual/um3089-stm32cubeclt-installation-guide-stmicroelectronics.pdf).

1. Download the [STM32CubeCLT Debian Linux Installer](https://www.st.com/en/development-tools/stm32cubeclt.html#section-get-software-table)
version specified in [README.md > Tool versions](../README.md#tool-versions) and copy to `C:\temp`
1. Open a Terminal to the distribution (Windows Terminal > `JFD.Ubuntu`) and execute the following shell actions:

```sh
# extract and run installer
cd /tmp
unzip /mnt/c/temp/st-stm32cubeclt*deb_bundle.sh.zip
sudo sh ./st-stm32cubeclt*deb_bundle.sh
# Accept licence [y]

# remove injected path (installer forces bundled old versions of CMake amd ninja-build, verify with 'which cmake')
sudo mv /etc/profile.d/cubeclt-bin-path_*.sh /etc/profile.d/cubeclt-bin-path.sh.disable

# install dependencies
wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2ubuntu0.1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.3-2ubuntu0.1_amd64.deb
sudo dpkg -i libtinfo5_*.deb libncurses5_*.deb

# add toolchain environment variable to specify STM32CubeCLT location
echo "export STM32CLT_PATH='$(ls -d /opt/st/stm32cubeclt_*.*.* | head -n1)'" >> ~/.bashrc
```
