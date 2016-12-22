# gadgetos

## Install required build tools

#### Install sunxi-fel and fastboot

Clients for bootloaders on gr8. These support USB flashing.

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
#### linux (Ubuntu):
https://docs.docker.com/engine/installation/linux/ubuntulinux/ 

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

On macOS, you'll need to launch the Docker application from your Applications folder before you can run these scripts. This can take about 10-15 minutes, depending on your computer.

### Create gadgetos config file

The heart of your gadgetos is the config file. You can create a starting point, depending on what you want your CHIP Pro to do. We have already created a few examples - here are the commands to generate the config for each:

* Default - `scripts/build-gadget make chippro_defconfig`
* Blinkenlights - `scripts/build-gadget make chippro_blinkenlights_defconfig`
* Mic Recorder - `scripts/build-gadget make chippro_micrecorder_defconfig`
* Access Point - `scripts/build-gadget make chippro_wirelessap_defconfig`

Creating this config file takes less than a minute.

#### [optional] Customize your configuration
If you want to add some capabilities to the default rootfs, you can use an ncurses UI to navigate the many options of buildroot:
```
scripts/build-gadget make nconfig
```

#### [optional] Customize your kernel
If you want to add some capabilities to the kernel, you can use an ncurses UI to navigate the many options:
```
scripts/build-gadget make linux-nconfig
```

### Make gadgetos
Now you are ready to build!

```
scripts/build-gadget make
```

This can take an hour or more.

## Flash With OS

Now that you have built an operating system, you can flash it to CHIP Pro.

#### Start UART terminal

Open a new terminal window, plug in to the dev kit's USB micro connector and start a terminal session:
```
screen /dev/tty.usbserial-XXX 115200 #macOS - hit tab after the '-'
screen /dev/ttyUSB0 #linux
```

#### Flash gadgetos image to chippro

Hold down the fel button and power up the Dev Board and
```
scripts/flash-gadget
```
In the other UART terminal window you'll need to enter a couple commands to get things going. When you get to the `=>` prompt enter:
```
=> fastboot 0
```
You'll get that prompt again later, then you'll need to:
```
=> reset
```

#### Alternatively
If the dev kit already has a gadget OS on it and you are re-flashing, boot CHIP Pro, then open a terminal. Use the command:
```
gadget-enter-flashing-mode
```
This will reboot into a flashing mode. From your computer's command line in the gadget-os-proto docker, run the flash script:
```
scripts/flash-gadget
```
It will complaing that FEL device is not found, then after a few seconds, begin flashing from fastboot.

#### Update the OS and Re-flash

If the repo is updated and you want to reflash, from your local repo directory, you can use the appropriate arguments to `make` :
```
git pull
scripts/build-gadget make gadget-init-scripts-reconfigure all # for default
scripts/build-gadget make demo-blinkenlights-reconfigure all # ... blinkenlights
scripts/build-gadget make demo-micrecorder-reconfigure all # ... micrecorder
scripts/build-gadget make demo-wirelessap-reconfigure all # ... wirelessap
```

Then try the "Alternatively" procedure above to reflash.

## Try it!

There are some examples on the system you just flashed.

#### Blinkenlights

Try the blinking lights example. From CHIP Pro's prompt:
```
blink-leds
```
This blinks the 8 LEDs on CHIP's GPIO in various patterns.

#### VU meter

Now try the VU meter example
```
/opt/bin/vu-meter
```
Scream loudly, speak softly, tap the mics, and MAKE SOME NOISE, SPORTSFANS!. You'll see the LEDs light, proporitional to the volume of the noise.
