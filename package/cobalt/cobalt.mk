################################################################################
#
# COBALT
#
################################################################################

COBALT_VERSION = a772cccf1da68623f3312bb8466860e2d1964f24
COBALT_SITE_METHOD = git
COBALT_SITE = git@github.com:Metrological/cobalt
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = gst1-plugins-good gst1-plugins-bad host-bison host-ninja wpeframework-clientlibraries host-python3 host-python-six host-gn

export COBALT_STAGING_DIR=$(STAGING_DIR)
export COBALT_TOOLCHAIN_PREFIX=$(TARGET_CROSS)
export COBALT_INSTALL_DIR=$(TARGET_DIR)

export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

COBALT_PLATFORM = wpe-arm

ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
COBALT_DEPENDENCIES += gst1-bcm
COBALT_VIDEO_OVERLAY=false
else
COBALT_VIDEO_OVERLAY=true
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
export COBALT_HAS_OCDM=1
else
export COBALT_HAS_OCDM=0
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY),y)
export COBALT_HAS_PROVISION=1
else
export COBALT_HAS_PROVISION=0
endif

ifeq ($(BR2_PACKAGE_WESTON),y)
export COBALT_HAS_WAYLANDSINK=1
COBALT_DEPENDENCIES += weston
else
export COBALT_HAS_WAYLANDSINK=0
endif

ifeq ($(BR2_PACKAGE_COBALT_BUILD_TYPE_QA),y)
	COBALT_BUILD_TYPE = qa
	COBALT_DEPENDENCIES += host-nodejs
else ifeq ($(BR2_PACKAGE_COBALT_BUILD_TYPE_GOLD),y)
	COBALT_BUILD_TYPE = gold
endif

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
export COBALT_EXECUTABLE_TYPE = shared_library
else
export COBALT_EXECUTABLE_TYPE = executable
endif

ifeq ($(BR2_PACKAGE_COBALT_USE_WPEFRAMEWORK_DATA_PATH), y)
export COBALT_DATA_PATH = $(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_INSTALL_PATH)")/Cobalt
COBALT_DATA_INSTALL_PATH = $(TARGET_DIR)/$(COBALT_DATA_PATH)
COBALT_DATA_SRC_PATH = content/data/*
else
COBALT_DATA_INSTALL_PATH = $(TARGET_DIR)/usr/share/
COBALT_DATA_SRC_PATH = content
endif

define COBALT_BUILD_CMDS
    export PYTHONPATH="$(PYTHONPATH):$(@D)"; \
    cd $(@D) && $(HOST_DIR)/usr/bin/gn gen out/wpe --script-executable=python3 --args='target_platform="$(COBALT_PLATFORM)" build_type="$(COBALT_BUILD_TYPE)" target_cpu="arm" is_clang=false sb_install_content_subdir="content/data" is_video_overlay=$(COBALT_VIDEO_OVERLAY)'
    $(HOST_DIR)/usr/bin/ninja -C $(@D)/out/wpe cobalt_install
endef

define COBALT_INSTALL_STAGING_CMDS
    cp -a $(@D)/out/wpe/install/lib/libcobalt.so $(STAGING_DIR)/usr/lib/libcobalt.so
    mkdir -p $(STAGING_DIR)/usr/include/starboard
    cp -a $(@D)/starboard/*.h $(STAGING_DIR)/usr/include/starboard/
    mkdir -p $(STAGING_DIR)/usr/include/third_party/starboard/wpe/shared
    cp -a $(@D)/third_party/starboard/wpe/shared/*.h $(STAGING_DIR)/usr/include/third_party/starboard/wpe/shared/
endef

define COBALT_INSTALL_TARGET_CMDS
    cp -a $(@D)/out/wpe/install/lib/libcobalt.so $(TARGET_DIR)/usr/lib/libcobalt.so
    mkdir -p $(COBALT_DATA_INSTALL_PATH)
    cp -a $(@D)/out/wpe/install/$(COBALT_DATA_SRC_PATH) $(COBALT_DATA_INSTALL_PATH)
endef

$(eval $(generic-package))
