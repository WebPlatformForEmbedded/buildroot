################################################################################
#
# wpeframework-tools
#
################################################################################

WPEFRAMEWORK_TOOLS_VERSION = e22e9e597f8916c752122f87ec0312d7dcf2ab3c

HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,Thunder,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3-jsonref
HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

$(eval $(host-cmake-package))
