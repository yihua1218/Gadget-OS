#!/bin/bash -x

# ROOT_DIR="$(pwd)"
ROOT_DIR="${BR2_EXTERNAL_GADGETOS_PATH}"
BOARD_DIR=${ROOT_DIR}/board/nextthing/chippro

MKIMAGE=${HOST_DIR}/usr/bin/mkimage

# ${MKIMAGE} -f ${BOARD_DIR}/bootimg.its ${BINARIES_DIR}/bootimg.itb

# cat <<-EOF >> ${TARGET_DIR}/etc/mdev.conf
# sd[a-z][0-9]* 0:0 0660 *(/opt/bin/automount $MDEV)
# mmcblk[0-9]p[0-9] 0:0 0660 *(/opt/bin/automount $MDEV)
# EOF

echo "TERM=xterm" | tee -a ${TARGET_DIR}/etc/profile

## Move modifiable data to /data and make the output tar
## before removing the local content

mkdir -p ${TARGET_DIR}/data/etc
mkdir -p ${TARGET_DIR}/data/var

pushd ${TARGET_DIR}/etc
mv ssh ../data/etc/ssh
ln -s ../data/etc/ssh ssh

mv dnsmasq.conf ../data/etc/
ln -s ../data/etc/dnsmasq.conf dnsmasq.conf
popd

pushd ${TARGET_DIR}
mv var ../data/
ln -s ../data/var var
popd


pushd ${TARGET_DIR}/data
tar -f ${BINARIES_DIR}/data.tar -c .
popd


