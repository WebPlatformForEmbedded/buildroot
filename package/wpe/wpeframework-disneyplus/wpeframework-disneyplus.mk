################################################################################
#
# wpeframework-disneyplus
#
################################################################################

WPEFRAMEWORK_DISNEYPLUS_VERSION = 56301bd58c8ba9b18516eaba602dbd29ced5dd2e
WPEFRAMEWORK_DISNEYPLUS_SITE_METHOD = git
WPEFRAMEWORK_DISNEYPLUS_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginDisneyPlus.git
WPEFRAMEWORK_DISNEYPLUS_INSTALL_STAGING = YES
WPEFRAMEWORK_DISNEYPLUS_DEPENDENCIES = wpeframework disney

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_AUTOSTART),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_AUTOSTART=true
else
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_AUTOSTART=false
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_DEVICE),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_DEVICE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_DEVICE))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VENDOR),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_VENDOR="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VENDOR))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_REGION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_REGION="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_REGION))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_LANGUAGE),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_LANGUAGE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_LANGUAGE))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_ADVERTISING_ID),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_ADVERTISING_ID="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_ADVERTISING_ID))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_GRAPHICS_MODE_720P),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_GRAPHICS_MODE=720p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_GRAPHICS_MODE_1080P),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_GRAPHICS_MODE=1080p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_GRAPHICS_MODE_2160P),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_GRAPHICS_MODE=2160p
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VIDEO_MEMORY),0)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_VIDEO_MEMORY=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VIDEO_MEMORY)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_STACK_SIZE),0)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_STACK_SIZE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_STACK_SIZE)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_PERSONA_ID),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_PERSONA_ID="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_PERSONA_ID))"
endif

ifeq ($(BR2_PACKAGE_DISNEY_TOOLING_SHIELD_ASSISTANT),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_SHIELD_ASSISTANT=ON
else
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_SHIELD_ASSISTANT=OFF
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_MAX_VIDEO_RESOLUTION_SD),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAX_VIDEO_RESOLUTION=sd
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_MAX_VIDEO_RESOLUTION_720P60),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAX_VIDEO_RESOLUTION=720p60
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_MAX_VIDEO_RESOLUTION_1080P60),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAX_VIDEO_RESOLUTION=1080p60
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DISNEYPLUS_MAX_VIDEO_RESOLUTION_2160P60),y)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAX_VIDEO_RESOLUTION=2160p60
endif

WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST = ""
ifeq ($(PLUGIN_DISNEYPLUS_AUDIO_CODECS_AAC),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST)aac
endif
ifeq ($(PLUGIN_DISNEYPLUS_AUDIO_CODECS_AC3),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST)ac3
endif
ifeq ($(PLUGIN_DISNEYPLUS_AUDIO_CODECS_EAC3),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST)eac3
endif
ifeq ($(PLUGIN_DISNEYPLUS_AUDIO_CODECS_ATMOS),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST := $(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST)atmos
endif
ifneq ($(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_AUDIO_CODECS="$(call qstrip,$(WPEFRAMEWORK_DISNEYPLUS_AUDIO_CODECS_LIST))"
endif

WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST = ""
ifeq ($(PLUGIN_DISNEYPLUS_VIDEO_PROFILE_H264_MAIN),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST)h264_main
endif
ifeq ($(PLUGIN_DISNEYPLUS_VIDEO_PROFILE_H264_HIGH),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST)h264_high
endif
ifeq ($(PLUGIN_DISNEYPLUS_VIDEO_PROFILE_HEVC_MAIN),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST)hevc_main
endif
ifeq ($(PLUGIN_DISNEYPLUS_VIDEO_PROFILE_HEVC_MAIN_10),y)
	ifneq ($(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),"")
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),
	endif
	WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST := $(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST)hevc_main_10
endif
ifneq ($(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_VIDEO_PROFILES="$(call qstrip,$(WPEFRAMEWORK_DISNEYPLUS_VIDEO_PROFILES_LIST))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_DISTRIBUTION_PARTNER),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_DISTRIBUTION_PARTNER ="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_DISTRIBUTION_PARTNER))"
endif

ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_DIAL),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_DIAL="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_DIAL))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_DEDICATED_BUTTON),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_DEDICATED_BUTTON="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_DEDICATED_BUTTON))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_DEDICATED_ICON),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_DEDICATED_ICON="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_DEDICATED_ICON))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_APPLICATION_LIST),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_APPLICATION_LIST="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_APPLICATION_LIST))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_INTEGRATED_TILE),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_INTEGRATED_TILE="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_INTEGRATED_TILE))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_SEARCH_RESULT),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_SEARCH_RESULT="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_SEARCH_RESULT))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_SEARCH_CONTINUATION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_SEARCH_CONTINUATION="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_SEARCH_CONTINUATION))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_VOICE_CONTROL),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_VOICE_CONTROL="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_VOICE_CONTROL))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_VOICE_SEARCH_RESULT),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_VOICE_SEARCH_RESULT="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_VOICE_SEARCH_RESULT))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_VISUAL_GESTURE),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_VISUAL_GESTURE="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_VISUAL_GESTURE))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_TOUCH_GESTURE),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_TOUCH_GESTURE="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_TOUCH_GESTURE))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_EPG_GRID),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_EPG_GRID="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_EPG_GRID))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_NUMBER),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_CHANNEL_NUMBER="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_NUMBER))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_ZAP),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_CHANNEL_ZAP="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_ZAP))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_BAR),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_CHANNEL_BAR="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_CHANNEL_BAR))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_WEB_BROWSER),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_WEB_BROWSER="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_WEB_BROWSER))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_POWER_ON),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_POWER_ON="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_POWER_ON))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_POWER_ON_FROM_DEDICATED_BUTTON),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_POWER_ON_FROM_DEDICATED_BUTTON="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_POWER_ON_FROM_DEDICATED_BUTTON))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_POWER_ON),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_POWER_ON="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_POWER_ON))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESTART),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESTART="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESTART))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_RESTART),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_RESTART="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_SUSPENDED_RESTART))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_SCREEN_SAVER),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_SCREEN_SAVER="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_SCREEN_SAVER))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_STANDBY),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_STANDBY="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_FROM_STANDBY))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_BANNER_AD),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESUMED_BANNER_AD="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_BANNER_AD))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_TITLE_RECOMMENDATION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESUMED_TITLE_RECOMMENDATION="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_TITLE_RECOMMENDATION))"
endif
ifneq ($(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_APPLICATION_PROMOTION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_MAPPING_RESUMED_APPLICATION_PROMOTION="$(call qstrip,$(PLUGIN_DISNEYPLUS_MAPPING_RESUMED_APPLICATION_PROMOTION))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_SOFTWARE_NAME),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_SOFTWARE_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_SOFTWARE_NAME))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_SOFTWARE_REVISION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_SOFTWARE_REVISION="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_SOFTWARE_NAME))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_FIRMWARE_VERSION),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_FIRMWARE_VERSION ="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_FIRMWARE_VERSION))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_AUDIO_BUFFER),0)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_AUDIO_BUFFER_SIZE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_AUDIO_BUFFER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VIDEO_BUFFER),0)
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_VIDEO_BUFFER_SIZE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_VIDEO_BUFFER)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_CUSTOM_ARGS),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_CUSTOM_ARGS ="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_CUSTOM_ARGS))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_PERSISTENT_DIR),"")
WPEFRAMEWORK_DISNEYPLUS_CONF_OPTS += -DPLUGIN_DISNEYPLUS_PERSISTENT_DIR ="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_DISNEYPLUS_PERSISTENT_DIR))"
endif



$(eval $(cmake-package))
