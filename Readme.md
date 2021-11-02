# Redis Dump

**Note:** _This project is started as a fork of Yann Hamon's [redis-dump-go](https://github.com/yannh/redis-dump-go)._

___

Dumps Redis keys & values to a file. Similar in spirit to https://www.npmjs.com/package/redis-dump and https://github.com/delano/redis-dump but:

* Will dump keys across **several processes & connections**
* Uses SCAN rather than KEYS * for much **reduced memory footprint** with large databases
* Easy to deploy & containerize - **single binary**.
* Generates a [RESP](https://redis.io/topics/protocol) file rather than a JSON or a list of commands. This is **faster to ingest**, and [recommended by Redis](https://redis.io/topics/mass-insert) for mass-inserts.

Warning: like similar tools, `upstash-redis-dump` does NOT provide Point-in-Time backups. Please use [Redis backups methods](https://redis.io/topics/persistence) when possible.

## Features

* Dumps all databases present on the Redis server
* Keys TTL are preserved by default
* Configurable Output (Redis commands, RESP)
* Redis password-authentication

## Installation

```bash
go install github.com/upstash/upstash-redis-dump@latest
```

## Run

```
$ upstash-redis-dump -h
Usage of upstash-redis-dump:
  -batchSize int
        HSET/RPUSH/SADD/ZADD only add 'batchSize' items at a time (default 1000)
  -cacert string
        TLS CACert file path
  -cert string
        TLS Cert file path
  -db uint
        only dump this database (default: all databases)
  -filter string
        Key filter to use (default "*")
  -host string
        Server host (default "127.0.0.1")
  -key string
        TLS Key file path
  -n int
        Parallel workers (default 10)
  -noscan
        Use KEYS * instead of SCAN - for Redis <=2.8
  -output string
        Output type - can be resp or commands (default "resp")
  -pass string
        Server password
  -port int
        Server port (default 6379)
  -s    Silent mode (disable logging of progress / stats)
  -tls
        Enable TLS
  -ttl
        Preserve Keys TTL (default true)

```

## Sample Export 

```bash
$ upstash-redis-dump -db 0 -host eu1-moving-loon-6379.upstash.io -port 6379 -pass PASSWORD -tls > redis.dump
Database 0: 9 keys dumped
```

## Importing the data

```
redis-cli --tls -u redis://REDIS_PASSWORD@gusc1-cosmic-heron-6379.upstash.io:6379 --pipe < redis.dump
```
