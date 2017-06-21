FROM docker:dind

RUN apk add --update openssh

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN mkdir -p /var/run/sshd

RUN ln -s $(which docker) /usr/bin/docker

ADD authorized_keys /root/.ssh/authorized_keys

CMD /usr/sbin/sshd -D & dockerd 
