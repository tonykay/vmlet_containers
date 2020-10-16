FROM registry.access.redhat.com/ubi8/ubi-init

MAINTAINER Tony Kay (tok) tok@redhat.com
# https://gist.github.com/lenchevsky/7eba11bd491e70105de3600ec9ec1292

ARG RHN_PASSWORD 
ARG RHN_USERNAME
ENV RHN_PASSWORD=$RHN_PASSWORD
ENV RHN_USERNAME=$RHN_USERNAME

# Install packages

#RUN subscription-manager register --auto-attach --username ${RHN_USERNAME} --password ${RHN_PASSWORD} ; \
#    yum install -y openssh-server openssl certmonger; \

RUN    systemctl enable sshd.service

# Enable root and pos accounts

RUN echo 'root:33103255235331325230' | chpasswd
RUN adduser vagrant && \
    echo 'vagrant:ol2432sn324231024113310' | chpasswd && \
    usermod -aG wheel vagrant
	
# Configure SSHD
RUN mkdir -p /var/run/sshd ; chmod -rx /var/run/sshd
# http://stackoverflow.com/questions/2419412/ssh-connection-stop-at-debug1-ssh2-msg-kexinit-sent
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
# Bad security, add a user and sudo instead!
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# Deploy ssh keys
RUN mkdir /root/.ssh/ &&                  \
	echo ${FOO} > ~/.ssh/authorized_keys && \
	chmod 700 ~/.ssh &&                     \
	chmod 600 ~/.ssh/authorized_keys

RUN mkdir /home/vagrant/.ssh/ && \
	echo "${FOO}" > /home/vagrant/.ssh/authorized_keys &&   \
	chmod 700 /home/vagrant/.ssh &&                         \
	chmod 600 /home/vagrant/.ssh/authorized_keys &&         \
	chown -R vagrant:vagrant /home/vagrant/.ssh/ &&         \
  bash -c 'echo "vagrant ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers'

# Configure vagrant
# RUN bash -c 'echo "vagrant ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'

EXPOSE 22
#EXPOSE 3306
#EXPOSE 8080

CMD ["/usr/sbin/sshd"]
#CMD ["/usr/sbin/init"]
