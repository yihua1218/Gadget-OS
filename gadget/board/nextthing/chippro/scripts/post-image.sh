#!/bin/bash

NAND_CONFIG=$2

# Environment variables passed in from buildroot:
# BR2_CONFIG, HOST_DIR, STAGING_DIR, TARGET_DIR, BUILD_DIR, BINARIES_DIR and BASE_DIR.

echo "##############################################################################"
echo "## $0 "
echo "##############################################################################"

echo "# \$1 = $1"
echo "# \$2 = $2"

echo "# NAND_CONFIG = $NAND_CONFIG"
echo "# BR2_CONFIG=$BR2_CONFIG"
echo "# HOST_DIR=$HOST_DIR"
echo "# STAGING_DIR=$STAGING_DIR"
echo "# TARGET_DIR=$TARGET_DIR"
echo "# BUILD_DIR=$BUILD_DIR"
echo "# BINARIES_DIR=$BINARIES_DIR"
echo "# BASE_DIR=$BASE_DIR"

ROOT_DIR="${BR2_EXTERNAL_GADGETOS_PATH}"
BOARD_DIR=${ROOT_DIR}/board/nextthing/chippro

## create U-BOOT SCRIPT
mkimage -A arm -T script -C none -n "Flash" -d "${BOARD_DIR}/uboot.script.source" "${1}/uboot.script"


## create NAND images
NAND_CONFIG="${NAND_CONFIG}.config"

pushd $BINARIES_DIR

source "${HOST_DIR}/usr/bin/chip_nand_scripts_common" 
read_nand_config "${NAND_CONFIG}"

echo "## creating SPL image"
"${HOST_DIR}/usr/bin/mk_spl_image" -N "${NAND_CONFIG}" sunxi-spl.bin

echo "## creating uboot image"
"${HOST_DIR}/usr/bin/mk_uboot_image" -N "${NAND_CONFIG}" u-boot-dtb.bin

echo "## creating ubifs image"
"${HOST_DIR}/usr/bin/mk_ubifs_image" -N "${NAND_CONFIG}" -o rootfs.ubifs rootfs_ro.tar

echo "## creating ubifs image"
"${HOST_DIR}/usr/bin/mk_ubifs_image" -N "${NAND_CONFIG}" -o data.ubifs data.tar

echo "## creating ubi image"
"${HOST_DIR}/usr/bin/mk_ubi_image" -N "${NAND_CONFIG}" -c "${BOARD_DIR}/configs/ubinize.config" rootfs.ubifs

ln -sf "spl-$NAND_EBSIZE-$NAND_PSIZE-${NAND_OSIZE}.bin" "$BINARIES_DIR/flash-spl.bin"
ln -sf "uboot-${NAND_EBSIZE}.bin" "$BINARIES_DIR/flash-uboot.bin"
ln -sf "chip-$NAND_EBSIZE-${NAND_PSIZE}.ubi.sparse" "$BINARIES_DIR/flash-rootfs.bin"

popd

