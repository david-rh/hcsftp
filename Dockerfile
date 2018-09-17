# Hc-erp-host for sftp 
FROM registry.access.redhat.com/rhel7/rhel
MAINTAINER Cheriyan Thomas <cthomas@hc.hctx.net> 

RUN yum -y update; yum clean all 
RUN yum -y install openssh-server openssh-clients crontabs rsync passwd; yum clean all 

ADD sshd_config /etc/ssh/sshd_config 
ADD ./start.sh /start.sh 

RUN mkdir /var/run/sshd 

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN chmod 640 /etc/ssh/ssh_host_rsa_key
RUN chgrp ssh_keys /etc/ssh/ssh_host_rsa_key
RUN ls -l /etc/ssh/ssh_host*

RUN chmod 755 /start.sh 
RUN ./start.sh 

EXPOSE 22 

ENTRYPOINT ["/usr/sbin/sshd", "-de"]
