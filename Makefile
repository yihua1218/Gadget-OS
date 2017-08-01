GADGET_DIR = "$(PWD)/"
IMAGE_DIR = "$(PWD)/output/images"

TOP=$(CURDIR)
OUTPUT_DIR?=/opt/output
BR_DIR?=/opt/buildroot

ifneq ($(strip $(TERM)),)
INTERACTIVE = -it
else
INTERACTIVE =
endif

ifeq ($(strip $(no_docker)),)
ID=$(shell cat scripts/id)
ifeq ($(strip $(ID)),)
$(error scripts/id not found! please run `scripts/init-container` )
endif

GADGET_CONTAINER = gadget-build-container
BUILD_OUTPUT_VOL = "gadget-build-output-${ID}"
DL_CACHE_VOL     = "gadget-build-dlcache-${ID}"
TMP_VOL          = "gadget-build-tmp-${ID}"
BR2_EXTERNAL?=/opt/gadget-os-proto/gadget

DOCKER = \
echo "------------------------------------------------------------"; \
echo " Running Docker - hit CTRL-C then CTRL-\ to interrupt"; \
echo "------------------------------------------------------------"; \
docker run \
--rm \
--env BR2_DL_DIR=/opt/dlcache/ \
--env BR2_EXTERNAL=${BR2_EXTERNAL} \
--volume=${DL_CACHE_VOL}:/opt/dlcache/ \
--volume=${BUILD_OUTPUT_VOL}:/opt/output \
--volume=${IMAGE_DIR}:/opt/output/images \
--volume=${GADGET_DIR}:/opt/gadget-os-proto \
--volume=${GADGET_DIR}/local:/local \
--volume=${TMP_VOL}:/tmp \
--name=gadget-build-task \
-w="/opt/gadget-os-proto" \
${INTERACTIVE} \
${GADGET_CONTAINER}
else
BR2_EXTERNAL?=$(CURDIR)
DOCKER =
endif

all:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR)

%_defconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

%:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

nconfig:
	@$(DOCKER) make -C $(BR_DIR) O=$(OUTPUT_DIR) nconfig

SHELL:
	@$(DOCKER) /bin/bash

help:
	@$(foreach b, $(sort $(notdir $(wildcard $(BR2_EXTERNAL_GADGETOS_PATH)/configs/*_defconfig))), \
	  printf "  %-29s - Build for %s\\n" $(b) $(b:_defconfig=);)
