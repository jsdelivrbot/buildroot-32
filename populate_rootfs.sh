#!/bin/sh
rm -rf /home/varcain/tftp/*
rm -rf /home/varcain/nfs/*
cp /home/varcain/projects/buildroot/output/images/zImage /home/varcain/tftp/
cp /home/varcain/projects/buildroot/output/images/bcm2709-rpi-2-b.dtb /home/varcain/tftp/rpi2.dtb
tar -xf /home/varcain/projects/buildroot/output/images/rootfs.tar -C /home/varcain/nfs/
echo "Done!"

