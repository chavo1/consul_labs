#!/usr/bin/env bash

which redis-server 2>/dev/null || {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y redis-server redis-tools
  sed -i 's/bind.*/bind 0.0.0.0/' /etc/redis/redis.conf
  update-rc.d redis-server defaults
}
/etc/init.d/redis-server status 2>/dev/null && /etc/init.d/redis-server force-reload 2>/dev/null || /etc/init.d/redis-server start 2>/dev/null


# If service is not present in the /etc/conul.d folder creates a service file
if [ ! -f "/etc/consul.d/redis.json" ]; then
	
	# Creates folder
	sudo mkdir -p /etc/consul.d
	sudo chmod a+w /etc/consul.d	
	
	#Creates File
	echo '{"service": {"name": "redis", "tags": ["redis-server"], "port": 6379}}' | sudo tee /etc/consul.d/redis.json

fi


