################################################################################
#
# wpeframework-plugins
#
################################################################################
WPEFRAMEWORK_PLUGINS_VERSION = 428c5e0b6107cd770657a421a1a62d7a83bbf647
WPEFRAMEWORK_PLUGINS_SITE = $(call github,rdkcentral,ThunderNanoServices,$(WPEFRAMEWORK_PLUGINS_VERSION))
WPEFRAMEWORK_PLUGINS_INSTALL_STAGING = YES
WPEFRAMEWORK_PLUGINS_DEPENDENCIES = wpeframework wpeframework-interfaces wpeframework-clientlibraries libpng

# wpeframework-netflix binary package config
WPEFRAMEWORK_PLUGINS_OPKG_NAME = "wpeframework-plugins"
WPEFRAMEWORK_PLUGINS_OPKG_VERSION = "1.0.0"
WPEFRAMEWORK_PLUGINS_OPKG_ARCHITECTURE = "${BR2_ARCH}"
WPEFRAMEWORK_PLUGINS_OPKG_MAINTAINER = "Metrological"
WPEFRAMEWORK_PLUGINS_OPKG_DESCRIPTION = "WPEFramework plugins"

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += \
       -DCMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLUGINS_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS=ON

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLUGIN_NAME),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_NAME=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLUGIN_NAME)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUTOSTART=false
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_PERSISTENT_ROOT_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_PERSISTENT_PATH)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLATFORM_RPI3),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_PLATFORM="rpi3"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLATFORM_CUSTOM),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_PLATFORM=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLATFORM_CUSTOM_VALUE)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_DATA_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_DATA_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_DATA_PATH)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_ALEXA_CLIENT_CONFIG),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ALEXA_CLIENT_CONFIG=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_ALEXA_CLIENT_CONFIG))
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ALEXA_CLIENT_CONFIG="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_DATA_PATH))/$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLUGIN_NAME))/AlexaClientSDKConfig.json"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_SMART_SCREEN_CONFIG),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_SMART_SCREEN_CONFIG=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_SMART_SCREEN_CONFIG))
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_SMART_SCREEN_CONFIG="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_DATA_PATH))/$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLUGIN_NAME))/SmartScreenSDKConfig.json"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_NONE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="NONE"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_CRITICAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="CRITICAL"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_ERROR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="ERROR"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_WARN),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="WARN"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_DEBUG0),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="DEBUG0"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_LOG_LEVEL_DEBUG9),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_LOG_LEVEL="DEBUG9"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE_PORTAUDIO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUDIOSOURCE="PORTAUDIO"
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += portaudio
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE_BLRC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUDIOSOURCE="BluetoothRemoteControl"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE_CUSTOM),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUDIOSOURCE=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE_CUSTOM_VALUE)
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_AUDIOSOURCE=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_AUDIOSOURCE)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_ENABLE_SMART_SCREEN_SUPPORT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_SMART_SCREEN_SUPPORT=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += alexa-smart-screen-sdk
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_ENABLE_SMART_SCREEN),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_SMART_SCREEN=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_SMART_SCREEN=false
endif
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_SMART_SCREEN_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_ENABLE_KWD_SUPPORT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_KWD_SUPPORT=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += alexa-pryon-kwd
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_ENABLE_KWD),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_KWD=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_KWD=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_KWD_MODELS_PATH),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_KWD_MODELS_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_AVS_CUSTOM_KWD_MODELS_PATH)
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_KWD_MODELS_PATH="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_DATA_PATH))/$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_AVS_PLUGIN_NAME))/models"
endif
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_AVS_ENABLE_KWD_SUPPORT=OFF
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_AUTOSTART=false
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_SERVER_ADDRESS=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_SERVER_ADDRESS)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_SERVER_PORT=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_SERVER_PORT)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_CUSTOMER=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_CUSTOMER)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_PLATFORM=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_PLATFORM)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_COUNTRY=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_COUNTRY)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_TYPE=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_TYPE)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_SESSION=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_SESSION)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_CALLSIGN_MAPPING=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_CALLSIGN_MAPPING)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BACKOFFICE_STATE_MAPPING=$(BR2_PACKAGE_WPEFRAMEWORK_BACKOFFICE_STATE_MAPPING)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CECCONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_CECCONTROL=ON
ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DCEC_DEVICE_ADAPTER_IMPLEMENTATION=Nexus
else ifeq ($(BR2_PACKAGE_PLATCO_TV_BSP),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DCEC_DEVICE_ADAPTER_IMPLEMENTATION=Amlogic
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DCEC_DEVICE_ADAPTER_IMPLEMENTATION=Linux
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += cobalt
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COBALT_STARBOARD_CONFIGURATION_INCLUDE="third_party/starboard/wpe/shared/configuration_public.h"
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_AUTOSTART=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_OUTOFPROCESS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_OUTOFPROCESS=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_OUTOFPROCESS=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_USER),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_USER=$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_USER)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_GROUP),"")
WPEFRAMEWORK_COBALT_USER_GROUP=cobalt
else
WPEFRAMEWORK_COBALT_USER_GROUP=$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_GROUP)")
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP),"")
WPEFRAMEWORK_CDMI_GROUP=,$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP)")
endif
WPEFRAMEWORK_COBALT_USER=$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_USER)") -1 $(WPEFRAMEWORK_COBALT_USER_GROUP) -1 * - - $(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_PLATFORM_VIDEO_DEVICE_GROUP)"),$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_GROUP)")$(WPEFRAMEWORK_CDMI_GROUP) cobalt
WPEFRAMEWORK_COBALT_PERMISSION=$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_DATA_PATH)")/Cobalt r 0550 root $(subst ",,$(WPEFRAMEWORK_COBALT_USER_GROUP)") - - - - -
endif
ifneq ($(WPEFRAMEWORK_COBALT_USER_GROUP),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_GROUP=$(WPEFRAMEWORK_COBALT_USER_GROUP)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_SINGLE_PLAYBACKRATE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_PLAYBACKRATES=false
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_RESOLUTION_720P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_RESOLUTION=720p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_RESOLUTION_1080P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_RESOLUTION=1080p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_RESOLUTION_2160P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_RESOLUTION=2160p
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_OPERATOR_NAME),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_OPERATOR_NAME=$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_OPERATOR_NAME)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_SCOPE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_SCOPE=$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_SCOPE)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COBALT_SECRET),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COBALT_SECRET=$(BR2_PACKAGE_WPEFRAMEWORK_COBALT_SECRET)
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMMANDER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMMANDER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEVICEINFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DSRESOLUTION),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DSRESOLUTION=ON
ifeq ($(BR2_PACKAGE_DSRESOLUTION_WITH_DUMMY_DSHAL), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DDSRESOLUTION_WITH_DUMMY_DSHAL=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_720P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=720p
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_1080P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=1080p50Hz
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_RESOLUTION_2160P),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_RESOLUTION=2160p50Hz
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DHCPSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DHCPSERVER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER=ON

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_HAS_YOUTUBE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_ENABLE_YOUTUBE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_MODE_ACTIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_MODE="active"
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_CALLSIGN),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_CALLSIGN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_CALLSIGN))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_MODE_PASSIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_MODE="passive"
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_YOUTUBE_RUNTIMECHANGE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_RUNTIMECHANGE=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_YOUTUBE_RUNTIMECHANGE=false
endif
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NAME))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETFLIX),y)

