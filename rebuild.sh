#!/bin/bash

#docker rmi sshlab
cp /bin/nc.openbsd ./nc
cp ~/.ssh/id_rsa.pub ./

docker build . -t sshlab

rm nc id_rsa.pub
