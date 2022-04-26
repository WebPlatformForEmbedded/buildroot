################################################################################
#
# Disney+ ADK
#
################################################################################

DISNEY_VERSION = 63d553b8b38d96b7a1093939f0058c4ada4ee39f
DISNEY_SITE = git@github.com:Metrological/disneyplus-adk.git
DISNEY_SITE_METHOD = git
DISNEY_LICENSE = PROPRIETARY
DISNEY_INSTALL_STAGING = YES
DISNEY_DEPENDENCIES = libgles libegl

_DISNEY_TARGET_NAME = undefined
_DISNEY_PLATFORM_TYPE = undefined
_DISNEY_PLAYER = null
DISNEY_LIBOPENSSL_SO_VERSION =

ifeq ($(BR2_PACKAGE_DISNEY_TARGET_WPE),y)
_DISNEY_TARGET_NAME = wpe
_DISNEY_PLATFORM_TYPE = stb_mtk
DISNEY_DEPENDENCIES += wpeframework-clientlibraries gstreamer1 gst1-plugins-base gst1-plugins-good
endif

ifeq ($(BR2_PACKAGE_DISNEY_PLAYER_UMA),y)
_DISNEY_PLAYER = nve-shared
_DISNEY_CURL_HTTP = --curl-http2
DISNEY_DEPENDENCIES += disney-uma
endif

ifeq ($(BR2_PACKAGE_DISNEY_LIBOPENSSL),y)
# Using own SSL lib?
DISNEY_DEPENDENCIES += disney-libopenssl
else
DISNEY_DEPENDENCIES += libopenssl
endif

_DISNEY_BUILD_TYPE = debug
ifeq ($(BR2_PACKAGE_DISNEY_BUILD_RELEASE),y)
_DISNEY_BUILD_TYPE = release-o2
else ifeq ($(BR2_PACKAGE_DISNEY_BUILD_PRODUCTION),y)
_DISNEY_BUILD_TYPE = ship
endif

ifeq ($(BR2_PACKAGE_DISNEY_VERBOSE),y)
_DISNEY_VERBOSE = verbose=1
endif

ifeq ($(findstring 64,$(KERNEL_ARCH)),64)
_DISNEY_TARGET_ARCH = $(KERNEL_ARCH)_64
else
_DISNEY_TARGET_ARCH = $(KERNEL_ARCH)_32
endif

_DISNEY_TARGET_PLATFORM = $(_DISNEY_TARGET_NAME)_linux_$(_DISNEY_PLATFORM_TYPE)_$(_DISNEY_TARGET_ARCH)
_DISNEY_BUILD_CONFIG = $(_DISNEY_BUILD_TYPE)_$(_DISNEY_TARGET_PLATFORM)

ifeq ($(BR2_PACKAGE_DISNEY_LINK_EXECUTABLE),y)
define _DISNEY_INSTALL_MERLIN
       $(INSTALL) -D -m 0755 $(@D)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/merlin $(TARGET_DIR)/usr/bin/merlin
endef
endif

ifeq ($(BR2_PACKAGE_DISNEY_LINK_LIBRARY),y)
define _DISNEY_INSTALL_M5
       @echo "Installing M5 library"
       $(INSTALL) -D -m 0755 $(@D)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/*.so $(1)/usr/lib/
endef
endif

ifeq ($(BR2_PACKAGE_DISNEY_LINK_TESTS),y)
define _DISNEY_INSTALL_TESTS
       @echo "Installing unit tests resources..."
       $(INSTALL) -D -m 0755 $(@D)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/tests $(TARGET_DIR)/usr/bin/merlin-tests
       mkdir -p -p $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/bin $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/tests $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/target $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/source/adk/manifest/examples $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       touch $(TARGET_DIR)$(_DISNEY_DATA_DIR)/.gitignore
endef

_DISNEY_DATA_DIR = /usr/share/WPEFramework/DisneyPlus

define _DISNEY_INSTALL_RESOURCES
       @echo "Installing resources..."
       mkdir -p $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/certs $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/assets $(TARGET_DIR)$(_DISNEY_DATA_DIR)
       rsync -a $(@D)/resource $(TARGET_DIR)$(_DISNEY_DATA_DIR)
endef
endif

define DISNEY_CONFIGURE_CMDS
       cd $(@D) && CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" GCC_PREFIX="$(TARGET_CROSS)" PLATFORM="$(_DISNEY_TARGET_PLATFORM)" \
          ARCH="$(KERNEL_ARCH)" SSL_VERSION="$(DISNEY_LIBOPENSSL_SO_VERSION)" SYSINCLUDEDIR="$(STAGING_DIR)/usr/include" \
              SYSLIBDIR="$(STAGING_DIR)/usr/lib" \
                 ./premake5 --verbose --target=$(_DISNEY_TARGET_NAME) --player=$(_DISNEY_PLAYER) $(_DISNEY_CURL_HTTP) gmake2
endef

define DISNEY_BUILD_CMDS
       @echo ----------------------------------------------------------------------------
       @echo Building Disney ADK target $(_DISNEY_BUILD_TYPE)_$(_DISNEY_TARGET_PLATFORM)
       @echo ----------------------------------------------------------------------------
       cd $(@D)/build && make config=$(_DISNEY_BUILD_CONFIG) $(_DISNEY_VERBOSE)
endef

define DISNEY_INSTALL_STAGING_CMDS
       @echo "Installing binaries..."
       $(call _DISNEY_INSTALL_M5, $(STAGING_DIR))
endef

define DISNEY_INSTALL_TARGET_CMDS
       @echo "Installing binaries..."
       $(call _DISNEY_INSTALL_MERLIN)
       $(call _DISNEY_INSTALL_M5, $(TARGET_DIR))
       $(call _DISNEY_INSTALL_TESTS)
       $(call _DISNEY_INSTALL_RESOURCES)
endef

$(eval $(generic-package))

include package/disney/*/*.mk
