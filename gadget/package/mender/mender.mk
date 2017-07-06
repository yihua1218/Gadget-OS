################################################################################
#
# mender
#
################################################################################

MENDER_VERSION = 7449c12bc60b8484a27e8f56cd957c6759b12c3d
MENDER_SITE = $(call github,mirzak,mender,$(MENDER_VERSION))
MENDER_LICENSE = Apache-2.0
MENDER_LICENSE_FILES = LICENSE

MENDER_DEPENDENCIES = host-go

MENDER_GOPATH = "$(@D)/Godeps/_workspace"
MENDER_MAKE_ENV = $(HOST_GO_TARGET_ENV) \
	CGO_ENABLED=1 \
	GOBIN="$(@D)/bin" \
	GOPATH="$(MENDER_GOPATH)" \
	PATH=$(BR_PATH)

MENDER_GLDFLAGS = \
	-X main.gitCommit=$(MENDER_VERSION)

ifeq ($(BR2_STATIC_LIBS),y)
FLANNEL_GLDFLAGS += -extldflags '-static'
endif

MENDER_GOTAGS = cgo static_build

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
MENDER_GOTAGS += seccomp
MENDER_DEPENDENCIES += libseccomp host-pkgconf
endif

define MENDER_CONFIGURE_CMDS
	mkdir -p $(MENDER_GOPATH)/src/github.com/mendersoftware
	ln -s $(@D) $(MENDER_GOPATH)/src/github.com/mendersoftware/mender
endef

define MENDER_BUILD_CMDS
	cd $(@D) && $(MENDER_MAKE_ENV) $(HOST_DIR)/usr/bin/go get -d
	cd $(@D) && $(MENDER_MAKE_ENV) $(HOST_DIR)/usr/bin/go \
		build -v -o $(@D)/bin/mender \
		-tags "$(MENDER_GOTAGS)" -ldflags "$(MENDER_GLDFLAGS)" .
endef

define MENDER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/mender $(TARGET_DIR)/usr/bin/mender
endef

$(eval $(generic-package))
