#!/bin/sh
SUPERIMAGE_PATH=$BASE_DIR/images/stm32f429-disco.img
UBOOTIMAGE_PATH=$BASE_DIR/images/u-boot.bin
DTB_PATH=$BASE_DIR/images/stm32f429-disco.dtb
KERNELIMAGE_PATH=$BASE_DIR/images/xipuImage
ROOTFSIMAGE_PATH=$BASE_DIR/images/rootfs.romfs

FLASH_BASE="0x08000000"
# Seek values according to MEMORY_MAP
DTB_OFFSET="264"
KERNEL_OFFSET="272"
ROOTFS_OFFSET="1536"

rm -f $SUPERIMAGE_PATH
dd if=/dev/zero of=$SUPERIMAGE_PATH bs=2M count=1
echo "Appending U-Boot image"
dd if=$UBOOTIMAGE_PATH of=$SUPERIMAGE_PATH
echo "Appending DTB"
dd if=$DTB_PATH of=$SUPERIMAGE_PATH bs=1K seek=$DTB_OFFSET
echo "Appending Kernel"
dd if=$KERNELIMAGE_PATH of=$SUPERIMAGE_PATH bs=1K seek=$KERNEL_OFFSET
echo "Appending Rootfs"
dd if=$ROOTFSIMAGE_PATH of=$SUPERIMAGE_PATH bs=1K seek=$ROOTFS_OFFSET

openocd \
	-f board/stm32f429discovery.cfg \
	-c "init" \
	-c "reset init" \
	-c "flash probe 0" \
	-c "flash write_image erase $SUPERIMAGE_PATH $FLASH_BASE" \
	-c "reset run" -c shutdown
