################################################################################
#
# wifi-onboarding
#
################################################################################

WIFI_ONBOARDING_VERSION = unstable
WIFI_ONBOARDING_SITE = https://github.com/nextthingco/wifi-onboarding
WIFI_ONBOARDING_SITE_METHOD = git

WIFI_ONBOARDING_DEPENDENCIES = host-go

WIFI_ONBOARDING_GOPATH = "$(@D)/gopath"
WIFI_ONBOARDING_MAKE_ENV = $(HOST_GO_TARGET_ENV) \
	GOBIN="$(@D)/bin" \
	GOPATH="$(WIFI_ONBOARDING_GOPATH)"\
	$(TARGET_MAKE_ENV)

define WIFI_ONBOARDING_BUILD_CMDS
        $(MAKE) clean
        $(WIFI_ONBOARDING_MAKE_ENV) $(MAKE) -C $(@D) get
        $(WIFI_ONBOARDING_MAKE_ENV) GIT_COMMIT=$(WIFI_ONBOARDING_VERSION) $(MAKE) -C $(@D) wifi-onboarding
endef

define WIFI_ONBOARDING_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/linux_arm/wifi-onboarding $(TARGET_DIR)/usr/bin/wifi-onboarding
	$(INSTALL) -d -m 0644 $(TARGET_DIR)/usr/lib/wifi-onboarding/view
	$(INSTALL) -d -m 0644 $(TARGET_DIR)/usr/lib/wifi-onboarding/static
	$(INSTALL) -D -m 0644 $(@D)/view/*   $(TARGET_DIR)/usr/lib/wifi-onboarding/view
	$(INSTALL) -D -m 0644 $(@D)/static/* $(TARGET_DIR)/usr/lib/wifi-onboarding/static
endef

#define WIFI_ONBOARDING_INSTALL_INIT_SYSV
#        $(INSTALL) -m 755 -D package/gadget-initc/S91_gadget_initc \
#                $(TARGET_DIR)/etc/init.d/S91_gadget_initc
#endef

$(eval $(generic-package))
