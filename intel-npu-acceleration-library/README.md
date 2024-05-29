# npu_play

This repo demonstrates the setup of all required Intel NPU user-space drivers and software for use with intel-npu-acceleration-library. 

## Prerequisite

The NPU device uses a precompiled firmware blob that needs to be updated on the host outside of the docker environment.  The following steps will install the required firmware blob upon the next system reboot:
```
$ wget https://github.com/intel/linux-npu-driver/releases/download/v1.2.0/intel-fw-npu_1.2.0.20240404-8553879914_ubuntu22.04_amd64.deb 
$ sudo dpkg -i *.deb
$ sudo reboot
```
## Usage

To build the containers, type:
```
$ ./build.sh
```

To execute the a simple matrix mult example using the Intel NPU Acceleration Library:
```
$ ./run.sh
```

