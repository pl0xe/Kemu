#!/usr/bin/env bash

# kcreate.sh - downloads a linux kernel and builds a bzImage
# then puts it on the current directory

# download the kernel
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.11.2.tar.xz

# extract/decompress kernel
tar xf ./linux-6.11.2.tar.xz

# compile the kernel
cd linux-6.11.2
make ARCH=x86_64 defconfig 
make -j15 # higher than 15 my PC fails to compile all sources
cp arch/x86/boot/bzImage ..
