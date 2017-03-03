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

ifeq ($(strip $(BR2_PACKAGE_GADGET_INIT_SCRIPTS_USB_GADGET)),y)
define GADGET_INIT_SCRIPTS_INSTALL_USB_GADGET
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S55_usb_gadget $(TARGET_DIR)/etc/init.d/
endef
GADGET_INIT_SCRIPTS_POST_INSTALL_TARGET_HOOKS += GADGET_INIT_SCRIPTS_INSTALL_USB_GADGET
endif

ifeq ($(strip $(BR2_PACKAGE_GADGET_INIT_SCRIPTS_DOCKERD)),y)
define GADGET_INIT_SCRIPTS_INSTALL_DOCKERD
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S90_dockerd $(TARGET_DIR)/etc/init.d/
endef
GADGET_INIT_SCRIPTS_POST_INSTALL_TARGET_HOOKS += GADGET_INIT_SCRIPTS_INSTALL_DOCKERD
endif

define GADGET_INIT_SCRIPTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/etc/modules $(TARGET_DIR)/etc/
	$(INSTALL) -D -m 644 $(@D)/etc/securetty $(TARGET_DIR)/etc/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/rcS $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/rcK $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S01_setup_ttys $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S02_mounts $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S10_modules $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 700 $(@D)/etc/init.d/S20_setup_audio_codec $(TARGET_DIR)/etc/init.d/

endef

$(eval $(generic-package))