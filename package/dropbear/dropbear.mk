################################################################################
#
# dropbear
#
################################################################################

DROPBEAR_VERSION = 2016.74
DROPBEAR_SITE = http://matt.ucc.asn.au/dropbear/releases
DROPBEAR_SOURCE = dropbear-$(DROPBEAR_VERSION).tar.bz2
DROPBEAR_LICENSE = MIT, BSD-2c-like, BSD-2c
DROPBEAR_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_DROPBEAR_PROGRAM),y)
DROPBEAR_TARGET_BINS = dropbearkey dropbearconvert scp
DROPBEAR_PROGRAMS = dropbear $(DROPBEAR_TARGET_BINS)
else #case for BR2_PACKAGE_DROPBEAR_LIB
DROPBEAR_PROGRAMS = dropbear
DROPBEAR_AUTORECONF = YES
define DROPBEAR_APPLY_LOCAL_PATCHES
 # Apply these patches only incase of WPEFramework/DropbearServer plugin is enabled.
 $(APPLY_PATCHES) $(@D) package/dropbear/ *.patch.conditional
endef
DROPBEAR_POST_PATCH_HOOKS += DROPBEAR_APPLY_LOCAL_PATCHES
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_CLIENT),y)
# Build dbclient, and create a convenience symlink named ssh
DROPBEAR_PROGRAMS += dbclient
DROPBEAR_TARGET_BINS += dbclient ssh
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_PROGRAM),y)
DROPBEAR_MAKE = \
        $(MAKE) MULTI=1 SCPPROGRESS=1 \
        PROGRAMS="$(DROPBEAR_PROGRAMS)"
else #case for BR2_PACKAGE_DROPBEAR_LIB
DROPBEAR_MAKE = \
        $(MAKE) DROPBEAR_SHARED_LIB=1
endif

ifeq ($(BR2_STATIC_LIBS),y)
DROPBEAR_MAKE += STATIC=1
endif

define DROPBEAR_FIX_XAUTH
	$(SED) 's,^#define XAUTH_COMMAND.*/xauth,#define XAUTH_COMMAND "/usr/bin/xauth,g' $(@D)/options.h
endef

DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_FIX_XAUTH

define DROPBEAR_ENABLE_REVERSE_DNS
	$(SED) 's:.*\(#define DO_HOST_LOOKUP\).*:\1:' $(@D)/options.h
endef

define DROPBEAR_BUILD_SMALL
	$(SED) 's:.*\(#define NO_FAST_EXPTMOD\).*:\1:' $(@D)/options.h
endef

define DROPBEAR_BUILD_FEATURED
	$(SED) 's:^#define DROPBEAR_SMALL_CODE::' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_BLOWFISH\).*:\1:' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_TWOFISH128\).*:\1:' $(@D)/options.h
	$(SED) 's:.*\(#define DROPBEAR_TWOFISH256\).*:\1:' $(@D)/options.h
endef

define DROPBEAR_DISABLE_STANDALONE
	$(SED) 's:\(#define NON_INETD_MODE\):/*\1 */:' $(@D)/options.h
endef

define DROPBEAR_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/dropbear/dropbear.service \
		$(TARGET_DIR)/usr/lib/systemd/system/dropbear.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/dropbear.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/dropbear.service
endef

ifeq ($(BR2_USE_MMU),y)
define DROPBEAR_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/dropbear/S50dropbear \
		$(TARGET_DIR)/etc/init.d/S50dropbear
endef
else
DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_DISABLE_STANDALONE
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_DISABLE_REVERSEDNS),)
DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_ENABLE_REVERSE_DNS
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_SMALL),y)
DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_BUILD_SMALL
DROPBEAR_CONF_OPTS += --disable-zlib
else
DROPBEAR_POST_EXTRACT_HOOKS += DROPBEAR_BUILD_FEATURED
DROPBEAR_DEPENDENCIES += zlib
endif

ifneq ($(BR2_PACKAGE_DROPBEAR_WTMP),y)
DROPBEAR_CONF_OPTS += --disable-wtmp
endif

ifneq ($(BR2_PACKAGE_DROPBEAR_LASTLOG),y)
DROPBEAR_CONF_OPTS += --disable-lastlog
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_LIB),y)
define DROPBEAR_INSTALL_TARGET_CMDS
        ln -snf /var/run/dropbear $(TARGET_DIR)/etc/dropbear
        $(INSTALL) -D $(@D)/libdropbear.so $(TARGET_DIR)/usr/lib
        $(INSTALL) -D $(@D)/libdropbear.h $(STAGING_DIR)/usr/include
        $(INSTALL) -D $(@D)/libdropbear.pc $(STAGING_DIR)/usr/lib/pkgconfig/LibDropbear.pc
endef
endif

ifeq ($(BR2_PACKAGE_DROPBEAR_PROGRAM),y)
define DROPBEAR_INSTALL_TARGET_CMDS
        $(INSTALL) -m 755 $(@D)/dropbearmulti $(TARGET_DIR)/usr/sbin/dropbear
        for f in $(DROPBEAR_TARGET_BINS); do \
                ln -snf ../sbin/dropbear $(TARGET_DIR)/usr/bin/$$f ; \
        done
        ln -snf /var/run/dropbear $(TARGET_DIR)/etc/dropbear
endef
endif

$(eval $(autotools-package))
