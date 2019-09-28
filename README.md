# sshlab
ssh lab with docker. Usecases of redirection ports.

* _ssh: replace ssh command with some hacks to generate host file for ip resolution. 
* run_ssh.sh: run sshlab docker instance with hostname as parameter.
* ip.sh: extract IP addresses from docker configuration and store in host file (default myhosts). Called on running docker image.
* resolve.sh: read host file to find which ip is matching hostname passed as parameter. Called when running _ssh.



# Redirection port SSH 
							


I - local port redirection: 
----------------------------

client ssh et tcp are on same machine.

ssh -L port-local:HOSTNAME:port-dist machine-dist

M0:port-local -----> machine-distant:22 --------> HOSTNAME:port-dist

I-a- local connection between 127.0.0.1/ssh0 and ssh1 par ssh2
--------------------------------------------------------------------

ssh -L 12346:172.19.0.1:8934 aldu@171.19.0.2
ssh -L 12346:ssh0:8934 aldu@ssh2

ssh0: nc -l -p 8934 172.19.0.1
ssh0: nc 127.0.0.1 12346

I-b- connection between 127.0.0.1 and ssh1/127.0.0.1
--------------------------------------------------

ssh -L 12347:localhost:8934 aldu@172.0.0.2
ssh -L 12347:localhost:8934 aldu@ssh2

sur server ssh2: nc -l -p 8934 127.0.0.1
sur client ssh0: nc 127.0.0.1 12347

II - distant port redirection
------------------------------

Ssh client and tcp server on same side. 

ssh -R port-distant:HOSTNAME:port-local machine-distant

machine-distante:port-distant ----> M0 ---------> HOSTNAME:port-local

II-a- redirection between distant machines ssh1 and ssh2
--------------------------------------------------------
ssh -R  12347:ssh2:9743 aldu@ssh1

redirect from ssh1/127.0.0.1:12347 to ssh2:9743 through 172.19.0.1

ssh2: nc -l -p 9743
ssh1: nc localhost 12347

II-b- Distant machines redirection ssh2 and ssh1
--------------------------------------------------

ssh -R 23478:ssh1:7777 aldu@ssh2

ssh2: nc -v localhost 23478
ssh1: nc -l -p 7777 ssh1

II-c- redirection M0 ssh1
-------------------------

ssh -R 12456:localhost:8956 aldu@ssh1

ssh1: nc -v localhost 12456
M0: nc -l -p 8956 localhost
