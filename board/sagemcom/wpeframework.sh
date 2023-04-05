#!/bin/sh

export SOURCE=/mnt
export LD_LIBRARY_PATH=$SOURCE/usr/lib:$SOURCE/lib:/lib:/usr/lib:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs:$SOURCE/usr/lib/wpe-webkit-1.0
export PATH=$SOURCE/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

export SAGEBIN_PATH=/usr/bin/
export GST_VIRTUAL_DISP_WIDTH=1920
export GST_VIRTUAL_DISP_HEIGHT=1080
export GST_VIRTUAL_SD_DISP_WIDTH=1920
export GST_VIRTUAL_SD_DISP_HEIGHT=1080
export GST_VIDEO_WINDOW_BOX_MODE='y'
export GST_ENABLE_SVP=1
export XDG_RUNTIME_DIR=/run
export LD_PRELOAD=libwayland-client.so.0:libwayland-egl.so.1:libnxclient.so:libsrai.so:libwidevine_tl.so:liboemcrypto_tl.so:libplayready30pk.so

if [ ! -f /usr/bin/drm.bin ]; then
        ln -s /usr/bin/widevine.bin /usr/bin/drm.bin
fi

if [ ! -d /usr/libexec/wpe-webkit-1.0 ]; then
	ln -s $SOURCE/usr/libexec/wpe-webkit-1.0 /usr/libexec/wpe-webkit-1.0
fi
if [ ! -d /usr/lib/wpe-webkit-1.0 ]; then
	ln -s $SOURCE/usr/lib/wpe-webkit-1.0 /usr/lib/wpe-webkit-1.0
fi

cd /usr/bin/
$SOURCE/usr/bin/WPEFramework -c $SOURCE/etc/WPEFramework/config.json &

