#!/bin/bash
CONTAINER_NAME=lixg
SSH_PORT=11000
PORT1=`expr $SSH_PORT + 1 `
PORT2=`expr $SSH_PORT + 2 `
PORT3=`expr $SSH_PORT + 3`
PORT4=`expr $SSH_PORT + 4`
docker stop ${CONTAINER_NAME} && docker rm -f ${CONTAINER_NAME}
# if use --privileged, -e NVIDIA_VISIBLE_DEVICES=0 will not work
docker run -d  \
    --restart=always \
    --gpus=all \
    --shm-size=32gb \
    -e DISPLAY=$DISPLAY \
    -p $SSH_PORT:22 \
    -p $PORT1:$PORT1 \
    -p $PORT2:$PORT2 \
    -p $PORT3:$PORT3 \
    -p $PORT4:$PORT4 \
    -v /data/lixg:/root/data \
    -v /data/cpf:/root/cpf \
    -v /data/Public:/root/Public \
    --name ${CONTAINER_NAME} \
    --hostname ${CONTAINER_NAME} \
    ssh-dev:11.1-cudnn8-devel-ubuntu18.04

