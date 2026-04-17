# Podman

- [Podman](#podman)
  - [Windows](#windows)
    - [Setup](#setup)
    - [Verify installation](#verify-installation)
      - [Verify simple container working](#verify-simple-container-working)
      - [Verify port forwarding](#verify-port-forwarding)
      - [Verify Docker API/command forwarding](#verify-docker-apicommand-forwarding)
  - [WSL2](#wsl2)
    - [Install](#install)
      - [Docker command forwarding](#docker-command-forwarding)
      - [Fix WSL-specific container runtime settings](#fix-wsl-specific-container-runtime-settings)
      - [Add Docker-like registry behaviour (unqualified container names)](#add-docker-like-registry-behaviour-unqualified-container-names)
  - [Settings](#settings)
    - [Rootful](#rootful)
      - [Root user](#root-user)
      - [Non-root user](#non-root-user)
    - [Volume mounts](#volume-mounts)
    - [Maintenance / Upgrading](#maintenance--upgrading)
      - [SSH](#ssh)
      - [Upgrade machine packages](#upgrade-machine-packages)
      - [Remove podman machine](#remove-podman-machine)

## Windows

Follow instructions at [Podman for Windows](https://github.com/containers/podman/blob/main/docs/tutorials/podman-for-windows.md).

### Setup

- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
- Install Docker CLI
  - `choco install docker-cli`
  - `winget install Docker.DockerCLI`
- Install latest [Podman release](https://github.com/containers/podman/releases)
  - Virtualisation provider: **WSL2**
- User cmd: `podman machine init`
- *(optional)* Move podman vhdx file:

```sh
wsl --shutdown
wsl -l -v
wsl --manage podman-machine-default --move C:\vmx\wsl\podman
podman machine ls
```

### Verify installation

#### Verify simple container working

```sh
podman machine start
wsl -l -v

# Check root-less user
podman run ubi9-micro date
podman machine stop

# Check root user
podman machine set --rootful
podman machine start
podman run ubi8-micro date
podman machine stop

# Restore root-less preference
podman machine set --rootful=false
```

#### Verify port forwarding

```sh
podman machine start
podman run --rm -d -p 8080:80 --name httpd docker.io/library/httpd
# Verify by browsing: http://localhost:8080/
podman machine stop
```

#### Verify Docker API/command forwarding

```sh
podman machine start
docker run -it fedora echo "Hello Podman!"
podman machine stop
```

## WSL2

### Install

```sh
sudo apt update
sudo apt install -y podman
sudo apt install -y uidmap slirp4netns fuse-overlayfs
sudo apt install -y podman-docker
systemctl --user enable --now podman.socket

# Verify status
systemctl --user status podman.socket
```

#### Docker command forwarding

```sh
nano  ~/.bashrc
```

Append:

```sh
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
```

#### Fix WSL-specific container runtime settings

```sh
mkdir -p ~/.config/containers
nano ~/.config/containers/containers.conf
```

```toml
[engine]
cgroup_manager = "cgroupfs"
events_logger = "file"
```

#### Add Docker-like registry behaviour (unqualified container names)

```sh
sudo nano /etc/containers/registries.conf
```

Append:

```toml
unqualified-search-registries = ["docker.io"]
```

Test:

```sh
podman run -d -p 8080:80 nginx
# Verify by browsing: http://localhost:8080
```

## Settings

### Rootful

#### Root user

```sh
podman machine stop
podman machine set --rootful
podman machine start
```

#### Non-root user

```sh
podman machine stop
podman machine set --rootful=false
podman machine start
```

### Volume mounts

- Windows paths
  - `podman run --rm -v c:\Users\User\myfolder:/myfolder ubi9-micro ls /myfolder`
- Unix style paths
  - `podman run --rm -v /c/Users/User/myfolder:/myfolder ubi9-micro ls /myfolder`
- WSL paths
  - `podman run --rm -v /var/myfolder:/myfolder ubi9-micro ls /myfolder`

### Maintenance / Upgrading

#### SSH

```sh
podman machine start
podman machine ssh
```

#### Upgrade machine packages

```sh
podman --version
sudo dnf upgrade -y
```

#### Remove podman machine

```sh
podman machine rm
```
