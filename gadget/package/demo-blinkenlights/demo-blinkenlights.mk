################################################################################
#
# demo-blinkenlights
#
################################################################################

DEMO_BLINKENLIGHTS_VERSION = 0.1
DEMO_BLINKENLIGHTS_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/demo-blinkenlights/files
DEMO_BLINKENLIGHTS_SITE_METHOD = local
DEMO_BLINKENLIGHTS_LICENSE = MIT
# DEMO_BLINKENLIGHTS_DEPENDENCIES = host-bison host-flex

####

define DEMO_BLINKENLIGHTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/S15_blinkenlights $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 755 $(@D)/blink-leds $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 755 $(@D)/fade-pwms $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))