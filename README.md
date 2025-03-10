# Arch Linux RootFS

This repository contains the automatic build script of minimal Arch Linux on WSL2 RootFS, provided by [Azure Zeng](https://azw.is-a.dev/).

This repo will build RootFS automatically at 07:24 AM UTC on every 1st day of the month.

## ⚠️ WARNING:

Please read this readme carefully before using this RootFS.

1. **Please read this README thoroughly before using any RootFS archives provided by this repository.**

2. Arch Linux on WSL installation is currently supported by official. Before you start, it is recommended to visit [official guide on Arch Linux Wiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL).

3. Although supported officially, there might be some problems which is not reproducible in non-WSL Arch Linux installation. Therefore, you should be familiar with normal Arch Linux installations.

4. The RootFS file provided in this repository is only intended to be installed in WSL2. WSL1 is not supported as Microsoft strongly advises using WSL2 now.

## Installation

Download the latest [rootfs.tar.gz](https://github.com/AzureZeng/wsl-arch-rootfs/releases/latest) in the Repository Releases.

Then import RootFS by using `wsl --import <Distro> <InstallLocation> <FileName>`.

For example:

```powershell
wsl --import Arch C:\Users\azurezeng\WSL\Arch rootfs.tar.gz
```

**\*New!** If WSL version 2.4.4 or higher version is installed, it is able to install and configure Arch Linux instantly by double-clicking `archlinux.wsl` or execute the following:

```powershell
wsl --install --from-file /path/to/archlinux.wsl
```

You can use the RootFS with yuk7's [wsldl](https://github.com/yuk7/wsldl) together to get more convenient installation. The manual of [wsldl](https://github.com/yuk7/wsldl) can be found at [here](https://github.com/yuk7/wsldl/blob/main/README.md).

After importing, remember to do `pacman-key --init` and `pacman-key --populate` **immediately**, otherwise `pacman` may not work.

Then, remember to do `pacman -Syu` to update all packages to the latest as soon as possible.

### Hints

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

* Removed auto-generated `/etc/pacman.d/gnupg` for security reason (since 7/20/2024).

* `/tmp` is mounted as `tmpfs` by adding this mount option to `/etc/fstab`. This behavior is same as default Arch Linux installation.

* Masked Systemd services: `systemd-resolved.service`, `systemd-networkd.service`, `tmp.mount`.

* Disabled the appending of Windows environment variables by default. This setting is done via `/etc/wsl.conf`.

## Some tips

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

7. Error `error: restricting filesystem access failed because landlock is not supported by the kernel!` when using `pacman`

   Some security features are introduced in `pacman` v7.x, requiring a newer kernel version. However, Microsoft still sticks using Linux kernel v5.15.x.

   You can compile a newer kernel version and change WSL setting to use custom kernel, or just enable `DisableSandbox` setting in `/etc/pacman.conf`.

```
#UseSyslog
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
ParallelDownloads = 5
DownloadUser = alpm
DisableSandbox
```
