#!/bin/sh
UBOOTIMAGE_PATH=$BASE_DIR/images/u-boot.bin
UBOOTIMAGE_ADDR="0x08000000"
openocd \
	-f board/stm32f429discovery.cfg \
	-c "init" \
	-c "reset init" \
	-c "flash probe 0" \
	-c "flash write_image erase $UBOOTIMAGE_PATH $UBOOTIMAGE_ADDR" \
	-c "reset run" -c shutdown
