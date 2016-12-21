################################################################################
#
# gadget-init-scripts
#
################################################################################

GADGET_INIT_SCRIPTS_VERSION = 0.1
GADGET_INIT_SCRIPTS_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/gadget-init-scripts/files
GADGET_INIT_SCRIPTS_SITE_METHOD = local
GADGET_INIT_SCRIPTS_LICENSE = MIT

####

define GADGET_INIT_SCRIPTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/etc/modules $(TARGET_DIR)/etc/
	$(INSTALL) -D -m 644 $(@D)/etc/securetty $(TARGET_DIR)/etc/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S* $(TARGET_DIR)/etc/init.d/
endef

$(eval $(generic-package))