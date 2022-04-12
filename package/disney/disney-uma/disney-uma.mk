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

define _DISNEY_UMA_INSTALL
       @echo "Installing player library"
       rsync -a $(@D)/partner/prebuilt-libs/$(_DISNEY_UMA_PLATFORM)/stripped/ship/*.so $(1)/usr/lib/
endef

define DISNEY_UMA_INSTALL_STAGING_CMDS
       $(call _DISNEY_UMA_INSTALL, $(STAGING_DIR))
endef

define DISNEY_UMA_INSTALL_TARGET_CMDS
       $(call _DISNEY_UMA_INSTALL, $(TARGET_DIR))
endef

$(eval $(generic-package))