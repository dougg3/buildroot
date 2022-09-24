################################################################################
#
# chumby-cpi
#
################################################################################

CHUMBY_CPI_VERSION = 835162858bb5ca7647e7567bd5cde82efc222577
CHUMBY_CPI_SITE = $(call github,sutajiokousagi,cpi,$(CHUMBY_CPI_VERSION))
CHUMBY_CPI_LICENSE = PROPRIETARY

ifeq ($(BR2_PACKAGE_CHUMBY_CPI_C8_BIN),y)
define CHUMBY_CPI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/export/arm-linux-silvermoon/bin/cpi \
		$(TARGET_DIR)/usr/bin/
endef
endif

$(eval $(generic-package))
