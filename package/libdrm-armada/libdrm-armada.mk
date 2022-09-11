################################################################################
#
# libdrm-armada
#
################################################################################

LIBDRM_ARMADA_VERSION = 607c697d7c403356601cd0d5fa6407b61a45e8ed
LIBDRM_ARMADA_SITE = $(call github,dougg3,libdrm-armada,$(LIBDRM_ARMADA_VERSION))
LIBDRM_ARMADA_DEPENDENCIES = libdrm
LIBDRM_ARMADA_INSTALL_STAGING = YES
LIBDRM_ARMADA_AUTORECONF = YES
LIBDRM_ARMADA_LICENSE_FILES = COPYING

# Needed for autoreconf to work properly
define LIBDRM_ARMADA_FIXUP_M4_DIR
        mkdir $(@D)/m4
endef

LIBDRM_ARMADA_POST_PATCH_HOOKS += LIBDRM_ARMADA_FIXUP_M4_DIR

$(eval $(autotools-package))
