TOP=$(CURDIR)
OUTPUT_DIR=/opt/output
BR_DIR?=/opt/buildroot

# export BR2_DL_DIR?=$(HOME)/.br2_download_cache
# export BR2_CCACHE_DIR?=$(HOME)/.br2_ccache
# export BR2_EXTERNAL_GADGETOS_PATH=$(CURDIR)/gadget

export BR2_EXTERNAL=$(CURDIR)/gadget

all:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR)

%_defconfig:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

%:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) $@


nconfig:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) nconfig
help:
	@$(foreach b, $(sort $(notdir $(wildcard $(BR2_EXTERNAL_GADGETOS_PATH)/configs/*_defconfig))), \
	  printf "  %-29s - Build for %s\\n" $(b) $(b:_defconfig=);)
