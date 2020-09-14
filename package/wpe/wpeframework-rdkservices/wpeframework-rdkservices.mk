################################################################################
#
# wpeframework-rdkservices
#
################################################################################

WPEFRAMEWORK_RDKSERVICES_VERSION = 6c0e1991d22bc8f8a44b9d7e702c75491cd2f7c2
WPEFRAMEWORK_RDKSERVICES_SITE = $(call github,rdkcentral,rdkservices,$(WPEFRAMEWORK_RDKSERVICES_VERSION))
WPEFRAMEWORK_RDKSERVICES_INSTALL_STAGING = YES
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES = wpeframework

WPEFRAMEWORK_RDKSERVICES_OPKG_NAME = "wpeframework-rdkservices"
WPEFRAMEWORK_RDKSERVICES_OPKG_VERSION = "1.0.0"
WPEFRAMEWORK_RDKSERVICES_OPKG_ARCHITECTURE = "${BR2_ARCH}"
WPEFRAMEWORK_RDKSERVICES_OPKG_MAINTAINER = "Metrological"
WPEFRAMEWORK_RDKSERVICES_OPKG_DESCRIPTION = "WPEFramework rdkservices"

WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_RDKSERVICES_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_DEBUG),y)
        WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_TYPE=Debug
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_DEBUG_OPTIMIZED),y)
        WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_TYPE=DebugOptimized
else ifeq ($( BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_RELEASE_WITH_SYMBOLS),y)
        WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_TYPE=ReleaseSymbols
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_RELEASE),y)
        WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_TYPE=Release
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_BUILD_TYPE_PRODUCTION),y)
        WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DBUILD_TYPE=Production
endif

WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DCOMCAST_CONFIG=OFF

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEVICEINFO),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_MONITOR=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_WEBKIT),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_WEBKITBROWSER=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_WEBKIT}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_YOUTUBE),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_YOUTUBE=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_YOUTUBE_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_YOUTUBE}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_COBALT),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_COBALT=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_COBALT_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_COBALT}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_AMAZON),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_AMAZON_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_AMAZON}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_APPS),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_APPS=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_APPS_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_APPS}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_UX),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_WEBKITBROWSER_UX=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_UX_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_UX}
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_MONITOR_NETFLIX),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_NETFLIX=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_NETFLIX_MEMORYLIMIT=${BR2_PACKAGE_WPEFRAMEWORK_MONITOR_NETFLIX}
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_TRACECONTROL),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_TRACECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_LOCATIONSYNC),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_LOCATIONSYNC=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_LOCATIONSYNC_URI=${BR2_PACKAGE_WPEFRAMEWORK_LOCATIONSYNC_URI}
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI=ON
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_AUTOSTART=true
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_OOP=true
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_KEYBOX),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_WIDEVINE_KEYBOX="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_KEYBOX))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_DEVICE_CERTIFICATE),"")
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += \
    -DPLUGIN_OPENCDMI_WIDEVINE_DEVICE_CERTIFICATE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_DEVICE_CERTIFICATE))"
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_USER),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_USER=$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_USER)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP),)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_GROUP=$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_GROUP)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_CLEARKEY),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_CLEARKEY=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-clearkey
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-playready
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-playready-nexus
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_NEXUS_SVP),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_NEXUS=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-playready-nexus-svp
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_SECURE_STOP_METERING_CERTIFICATE),"")
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_METERING_CERTIFICATE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_SECURE_STOP_METERING_CERTIFICATE))"
endif
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_PLAYREADY_VGDRM),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_PLAYREADY_VGDRM=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-playready-vgdrm
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_WIDEVINE=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-widevine
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DOPENCDMI_WIDEVINE_NEXUS_SVP=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-widevine-nexus-svp
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_NAGRA),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_NAGRA=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-nagra
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDMI_NCAS),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_OPENCDMI_NCAS=ON
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += wpeframework-cdmi-ncas
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_MESSENGER),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_MESSENGER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_SECURITYAGENT),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_SECURITYAGENT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PACKAGER),y)
WPEFRAMEWORK_RDKSERVICES_DEPENDENCIES += opkg
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_PACKAGER=ON
endif

ifeq  ($(BR2_PACKAGE_WPEFRAMEWORK_DEVICEIDENTIFICATION),y)
WPEFRAMEWORK_RDKSERVICES_CONF_OPTS += -DPLUGIN_DEVICEIDENTIFICATION=ON
endif

$(eval $(cmake-package))
