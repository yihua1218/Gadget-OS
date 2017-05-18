################################################################################
#
# rauc
#
################################################################################

RAUC_VERSION = v0.1.1
RAUC_SITE = $(call github,rauc,rauc,$(RAUC_VERSION))
RAUC_LICENSE = LGPLv2.1
RAUC_LICENSE_FILES = COPYING
RAUC_AUTORECONF = YES
RAUC_DEPENDENCIES = libglib2 libcurl openssl

$(eval $(autotools-package))
