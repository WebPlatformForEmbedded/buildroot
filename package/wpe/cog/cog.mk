################################################################################
#
# Cog
#
################################################################################

COG_VERSION = a4663e60f2e0359e078aed11bc5916264205ba18
COG_SITE = $(call github,Igalia,cog,$(COG_VERSION))
COG_INSTALL_STAGING = YES
COG_DEPENDENCIES += wpewebkit
COG_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE" \
	-DCOG_PLATFORM_FDO=NO

$(eval $(cmake-package))

