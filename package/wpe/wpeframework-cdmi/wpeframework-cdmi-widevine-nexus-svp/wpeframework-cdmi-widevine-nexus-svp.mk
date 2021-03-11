################################################################################
#
# wpeframework-cdmi-widevine-nexus-svp
#
################################################################################

WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_VERSION = bd7cb7b2e4bddd18f978ccab67342dfecf28755a
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE_METHOD = git
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_SITE = https://code.rdkcentral.com/r/soc/broadcom/components/rdkcentral/OCDM-Widevine-Nexus-SVP
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_INSTALL_STAGING = NO
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES = wpeframework-clientlibraries

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_DEPENDENCIES += bcm-refsw
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_WIDEVINE_VERSION_14),y)
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_CONF_OPTS += -DCENC_VERSION=14
endif
ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_WIDEVINE_VERSION_15),y)
WPEFRAMEWORK_CDMI_WIDEVINE_NEXUS_SVP_CONF_OPTS += -DCENC_VERSION=15
endif

$(eval $(cmake-package))
