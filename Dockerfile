FROM rastasheep/ubuntu-sshd


RUN useradd -ms /bin/bash aldu
RUN echo aldu:aldu |chpasswd
#USER aldu
RUN mkdir  /home/aldu/.ssh

COPY sshd_config /etc/ssh
COPY nc /bin/nc
COPY id_rsa.pub /home/aldu/.ssh/authorized_keys

