#!/bin/sh
XIPUIMAGE_PATH=$BASE_DIR/images/xipuImage
XIPUIMAGE_ADDR="0x08044000"
openocd \
	-f board/stm32f429discovery.cfg \
	-c "init" \
	-c "reset init" \
	-c "flash probe 0" \
	-c "flash write_image erase $XIPUIMAGE_PATH $XIPUIMAGE_ADDR" \
	-c "reset run" -c shutdown
