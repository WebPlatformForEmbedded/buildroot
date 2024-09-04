################################################################################
#
# gstreamer1-full
#
################################################################################

GSTREAMER1_FULL_VERSION = 1.24.8
GSTREAMER1_FULL_INSTALL_STAGING = YES
GSTREAMER1_FULL_LICENSE_FILES = COPYING
GSTREAMER1_FULL_LICENSE = LGPL-2.0+, LGPL-2.1+
GSTREAMER1_FULL_SOURCE = gstreamer-$(GSTREAMER1_FULL_VERSION).tar.bz2
GSTREAMER1_FULL_SITE = "https://gitlab.freedesktop.org/gstreamer/gstreamer/-/archive/$(GSTREAMER1_FULL_VERSION)/"
BR_NO_CHECK_HASH_FOR += $(GSTREAMER1_FULL_SOURCE)

GSTREAMER1_FULL_EXTRA_COMPILER_OPTIONS =
ifeq ($(BR2_PACKAGE_GSTREAMER1_FULL_SYMBOLS),y)
GSTREAMER1_FULL_EXTRA_COMPILER_OPTIONS += -g
ifeq ($(BR2_PACKAGE_GSTREAMER1_FULL_NO_OPTIMIZATIONS),y)
GSTREAMER1_FULL_EXTRA_COMPILER_OPTIONS += -O0
endif
endif

BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_WEBRTC = y

# FIXME: we could be more granular with the libraries based on WPE features (e.g. mpegts & transcoder).
GST_FULL_LIBRARIES = gstreamer-base-1.0 \
    gstreamer-pbutils-1.0 \
    gstreamer-app-1.0 \
    gstreamer-allocators-1.0 \
    gstreamer-tag-1.0 \
    gstreamer-video-1.0 \
    gstreamer-audio-1.0 \
    gstreamer-transcoder-1.0 \
    gstreamer-mpegts-1.0 \
    gstreamer-fft-1.0 \
    gstreamer-codecparsers-1.0

ifeq ($(BR2_PACKAGE_GST1_FULL_PLUGINS_BASE_LIB_OPENGL_GLES2),y)
GST_FULL_LIBRARIES += gstreamer-gl-1.0
endif

ifeq ($(BR2_PACKAGE_GST1_FULL_PLUGINS_BAD_PLUGIN_WEBRTC),y)
GST_FULL_LIBRARIES += gstreamer-webrtc-1.0 gstreamer-sdp-1.0 gstreamer-rtp-1.0
endif

empty :=
space := $(empty) $(empty)
comma := ,
GST_FULL_LIBRARIES := $(subst $(space),$(comma),$(GST_FULL_LIBRARIES))

# FIXME: --wrap-mode=default here is because currently we still need to download subprojects at build time for gstreamer1-full
# like e.g. libnice. We should instead apply a post-extract hook to download only the subprojects we want and leave the rest
# to be used as dependencies in buildroot.
GSTREAMER1_FULL_CONF_OPTS = \
    --bindir=bin/gstreamer-full-1.0 \
    --libdir=lib/gstreamer-full-1.0 \
    --includedir=include/gstreamer-full-1.0 \
    --libexecdir=libexec/gstreamer-full-1.0 \
    --wrap-mode=default \
    --default-library=static \
    -Dauto_features=disabled \
    -Dintrospection=disabled \
    -Dtools=enabled \
    -Dges=disabled \
    -Dlibav=disabled \
    -Dgpl=enabled \
    -Dgst-full=enabled \
    -Dgst-full-libraries=${GST_FULL_LIBRARIES} \
    -Dgstreamer:registry=false \
    -Dgstreamer:gst_debug=true \
    -Dgstreamer:option-parsing=true \
    -Dgst-plugins-base:app=enabled \
    -Dgst-plugins-base:gio=enabled \
    -Dgst-plugins-base:playback=enabled \
    -Dgst-plugins-base:audioconvert=enabled \
    -Dgst-plugins-base:audioresample=enabled \
    -Dgst-plugins-base:audiomixer=enabled \
    -Dgst-plugins-base:audiotestsrc=enabled \
    -Dgst-plugins-base:videoconvertscale=enabled \
    -Dgst-plugins-base:videotestsrc=enabled \
    -Dgst-plugins-base:volume=enabled \
    -Dgst-plugins-base:opus=enabled \
    -Dgst-plugins-base:typefind=enabled \
    -Dgst-plugins-good:autodetect=enabled \
    -Dgst-plugins-good:audioparsers=enabled \
    -Dgst-plugins-good:audiofx=enabled \
    -Dgst-plugins-good:deinterlace=enabled \
    -Dgst-plugins-good:interleave=enabled \
    -Dgst-plugins-good:id3demux=enabled \
    -Dgst-plugins-good:isomp4=enabled \
    -Dgst-plugins-good:matroska=enabled \
    -Dgst-plugins-bad:videoparsers=enabled \
    -Dgst-plugins-bad:videofilters=enabled \
    -Dgst-plugins-bad:opus=enabled \
    -Dgst-plugins-bad:dash=enabled \
    -Dgst-plugins-bad:faad=enabled \
    -Dgst-plugins-bad:hls=enabled \
    -Dgst-plugins-bad:hls-crypto=openssl \
    -Dgst-plugins-bad:webp=enabled \
    -Dgst-plugins-bad:subenc=enabled \
    -Dgst-plugins-bad:debugutils=enabled

