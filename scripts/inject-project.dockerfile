FROM docker:dind

RUN apk add --update openssh tar

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN mkdir -p /var/run/sshd
RUN mkdir -p /data/root/
RUN rmdir /root
RUN ln -s /data/root /root

RUN ln -s $(which docker) /usr/bin/docker

ADD authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

CMD /usr/sbin/sshd -D & dockerd --storage-driver overlay2
