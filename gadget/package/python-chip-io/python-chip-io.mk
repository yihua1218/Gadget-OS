################################################################################
#
# python-chip-io
#
############################################################################

PYTHON_CHIP_IO_VERSION = 9d7fb634a3573515d62a9ac4071ed59f8e4c9ec4
PYTHON_CHIP_IO_SOURCE = CHIP_IO_$(PYTHON_CHIP_IO_VERSION).tar.gz
PYTHON_CHIP_IO_SITE = https://github.com/zerotri/CHIP_IO
PYTHON_CHIP_IO_SITE_METHOD = git
PYTHON_CHIP_IO_LICENSE = MIT
PYTHON_CHIP_IO_LICENSE_FILES = LICENSE
PYTHON_CHIP_IO_DEPENDENCIES = host-dtc-overlay
PYTHON_CHIP_IO_SETUP_TYPE = setuptools

$(eval $(python-package))