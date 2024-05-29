#!/bin/bash
docker run -it --rm -v `pwd`:/project -w /project --device /dev/accel:/dev/accel intel-npu-library /bin/bash _run.sh 

