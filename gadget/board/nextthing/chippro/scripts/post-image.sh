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

echo PATH=$PATH
mk_gadget_images -N ${NAND_CONFIG}.config -c "${BOARD_DIR}/configs/ubinize.config" "${BINARIES_DIR}" 

mkimage -A arm -T script -C none -n "Flash" -d "${BOARD_DIR}/uboot.script.source" "${1}/uboot.script"
