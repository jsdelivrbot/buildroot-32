################################################################################
#
# Build the ext2 root filesystem image
#
################################################################################

# qstrip results in stripping consecutive spaces into a single one. So the
# variable is not qstrip-ed to preserve the integrity of the string value.
EXT2_LABEL := $(subst ",,$(BR2_TARGET_ROOTFS_EXT2_LABEL))
#" Syntax highlighting... :-/ )

EXT2_OPTS = \
	-d $(TARGET_DIR) \
	-r $(BR2_TARGET_ROOTFS_EXT2_REV) \
	-N $(BR2_TARGET_ROOTFS_EXT2_INODES) \
	-m $(BR2_TARGET_ROOTFS_EXT2_RESBLKS) \
	-L "$(EXT2_LABEL)"

ROOTFS_EXT2_DEPENDENCIES = host-e2fsprogs

define ROOTFS_EXT2_CMD
	rm -f $@
	$(HOST_DIR)/usr/sbin/mkfs.ext$(BR2_TARGET_ROOTFS_EXT2_GEN) $(EXT2_OPTS) $@ \
		 $(BR2_TARGET_ROOTFS_EXT2_BLOCKS)
endef

rootfs-ext2-symlink:
	ln -sf rootfs.ext2$(ROOTFS_EXT2_COMPRESS_EXT) $(BINARIES_DIR)/rootfs.ext$(BR2_TARGET_ROOTFS_EXT2_GEN)$(ROOTFS_EXT2_COMPRESS_EXT)

.PHONY: rootfs-ext2-symlink

ifneq ($(BR2_TARGET_ROOTFS_EXT2_GEN),2)
ROOTFS_EXT2_POST_TARGETS += rootfs-ext2-symlink
endif

$(eval $(call ROOTFS_TARGET,ext2))
