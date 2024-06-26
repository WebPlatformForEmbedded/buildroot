################################################################################
#
# wpebackend-fdo
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38),y)
WPEBACKEND_FDO_VERSION = 1.14.0
else
WPEBACKEND_FDO_VERSION = 1.4.1
endif

WPEBACKEND_FDO_SITE = https://wpewebkit.org/releases
WPEBACKEND_FDO_SOURCE = wpebackend-fdo-$(WPEBACKEND_FDO_VERSION).tar.xz
WPEBACKEND_FDO_INSTALL_STAGING = YES
WPEBACKEND_FDO_LICENSE = BSD-2-Clause
WPEBACKEND_FDO_LICENSE_FILES = COPYING
WPEBACKEND_FDO_DEPENDENCIES = libglib2 wpebackend wayland

$(eval $(cmake-package))
