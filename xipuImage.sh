#!/bin/sh
rm output/images/xipImage_padded
tr '\000' '\377' < /dev/zero | dd of=reserve bs=1 count=64
cat reserve output/images/xipImage > output/images/xipImage_padded
output/host/usr/bin/mkimage -x -A arm -O linux -T kernel -C none -a 0x08080000 -e 0x08080041 -n "XIP Image" -d output/images/xipImage_padded output/images/xipuImage
