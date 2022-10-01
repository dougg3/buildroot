################################################################################
#
# chumby8tscal
#
################################################################################

CHUMBY8TSCAL_VERSION = 289bb711967b66b674d753d67b28e6f2bb05a863
CHUMBY8TSCAL_SITE = $(call github,dougg3,Chumby8TSCal,$(CHUMBY8TSCAL_VERSION))
CHUMBY8TSCAL_LICENSE = GPL-3.0+

# To install, copy the program to /usr/bin
define CHUMBY8TSCAL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/Chumby8TSCal \
		$(TARGET_DIR)/usr/bin/Chumby8TSCal
endef

$(eval $(qmake-package))
