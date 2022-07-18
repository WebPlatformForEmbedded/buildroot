################################################################################
#
# Disney+ tooling
#
################################################################################

DISNEY_TOOLING_VERSION = 863d2d4dfa5abfd66a14c9111b3c092b885e386b
DISNEY_TOOLING_SITE = git@github.com:Metrological/disneyplus-tooling.git
DISNEY_TOOLING_SITE_METHOD = git
DISNEY_TOOLING_LICENSE = PROPRIETARY
DISNEY_TOOLING_INSTALL_STAGING = YES
DISNEY_TOOLING_DEPENDENCIES = disney

# Shields need to be built from the ADK sources.
# A link is created from the shield-agent (this build dir) to the ADK build directory.
# That way shield-agent and extension can be properly configured using configuration variables from the ADK
# and a proper premake file can be selected. Then it is built using generated make files inside the ADK build directory.
_DISNEY_BUILD_DIR = "$(BUILD_DIR)/disney-$(DISNEY_VERSION)"


_DISNEY_TOOLING_CONFIGURE_FLAGS = --file=shield-agent/premake5.lua \
								  --target=$(_DISNEY_TARGET_NAME)

ifeq ($(BR2_PACKAGE_DISNEY_PLAYER_UMA),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --player=nve-shared --curl-http2
DISNEY_DEPENDENCIES += disney-uma
endif

ifeq ($(BR2_PACKAGE_DISNEY_VERBOSE),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --verbose
_DISNEY_VERBOSE = verbose=1
endif

ifeq ($(BR2_PACKAGE_DISNEY_WPE_R3),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --wpe-version=R3
endif
ifeq ($(BR2_PACKAGE_DISNEY_WPE_R2),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --wpe-version=R2
endif

ifeq ($(BR2_PACKAGE_DISNEY_NON_DEBUG_TRACES),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --wpe-debug
endif

ifeq ($(BR2_PACKAGE_DISNEY_NATIVE_AUDIO),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --wpe-native-audio
endif

ifeq ($(BR2_PACKAGE_DISNEY_NATIVE_VIDEO),y)
_DISNEY_TOOLING_CONFIGURE_FLAGS += --wpe-native-video
endif

_DISNEY_MORGANA_LIBRARY_NAME = libmorgana.so
ifeq ($(BR2_PACKAGE_DISNEY_MORGANA_SHARED_LIB),y)
    _DISNEY_TOOLING_CONFIGURE_FLAGS += --morgana-library
    ifeq ($(_DISNEY_BUILD_TYPE),"ship")
    _DISNEY_MORGANA_LIBRARY_NAME = libmorgana-sym.so
    endif
endif

DISNEY_LDFLAGS := ${TARGET_LDFLAGS}-Wl,--no-as-needed

define DISNEY_TOOLING_CONFIGURE_CMDS
    ln -sf "$(@D)/shield-agent" "${_DISNEY_BUILD_DIR}"
    cd "$(_DISNEY_BUILD_DIR)" && \
	    CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" \
        GCC_PREFIX="$(TARGET_CROSS)" \
        PLATFORM="$(_DISNEY_TARGET_PLATFORM)" \
        ARCH="$(KERNEL_ARCH)" \
        SSL_VERSION="$(DISNEY_LIBOPENSSL_SO_VERSION)" \
        SYSINCLUDEDIR="$(STAGING_DIR)/usr/include" \
        SYSLIBDIR="$(STAGING_DIR)/usr/lib" \
        LDFLAGS="$(DISNEY_LDFLAGS)" \
		./premake5 $(_DISNEY_TOOLING_CONFIGURE_FLAGS) gmake2
endef

ifeq ($(BR2_PACKAGE_DISNEY_TOOLING_SHIELD_AGENT),y)
define _DISNEY_TOOLING_BUILD_SHIELD_AGENT
    @echo ----------------------------------------------------------------------------
    @echo Building Disney SHIELD Agent
    @echo ----------------------------------------------------------------------------
    cd "$(_DISNEY_BUILD_DIR)/build" && \
		make shield-agent config=$(_DISNEY_BUILD_CONFIG) $(_DISNEY_VERBOSE)
endef
endif

ifeq ($(BR2_PACKAGE_DISNEY_TOOLING_SHIELD_EXTENSION),y)
define _DISNEY_TOOLING_BUILD_SHIELD_EXTENSION
    @echo ----------------------------------------------------------------------------
    @echo Building Disney SHIELD Extension
    @echo ----------------------------------------------------------------------------
    cd "$(_DISNEY_BUILD_DIR)/build" && \
		make shield-agent-extension morgana config=$(_DISNEY_BUILD_CONFIG) $(_DISNEY_VERBOSE)
endef
endif

define DISNEY_TOOLING_BUILD_CMDS
	$(call _DISNEY_TOOLING_BUILD_SHIELD_AGENT)
	$(call _DISNEY_TOOLING_BUILD_SHIELD_EXTENSION)
endef


ifeq ($(BR2_PACKAGE_DISNEY_TOOLING_SHIELD_AGENT),y)
define _DISNEY_TOOLING_INSTALL_SHIELD_AGENT
    @echo "Installing shield-agent executable"
    $(INSTALL) -D -m 0755 "$(_DISNEY_BUILD_DIR)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/shield-agent" "$(TARGET_DIR)/usr/bin/shield-agent"
endef
endif

ifeq ($(BR2_PACKAGE_DISNEY_TOOLING_SHIELD_EXTENSION),y)
define _DISNEY_TOOLING_INSTALL_SHIELD_EXTENSION
    @echo "Installing Extensions"
    rsync -a "$(_DISNEY_BUILD_DIR)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/extensions" "$(TARGET_DIR)$(_DISNEY_DATA_DIR)/shield_runtime/"
endef

ifeq ($(BR2_PACKAGE_DISNEY_MORGANA_SHARED_LIB),y)
define _DISNEY_TOOLING_INSTALL_MORGANA_LIB
    @echo "Installing morgana library"
    $(INSTALL) -D -m 0755 "$(_DISNEY_BUILD_DIR)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/$(_DISNEY_MORGANA_LIBRARY_NAME)" $(1)/usr/lib/$(_DISNEY_MORGANA_LIBRARY_NAME)
endef
else
define _DISNEY_TOOLING_INSTALL_MORGANA_EXEC
    @echo "Installing morgana executable"
    $(INSTALL) -D -m 0755 "$(_DISNEY_BUILD_DIR)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/morgana" "$(TARGET_DIR)/usr/bin/morgana"
endef
endif

endif

define DISNEY_TOOLING_INSTALL_STAGING_CMDS
    $(call _DISNEY_TOOLING_INSTALL_MORGANA_LIB, $(STAGING_DIR))
endef

define DISNEY_TOOLING_INSTALL_TARGET_CMDS
    @echo "Installing shield_runtime"
    rsync -a "$(_DISNEY_BUILD_DIR)/shield_runtime" "$(TARGET_DIR)$(_DISNEY_DATA_DIR)"
    $(call _DISNEY_TOOLING_INSTALL_SHIELD_AGENT)
    $(call _DISNEY_TOOLING_INSTALL_SHIELD_EXTENSION)
    $(call _DISNEY_TOOLING_INSTALL_MORGANA_EXEC)
    $(call _DISNEY_TOOLING_INSTALL_MORGANA_LIB, $(TARGET_DIR))
endef


$(eval $(generic-package))
