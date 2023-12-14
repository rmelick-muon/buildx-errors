#!/usr/bin/env bash
docker buildx create --name container --driver=docker-container default

docker buildx build -t base:local -f base.dockerfile --builder=container --load .

docker buildx build -t second:local -f second.dockerfile --builder=container .
