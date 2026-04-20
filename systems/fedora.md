# Fedora

- [Fedora](#fedora)
  - [Common tasks](#common-tasks)
  - [Update bash aliases](#update-bash-aliases)
  - [Install dev tools](#install-dev-tools)
    - [General](#general)
    - [Vim](#vim)
    - [C/C++](#cc)
    - [Git bash status line](#git-bash-status-line)
      - [32-bit C/C++ GCC/LLVM CMake build fails on missing include](#32-bit-cc-gccllvm-cmake-build-fails-on-missing-include)
    - [.NET](#net)

## Common tasks

| Task    | Commands                     |
|---------|------------------------------|
| Update  | `sudo dnf upgrade --refresh` |
| Install | `sudo dnf install <package>` |
| Search  | `dnf search <package>`       |

## Update bash aliases

Append the following to  `~/.bashrc`

```sh
# User customisations
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias vi='/usr/bin/vim'
```

## Install dev tools

### General

```sh
sudo dnf install awk git pip pipx # awk required by git for tab autocomplete
```

### Vim

```sh
sudo dnf install vim git ack curl
git config --global core.editor vim
```

### C/C++

```sh
sudo dnf install cmake ninja-build
sudo dnf install gcc gcc-c++ gdb
sudo dnf install glibc-devel.i686 libstdc++-devel.i686 # gcc 32-bit support

sudo dnf install llvm clang lld lldb clang-tools-extra clang-analyzer
sudo dnf install compiler-rt.i686 libcxx.i686 libstdc++-devel.i686 # llvm 32-bit support (stdlib=libc++)
```

### Git bash status line

Append the following to  `~/.bashrc`

```sh
# git bash status line
source /usr/share/git-core/contrib/completion/git-prompt.sh
export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[33m\]\w\[\e[36m\]$(__git_ps1 " (%s)")\[\e[0m\]$(if [ -n "$(__git_ps1)" ]; then echo -e "\n\$ "; else echo "\$ "; fi)'
```

#### 32-bit C/C++ GCC/LLVM CMake build fails on missing include

> /usr/bin/../lib/gcc/x86_64-redhat-linux/15/../../../../include/c++/15/cstdint:40:10: fatal error: 'bits/c++config.h' file not found

Add the following to the clang command line (see [toolchain-linux-clang.make](assets/toolchain-linux-clang.cmake) and [toolchain-linux-gcc.make](assets/toolchain-linux-gcc.cmake)):

```sh
-m32 -isystem /usr/include/c++/15/i686-redhat-linux
```

### .NET

```sh
sudo dnf install glibc libgcc ca-certificates openssl-libs libstdc++ libicu tzdata krb5-libs zlib # dependencies
sudo dnf install dotnet-runtime-10.0 # <-- just the runtime - change to latest version
sudo dnf install dotnet-sdk-10.0 # <-- full dev sdk - change to latest version
```
