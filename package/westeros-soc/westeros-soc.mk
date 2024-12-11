################################################################################
#
# westeros-soc
#
################################################################################

WESTEROS_SOC_VERSION = 3cd00f708479652a5ffecc7f220993352447edf9
WESTEROS_SOC_SITE_METHOD = git
WESTEROS_SOC_SITE = https://code.rdkcentral.com/r/components/opensource/westeros
WESTEROS_SOC_INSTALL_STAGING = YES

WESTEROS_SOC_DEPENDENCIES = host-pkgconf host-autoconf wayland libegl

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLATFORM),y)
	WESTEROS_SOC_DEPENDENCIES += wpeframework-platform
endif

WESTEROS_SOC_CONF_OPTS += \
	--prefix=/usr/ \
	--disable-silent-rules \
	--disable-dependency-tracking \

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	WESTEROS_SOC_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/interface/vmcs_host/linux/"
	WESTEROS_SOC_SUBDIR = rpi
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
	WESTEROS_SOC_MAKE_ENV += \
		$(BCM_REFSW_MAKE_ENV) \
		REFSW_VERSION="$(STAGING_DIR)/usr/share/wayland-egl" \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)
	WESTEROS_SOC_CONF_OPTS += \
		--enable-vc5 \
		--enable-nxclient_local=no \
		CFLAGS="$(TARGET_CFLAGS) -I${STAGING_DIR}/usr/include/refsw/ -I$(STAGING_DIR)/usr/share/wayland-egl" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -DEMBEDDED_SETTOP_BOX=1 -DPLATFORM_HAS_NEXUS=1 -DFORCE_1080 -I${STAGING_DIR}/usr/include/refsw/"
	WESTEROS_SOC_SUBDIR = brcm
ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
	WESTEROS_SOC_DEPENDENCIES += wayland-egl-bnxs bcm-refsw
endif
else ifeq ($(BR2_PACKAGE_LIBDRM),y)
ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4),y)
	WESTEROS_DRM_CARD=/dev/dri/card1
else
	WESTEROS_DRM_CARD=/dev/dri/card0
endif
	WESTEROS_SOC_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -DDEFAULT_CARD=\\\"$(WESTEROS_DRM_CARD)\\\" -I $(STAGING_DIR)/usr/include/libdrm"
	WESTEROS_SOC_SUBDIR = drm
	WESTEROS_SOC_DEPENDENCIES += libdrm
endif

define WESTEROS_SOC_RUN_AUTORECONF
	cd $(@D)/$(WESTEROS_SOC_SUBDIR) && $(HOST_DIR)/usr/bin/autoreconf --force --install
endef
WESTEROS_SOC_PRE_CONFIGURE_HOOKS += WESTEROS_SOC_RUN_AUTORECONF

define WESTEROS_SOC_ENTER_BUILD_DIR
	cd $(@D)/$(WESTEROS_SOC_SUBDIR)
endef

WESTEROS_SOC_PRE_BUILD_HOOKS += WESTEROS_SOC_ENTER_BUILD_DIR

define WESTEROS_SOC_REMOVE_LA
   rm $(STAGING_DIR)/usr/lib/libwesteros_gl.la
endef

WESTEROS_SOC_POST_INSTALL_STAGING_HOOKS += WESTEROS_SOC_REMOVE_LA

$(eval $(autotools-package))
