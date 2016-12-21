# gadgetos

## Install required build tools

#### Install sunxi-fel and fastboot: Clients for bootloaders on gr8. These support USB flashing.
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

#### Install docker: Provides containers to run your gadgetos builds
#### linux (debian):
https://docs.docker.com/engine/installation/linux/debian/
#### macOS:
https://docs.docker.com/docker-for-mac/

## Build and flash gadgetos

#### Get gadgetos source code
```
git clone https://github.com/nextthingco/gadget-os-proto
cd gadget-os-proto
git submodule update --init --recursive
```

#### Create docker image for building gadgetos
```
scripts/build-container
```

On OS X, you'll need to launch the Docker application from your Applications folder before you can run these scripts. This can take about 10-15 minutes, depending on your computer.

#### Build gadgetos base buildroot defconfig
```
scripts/build-gadget make chippro_defconfig
```

This takes less than a minute.

#### [optional] Override base defconfig using ncurses utility. You'll know if you need this.
```
scripts/build-gadget make nconfig
```
#### Build gadgetos
```
scripts/build-gadget make
```

This can take an hour or more

#### Flash gadgetos image to chippro
```
scripts/flash-gadget
```
