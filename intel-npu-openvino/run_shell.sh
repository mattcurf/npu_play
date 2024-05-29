#!/bin/bash

docker run -it --rm --security-opt seccomp=unconfined -v `pwd`:/project -w /project --device /dev/dri:/dev/dri --device /dev/accel:/dev/accel -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY intel-npu-openvino 

