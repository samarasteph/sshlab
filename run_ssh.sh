#!/bin/bash

IMG_NAME=sshlab
docker run --network ssh-net -d --rm --name $1 -h $1 $IMG_NAME
./ip.sh $1




