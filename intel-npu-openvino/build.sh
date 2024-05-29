#!/bin/bash
docker build -t intel-npu-driver docker 
docker build -t intel-npu-openvino -f docker/Dockerfile.openvino docker