ifeq ($(BR2_PACKAGE_NETFLIX5_1),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNETFLIX_VERSION_5_1=true
endif
ifeq ($(BR2_PACKAGE_NETFLIX52),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNETFLIX_VERSION_5_2=true
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_ENABLE_NETFLIX=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_MODE_ACTIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_MODE="active"
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_CALLSIGN),"")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_CALLSIGN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_CALLSIGN))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DIALSERVER_NETFLIX_MODE_PASSIVE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DIALSERVER_NETFLIX_MODE="passive"
endif
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DICTIONARY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_DICTIONARY=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PIN),)
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_PIN=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PIN}
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_CALLSIGN=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_CALLSIGN}
    WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PAIRING_PRODUCER=${BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PAIRING_PRODUCER}
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_IOCONNECTOR_PINS='$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_IOCONNECTOR_PINS))'
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_INPUTSWITCH),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_INPUTSWITCH=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EGLTEST),y)
WPEFRAMEWORK_COMMON_CONF_OPTS += -DPLUGIN_EGLTEST=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_FRONTPANEL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_FRONTPANEL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_NETWORKCONTROL),y)
ifeq ($(BR2_TARGET_GENERIC_NETWORK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETWORKCONTROL_SYSTEM_NETWORK=ON
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETWORKCONTROL=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_NETWORKCONTROL_INTERFACES='$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_NETWORKCONTROL_INTERFACES))'
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH),y)
#Prevent switching bluetooth to ttyS0
export BLUETOOTH=1
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH_BAUDRATE_HIGH),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_BAUDRATE=921600
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_BAUDRATE=115200
endif
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-libraries
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_AUTOSTART=true
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTH_PERSISTMAC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_PERSISTMAC=true
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTH_OOP=false
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += bluez5_utils
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHREMOTECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHREMOTECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_LATENCY=${BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_LATENCY}
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_CODECSBC), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_LQ),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=LQ
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_MQ),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=MQ
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_HQ),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=HQ
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_CODECSBC_PRESET_XQ),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_CODECSBC_PRESET=XQ
endif
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += sbc
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_SDPSERVICE), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_NAME=${BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_SDPSERVICE_NAME}
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_DESCRIPTION=${BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_SDPSERVICE_DESCRIPTION}
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_BLUETOOTHAUDIOSINK_SDPSERVICE_PROVIDER=${BR2_PACKAGE_WPEFRAMEWORK_BLUETOOTHAUDIOSINK_SDPSERVICE_PROVIDER}
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DREMOTECONTROL_IMPLEMENTATION_REPOSITORY=https://github.com/WebPlatformForEmbedded/RemoteControl-brcm
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_DEVINPUT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_DEVINPUT=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += udev
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_IR=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR_CODEMASK),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CODEMASK="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IR_CODEMASK))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CUSTOM_VIRTUAL_NAME="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL_NAME))"
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_REMOTECONTROL_CUSTOM_VIRTUAL_MAP_FILE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_CUSTOM_VIRTUAL_MAP_FILE))"
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_RESOURCEMONITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_RESOURCEMONITOR=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SNAPSHOT),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += libpng
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SNAPSHOT=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DSNAPSHOT_IMPLEMENTATION_REPOSITORY=git@github.com:WebPlatformForEmbedded/Snapshot-brcm.git
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCHBOARD),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCHBOARD=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCHBOARD_DEFAULT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCHBOARD_DEFAULT=$(BR2_PACKAGE_WPEFRAMEWORK_SWITCHBOARD_DEFAULT)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCH_AMAZON),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCH_AMAZON=ON
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCH_COBALT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCH_COBALT=ON
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCH_NETFLIX),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCH_NETFLIX=ON
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_SWITCH_WEBKITBROWSER),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SWITCH_WEBKITBROWSER=ON
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SYSTEMCOMMANDS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SYSTEMCOMMANDS=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_FILETRANSFER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_FILETRANSFER=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_FIRMWARECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_FIRMWARECONTROL=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += mfr-library
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TESTCONTROLLER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TESTCONTROLLER=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLEJSONRPC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_JSONRPC=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLE_DYNAMIC_LOADING),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DEXAMPLE_DYNAMICLOADING=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLE_DYNAMIC_LOADING_YIN),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DEXAMPLE_DYNAMICLOADING_YIN=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLE_DYNAMIC_LOADING_YIN_OOP),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YIN_MODE="Local"
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YIN_MODE="Off"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLE_DYNAMIC_LOADING_YANG),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DEXAMPLE_DYNAMICLOADING_YANG=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_EXAMPLE_DYNAMIC_LOADING_YANG_OOP),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YANG_MODE="Local"
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_YANG_MODE="Off"
endif
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OUTOFPROCESSTEST),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_OUTOFPROCESS=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TESTUTILITY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TESTUTILITY=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TIMESYNC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TIMESYNC=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TIMESYNC_DEFFERED),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_TIMESYNC_DEFFERED=ON
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VOLUMECONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_VOLUMECONTROL=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DVOLUMECONTROL_IMPLEMENTATION_REPOSITORY=git@github.com:WebPlatformForEmbedded/VolumeControl-brcm.git
endif

