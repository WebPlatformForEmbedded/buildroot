WPEFRAMEWORK_LAUNCHER_VERSION = R3.5
WPEFRAMEWORK_LAUNCHER_SITE_METHOD = git
WPEFRAMEWORK_LAUNCHER_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginLauncher.git
WPEFRAMEWORK_LAUNCHER_INSTALL_STAGING = YES
WPEFRAMEWORK_LAUNCHER_DEPENDENCIES = wpeframework wpeframework-interfaces

WPEFRAMEWORK_LAUNCHER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_LAUNCHER_VERSION}

$(eval $(cmake-package))

