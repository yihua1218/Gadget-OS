################################################################################
#
# wifi-onboarding
#
################################################################################

WIFI_ONBOARDING_VERSION = unstable
WIFI_ONBOARDING_SITE = https://github.com/nextthingco/wifi-onboarding
WIFI_ONBOARDING_SITE_METHOD = git

WIFI_ONBOARDING_DEPENDENCIES = host-go

WIFI_ONBOARDING_ASSET_PATH=/usr/lib/wifi-onboarding

WIFI_ONBOARDING_GOPATH = "$(@D)/gopath"
WIFI_ONBOARDING_MAKE_ENV = $(HOST_GO_TARGET_ENV) \
	GOBIN="$(@D)/bin" \
	GOPATH="$(WIFI_ONBOARDING_GOPATH)" \
	WIFI_ONBOARDING_VIEW_LOCATION="$(WIFI_ONBOARDING_ASSET_PATH)/view/*" \
	WIFI_ONBOARDING_STATIC_LOCATION="$(WIFI_ONBOARDING_ASSET_PATH)/static" \
	WIFI_ONBOARDING_DEFAULT_PORT=$(BR2_PACKAGE_WIFI_ONBOARDING_DEFAULT_PORT) \
	$(TARGET_MAKE_ENV)

define WIFI_ONBOARDING_BUILD_CMDS
        $(MAKE) clean
        $(WIFI_ONBOARDING_MAKE_ENV) $(MAKE) -C $(@D) get
        $(WIFI_ONBOARDING_MAKE_ENV) GIT_COMMIT=$(WIFI_ONBOARDING_VERSION) $(MAKE) -C $(@D)
endef

define WIFI_ONBOARDING_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/linux_arm/wifi-onboarding $(TARGET_DIR)/usr/bin/wifi-onboarding
	$(INSTALL) -d -m 0644 $(TARGET_DIR)$(WIFI_ONBOARDING_ASSET_PATH)/view
	$(INSTALL) -d -m 0644 $(TARGET_DIR)$(WIFI_ONBOARDING_ASSET_PATH)/static
	$(INSTALL) -D -m 0644 $(@D)/view/*   $(TARGET_DIR)$(WIFI_ONBOARDING_ASSET_PATH)/view
	$(INSTALL) -D -m 0644 $(@D)/static/* $(TARGET_DIR)$(WIFI_ONBOARDING_ASSET_PATH)/static
endef

define WIFI_ONBOARDING_INSTALL_INIT_SYSV
    $(INSTALL) -D -m 755 $(BR2_EXTERNAL_GADGETOS_PATH)/package/wifi-onboarding/S50_wifi_onboarding \
		$(TARGET_DIR)/etc/init.d/S50_wifi_onboarding
endef

$(eval $(generic-package))
