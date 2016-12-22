################################################################################
#
# eth_usb_gadget
#
################################################################################

ETH_USB_GADGET_DEPENDENCIES = skeleton host-network-interfaces-script dnsmasq

#TODO: parametrize ip $(BR2_ETH_USB_GADGET_IP)
define ETH_USB_GADGET_BUILD_CMDS

endef

define ETH_USB_GADGET_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(ETH_USB_GADGET_PKGDIR)/S81_dnsmasq_usb0 $(TARGET_DIR)/etc/init.d/S81_dnsmasq_usb0
	$(INSTALL) -D -m 0644 $(ETH_USB_GADGET_PKGDIR)/dnsmasq_usb0.conf $(TARGET_DIR)/etc/dnsmasq_usb0.conf
endef

ifeq ($(strip $(BR2_PACKAGE_ETH_USB_GADGET)),y)
define ETH_USB_GADGET_MODIFY_NETWORK
	( \
		$(HOST_DIR)/usr/bin/changeInterface $(TARGET_DIR)/etc/network/interfaces device=usb0 action=add \
			mode=static \
			address=192.168.81.1 \
			netmask=255.255.255.0 \
	)
endef
endif

TARGET_FINALIZE_HOOKS += ETH_USB_GADGET_MODIFY_NETWORK

$(eval $(generic-package))
