################################################################################
#
# opentelemetry-proto
#
################################################################################

OPENTELEMETRY_PROTO_VERSION = 1.11.0
OPENTELEMETRY_PROTO_SITE = $(call github,open-telemetry,opentelemetry-proto,v$(OPENTELEMETRY_PROTO_VERSION))
OPENTELEMETRY_PROTO_LICENSE = Apache-2.0
OPENTELEMETRY_PROTO_LICENSE_FILES = LICENSE

define HOST_OPENTELEMETRY_PROTO_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/share/opentelemetry-proto
	cp -a $(@D)/opentelemetry $(HOST_DIR)/share/opentelemetry-proto/
endef

$(eval $(host-generic-package))
