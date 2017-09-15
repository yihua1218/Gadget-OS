################################################################################
#
# gadget-bluetooth-conf
#
################################################################################

GADGET_BLUETOOTH_CONF_VERSION = 0.1
GADGET_BLUETOOTH_CONF_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/gadget-bluetooth-conf/files
GADGET_BLUETOOTH_CONF_SITE_METHOD = local
GADGET_BLUETOOTH_CONF_LICENSE = MIT

####

define GADGET_BLUETOOTH_CONF_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/bluetooth.conf $(TARGET_DIR)/etc/dbus-1/system.d/bluetooth.conf
	$(INSTALL) -D -m 700 $(@D)/S41_bluetoothd $(TARGET_DIR)/etc/init.d/S41_bluetoothd
endef

$(eval $(generic-package))
