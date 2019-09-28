#!/bin/bash

CMD_STR=$*

if [ -z "$HOSTALIASES" ]; then
	HOSTALIASES=./myhosts
fi
	
while read LINE ; do 

	if [ -n "$LINE" ]; then

		IP=$(echo $LINE | awk '{print $1}')
		HOST=$(echo $LINE | awk '{print $2}')

		if [[ $CMD_STR == *$HOST* ]] 
		then 
			CMD_STR=$(echo "$CMD_STR" | sed "s/$HOST/$IP/g")
		fi
	fi
done < $HOSTALIASES

echo $CMD_STR
