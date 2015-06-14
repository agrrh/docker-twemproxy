#!/bin/bash
cp /twemproxy.yml.in /twemproxy.yml
LINKS="$(env|grep '_TCP='|cut -d/ -f3|sort|uniq)"
index=1
if [[ -n $REDIS_AUTH ]]; then
	echo "  redis_auth: $REDIS_AUTH" >> /twemproxy.yml
fi
echo "  servers:" >> /twemproxy.yml
for server in $LINKS; do
	echo "    - $server:1 server$index" >> /twemproxy.yml
	index=$((index + 1))
done
nutcracker -c /twemproxy.yml -v 7 -s 6222
