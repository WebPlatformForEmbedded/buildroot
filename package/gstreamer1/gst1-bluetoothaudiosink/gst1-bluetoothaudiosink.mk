################################################################################
#
# gst-bluetoohaudiosink
#
################################################################################

GST1_BLUETOOTHAUDIOSINK_VERSION = 5ca928e8cebca5158659741578ca02a2422091e6
GST1_BLUETOOTHAUDIOSINK_SITE = git@github.com:WebPlatformForEmbedded/gstbluetoothaudiosink.git
GST1_BLUETOOTHAUDIOSINK_SITE_METHOD = git
GST1_BLUETOOTHAUDIOSINK_INSTALL_STAGING = YES
GST1_BLUETOOTHAUDIOSINK_DEPENDENCIES = gstreamer1 wpeframework-clientlibraries

$(eval $(cmake-package))
