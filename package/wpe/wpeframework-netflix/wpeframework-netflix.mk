################################################################################
#
# wpeframework-netflix
#
################################################################################

WPEFRAMEWORK_NETFLIX_VERSION = 9735202436138fd1438d47cdd5e17618290990ff

ifeq ($(BR2_PACKAGE_NETFLIX5),y)
# Netflix 5 has a little different API, use "netflix5" branch for now.
WPEFRAMEWORK_NETFLIX_VERSION = ca237132a3ce7d6be01fbe941fdf9a65bebc2c42
endif

WPEFRAMEWORK_NETFLIX_SITE_METHOD = git
WPEFRAMEWORK_NETFLIX_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginNetflix.git
WPEFRAMEWORK_NETFLIX_INSTALL_STAGING = YES
WPEFRAMEWORK_NETFLIX_DEPENDENCIES = wpeframework 

ifeq ($(BR2_PACKAGE_NETFLIX5_LIB),y)
WPEFRAMEWORK_NETFLIX_DEPENDENCIES = netflix5
endif

ifeq ($(BR2_PACKAGE_NETFLIX_LIB),y)
WPEFRAMEWORK_NETFLIX_DEPENDENCIES = netflix
endif


WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_NETFLIX_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
# WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

# TODO: Do not have WPEFRAMEWORK versioning yet
# WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_NETFLIX_VERSION="$(WEBBRIDGE_BUILD_VERSION)-dev"

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_AUTOSTART),y)
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_AUTOSTART=true
else
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_AUTOSTART=false
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_MODEL),)
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_MODEL="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_MODEL))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_SUSPEND_TIMEOUT),)
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_SUSPENDTIMEOUT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_SUSPEND_TIMEOUT))"
endif

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_RESUME_TIMEOUT),)
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_RESUMETIMEOUT="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_RESUME_TIMEOUT))"
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_NETFLIX_FULLHD),y)
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_FULLHD=true
else
WPEFRAMEWORK_NETFLIX_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_FULLHD=false
endif

$(eval $(cmake-package))

