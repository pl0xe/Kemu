#!/usr/bin/env sh

# fscreate.sh - create a filesystem for a linux kernel to
# load into a busybox shell.

# seperate the build environment from CWD
mkdir -p build-rootfs
cd build-rootfs

# make the actual directory that represents
# the filesystem
mkdir rootfs

# building busybox
wget https://busybox.net/downloads/busybox-1.37.0.tar.bz2
tar -xjf ./busybox-1.37.0.tar.bz2
cd busybox-1.37.0
make defconfig
make
make CONFIG_PREFIX=$(realpath ../rootfs) install

# create necessary directory structure
cd ../rootfs
mkdir -p bin proc sys dev etc etc/init.d

# create init file
cat << EOT >> init
#!/bin/sh
# idk why we mount this, have to look into it
mount -t proc none /proc
mount -t sysfs none /sys
/bin/sh
EOT

chmod +x init

find . | cpio -o --format=newc > ../rootfs.img | gzip -9

# emulate the system
qemu-system-x86_64 -kernel bzImage \
  -initrd rootfs.img \
  -nographic \
  -append console=ttyS0
