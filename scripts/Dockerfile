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
	lzop && \
	rm -rf /var/lib/apt-lists/* && \
	locale-gen en_US.UTF-8 && \
	echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
	git clone https://github.com/linux-sunxi/sunxi-tools /opt/sunxi-tools && \
	make -C /opt/sunxi-tools sunxi-nand-image-builder && \
	cp /opt/sunxi-tools/sunxi-nand-image-builder /usr/local/bin && \
	mkdir -p /opt/buildroot && \
	mkdir -p /opt/output && \
	mkdir -p /opt/dlcache && \
	wget -P /opt "https://github.com/buildroot/buildroot/archive/2017.05.tar.gz" && \
	tar -C /opt/buildroot -xzf /opt/2017.05.tar.gz --strip-components=1
