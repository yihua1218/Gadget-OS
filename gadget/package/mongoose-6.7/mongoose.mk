################################################################################
#
# mongoose
#
################################################################################

MONGOOSE_6_7_VERSION = 6.7
MONGOOSE_6_7_SITE = $(call github,cesanta,mongoose,$(MONGOOSE_6_7_VERSION))
MONGOOSE_6_7_LICENSE = GPLv2
MONGOOSE_6_7_LICENSE_FILES = LICENSE
MONGOOSE_6_7_INSTALL_STAGING = YES

MONGOOSE_6_7_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)

ifeq ($(BR2_PACKAGE_MONGOOSE_6_7_ENABLE_HTTP_STREAMING_MULTIPART),y)
MONGOOSE_6_7_CFLAGS += -DMG_ENABLE_HTTP_STREAMING_MULTIPART
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
MONGOOSE_6_7_DEPENDENCIES += openssl
# directly linked
MONGOOSE_6_7_CFLAGS += -DNS_ENABLE_SSL -lssl -lcrypto -lz
endif

define MONGOOSE_6_7_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CC) -c $(@D)/mongoose.c $(MONGOOSE_6_7_CFLAGS) -o $(@D)/mongoose.o
	$(TARGET_MAKE_ENV) $(TARGET_AR) rcs $(@D)/libmongoose.a $(@D)/mongoose.o
endef

define MONGOOSE_6_7_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 644 $(@D)/libmongoose.a \
		$(STAGING_DIR)/usr/lib/libmongoose.a
	$(INSTALL) -D -m 644 $(@D)/mongoose.h \
		$(STAGING_DIR)/usr/include/mongoose.h
endef

$(eval $(generic-package))
