docker-twemproxy
================

Docker image of [twemproxy](https://github.com/twitter/twemproxy) proxy server in front of [redis](http://redis.io/) instances. 

Based on [coderfi/docker-twemproxy](https://github.com/jgoodall/docker-twemproxy)

## Overview

This image rely on no external service, simply link it to your redis servers.

## Usage

You may want to customize the twemproxy configuration in `twemproxy.yml.in` - particularly the `hash_tag` option.

    # start some redis containers
    docker run --name=redis-a --rm dockerfile/redis
    docker run --name=redis-b --rm dockerfile/redis

    # start the container
    docker run --name=twemproxy --rm --link redis-b:a --link redis-b:b -p 6379:6379 -p 6222:6222 ganomede/twemproxy

    # connect using a redis client
    redis-cli -h localhost -p 6379

    # get stats on cluster (use `docker ps` to get `<ip>`)
    curl localhost:6222
