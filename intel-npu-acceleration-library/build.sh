#!/bin/bash
docker build -t intel-npu-driver docker 
docker build -t intel-npu-library -f docker/Dockerfile.npu docker

