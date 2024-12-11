################################################################################
#
# westeros
#
################################################################################
WESTEROS_VERSION = 3cd00f708479652a5ffecc7f220993352447edf9
WESTEROS_SITE_METHOD = git
WESTEROS_SITE = https://code.rdkcentral.com/r/components/opensource/westeros
WESTEROS_INSTALL_STAGING = YES

WESTEROS_DEPENDENCIES = host-pkgconf host-autoconf wayland \
	libxkbcommon westeros-simpleshell westeros-simplebuffer westeros-soc gstreamer1

WESTEROS_CONF_OPTS = \
	--prefix=/usr/ \
	--enable-rendergl=yes \
	--enable-sbprotocol=yes \
	--enable-ldbprotocol=yes \
	--enable-xdgv5=yes \
	--enable-app=yes \
	--enable-test=yes \
	--enable-player=yes

ifeq ($(BR2_PACKAGE_WESTEROS_ESSOS), y)
WESTEROS_CONF_OPTS += \
	--enable-essos=yes
else
WESTEROS_CONF_OPTS += \
	--disable-essos
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -I${STAGING_DIR}/usr/include/interface/vmcs_host/linux"
	WESTEROS_LDFLAGS += -lEGL -lGLESv2 -lbcm_host
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
	WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_NEXUS"
	WESTEROS_CONF_ENV += \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR) 
	WESTEROS_CONF_OPTS += \
		--enable-vc5=yes \
		CFLAGS="$(TARGET_CFLAGS) -I${STAGING_DIR}/usr/include/refsw/" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -I${STAGING_DIR}/usr/include/refsw/"
	WESTEROS_MAKE_OPTS += \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR) \
		$(BCM_REFSW_MAKE_ENV)	
ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
	WESTEROS_DEPENDENCIES += wayland-egl-bnxs  bcm-refsw
endif
else ifeq ($(BR2_PACKAGE_LIBDRM),y)
	WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_DRM"
	WESTEROS_CONF_ENV += LDFLAGS="-L$(@D)/.libs -lEGL -lGLESv2"
endif # BR2_PACKAGE_WESTEROS_SOC_RPI


define WESTEROS_RUN_AUTORECONF
        cd $(@D) && $(HOST_DIR)/usr/bin/autoreconf --force --install
endef
WESTEROS_PRE_CONFIGURE_HOOKS += WESTEROS_RUN_AUTORECONF

define WESTEROS_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/protocol
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/linux-dmabuf/protocol
	$(WESTEROS_MAKE_OPTS) \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(WESTEROS_LDFLAGS)
endef

define WESTEROS_INSTALL_STAGING_CMDS
	cp -a $(@D)/.libs/*.so* $(STAGING_DIR)/usr/lib/
	cp -a $(@D)/*.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	cp -a $(@D)/*.h $(STAGING_DIR)/usr/include
	cp -a $(@D)/protocol/*.h $(STAGING_DIR)/usr/include
	cp -a $(@D)/essos/essos*.h $(STAGING_DIR)/usr/include
	cp -a $(@D)/essos/.libs/*.so* $(STAGING_DIR)/usr/lib/ 
endef

define WESTEROS_INSTALL_TARGET_CMDS
	cp -a $(@D)/.libs/*.so* $(TARGET_DIR)/usr/lib/
	cp -a $(@D)/essos/.libs/*.so* $(TARGET_DIR)/usr/lib/
endef

$(eval $(autotools-package))
