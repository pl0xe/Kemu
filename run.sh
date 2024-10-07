#!/usr/bin/env sh

qemu-system-x86_64 -kernel bzImage \
  -initrd rootfs.img.gz \
  -nographic \
  -append "console=ttyS0 init=/bin/sh"
