#!/bin/sh
mount /dev/sdb1 /media/sdcard
cp output/images/uImage  /media/sdcard
sync
umount /media/sdcard
echo "Done!"
