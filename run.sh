#!/usr/bin/env bash

# This is a good way to test the kernel we just compiled, if this
# is ran we should see a kernel panic for no file system

#qemu-system-x86_64 \
#  -no-kvm \
#  -kernel arch/x86/boot/bzImage \
#  -hda /dev/zero \
#  -append "root=/dev/zero console=ttyS0" \
#  -serial stdio \
#  -display none


