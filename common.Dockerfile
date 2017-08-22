FROM ubuntu:16.04
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.utf8

RUN apt update && \
	apt -y upgrade && \
	apt -y install wget \
	build-essential \
	bc \
	git \
	locales \
	cpio \
	lib32stdc++6 lib32z1 libc6-i386 \
	texinfo \
	vim \
	unzip \
	ncurses-dev \
	python \
	android-tools-fsutils \
	android-tools-fastboot \
	libusb-1.0-0-dev \
	pkg-config \
	lzop && \
	rm -rf /var/lib/apt-lists/* && \
	locale-gen en_US.UTF-8 && \
	echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
	git clone https://github.com/linux-sunxi/sunxi-tools /opt/sunxi-tools && \
	make -C /opt/sunxi-tools && \
	make -C /opt/sunxi-tools misc && \
	make -C /opt/sunxi-tools install && \
	make -C /opt/sunxi-tools install-misc && \
	rm -rf /opt/sunxi-tools && \
	mkdir -p /opt/buildroot && \
	mkdir -p /opt/output && \
	mkdir -p /opt/dlcache && \
	mkdir -p /local && \
	mkdir -p /opt/gadget-os-proto/output && \
	mkdir -p /opt/gadget-os-proto/local && \
	wget -P /opt "https://github.com/buildroot/buildroot/archive/2017.05.tar.gz" && \
	tar -C /opt/buildroot -xzf /opt/2017.05.tar.gz --strip-components=1

ADD .git/ /opt/gadget-os-proto/.git
ADD .branch /opt/gadget-os-proto/.branch
ADD gadget/ /opt/gadget-os-proto/gadget
ADD Makefile /opt/gadget-os-proto/Makefile

WORKDIR /opt/gadget-os-proto
