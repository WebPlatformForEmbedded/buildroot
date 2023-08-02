################################################################################
#
# gst-bluetoohaudiosink
#
################################################################################

GST1_BLUETOOTHAUDIOSINK_VERSION = 3b1db2f42b4aab2df0e121fbfc1f09f5444ef969
GST1_BLUETOOTHAUDIOSINK_SITE = git@github.com:WebPlatformForEmbedded/gstbluetoothaudiosink.git
GST1_BLUETOOTHAUDIOSINK_SITE_METHOD = git
GST1_BLUETOOTHAUDIOSINK_INSTALL_STAGING = YES
GST1_BLUETOOTHAUDIOSINK_DEPENDENCIES = gstreamer1 wpeframework-clientlibraries

$(eval $(cmake-package))
