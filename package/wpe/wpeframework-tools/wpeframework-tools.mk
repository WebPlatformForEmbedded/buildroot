################################################################################
#
# wpeframework-tools
#
################################################################################
HOST_WPEFRAMEWORK_TOOLS_VERSION = 5d0e8030575dc649cb90dd2d65ca37ada8862ca7
HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,ThunderTools,$(HOST_WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref


ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
HOST_WPEFRAMEWORK_TOOLS_CONF_OPTS += \
	-DGENERIC_CMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

$(eval $(host-cmake-package))
