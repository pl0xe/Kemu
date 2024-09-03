# KEMU - Kernel Emulation Guide

Research documentation on a way to setup a bootable
linux environment with different kernels on the fly
for testing exploits.

## Environment Preface

I am using Windows 11, WSL2 Ubuntu 22.04.2 LTS, QEMU for
emulating the system that will boot our Linux Kernel.

## Install QEMU

`sudo apt install qemu qemu-system qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils`

## Download Linux Kernel


Navigate to `www.kernel.org` which leads to the linux
kernel archive. You can download a tarball containing 
the linux kernel source from there.

The other options is to git clone the stable branch maintained
here and not check out the torvalds version which is only
for mainline release. After we checkout a commit tag as a 
new branch for you to  build whatever version you want

`git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/`

list and filter kernel version/tags

`git tag | grep 'v6.2'`

`git checkout -b anyname v6.2.2`

## Compile Kernel

install dependencies

`sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison`

configure kernel flags depending on your needs or keep it
vanilla.

*note : most likely your kernel config will have this on by default but is
these flags are necessary for QEMU kernel debugging.

    - Device drivers → Network device support → Virtio network driver <*>

    - Device drivers → Block devices → Virtio block driver <*>

`make ARCH=x86_64 menuconfig`

`make j${nproc}`

If you see `Kernel: arch/x86/boot/bzImage is ready  (#1)` thats a success.

## Setting up the filesystem

`git clone git://git.buildroot.net/buildroot`

`cd buildroot`

`make menuconfig`

Select the target for x86_64

Filesystem should be set for EXT4

Then select target packages for openssh

```bash
# may be necessary since WSL has a path with spaces, tabs or newlines
# which will break the buildroot build system.
set PATH=/bin;/usr/local/bin;/usr/bin
make -j${nproc}
```

# references

https://www.josehu.com/technical/2021/01/02/linux-kernel-build-debug.html

https://stackoverflow.com/questions/28136815/linux-kernel-how-to-obtain-a-particular-version-right-upto-sublevel

https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade
