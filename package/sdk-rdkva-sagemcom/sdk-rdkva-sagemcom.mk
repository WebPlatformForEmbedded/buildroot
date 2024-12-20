################################################################################
#
# sdk-rdkva-sagemcom
#
################################################################################

SDK_RDKVA_SAGEMCOM_VERSION = fd400d2c979d63fbb17a272a9b0bc530ccbae974
SDK_RDKVA_SAGEMCOM_SITE = git@github.com:Metrological/SDK_RDKVA_Sagemcom.git
SDK_RDKVA_SAGEMCOM_SITE_METHOD = git
SDK_RDKVA_SAGEMCOM_INSTALL_STAGING = YES
SDK_RDKVA_SAGEMCOM_INSTALL_TARGET = NO

define SDK_RDKVA_SAGEMCOM_INSTALL_STAGING_CMDS
	cp -r $(@D)/usr/* $(STAGING_DIR)/usr/
endef

#define SDK_RDKVA_SAGEMCOM_INSTALL_TARGET_CMDS
#	cp -r $(@D)/usr/lib/* $(STAGING_DIR)/usr/lib/
#endef

$(eval $(generic-package))
