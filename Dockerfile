# Hc-erp-host for sftp 
FROM centos:centos7 
MAINTAINER Cheriyan Thomas <cthomas@hc.hctx.net> 

RUN yum -y update; yum clean all 
RUN yum -y install openssh-server openssh-clients crontabs rsync passwd; yum clean all 

ADD sshd_config /etc/ssh/sshd_config 
ADD ./start.sh /start.sh 

RUN mkdir /var/run/sshd 

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh 
EXPOSE 22 
RUN ./start.sh 

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
