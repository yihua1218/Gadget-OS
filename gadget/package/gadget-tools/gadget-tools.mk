################################################################################
#
# gadget-tools
#
################################################################################

GADGET_TOOLS_VERSION = 0.1
GADGET_TOOLS_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/gadget-tools/files
GADGET_TOOLS_SITE_METHOD = local
GADGET_TOOLS_LICENSE = MIT

####

define GADGET_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 700 $(@D)/usr/sbin/* $(TARGET_DIR)/usr/sbin/
endef

$(eval $(generic-package))