################################################################################
#
# cog
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT_NEXT),y)
COG_VERSION = 0.18.0
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_42),y)
COG_VERSION = 0.18.0
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38),y)
COG_VERSION = 0.16.0
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)
COG_VERSION = 0.14.1
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22),y)
COG_VERSION = 0.6.0
endif

COG_SITE = https://wpewebkit.org/releases
COG_SOURCE = cog-$(COG_VERSION).tar.xz
COG_INSTALL_STAGING = YES
COG_DEPENDENCIES = dbus wpewebkit
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_CONF_OPTS_CMAKE = \
	-DCOG_BUILD_PROGRAMS=ON \
	-DINSTALL_MAN_PAGES=OFF \
	-DCOG_HOME_URI='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))'
COG_CONF_OPTS_MESON = \
	-Ddocumentation=false \
	-Dmanpages=false \
	-Dprograms=true \
	-Dcog_home_uri='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))' \
	-Dplatforms='$(subst $(space),$(comma),$(strip $(COG_PLATFORMS_LIST)))'

# Add the wpebackend-fdo dependency if any of the backends which
# need it have been selected (i.e. the expansion is non-empty.)
ifneq ($(BR2_PACKAGE_COG_PLATFORM_HEADLESS)$(BR2_PACKAGE_COG_PLATFORM_FDO)$(BR2_PACKAGE_COG_PLATFORM_DRM),)
COG_DEPENDENCIES += wpebackend-fdo
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28)$(BR2_PACKAGE_WPEWEBKIT2_38)$(BR2_PACKAGE_WPEWEBKIT2_42)$(BR2_PACKAGE_WPEWEBKIT_NEXT),y)
COG_FDO_PLATFORM_CMAKE_OPTION = COG_PLATFORM_WL
COG_CONF_OPTS_CMAKE += \
	-DCOG_PLATFORM_GTK4=OFF \
	-DCOG_PLATFORM_X11=OFF
else
COG_FDO_PLATFORM_CMAKE_OPTION = COG_PLATFORM_FDO
endif # BR2_PACKAGE_WPEWEBKIT2_38

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22)$(BR2_PACKAGE_WPEWEBKIT2_28)$(BR2_PACKAGE_WPEWEBKIT2_38),y)
ifeq ($(BR2_PACKAGE_LIBSOUP_VERSION_2),y)
COG_CONF_OPTS_CMAKE += -DUSE_SOUP2=ON
COG_CONF_OPTS_MESON += -Dsoup2=enabled
else
COG_CONF_OPTS_CMAKE += -DUSE_SOUP2=OFF
COG_CONF_OPTS_MESON += -Dsoup2=disabled
endif # BR2_PACKAGE_LIBSOUP_VERSION_2
endif

ifeq ($(BR2_PACKAGE_WESTON),y)
COG_CONF_OPTS_CMAKE += -DCOG_WESTON_DIRECT_DISPLAY=ON
COG_CONF_OPTS_MESON += -Dwayland_weston_direct_display=true
COG_DEPENDENCIES += weston
else
COG_CONF_OPTS_CMAKE += -DCOG_WESTON_DIRECT_DISPLAY=OFF
COG_CONF_OPTS_MESON += -Dwayland_weston_direct_display=false
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_HEADLESS),y)
COG_CONF_OPTS_CMAKE += -DCOG_PLATFORM_HEADLESS=ON
COG_PLATFORMS_LIST += headless
else
COG_CONF_OPTS_CMAKE += -DCOG_PLATFORM_HEADLESS=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_CONF_OPTS_CMAKE += -D$(COG_FDO_PLATFORM_CMAKE_OPTION)=ON
COG_PLATFORMS_LIST += wayland
COG_DEPENDENCIES += libxkbcommon wayland-protocols wayland
else
COG_CONF_OPTS_CMAKE += -D$(COG_FDO_PLATFORM_CMAKE_OPTION)=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_DRM),y)
COG_CONF_OPTS_CMAKE += -DCOG_PLATFORM_DRM=ON
COG_PLATFORMS_LIST += drm
COG_DEPENDENCIES += libdrm libinput libgbm libegl udev
else
COG_CONF_OPTS_CMAKE += -DCOG_PLATFORM_DRM=OFF
endif

ifeq ($(BR2_PACKAGE_COG_USE_SYSTEM_DBUS),y)
ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38)$(BR2_PACKAGE_WPEWEBKIT2_42)$(BR2_PACKAGE_WPEWEBKIT_NEXT),y)
COG_DBUS_POLICY_FILE = $(@D)/build/com.igalia.Cog.conf
else
COG_DBUS_POLICY_FILE = $(@D)/com.igalia.Cog.conf
endif
define COG_INSTALL_DBUS_POLICY
	$(RM) $(TARGET_DIR)/etc/dbus-1/systemd.d/com.igalia.Cog.conf
	$(INSTALL) -D -m 0644 $(COG_DBUS_POLICY_FILE) $(TARGET_DIR)/usr/share/dbus-1/system.d/
endef
COG_POST_INSTALL_TARGET_HOOKS += COG_INSTALL_DBUS_POLICY
COG_CONF_OPTS_CMAKE += -DCOG_DBUS_SYSTEM_BUS=ON
COG_CONF_OPTS_MESON += -Dcog_dbus_control=system
else
COG_CONF_OPTS_CMAKE += -DCOG_DBUS_SYSTEM_BUS=OFF
COG_CONF_OPTS_MESON += -Dcog_dbus_control=user
endif # BR2_PACKAGE_COG_USE_SYSTEM_DBUS

# WPE WebKit 2.28 has been patched to use libsoup3, but the pkg-config
# module is still named wpe-webkit-1.0 (instead of -1.1), so patch the
# build system after extracting the tarball.
ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)
define COG_POST_EXTRACT_ADJUST_PKGCONF_REQUIREMENT
	sed -i \
		-e 's/wpe-webkit-1.1/wpe-webkit-1.0/g' \
		-e 's/wpe-webkit-1.0>=[0-9.]\+/wpe-webkit-1.0/g' \
		$(@D)/CMakeLists.txt
endef
COG_POST_EXTRACT_HOOKS += COG_POST_EXTRACT_ADJUST_PKGCONF_REQUIREMENT
endif # BR2_PACKAGE_WPEWEBKIT2_28

define COG_INSTALL_SETTINGS
	$(INSTALL) -D -m 0644 package/cog/websettings.txt $(TARGET_DIR)/root
endef
COG_POST_INSTALL_TARGET_HOOKS += COG_INSTALL_SETTINGS

ifeq ($(BR2_PACKAGE_COG_AUTOSTART),y)
define COG_AUTOSTART
	$(INSTALL) -D -m 0755 package/cog/S90cog $(TARGET_DIR)/etc/init.d
endef
COG_POST_INSTALL_TARGET_HOOKS += COG_AUTOSTART
endif # BR2_PACKAGE_COG_AUTOSTART


ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38)$(BR2_PACKAGE_WPEWEBKIT2_42)$(BR2_PACKAGE_WPEWEBKIT_NEXT),y)
ifeq ($(BR2_PACKAGE_LIBMANETTE),y)
COG_DEPENDENCIES += libmanette
endif
COG_CONF_OPTS = $(COG_CONF_OPTS_MESON)
$(eval $(meson-package))
else # !BR2_PACKAGE_WPEWEBKIT2_38
COG_CONF_OPTS = $(COG_CONF_OPTS_CMAKE)
$(eval $(cmake-package))
endif # BR2_PACKAGE_WPEWEBKIT2_38
