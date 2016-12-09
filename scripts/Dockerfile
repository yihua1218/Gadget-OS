FROM ubuntu:16.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt -y upgrade
RUN apt -y install wget
RUN apt -y install build-essential
RUN apt -y install bc
RUN apt -y install git
RUN apt -y install locales
RUN apt -y install cpio
RUN apt -y install lib32stdc++6 lib32z1 libc6-i386
RUN apt -y install texinfo
RUN apt -y install vim
RUN apt -y install unzip
RUN apt -y install ncurses-dev
RUN apt -y install python
RUN apt -y install android-tools-fsutils
RUN locale-gen en_US.UTF-8 && \
	echo 'LANG="en_US.UTF-8"' > /etc/default/locale
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.utf8

RUN git clone https://github.com/linux-sunxi/sunxi-tools /opt/sunxi-tools
RUN make -C /opt/sunxi-tools sunxi-nand-image-builder
RUN cp /opt/sunxi-tools/sunxi-nand-image-builder /usr/local/bin
RUN mkdir -p /opt