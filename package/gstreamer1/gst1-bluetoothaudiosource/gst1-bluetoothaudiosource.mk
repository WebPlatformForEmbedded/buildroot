################################################################################
#
# gst-bluetoohaudiosource
#
################################################################################

GST1_BLUETOOTHAUDIOSOURCE_VERSION = 868ba262fa402c5657818adc3f447eb1dedb91dc
GST1_BLUETOOTHAUDIOSOURCE_SITE = git@github.com:WebPlatformForEmbedded/gstbluetoothaudiosource.git
GST1_BLUETOOTHAUDIOSOURCE_SITE_METHOD = git
GST1_BLUETOOTHAUDIOSOURCE_INSTALL_STAGING = YES
GST1_BLUETOOTHAUDIOSOURCE_DEPENDENCIES = gstreamer1 wpeframework-clientlibraries

$(eval $(cmake-package))
