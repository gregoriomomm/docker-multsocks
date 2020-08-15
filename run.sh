#!/bin/bash

if [ -z "${SOCKS_CONNECTIONS}" ]; then
   SOCKS_CONNECTIONS=0
fi

for i in $(seq 1 1 ${SOCKS_CONNECTIONS});  do    
    var_socks="SOCKS_$i"
    line="${!var_socks}"
    IFS=':' read -r -a array <<< "$line"
	
	echo tsocks socat TCP4-LISTEN:${array[0]},fork TCP4:${array[1]}:${array[2]}  
	tsocks socat TCP4-LISTEN:${array[0]},fork TCP4:${array[1]}:${array[2]}  &
	
	pids+=($!)
done


echo "Starting http proxy!!!"
tsocks ncat -l --proxy-type http localhost 3128 & 

echo "Starting socks over socks..."
tsocks /microsocks/microsocks 

