################################################################################
#
# chumby-utils
#
################################################################################

CHUMBY_UTILS_VERSION = 7b30428466ef34706936d4dd88ef34a747e52221
CHUMBY_UTILS_SITE = $(call github,dougg3,chumby-utils,$(CHUMBY_UTILS_VERSION))
CHUMBY_UTILS_LICENSE = GPL-3.0+

define CHUMBY_UTILS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define CHUMBY_UTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/chumby_card_reader_daemon \
		$(TARGET_DIR)/usr/sbin/chumby_card_reader_daemon
endef

$(eval $(generic-package))
