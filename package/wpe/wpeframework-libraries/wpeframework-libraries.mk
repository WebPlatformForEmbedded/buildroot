################################################################################
#
# wpeframework-libraries
#
################################################################################
WPEFRAMEWORK_LIBRARIES_VERSION = R4.4.1
WPEFRAMEWORK_LIBRARIES_SITE = $(call github,WebPlatformForEmbedded,ThunderLibraries,$(WPEFRAMEWORK_LIBRARIES_VERSION))
WPEFRAMEWORK_LIBRARIES_INSTALL_STAGING = YES
WPEFRAMEWORK_LIBRARIES_DEPENDENCIES = wpeframework

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
WPEFRAMEWORK_LIBRARIES_CONF_OPTS += \
       -DCMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

$(eval $(cmake-package))
