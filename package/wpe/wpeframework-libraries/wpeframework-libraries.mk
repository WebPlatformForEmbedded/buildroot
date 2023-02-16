################################################################################
#
# wpeframework-libraries
#
################################################################################
WPEFRAMEWORK_LIBRARIES_VERSION = 1c3dd1677c8c50e9582e5e0027fdf5a2c2b79abb
WPEFRAMEWORK_LIBRARIES_SITE_METHOD = git
WPEFRAMEWORK_LIBRARIES_SITE = git@github.com:WebPlatformForEmbedded/ThunderLibraries.git
WPEFRAMEWORK_LIBRARIES_INSTALL_STAGING = YES
WPEFRAMEWORK_LIBRARIES_DEPENDENCIES = wpeframework

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROADCAST),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBROADCAST=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BROADCAST_SI_PARSING),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBROADCAST_SI_PARSING=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH),y)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += -DBLUETOOTH=ON
WPEFRAMEWORK_LIBRARIES_DEPENDENCIES += bluez5_utils
endif

$(eval $(cmake-package))
