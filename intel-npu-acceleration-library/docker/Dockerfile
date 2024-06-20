FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=america/los_angeles

# Install base packages
#-----------------------
RUN apt update && \
  apt install --no-install-recommends -q -y \
    ca-certificates \
    gnupg \
    libtbb12 \ 
    software-properties-common \
    wget

# Install Intel NPU compute user-space drivers
RUN mkdir -p /tmp/npu && \
  cd /tmp/npu && \
  wget https://github.com/oneapi-src/level-zero/releases/download/v1.17.2/level-zero_1.17.2+u22.04_amd64.deb && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.5.0/intel-driver-compiler-npu_1.5.0.20240619-9582784383_ubuntu22.04_amd64.deb && \
  wget https://github.com/intel/linux-npu-driver/releases/download/v1.5.0/intel-level-zero-npu_1.5.0.20240619-9582784383_ubuntu22.04_amd64.deb && \
  dpkg -i *.deb && \
  rm *.deb

