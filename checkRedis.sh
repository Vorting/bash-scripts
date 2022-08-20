#!/bin/bash

# script checkRids.sh checking the status of redis, running it or not

redisPing=$(redis-cli -p 6379 PING)
if [ "$redisPing" = "PONG"  ]; then
	echo 'Already running'
else
	redisRestart=$(systemctl restart redis)
	echo $redisRestart
fi