ifeq ($(BR2_PACKAGE_GST1_FULL_PLUGINS_BASE_LIB_OPENGL_GLES2),y)
GSTREAMER1_FULL_CONF_OPTS += -Dgst-plugins-base:gl=enabled
else
GSTREAMER1_FULL_CONF_OPTS += -Dgst-plugins-base:gl=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_FULL_PLUGINS_BAD_PLUGIN_WEBRTC),y)
GSTREAMER1_FULL_CONF_OPTS += -Dlibnice=enabled \
    -Dlibnice:crypto-library=openssl \
    -Dwebrtc=enabled \
    -Dgst-plugins-good:rtp=enabled \
    -Dgst-plugins-bad:webrtc=enabled \
    -Dgst-plugins-bad:dtls=enabled \
    -Dgst-plugins-bad:sctp=enabled \
    -Dgst-plugins-bad:srtp=enabled \
    -Dgst-plugins-good:rtpmanager=enabled
else
GSTREAMER1_FULL_CONF_OPTS += -Dlibnice=disabled \
    -Dwebrtc=disabled \
    -Dgst-plugins-good:rtp=disabled \
    -Dgst-plugins-bad:webrtc=disabled \
    -Dgst-plugins-bad:dtls=disabled \
    -Dgst-plugins-bad:sctp=disabled \
    -Dgst-plugins-bad:srtp=disabled \
    -Dgst-plugins-good:rtpmanager=disabled
endif

GSTREAMER1_FULL_DEPENDENCIES = \
    host-bison \
    host-flex \
    host-pkgconf \
    libglib2 \
    libxml2 \
    libopenssl \
    faad2 \
    webp \
    $(if $(BR2_PACKAGE_LIBUNWIND),libunwind) \
    $(if $(BR2_PACKAGE_VALGRIND),valgrind) \
    $(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_GST1_FULL_PLUGINS_BAD_PLUGIN_WEBRTC),y)
GSTREAMER1_FULL_DEPENDENCIES += libsrtp
endif

GSTREAMER1_FULL_CFLAGS = $(TARGET_CFLAGS) $(GSTREAMER1_FULL_EXTRA_COMPILER_OPTIONS)
# TODO: -ldl is due to a build failure in libnice/stund. We should fix there sometime.
GSTREAMER1_FULL_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS) -ldl

# We postfix the staging directories with `gstreamer-full-1.0` to avoid conflicts with the system's gstreamer.
# Symlink to the postfixed library location to avoid needing to append to LD_LIBRARY_PATH.
GSTREAMER1_FULL_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_FULL_SYMLINK_LIB
define GSTREAMER1_FULL_SYMLINK_LIB
    ln -sfr $(TARGET_DIR)/usr/lib/gstreamer-full-1.0/libgstreamer-full-1.0.so $(TARGET_DIR)/usr/lib/libgstreamer-full-1.0.so
endef

$(eval $(meson-package))
