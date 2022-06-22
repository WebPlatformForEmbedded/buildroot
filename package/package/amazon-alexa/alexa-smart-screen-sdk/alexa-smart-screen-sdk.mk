################################################################################
#
# alexa-smart-screen-sdk
#
################################################################################

ALEXA_SMART_SCREEN_SDK_VERSION = v2.9.0
ALEXA_SMART_SCREEN_SDK_SITE =  $(call github,alexa,alexa-smart-screen-sdk,$(ALEXA_SMART_SCREEN_SDK_VERSION))
ALEXA_SMART_SCREEN_SDK_LICENSE = Apache-2.0
ALEXA_SMART_SCREEN_SDK_LICENSE_FILES = LICENSE.txt
ALEXA_SMART_SCREEN_SDK_INSTALL_STAGING = YES
ALEXA_SMART_SCREEN_SDK_DEPENDENCIES = host-cmake host-nodejs apl-client-library avs-device-sdk rapidjson
# SDK requires out of source building (SRCDIR != BUILDDIR)
ALEXA_SMART_SCREEN_SDK_SUPPORTS_IN_SOURCE_BUILD = NO

define ALEXA_SMART_SCREEN_SDK_EXTRACT_CMDS
	$(TAR) --strip-components=1 $(TAR_OPTIONS) $(ALEXA_SMART_SCREEN_SDK_DL_DIR)/$(ALEXA_SMART_SCREEN_SDK_SOURCE) -C $(@D)
endef

ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DAPL_CORE=ON 
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DAPL_CLIENT_INSTALL_PATH=$(STAGING_DIR)/usr
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DWEBSOCKETPP_INCLUDE_DIR=$(STAGING_DIR)/usr/include/websocketpp
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DAPL_CLIENT_JS_PATH=$(STAGING_DIR)/usr/share/apl-client-js

ifeq ($(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_BUILD_TYPE_DEBUG),y)
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DCMAKE_BUILD_TYPE=DEBUG
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DDISABLE_WEBSOCKET_SSL=ON
else ifeq ($(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_BUILD_TYPE_RELEASE),y)
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DCMAKE_BUILD_TYPE=RELEASE
endif

ifeq ($(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_USE_GSTREAMER),y)
ALEXA_SMART_SCREEN_SDK_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad gst1-libav
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DGSTREAMER_MEDIA_PLAYER=ON
endif

ifeq ($(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_MICROPHONE_BACKEND_PORTAUDIO),y)
ALEXA_SMART_SCREEN_SDK_DEPENDENCIES += portaudio
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DPORTAUDIO=ON
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DPORTAUDIO_LIB_PATH=$(TARGET_DIR)/usr/lib/libportaudio.so
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DPORTAUDIO_INCLUDE_DIR=$(STAGING_DIR)/usr/include
endif

ifeq ($(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_ENABLE_JS_GUICLIENT),y)
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DJS_GUICLIENT_ENABLE=ON
ALEXA_SMART_SCREEN_SDK_CONF_OPTS += -DJS_GUICLIENT_INSTALL_PATH="$(TARGET_DIR)/$(call qstrip,$(BR2_PACKAGE_ALEXA_SMART_SCREEN_SDK_JS_GUICLIENT_INSTALL_PATH))"
endif

$(eval $(cmake-package))
