GST1_BLUETOOTHAUDIOSINK_VERSION = 6019efe30dc0db009d18876c15f49a8fe2d86635
GST1_BLUETOOTHAUDIOSINK_SITE = git@github.com:WebPlatformForEmbedded/gstbluetoothaudiosink.git
GST1_BLUETOOTHAUDIOSINK_SITE_METHOD = git
GST1_BLUETOOTHAUDIOSINK_INSTALL_STAGING = YES
GST1_BLUETOOTHAUDIOSINK_DEPENDENCIES = gstreamer1 wpeframework-clientlibraries

$(eval $(cmake-package))