ifeq ($(BR2_PACKAGE_PLUGIN_RTSPCLIENT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_RTSPCLIENT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA=ON
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += parodus libparodus tinyxml
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_AUTOSTART=true
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_SERVICE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_SERVICE=true
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PINGWAITTIME=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PINGWAITTIME)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_WEBPAURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_WEBPAURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PARODUSLOCALURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PARODUSLOCALURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_PARTENRID=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_PARTENRID)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_BACKOFFMAX=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_BACKOFFMAX)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CERTPATH=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CERTPATH)
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_GENERIC_ADAPTER), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_GENERIC_ADAPTER=true
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_GENERICCLIENTURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_GENERICCLIENTURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_DATAMODELFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_DATAMODELFILE)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_NOTIFYCONFIGFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_NOTIFYCONFIGFILE)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_DEVICE_INFO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_DEVICE_INFO=true
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += procps-ng
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP=true
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += parodus2ccsp ccspcr
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_CLIENTURL=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSPCLIENTURL)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_CONFIGFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP_CONFIGFILE)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPA_CCSP_DATAFILE=$(BR2_PACKAGE_WPEFRAMEWORK_WEBPA_CCSP_DATAFILE)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBPROXY),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_PATH=$(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PATH)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PORT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_PORT=$(BR2_PACKAGE_WPEFRAMEWORK_WEBSERVER_PORT)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PORT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_BRIDGE_PORT=80
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSERVER_BRIDGE_PORT=$(BR2_PACKAGE_WPEFRAMEWORK_PORT)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WEBSHELL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WEBSHELL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_WIFICONTROL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_WIFICONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PERFORMANCE_MONITOR), y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PERFORMANCEMONITOR=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOPIN),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_GPIOPIN=$(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOPIN)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOTYPE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_POWER_GPIOTYPE=$(BR2_PACKAGE_WPEFRAMEWORK_POWER_GPIOTYPE)
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGINPROCESSCONTAINERS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSCONTAINERS=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGINPROCESSCONTAINERS_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSCONTAINERS_AUTOSTART=true
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR_AUTOSTART=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_EXITTIMEOUT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_PROCESSMONITOR_EXITTIMEOUT=${BR2_PACKAGE_WPEFRAMEWORK_PROCESSMONITOR_EXITTIMEOUT}
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_DECODERS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_DECODERS))
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += wpeframework-libraries
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=A
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_B),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=B
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_ANNEX_C),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=C
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_CABLE_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_CABLE_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_ANNEX=A
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_SATELLITE_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_SATELLITE_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL),y)
PLUGIN_STREAMER_IMPLEMENTATIONS += QAM
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL_ANNEX_A),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_ANNEX=A
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_ANNEX=NoAnnex
endif
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TERRESTRIAL_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TERRESTRIAL_FRONTENDS))
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_TS_SCANNING),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_TS_SCANNING=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_HOME_TS=$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_HOME_TS)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_DVB),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=DVB
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_ATSC),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=ATSC
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_BROADCAST_STANDARD_ISDB),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_BROADCAST_STANDARD=ISDB
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP), y)
PLUGIN_STREAMER_IMPLEMENTATIONS += Aamp
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_AAMP_FRONTENDS=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP_FRONTENDS))
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_STREAMER_AAMP_USE_WESTEROS_SINK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_AAMP_WESTEROSSINK=ON
endif
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += gst1-aamp
endif
ifeq (${BR2_PACKAGE_WPEFRAMEWORK_STREAMER_CENC}, y)
PLUGIN_STREAMER_IMPLEMENTATIONS += CENC
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += gstreamer1 gst1-cencdecrypt gst1-plugins-base gst1-plugins-good
endif
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_STREAMER_IMPLEMENTATIONS="$(PLUGIN_STREAMER_IMPLEMENTATIONS)"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SPARK),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += spark
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SPARK_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=false
endif

WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_LINUX=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_WPEFRAMEWORK=ON
else ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLATFORM_WAYLAND_EGL=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_RPCLINK),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_RPCLINK=ON
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR=ON
ifneq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNEXUS_SERVER_HAS_EXTENDED_INIT=OFF
endif
ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += westeros
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SUB_IMPLEMENTATION=Westeros
else ifeq ($(BR2_PACKAGE_WESTON),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += weston
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SUB_IMPLEMENTATION=Weston
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_WESTON_OUTPUT_CONFIGS='$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_WESTON_OUTPUT_CONFIGS))'
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_WESTON_TTY_LIST='$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_WESTON_TTY_LIST))'
else ifeq  ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_PLUGINS_DEPENDENCIES += bcm-refsw
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DCOMPOSITOR_IMPLEMENTATION_REPOSITORY=git@github.com:WebPlatformForEmbedded/Compositor-brcm.git
else ifeq  ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DCOMPOSITOR_IMPLEMENTATION_REPOSITORY=git@github.com:WebPlatformForEmbedded/Compositor-brcm.git
else ifeq  ($(BR2_PACKAGE_RPI_FIRMWARE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IMPLEMENTATION=RPI
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_GROUP), "")
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_CONNECTOR="/tmp/compositor|0770"
endif
else
$(error Missing a compositor implemtation, please provide one or disable PLUGIN_COMPOSITOR)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_OUTOFPROCESS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_OUTOFPROCESS=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_AUTOSTART),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=true
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_AUTOSTART=false
endif
ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_NXSERVER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_NEXUS_SERVER_EXTERNAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DNEXUS_SERVER_EXTERNAL=ON
else
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_IRMODE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_IRMODE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_IRMODE))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_BOXMODE),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_BOXMODE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_BOXMODE))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_SAGE_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SAGE_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_PAK_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_PAK_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_PAK_PATH))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_DRM_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_DRM_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_DRM_PATH))"
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_NONE),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="None"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_VIDEO),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="Video"
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SVP_ALL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_SVP="All"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX2),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_GFX2="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_GFX2))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_RESTRICTED),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_RESTRICTED="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_RESTRICTED))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_MAIN),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_MAIN="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_MAIN))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_EXPORT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_EXPORT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_EXPORT))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_SECUREGFX),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_SECUREGFX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_SECUREGFX))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_CLIENT),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_MEMORY_CLIENT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_MEMORY_CLIENT))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_HDCP1XBIN_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_HDCP1XBIN_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_HDCP1XBIN_PATH))"
endif
ifneq ($(BR2_PACKAGE_BCM_REFSW_HDCP2XBIN_PATH),)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_HDCP2XBIN_PATH="$(call qstrip,$(BR2_PACKAGE_BCM_REFSW_HDCP2XBIN_PATH))"
endif


ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=false
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_ALLOW_UNAUTHENTICATED_CLIENTS=true
endif
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_VIRTUALINPUT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_NEXUS_SERVER_EXTERNAL),y)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_HARDWAREREADY=0
else
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DPLUGIN_COMPOSITOR_HARDWAREREADY=${BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_HARDWAREREADY}
endif

define WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
    rm -rf $(TARGET_DIR)/usr/include/WPEFramework
endef

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_INSTALL_HEADERS),y)
WPEFRAMEWORK_PLUGINS_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
endif

endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CREATE_IPKG_TARGETS),y)
$(call SIMPLE_OPKG_TOOLS_CREATE_CPACK_METADATA,WPEFRAMEWORK_PLUGINS)
WPEFRAMEWORK_PLUGINS_CONF_OPTS += -DWPEFRAMEWORK_CREATE_IPKG_TARGETS=ON
WPEFRAMEWORK_PLUGINS_CONF_OPTS += ${WPEFRAMEWORK_PLUGINS_OPKG_CPACK_METADATA}

WPEFRAMEWORK_PLUGINS_POST_BUILD_HOOKS += SIMPLE_OPKG_TOOLS_MAKE_PACKAGE
WPEFRAMEWORK_PLUGINS_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_PLUGINS_INSTALL_IPKG_CMDS

define WPEFRAMEWORK_PLUGINS_INSTALL_IPKG_CMDS
    $(eval PACKAGE_NAME_PREFIX := ${WPEFRAMEWORK_PLUGINS_OPKG_NAME}_${WPEFRAMEWORK_PLUGINS_OPKG_VERSION}_${WPEFRAMEWORK_PLUGINS_OPKG_ARCHITECTURE})
    $(call SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE,${@D}/${PACKAGE_NAME_PREFIX}-WPEFrameworkWebKitBrowser.deb)
    $(call SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE,${@D}/${PACKAGE_NAME_PREFIX}-WPEInjectedBundle.deb)

    $(call SIMPLE_OPKG_TOOLS_REMOVE_FROM_TARGET)
endef # WPEFRAMEWORK_PLUGINS_INSTALL_TARGET_CMDS

endif # ($(BR2_PACKAGE_WPEFRAMEWORK_CREATE_IPKG_TARGETS),y)

define WPEFRAMEWORK_PLUGINS_USERS
	${WPEFRAMEWORK_COBALT_USER}
endef

define WPEFRAMEWORK_PLUGINS_PERMISSIONS
	${WPEFRAMEWORK_COBALT_PERMISSION}
endef

$(eval $(cmake-package))
