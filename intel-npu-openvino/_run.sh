#!/bin/bash
source /opt/intel/openvino_2024.2.0/setupvars.sh

BENCHMARK="/root/openvino_cpp_samples_build/intel64/Release/benchmark_app"
DEFAULT_ARGS="-d NPU -hint throughput -niter 64 -infer_precision i8"

RUN_BENCHMARK () {
  echo "***" $BENCHMARK -m $1 $DEFAULT_ARGS 
  $BENCHMARK -m $1 $DEFAULT_ARGS 
}

_dir=`pwd`
cd /tmp


/root/openvino_cpp_samples_build/intel64/Release/hello_query_device

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/age-gender-recognition-retail-0013
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/age-gender-recognition-retail-0013/FP16-INT8/age-gender-recognition-retail-0013.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/age-gender-recognition-retail-0013/FP16-INT8/age-gender-recognition-retail-0013.bin
RUN_BENCHMARK age-gender-recognition-retail-0013.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/public/anti-spoof-mn3
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/public/2022.1/anti-spoof-mn3/anti-spoof-mn3.onnx
python3 $_dir/convert.py anti-spoof-mn3.onnx
RUN_BENCHMARK anti-spoof-mn3.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/emotions-recognition-retail-0003
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/emotions-recognition-retail-0003/FP16-INT8/emotions-recognition-retail-0003.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/emotions-recognition-retail-0003/FP16-INT8/emotions-recognition-retail-0003.bin
RUN_BENCHMARK emotions-recognition-retail-0003.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/face-detection-retail-0004
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-retail-0004/FP16-INT8/face-detection-retail-0004.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-retail-0004/FP16-INT8/face-detection-retail-0004.bin
RUN_BENCHMARK face-detection-retail-0004.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/face-detection-retail-0005
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/face-detection-retail-0005/FP16-INT8/face-detection-retail-0005.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/face-detection-retail-0005/FP16-INT8/face-detection-retail-0005.bin
RUN_BENCHMARK face-detection-retail-0005.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/facial-landmarks-35-adas-0002
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/facial-landmarks-35-adas-0002/FP16-INT8/facial-landmarks-35-adas-0002.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/facial-landmarks-35-adas-0002/FP16-INT8/facial-landmarks-35-adas-0002.bin
RUN_BENCHMARK facial-landmarks-35-adas-0002.xml

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/head-pose-estimation-adas-0001
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/head-pose-estimation-adas-0001/FP16-INT8/head-pose-estimation-adas-0001.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/head-pose-estimation-adas-0001/FP16-INT8/head-pose-estimation-adas-0001.bin
RUN_BENCHMARK head-pose-estimation-adas-0001.xml

# Failed: Requires dynamic shape support
#wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-0205/FP16-INT8/face-detection-0205.xml
#wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-0205/FP16-INT8/face-detection-0205.bin
#RUN_BENCHMARK face-detection-0205.xml

wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/unet-camvid-onnx-0001/FP16-INT8/unet-camvid-onnx-0001.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/unet-camvid-onnx-0001/FP16-INT8/unet-camvid-onnx-0001.bin
RUN_BENCHMARK unet-camvid-onnx-0001.xml

# ResNet50 via PyTorch torchvision
python3 $_dir/download_resnet50.py
RUN_BENCHMARK model/ir_model/resnet50_fp16.xml

# https://github.com/WongKinYiu/yolov7
git clone https://github.com/WongKinYiu/yolov7
git config --global --add safe.directory yolov7
cd yolov7/
python3 -W ignore export.py --weights yolov7-tiny.pt --grid 2>&1 /dev/null
python3 $_dir/convert.py yolov7-tiny.onnx
RUN_BENCHMARK yolov7-tiny.xml
cd ..

# https://github.com/lukemelas/EfficientNet-PyTorch
python3 $_dir/download_efficientnet-b4.py
python3 $_dir/convert.py efficientnet-b4.onnx
RUN_BENCHMARK efficientnet-b4.xml
