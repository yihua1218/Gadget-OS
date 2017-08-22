################################################################################
#
# gadget-update
#
################################################################################

GADGET_UPDATE_VERSION = 0.1
GADGET_UPDATE_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/gadget-update/files
GADGET_UPDATE_SITE_METHOD = local
GADGET_UPDATE_LICENSE = MIT

####

define GADGET_UPDATE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/etc/gadget-update/system.cfg $(TARGET_DIR)/etc/gadget-update/system.cfg
	$(INSTALL) -D -m 644 $(@D)/etc/gadget-update/test.cert.pem $(TARGET_DIR)/etc/gadget-update/test.cert.pem
	$(INSTALL) -D -m 644 $(@D)/etc/gadget-update/ca-chain.cert.pem $(TARGET_DIR)/etc/gadget-update/ca-chain.cert.pem
	$(INSTALL) -D -m 755 $(@D)/sbin/update_requester $(TARGET_DIR)/sbin/update_requester
	$(INSTALL) -D -m 755 $(@D)/sbin/updater $(TARGET_DIR)/sbin/updater
	$(INSTALL) -D -m 755 $(@D)/sbin/update_volume $(TARGET_DIR)/sbin/update_volume
	$(INSTALL) -D -m 755 $(@D)/sbin/get_active_slot $(TARGET_DIR)/sbin/get_active_slot
	$(INSTALL) -D -m 755 $(@D)/sbin/get_inactive_slot $(TARGET_DIR)/sbin/get_inactive_slot
	$(INSTALL) -D -m 755 $(@D)/sbin/set_active_slot_uboot $(TARGET_DIR)/sbin/set_active_slot_uboot
	$(INSTALL) -D -m 755 $(@D)/sbin/toggle_active_slot $(TARGET_DIR)/sbin/toggle_active_slot
	$(INSTALL) -D -m 755 $(@D)/sbin/gadget_update_lib $(TARGET_DIR)/sbin/gadget_update_lib
endef

$(eval $(generic-package))
