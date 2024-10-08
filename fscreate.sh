#!/usr/bin/env sh

# fscreate.sh - create a filesystem for a linux kernel to
# load into a busybox shell.

# seperate the build environment from CWD
mkdir -p build-rootfs
cd build-rootfs

# make the directory that represents the filesystem we will pack
mkdir rootfs
ROOTFS=$(realpath rootfs)
mkdir -p rootfs/bin rootfs/proc rootfs/sys rootfs/dev rootfs/etc rootfs/etc/init.d

# building busybox
wget https://busybox.net/downloads/busybox-1.37.0.tar.bz2
tar -xjf ./busybox-1.37.0.tar.bz2
rm ./busybox-1.37.0.tar.bz2
cd busybox-1.37.0
make defconfig
make
make CONFIG_PREFIX=$ROOTFS install
cd ..

# create init file
cat << EOT > rootfs/init
#!/bin/sh
# idk why we mount this, have to look into it
mount -t proc none /proc
mount -t sysfs none /sys
/bin/sh
EOT
chmod +x rootfs/init

# pack the filesystem 
cd rootfs
find . | cpio -o --format=newc > ../rootfs.img
gzip -9 ../rootfs.img
cd ..


