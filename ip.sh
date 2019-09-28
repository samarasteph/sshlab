#!/bin/bash

#REG_EXP2="$(echo $REG_EXP | sed -e 's/{/\\{/g; s/}/\\}/g')"

DOCKER_HOSTNAME=$1
IP_ADDR=$(docker inspect $1 | grep -i ipaddress | awk '
BEGIN{
	rgx="[0-9]{1,3}(.[0-9]{1,3}){3}";
	#rgx=$REG_EXP;
} 
{ 
	if (match($0,rgx)){ 
		p=substr($0,RSTART,RLENGTH); 
		printf("%s",p,$1); 
	} 
}') 

if [ -z "$HOSTALIASES" ]; then
	HOSTFILE=./myhosts
else
	HOSTFILE=$HOSTALIASES
fi


sed -i '/$IP_ADDR/d' $HOSTFILE
#echo #"[DOCKER TAG] Docker containers host names update" >> $HOSTFILE
echo $IP_ADDR $DOCKER_HOSTNAME >> $HOSTFILE

echo [$1 $IP_ADDR] entry added in $HOSTFILE file
