################################################################################
#
# libamazon
#
################################################################################

LIBAMAZON_VERSION = a3793513e0456ecbdf334ae7bb5a973ef5b6031a
LIBAMAZON_SITE_METHOD = git
LIBAMAZON_SITE = git@github.com:Metrological/libamazon.git
LIBAMAZON_LICENSE = PROPRIETARY
LIBAMAZON_REDISTRIBUTE = NO
LIBAMAZON_INSTALL_STAGING = YES

LIBAMAZON_DEPENDENCIES = zlib jpeg libcurl libpng wpeframework gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad

$(eval $(cmake-package))
