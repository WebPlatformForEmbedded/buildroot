################################################################################
#
# wpeframework-interfaces
#
################################################################################
WPEFRAMEWORK_INTERFACES_VERSION = 9e185538c69175e4d027639d77adc7f6430dc29c
WPEFRAMEWORK_INTERFACES_SITE = $(call github,rdkcentral,ThunderInterfaces,$(WPEFRAMEWORK_INTERFACES_VERSION))
WPEFRAMEWORK_INTERFACES_INSTALL_STAGING = YES
WPEFRAMEWORK_INTERFACES_DEPENDENCIES = wpeframework

WPEFRAMEWORK_INTERFACES_OPKG_NAME = "wpeframework-interfaces"
WPEFRAMEWORK_INTERFACES_OPKG_VERSION = "1.0.0"
WPEFRAMEWORK_INTERFACES_OPKG_ARCHITECTURE = "${BR2_ARCH}"
WPEFRAMEWORK_INTERFACES_OPKG_MAINTAINER = "Metrological"
WPEFRAMEWORK_INTERFACES_OPKG_DESCRIPTION = "WPEFramework interfaces"

WPEFRAMEWORK_INTERFACES_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_INTERFACES_VERSION}

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
WPEFRAMEWORK_INTERFACES_CONF_OPTS += \
       -DCMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
WPEFRAMEWORK_INTERFACES_CONF_OPTS += -DCDMI=ON
endif

$(eval $(cmake-package))