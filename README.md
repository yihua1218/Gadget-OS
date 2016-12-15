# gadgetos

## Required build host tools

### Install sunxi-fel: client for fel bootloader on gr8, allows flashing.
#### linux (debian):
```
# TODO: fastboot install instructions
<install android-platform-tools>

# get sunxi-fel
sudo apt-get update
sudo apt-get install libusb-1.0-0-dev pkg-config
git clone https://github.com/linux-sunxi/sunxi-tools.git
pushd sunxi-tools
make
make install
popd
```
#### macOS:
```
# get fastboot
brew install android-platform-tools

# get sunxi-fel
git clone https://github.com/linux-sunxi/sunxi-tools.git
pushd sunxi-tools
make
make install
popd
```

### Install docker: provides containers to run your gadgetos builds
#### linux (debian):
https://docs.docker.com/engine/installation/linux/debian/
#### macOS:
https://docs.docker.com/docker-for-mac/

## Get gadgetos
```
git clone https://github.com/nextthingco/gadget-os-proto
cd gadget-os-proto
```

#### Build base gadgetos docker image
```
scripts/build-container
```
#### Build gadgetos base buildroot defconfig
```
scripts/build-gadget make chippro_defconfig
```
#### [optional] Override base defconfig using ncurses utility. You'll know if you need this.
```
scripts/build-gadget make nconfig
```
#### Build gadgetos
```
scripts/build-gadget make
```
#### Flash gadgetos image to chippro
```
scripts/flash-gadget
```
