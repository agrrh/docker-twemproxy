#!/bin/bash
cp /twemproxy.yml.in /twemproxy.yml
LINKS="$(env|grep '_TCP='|cut -d/ -f3|sort|uniq)"
index=1
for server in $LINKS; do
	echo "    - $server:1 server$index" >> /twemproxy.yml
	index=$((index + 1))
done
nutcracker -c /twemproxy.yml -v 7 -s 6222
