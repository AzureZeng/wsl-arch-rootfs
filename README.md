# Arch Linux RootFS

This repository contains the automatic build script of minimal Arch Linux on WSL2 RootFS, provided by [Azure Zeng](https://azw.is-a.dev/).

This repo will build RootFS automatically at 07:24 AM UTC on every 1st day of the month.

## ⚠️ WARNING:

Please read this readme carefully before using this RootFS.

1. Arch Linux on WSL installation is **UNSUPPORTED BY OFFICIAL** according to the [official code of conduct](https://terms.archlinux.org/docs/code-of-conduct/#arch-linux-distribution-support-only). Before reporting problems to Arch Linux official, please ensure that the problems are **REPRODUCIBLE** in **SUPPORTED** Arch Linux installations.

2. As mentioned above, you should be familiar with Arch Linux in **SUPPORTED** installations.

3. The RootFS file provided in this repository is only intended to be installed in WSL2. WSL1 is not supported as Microsoft strongly advises using WSL2 now. If you are seeking Arch Linux on WSL1, [ArchWSL](https://github.com/yuk7/ArchWSL) provided by [yuk7](https://github.com/yuk7/) might help.

## Installation

Download the latest [rootfs.tar.gz](https://github.com/AzureZeng/wsl-arch-rootfs/releases/latest) in the Repository Releases.

Then import RootFS by using `wsl --import <Distro> <InstallLocation> <FileName>`.

For example:

```powershell
wsl --import Arch C:\Users\azurezeng\WSL\Arch rootfs.tar.gz
```

You can use the RootFS with yuk7's [wsldl](https://github.com/yuk7/wsldl) together to get more convenient installation. You can look up wsldl's manual at [here](https://github.com/yuk7/wsldl/blob/main/README.md).

**HINT**: 

1. Rename the file name of wsldl to customize your distro's name.

2. You can place `<distro-name>.exe` and `rootfs.tar.gz` in the same directory, then double-click `<distro-name>.exe` to complete distro import.

UPDATE: `rootfs-with-wsldl.zip` contains both `rootfs.tar.gz` and `wsldl.exe` (renamed to `Arch.exe`). I would like to express sincere thanks to yuk7!

![](https://github.com/AzureZeng/wsl-arch-rootfs/assets/19504193/9245d019-a7bd-40d2-b267-0855121ae53b)

## Contents in this RootFS

For detailed auto-build process, please visit [build-rootfs.yml](https://github.com/AzureZeng/wsl-arch-rootfs/blob/main/.github/workflows/build-rootfs.yml).

Summary:

* Pre-installed packages: `base` `curl` `wget` `vim` `nano` `sudo` `texinfo` `man-db` `man-pages`

* `/etc/pacman.d/mirrorlist`: Updated from `https://archlinux.org/mirrorlist/all/`, and all mirrorlist sites are enabled by default.

* `/etc/pacman.conf`: Enabled `Color` and `ParallelDownloads` options by default.

* `/etc/locale.gen`: Enabled `en_US.UTF-8 UTF-8` by default. Then used `locale-gen` to generate localization files.

* `/etc/sudoers.d/wheel`: Enabled `%wheel ALL=(ALL:ALL) ALL`, which means users in `wheel` group will be able to use `sudo` by default.

## Some hints

1. After importing/installing the RootFS, it is advised to do `pacman -Syu` as early as possible, to ensure everything the latest.

2. Install `mesa` `mesa-utils` to get WSL GPU acceleration. 

3. Intel graphics user may experience some problems (see this [issue](https://github.com/yuk7/ArchWSL/issues/308) on ArchWSL). A workaround:

```bash
sudo ln -sf libedit.so /usr/lib/libedit.so.2
```

4. To download all packages (without package re-installing):

```bash
pacman -Qq | sudo pacman -Sw -
```

5. To enable `systemd` support, create `/etc/wsl.conf` with below content:

```ini
[boot]
systemd=true
```

6. You can set the default user by putting the following content to `/etc/wsl.conf`:

```ini
[user]
default=USERNAME_IN_WSL
```
