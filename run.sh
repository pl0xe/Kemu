#!/usr/bin/env bash

# run.sh - runs the qemu with the minimum required parameters to boot into the kernel

qemu-system-x86_64 -kernel bzImage \
  -initrd rootfs.img.gz \
  -nographic \
  -append "console=ttyS0 init=/bin/sh"
