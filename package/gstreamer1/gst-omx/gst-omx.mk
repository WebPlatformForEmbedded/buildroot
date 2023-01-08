################################################################################
#
# gst-omx
#
################################################################################

GST_OMX_VERSION = 1.16.2

ifeq ($(BR2_PACKAGE_GSTREAMER1_16),y)
GST_OMX_VERSION = 1.16.2
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1_18),y)
GST_OMX_VERSION = 1.18.6
endif

GST_OMX_SOURCE = gst-omx-$(GST_OMX_VERSION).tar.xz
GST_OMX_SITE = https://gstreamer.freedesktop.org/src/gst-omx

GST_OMX_LICENSE = LGPL-2.1
GST_OMX_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_GSTREAMER1_GIT),y)
GST_OMX_SOURCE = gst-omx-$(GST_OMX_VERSION).tar.bz2
GST_OMX_SITE = "https://gitlab.freedesktop.org/gstreamer/gst-omx/-/archive/$(GST_OMX_VERSION)/"
BR_NO_CHECK_HASH_FOR += $(GST_OMX_SOURCE)
GST_OMX_POST_DOWNLOAD_HOOKS += GSTREAMER1_COMMON_DOWNLOAD
GST_OMX_POST_EXTRACT_HOOKS += GSTREAMER1_COMMON_EXTRACT
GST_OMX_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES
GST_OMX_AUTORECONF = YES
GST_OMX_AUTORECONF_OPTS = -I $(@D)/common/m4
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
GST_OMX_VARIANT = rpi
ifeq ($(BR2_PACKAGE_GSTREAMER1_16),y)
GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-I$(STAGING_DIR)/usr/include/IL \
		-I$(STAGING_DIR)/usr/include/interface/vcos/pthreads \
		-I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"
else
GST_OMX_CONF_OPTS += -Dheader_path=$(STAGING_DIR)/usr/include/IL
endif
else ifeq ($(BR2_PACKAGE_BELLAGIO),y)
GST_OMX_VARIANT = bellagio
GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-DOMX_VERSION_MAJOR=1 \
		-DOMX_VERSION_MINOR=1 \
		-DOMX_VERSION_REVISION=2 \
		-DOMX_VERSION_STEP=0"
else
GST_OMX_VARIANT = generic
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1_16),y)
GST_OMX_CONF_OPTS += --with-omx-target=$(GST_OMX_VARIANT)
else
GST_OMX_CONF_OPTS += -Dtarget=$(GST_OMX_VARIANT)
endif

GST_OMX_DEPENDENCIES = gstreamer1 gst1-plugins-base libopenmax

# adjust library paths to where buildroot installs them
define GST_OMX_FIXUP_CONFIG_PATHS
	find $(@D)/config -name gstomx.conf | \
		xargs $(SED) 's|/usr/local|/usr|g' -e 's|/opt/vc|/usr|g'
endef

GST_OMX_POST_PATCH_HOOKS += GST_OMX_FIXUP_CONFIG_PATHS

GST_OMX_CFLAGS = $(TARGET_CFLAGS) $(GSTREAMER1_EXTRA_COMPILER_OPTIONS)

ifeq ($(BR2_PACKAGE_GSTREAMER1_16),y)
$(eval $(autotools-package))
else
$(eval $(meson-package))
endif
