# Arch Linux RootFS

This repository contains the automatic build script of minimal Arch Linux on WSL2 RootFS, provided by [Azure Zeng](https://azw.is-a.dev/).

This repo will build RootFS automatically at 07:24 AM UTC on every 1st day of the month.

## ⚠️ WARNING:

1. Please read this readme carefully before using RootFS.

2. Arch Linux on WSL installation is **NOT OFFICIALLY SUPPORTED** according to the [official code of conduct](https://terms.archlinux.org/docs/code-of-conduct/#arch-linux-distribution-support-only). Before reporting problems to Arch Linux official, please ensure that the problems are **REPRODUCIBLE** in **SUPPORTED** Arch Linux installations.

3. The RootFS file provided in this repository is only intended to be installed in WSL2. WSL1 is not supported as Microsoft strongly suggests using WSL2 now. If you are seeking Arch Linux on WSL1, [ArchWSL](https://github.com/yuk7/ArchWSL) provided by [yuk7](https://github.com/yuk7/) might help.

## Installation

Download the latest [rootfs.tar.gz](https://github.com/AzureZeng/wsl-arch-rootfs/releases/latest) in the Repo Releases.

Then import RootFS by using `wsl --import <Distro> <InstallLocation> <FileName>`.

For example:

```powershell
wsl --import Arch C:\Users\azurezeng\WSL\Arch rootfs.tar.gz
```

You can use the RootFS with yuk7's [wsldl](https://github.com/yuk7/wsldl) together to get more convenient installation. For wsldl's manual, visit [here](https://github.com/yuk7/wsldl/blob/main/README.md).

🛈 **HINT**: 

1. Rename the file name of wsldl to customize your distro's name.

2. You can place `<distro-name>.exe` and `rootfs.tar.gz` in the same directory, then double-click `<distro-name>.exe` to complete distro import.

![](https://github.com/AzureZeng/wsl-arch-rootfs/assets/19504193/9245d019-a7bd-40d2-b267-0855121ae53b)

## Contents in this RootFS

For detailed auto-build process, please visit [build-rootfs.yml](https://github.com/AzureZeng/wsl-arch-rootfs/blob/main/.github/workflows/build-rootfs.yml).

Summary:

* Pre-installed packages: `base` `curl` `wget` `vim` `nano` `sudo` `texinfo` `man-db` `man-pages`

* `/etc/pacman.d/mirrorlist`: updated from `https://archlinux.org/mirrorlist/all/`, and all mirrorlist sites are enabled by default.

* `/etc/pacman.conf`: enabled `Color` and `ParallelDownloads` options by default

* `/etc/locale.gen`: enabled `en_US.UTF-8 UTF-8` by default. Then used `locale-gen` to generate localization files.

* `/etc/sudoers.d/wheel`: Enabled `%wheel ALL=(ALL:ALL) ALL`, which users in `wheel` group will be able to use `sudo` by default.

* `/etc/wsl.conf`: Enabled `systemd` support by default.

## Some hints

1. Install `mesa` `mesa-utils` to get WSL GPU acceleration. 

2. Intel graphics user may encounter some problems (see this [issue](https://github.com/yuk7/ArchWSL/issues/308) on ArchWSL). Workaround: 

```bash
sudo ln -sf libedit.so /usr/lib/libedit.so.2
```

3. To download all packages (but no re-installation):

```bash
pacman -Qq | sudo pacman -Sw -
```