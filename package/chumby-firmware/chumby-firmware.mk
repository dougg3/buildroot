################################################################################
#
# chumby-firmware
#
################################################################################

CHUMBY_FIRMWARE_VERSION = 53d469865b3fd638be7b11aef9b631a3b677e9da
CHUMBY_FIRMWARE_SITE = $(call github,sutajiokousagi,meta-chumby,$(CHUMBY_FIRMWARE_VERSION))
CHUMBY_FIRMWARE_LICENSE = PROPRIETARY
CHUMBY_FIRMWARE_INSTALL_IMAGES = YES

ifeq ($(BR2_PACKAGE_CHUMBY_FIRMWARE_C8_OBM_BIN),y)
define CHUMBY_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/recipes/chumby-blobs/chumby-blobs-silvermoon/obm.bin \
	       $(BINARIES_DIR)/chumby-firmware/obm.bin
endef
endif

$(eval $(generic-package))
