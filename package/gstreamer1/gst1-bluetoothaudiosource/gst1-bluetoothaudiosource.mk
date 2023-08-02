################################################################################
#
# gst-bluetoohaudiosource
#
################################################################################

GST1_BLUETOOTHAUDIOSOURCE_VERSION = 7db07e3fa8e3bd37d76f5a90c101e80ccb76011c
GST1_BLUETOOTHAUDIOSOURCE_SITE = git@github.com:WebPlatformForEmbedded/gstbluetoothaudiosource.git
GST1_BLUETOOTHAUDIOSOURCE_SITE_METHOD = git
GST1_BLUETOOTHAUDIOSOURCE_INSTALL_STAGING = YES
GST1_BLUETOOTHAUDIOSOURCE_DEPENDENCIES = gstreamer1 wpeframework-clientlibraries

$(eval $(cmake-package))
