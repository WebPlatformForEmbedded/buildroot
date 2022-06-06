################################################################################
#
# Disney+ player
#
################################################################################

DISNEY_UMA_VERSION = 7c4504f33ee8616525517435075eac8a579a377d
DISNEY_UMA_SITE = git@github.com:Metrological/disneyplus-uma.git
DISNEY_UMA_SITE_METHOD = git
DISNEY_UMA_LICENSE = PROPRIETARY
DISNEY_UMA_INSTALL_STAGING = YES
DISNEY_UMA_DEPENDENCIES = libopenssl

_DISNEY_UMA_PLATFORM = *45*

# FIXME
# It is set here as well as in the disney.mk config (which depends on this package)
# It is needed for installing certificates in the correct place
_DISNEY_DATA_DIR = /usr/share/WPEFramework/DisneyPlus

define _DISNEY_UMA_INSTALL_PLAYER
    @echo "Installing player library"
    rsync -a $(@D)/partner/prebuilt-libs/$(_DISNEY_UMA_PLATFORM)/stripped/ship/libnve-api.so $(1)/usr/lib/libnve-api.so
endef

ifeq ($(BR2_PACKAGE_DISNEY_INSTALL_CERTIFICATES),y)
define _DISNEY_UMA_INSTALL_CERTIFICATES
    @echo "Installing tooling certificates"
    mkdir -p "$(TARGET_DIR)$(_DISNEY_DATA_DIR)/shield_runtime/shield_agent_data/certs/client"
    rsync -a  $(@D)/certificates/$(_DISNEY_UMA_PLATFORM)/dss_portal_device.pem "$(TARGET_DIR)$(_DISNEY_DATA_DIR)/shield_runtime/shield_agent_data/certs/client"
endef
endif

define _DISNEY_UMA_INSTALL_PERSONAS
    @echo "Installing personas"
    rsync -a "$(@D)/partner/resource/" "$(TARGET_DIR)/${_DISNEY_DATA_DIR}/resource"
endef

define DISNEY_UMA_INSTALL_STAGING_CMDS
    $(call _DISNEY_UMA_INSTALL_PLAYER, $(STAGING_DIR))
endef

define DISNEY_UMA_INSTALL_TARGET_CMDS
    $(call _DISNEY_UMA_INSTALL_PLAYER, $(TARGET_DIR))
    $(call _DISNEY_UMA_INSTALL_CERTIFICATES)
    $(call _DISNEY_UMA_INSTALL_PERSONAS)
endef

$(eval $(generic-package))