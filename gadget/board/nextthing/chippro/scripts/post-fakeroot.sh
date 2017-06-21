#!/bin/bash -ex

echo "##############################################################################"
echo "## $0 "
echo "##############################################################################"

echo "# PWD=$PWD"
echo "# BASE_DIR=$BASE_DIR"


## Move modifiable data to /data and make the output tar
## before removing the local content

TARGET_RO_DIR="${BASE_DIR}/target_ro"

TMP_DIR=$(mktemp -d)
RW_DIR="${TMPDIR}/data"
RW_ETC="${RW_DIR}/etc"
RW_VAR="${RW_DIR}/var"
RW_ROOT="${RW_DIR}/root"

echo "# TARGET_RO_DIR=${TARGET_RO_DIR}"

rm -rf "${TARGET_RO_DIR}"
cp -al "${TARGET_DIR}" "${TARGET_RO_DIR}"

mkdir -p "${TARGET_RO_DIR}/data"
mkdir -p "${RW_ETC}/docker"
mkdir -p "${RW_VAR}/empty"
mkdir -p "${RW_VAR}/misc"
mkdir -p "${RW_ROOT}/.ssh"

pushd "${TARGET_RO_DIR}/etc"
#mv resolv.conf "${RW_ETC}/resolv.conf"
mv ssh "${RW_ETC}/ssh"
mv dnsmasq.conf "${RW_ETC}/"
#ln -sf ../data/etc/resolv.conf resolv.conf
ln -sf ../data/etc/ssh ssh
ln -sf ../data/etc/dnsmasq.conf dnsmasq.conf
ln -sf ../data/etc/docker docker
popd

pushd "${TARGET_RO_DIR}/"

mv var data/
ln -sf data/var var

pushd data
ln -sf ../tmp tmp
ln -sf ../run run
popd

mv root/.ssh data/root/
pushd root
ln -sf ../data/root/.ssh .ssh
popd

popd

# Create tar ball for ro rootfs
echo "# generating '${BINARIES_DIR}/rootfs_ro.tar'..."
tar -C "${TARGET_RO_DIR}" -c -f "${BINARIES_DIR}/rootfs_ro.tar" .

# Create tar ball for writable partition
echo "# generating '${BINARIES_DIR}/data.tar'..."
tar -C "${RW_DIR}" -c -f "${BINARIES_DIR}/data.tar" .

# Cleanup
rm -rf "${TMP_DIR}"
