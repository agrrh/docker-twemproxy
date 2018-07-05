# docker-twemproxy

Docker image of [twemproxy](https://github.com/twitter/twemproxy) proxy server in front of [redis](http://redis.io/) instances.

Based on [coderfi/docker-twemproxy](https://github.com/jgoodall/docker-twemproxy), [j3k0/docker-twemproxy](https://github.com/j3k0/docker-twemproxy) and [chiaen/docker-alpine-twemproxy](https://github.com/chiaen/docker-alpine-twemproxy)

## Overview

This image rely on no external service, simply link it to your redis servers.

## Usage

You need to customize the twemproxy configuration in `twemproxy.yml` - particularly the `hash_tag` option:

```
$EDITOR twemproxy.yml
```

Then test deploy could look like:

```
# create network
docker network create twemproxy-test

# start some redis containers
docker run --name=redis-a --rm --network=twemproxy-test redis
docker run --name=redis-b --rm --network=twemproxy-test redis

# start the container
docker run --name=twemproxy --rm --network=twemproxy-test -p 6379:6379 -p 6222:6222 agrrh/twemproxy

# connect using a redis client
redis-cli -h localhost -p 6379

# get stats on cluster (use `docker ps` to get `<ip>`)
http :6222

# cleanup
docker rm -f redis-a
docker rm -f redis-b
docker network rm twemproxy-test
```
