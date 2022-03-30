################################################################################
#
# Disney+ tooling
#
################################################################################

DISNEY_TOOLING_VERSION = 014bc64b420dec4cc6d4b04eadb7f977e97f24ab
DISNEY_TOOLING_SITE = git@github.com:Metrological/disneyplus-tooling.git
DISNEY_TOOLING_SITE_METHOD = git
DISNEY_TOOLING_LICENSE = PROPRIETARY
DISNEY_TOOLING_INSTALL_STAGING = NO
DISNEY_TOOLING_DEPENDENCIES = disney

# Shields need to be built from the ADK sources.
# A link is created from the shield-agent (this build dir) to the ADK build directory.
# That way shield-agent and extension can be properly configured using configuration variables from the ADK
# and a proper premake file can be selected. Then it is built using generated make files inside the ADK build directory.
_DISNEY_BUILD_DIR = "$(BUILD_DIR)/disney-$(DISNEY_VERSION)"


_DISNEY_TOOLING_CONFIGURE_FLAGS = --verbose \
								  --file=shield-agent/premake5.lua \
								  --target=$(_DISNEY_TARGET_NAME)


ifeq ($(BR2_PACKAGE_DISNEY_PLAYER_UMA),y)
DISNEY_TOOLING_DEPENDENCIES += disney-uma
_DISNEY_TOOLING_CONFIGURE_FLAGS += --player=$(_DISNEY_PLAYER) $(_DISNEY_CURL_HTTP)
endif

define DISNEY_TOOLING_CONFIGURE_CMDS
    ln -sf "$(@D)/shield-agent" "${_DISNEY_BUILD_DIR}"
    cd "$(_DISNEY_BUILD_DIR)" && \
		CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" GCC_PREFIX="$(TARGET_CROSS)" PLATFORM="$(_DISNEY_TARGET_PLATFORM)" \
    	ARCH="$(KERNEL_ARCH)" SSL_VERSION="$(DISNEY_LIBOPENSSL_SO_VERSION)" SYSINCLUDEDIR="$(STAGING_DIR)/usr/include" \
    	SYSLIBDIR="$(STAGING_DIR)/usr/lib" \
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
    @echo "Installing morgana executable"
    $(INSTALL) -D -m 0755 "$(_DISNEY_BUILD_DIR)/build/bin/$(_DISNEY_TARGET_PLATFORM)/$(_DISNEY_BUILD_TYPE)/morgana" "$(TARGET_DIR)/usr/bin/morgana"
endef
endif

define _DISNEY_TOOLING_INSTALL
    @echo "Installing shield_runtime"
    rsync -a "$(_DISNEY_BUILD_DIR)/shield_runtime" "$(TARGET_DIR)$(_DISNEY_DATA_DIR)"
    if [ -d "$(_DISNEY_BUILD_DIR)/build/shield_runtime/shield_agent_data/assets/dy_lib_tests" ]; then \
        rsync -a "$(_DISNEY_BUILD_DIR)/build/shield_runtime/shield_agent_data/assets/dy_lib_tests" "$(TARGET_DIR)$(_DISNEY_DATA_DIR)/shield_runtime/shield_agent_data/assets"; \
    fi
    $(call _DISNEY_TOOLING_INSTALL_SHIELD_AGENT)
    $(call _DISNEY_TOOLING_INSTALL_SHIELD_EXTENSION)
endef

define DISNEY_TOOLING_INSTALL_TARGET_CMDS
    $(call _DISNEY_TOOLING_INSTALL)
endef


$(eval $(generic-package))
