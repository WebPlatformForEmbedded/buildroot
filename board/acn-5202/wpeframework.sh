#!/bin/ash
set -e

SOURCE="/hdd/metrological"

# Native stack disablement
# On some platforms following commands can fail due to missing
# libraries in the path. As a workaround  there is a need to set
# LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"
echo "Disabling native stack..."
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/" /opt/wpe/wpeframework.sh --kill
sleep 1
/etc/init.d/appman.sh stop
/etc/init.d/freecwmp.sh stop
/etc/init.d/udploggerd.sh stop
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/" play --stop || echo "Player already stopped."
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/" play --destroy || echo "Player already destroyed"
sleep 1

procs="WPEFramework WPEProcess WPEWebProcess WPENetworkProcess"
while [ ! -z "$(pidof $procs)" ]; do
        echo "WPE Processes are still running, waiting for exit."
        echo "Perhaps you need to run: kill -9 \$(pidof $procs)"
        sleep 3
done

# create a ref backup
[ ! -d /hdd/wpe.org ] && echo "Creating /opt/wpe.org..." && cp -rf /opt/wpe /hdd/wpe.org

# create /opt/wpe/usr in the $SOURCE for easier binds
mkdir -p "$SOURCE/opt/wpe"
ln -sf "$SOURCE/usr" "$SOURCE/opt/wpe/usr"

DIRS_TO_BIND="\
    /usr/lib/gstreamer-1.0 \
    /etc/WPEFramework \
    /usr/lib/wpeframework \
    /usr/share/WPEFramework \
    /opt/wpe/usr \
"

for bind_name in ${DIRS_TO_BIND}; do
    (grep -q "$bind_name" /proc/mounts && echo "Skipping bind $bind_name -> $SOURCE/$bind_name") \
    || mount --bind "$SOURCE/$bind_name" "$bind_name"
done

echo "Current mounts:"
mount

export SOURCE_KPN=/opt/wpe
export LD_LIBRARY_PATH=$SOURCE_KPN/usr/lib:/lib:/usr/lib:$SOURCE_KPN/lib:$SOURCE/lib:/usr/lib/wpeframework/plugins:/usr/lib/wpeframework/proxystub:/usr/share/WPEFramework/WebKitBrowser/
export PATH=$SOURCE_KPN/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$SOURCE_KPN/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=/usr/lib/gstreamer-1.0

# Needed for community sinks
export GST_VIDEO_WINDOW_BOX_MODE='y'
export GST_VIRTUAL_DISP_WIDTH=1280
export GST_VIRTUAL_DISP_HEIGHT=720
export GST_WPE_COMP='y'

# export XKB_CONFIG_ROOT=$SOURCE/usr/share/X11/xkb
export V3D_DRM_DISABLE=1

echo "Starting WPEFramework"
# Background
# WPEFramework -b -c "/etc/WPEFramework/config.json" &
# Foreground
WPEFramework -c "/etc/WPEFramework/config.json"
echo "Done."
