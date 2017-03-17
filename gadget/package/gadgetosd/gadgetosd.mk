################################################################################
#
# gadgetosd
#
################################################################################

GADGETOSD_VERSION = unstable
GADGETOSD_SITE = https://ntc.githost.io/nextthingco/gadgetosd
GADGETOSD_SITE_METHOD = git
GADGETOSD_DEPENDENCIES = util-linux mongoose-6.7 

HOST_GADGETOSD_DEPENDENCIES = util-linux mongoose-6.7

define GADGETOSD_BUILD_CMDS
	$(MAKE) clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define GADGETOSD_INSTALL_TARGET_CMDS
    $(INSTALL) -m 0755 -D $(GADGETOSD_PKGDIR)/S99_gadgetosd \
        $(TARGET_DIR)/etc/init.d/S99_gadgetosd
	$(INSTALL) -D -m 0755 $(@D)/gadgetosd $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/gadget $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
