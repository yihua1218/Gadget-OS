################################################################################
#
# demo-vu-meter
#
################################################################################

DEMO_VU_METER_VERSION = 0.1
DEMO_VU_METER_SITE = $(BR2_EXTERNAL_GADGETOS_PATH)/package/demo-vu-meter/files
DEMO_VU_METER_SITE_METHOD = local
DEMO_VU_METER_LICENSE = MIT

####

define DEMO_VU_METER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/S25_vumeter $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 755 $(@D)/vu-meter $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))