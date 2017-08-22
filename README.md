# gadgetos

## Please be advised that GadgetOS will eventually replace [Gadget-buildroot](https://github.com/NextThingCo/gadget-buildroot), however the software and documentation for GadgetOS are under very active, daily development. This is a work in progress release of the source code.

## Install required build tools

#### Install sunxi-fel and fastboot

Clients for bootloaders on gr8. These support USB flashing.

#### linux (debian):
```
# TODO: fastboot install instructions
sudo apt-get update
sudo apt-get install android-tools-fastboot

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
brew tap caskroom/cask
brew cask install android-platform-tools

# install libusb
brew install libusb

# get sunxi-fel
git clone https://github.com/linux-sunxi/sunxi-tools.git
pushd sunxi-tools
make
make install
popd
```

#### Install docker: Provides containers to run your gadgetos builds
#### linux (Ubuntu):
https://docs.docker.com/engine/installation/linux/ubuntulinux/ 

#### linux (debian):
https://docs.docker.com/engine/installation/linux/debian/
#### macOS:
https://docs.docker.com/docker-for-mac/

## Build and flash gadgetos

#### Get gadgetos source code
```
git clone https://github.com/NextThingCo/Gadget-OS.git
cd Gadget-OS
```

#### Create docker image for building gadgetos
```
scripts/init-container
```

On macOS, you'll need to launch the Docker application from your Applications folder before you can run these scripts. This can take about 10-15 minutes, depending on your computer.

### Create gadgetos config file

`make chippro_defconfig`

Creating this config file takes less than a minute.

#### [optional] Customize your configuration
If you want to add some capabilities to the default rootfs, you can use an ncurses UI to navigate the many options of buildroot:
```
make nconfig
```

#### [optional] Customize your kernel
If you want to add some capabilities to the kernel, you can use an ncurses UI to navigate the many options:
```
make linux-nconfig
```

### Make gadgetos
Now you are ready to build!

```
make
```

This can take an hour or more.

## Flash With OS

Now that you have built an operating system, you can flash it to CHIP Pro. 

#### Flash gadgetos image to chippro

Hold down the fel button and power up the Dev Board and
```
scripts/flash-gadget
```
The image will flash to the CHIP Pro. Once flashing has finished, reboot your device. You can then connect via UART and start using it.
