################################################################################
#
# gadget-setup-ssh-key
#
################################################################################

GADGET_SETUP_SSH_KEY_VERSION = 0.1
GADGET_SETUP_SSH_KEY_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/gadget-setup-ssh-key/files
GADGET_SETUP_SSH_KEY_SITE_METHOD = local
GADGET_SETUP_SSH_KEY_LICENSE = MIT

####

define GADGET_SETUP_SSH_KEY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 600 $(@D)/id_rsa.pub $(TARGET_DIR)/root/.ssh/authorized_keys
endef

$(eval $(generic-package))
