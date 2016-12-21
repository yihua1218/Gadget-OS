################################################################################
#
# network-interfaces-script
#
################################################################################

NETWORK_INTERFACES_SCRIPT_VERSION = master
NETWORK_INTERFACES_SCRIPT_REPO_NAME = Network-Interfaces-Script
NETWORK_INTERFACES_SCRIPT_SITE = https://github.com/NextThingCo/$(NETWORK_INTERFACES_SCRIPT_REPO_NAME)
NETWORK_INTERFACES_SCRIPT_SITE_METHOD = git

define HOST_NETWORK_INTERFACES_SCRIPT_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(HOST_NETWORK_INTERFACES_SCRIPT_DIR)/changeInterface.awk $(HOST_DIR)/usr/bin/changeInterface.awk
	$(INSTALL) -D -m 0755 $(HOST_NETWORK_INTERFACES_SCRIPT_DIR)/changeInterface $(HOST_DIR)/usr/bin/changeInterface
	$(INSTALL) -D -m 0755 $(HOST_NETWORK_INTERFACES_SCRIPT_DIR)/readInterfaces.awk $(HOST_DIR)/usr/bin/readInterfaces.awk
endef

$(eval $(host-generic-package))
