TOP=$(CURDIR)
OUTPUT_DIR=$(TOP)/output
BR_DIR=$(TOP)/buildroot

export BR2_EXTERNAL=$(CURDIR)/capsule

all:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR)

%_defconfig:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) $@

%:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) $@


nconfig:
	@make -C $(BR_DIR) O=$(OUTPUT_DIR) nconfig
help:
	@$(foreach b, $(sort $(notdir $(wildcard $(BR2_EXTERNAL)/configs/*_defconfig))), \
	  printf "  %-29s - Build for %s\\n" $(b) $(b:_defconfig=);)
