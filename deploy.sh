#!/bin/bash
export DOCKER_CLI_EXPERIMENTAL=enabled
echo "$DOCKER_PASSWORD" | docker login -u "barrelmaker97" --password-stdin
docker push barrelmaker97/friendbot
docker manifest create barrelmaker97/friendbot:latest barrelmaker97/friendbot:amd64 barrelmaker97/friendbot:arm64v8 barrelmaker97/friendbot:arm32v7
docker manifest annotate barrelmaker97/friendbot:latest barrelmaker97/friendbot:amd64 --os linux --arch amd64
docker manifest annotate barrelmaker97/friendbot:latest barrelmaker97/friendbot:arm64v8 --os linux --arch arm64 --variant v8
docker manifest annotate barrelmaker97/friendbot:latest barrelmaker97/friendbot:arm32v7 --os linux --arch arm --variant v7
docker manifest push barrelmaker97/friendbot:latest
