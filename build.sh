#!/bin/bash
docker build . --build-arg NVIDIA_CUDA_TAG=11.1-cudnn8-devel-ubuntu18.04   -t ssh-dev:11.1-cudnn8-devel-ubuntu18.04
