WPEFRAMEWORK_SNAPSHOT_VERSION = bdd3b1c2426bc03e832a72269d6218c10256a490
WPEFRAMEWORK_SNAPSHOT_SITE_METHOD = git
WPEFRAMEWORK_SNAPSHOT_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_SNAPSHOT_INSTALL_STAGING = YES
WPEFRAMEWORK_SNAPSHOT_DEPENDENCIES = WPEFramework rpi-userland

$(eval $(cmake-package))

