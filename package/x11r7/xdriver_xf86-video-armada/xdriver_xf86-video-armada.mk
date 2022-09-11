################################################################################
#
# xdriver_xf86-video-armada
#
################################################################################

XDRIVER_XF86_VIDEO_ARMADA_VERSION = e9bef412176c571dd8f1ae6ba069c9c37da48835
XDRIVER_XF86_VIDEO_ARMADA_SITE = $(call github,dougg3,xf86-video-armada,$(XDRIVER_XF86_VIDEO_ARMADA_VERSION))
XDRIVER_XF86_VIDEO_ARMADA_AUTORECONF = YES
XDRIVER_XF86_VIDEO_ARMADA_DEPENDENCIES = \
	libdrm-armada \
	xserver_xorg-server

# This package depends on a few files from the etna_viv repository,
# but it's not worth creating a package for it, because nothing actually
# ends up installed from it. So just download it as part of this package.
XDRIVER_XF86_VIDEO_ARMADA_ETNA_VIV_VERSION = 100009142dc24f2383525a334f7b25e883cf3d4d
XDRIVER_XF86_VIDEO_ARMADA_EXTRA_DOWNLOADS += \
	$(call github,etnaviv,etna_viv,$(XDRIVER_XF86_VIDEO_ARMADA_ETNA_VIV_VERSION))/etna_viv-$(XDRIVER_XF86_VIDEO_ARMADA_ETNA_VIV_VERSION).tar.gz

XDRIVER_XF86_VIDEO_ARMADA_LICENSE_FILES = COPYING etna_viv/LICENSE

# Extract etna_viv source files for driver
define XDRIVER_XF86_VIDEO_ARMADA_ETNASRC
	mkdir $(@D)/etna_viv
	$(call suitable-extractor,$(notdir $(XDRIVER_XF86_VIDEO_ARMADA_EXTRA_DOWNLOADS))) \
		$(XDRIVER_XF86_VIDEO_ARMADA_DL_DIR)/$(notdir $(XDRIVER_XF86_VIDEO_ARMADA_EXTRA_DOWNLOADS)) | \
	$(TAR) --strip-components=1 -C $(@D)/etna_viv $(TAR_OPTIONS) -
        mkdir $(@D)/m4
endef

XDRIVER_XF86_VIDEO_ARMADA_POST_EXTRACT_HOOKS += XDRIVER_XF86_VIDEO_ARMADA_ETNASRC

define XDRIVER_XF86_VIDEO_ARMADA_INSTALL_CONF_FILE
        $(INSTALL) -m 0644 -D $(@D)/conf/xorg-sample.conf $(TARGET_DIR)/etc/X11/xorg.conf
endef

XDRIVER_XF86_VIDEO_ARMADA_POST_INSTALL_TARGET_HOOKS += XDRIVER_XF86_VIDEO_ARMADA_INSTALL_CONF_FILE


XDRIVER_XF86_VIDEO_ARMADA_CONF_OPTS = --with-etnaviv-source=$(@D)/etna_viv

$(eval $(autotools-package))
