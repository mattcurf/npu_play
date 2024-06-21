#!/bin/bash
source /opt/intel/openvino_2024.2.0/setupvars.sh

_dir=`pwd`
cd /tmp

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/age-gender-recognition-retail-0013
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/age-gender-recognition-retail-0013/FP16-INT8/age-gender-recognition-retail-0013.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/age-gender-recognition-retail-0013/FP16-INT8/age-gender-recognition-retail-0013.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m age-gender-recognition-retail-0013.xml -d NPU -hint throughput 

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/public/anti-spoof-mn3
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/public/2022.1/anti-spoof-mn3/anti-spoof-mn3.onnx
python3 $_dir/convert.py anti-spoof-mn3.onnx
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m anti-spoof-mn3.xml -d NPU -hint throughput

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/emotions-recognition-retail-0003
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/emotions-recognition-retail-0003/FP16-INT8/emotions-recognition-retail-0003.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/emotions-recognition-retail-0003/FP16-INT8/emotions-recognition-retail-0003.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m emotions-recognition-retail-0003.xml -d NPU -hint throughput 

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/face-detection-retail-0004
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-retail-0004/FP16-INT8/face-detection-retail-0004.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-retail-0004/FP16-INT8/face-detection-retail-0004.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m face-detection-retail-0004.xml -d NPU -hint throughput 

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/face-detection-retail-0005
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/face-detection-retail-0005/FP16-INT8/face-detection-retail-0005.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/face-detection-retail-0005/FP16-INT8/face-detection-retail-0005.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m face-detection-retail-0005.xml -d NPU -hint throughput

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/facial-landmarks-35-adas-0002
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/facial-landmarks-35-adas-0002/FP16-INT8/facial-landmarks-35-adas-0002.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/facial-landmarks-35-adas-0002/FP16-INT8/facial-landmarks-35-adas-0002.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m facial-landmarks-35-adas-0002.xml -d NPU -hint throughput 

# https://github.com/openvinotoolkit/open_model_zoo/tree/master/models/intel/head-pose-estimation-adas-0001
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/head-pose-estimation-adas-0001/FP16-INT8/head-pose-estimation-adas-0001.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/head-pose-estimation-adas-0001/FP16-INT8/head-pose-estimation-adas-0001.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m head-pose-estimation-adas-0001.xml -d NPU -hint throughput

# Failed: Requires dynamic shape support
#wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-0205/FP16-INT8/face-detection-0205.xml
#wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2022.3/models_bin/1/face-detection-0205/FP16-INT8/face-detection-0205.bin
#/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m face-detection-0205.xml -d NPU -hint throughput

wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/unet-camvid-onnx-0001/FP16-INT8/unet-camvid-onnx-0001.xml
wget https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/unet-camvid-onnx-0001/FP16-INT8/unet-camvid-onnx-0001.bin
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m unet-camvid-onnx-0001.xml -d NPU -hint throughput

# ResNet50 via PyTorch torchvision
/root/openvino_cpp_samples_build/intel64/Release/hello_query_device
python3 $_dir/download_resnet50.py
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d NPU -hint throughput 

# https://github.com/WongKinYiu/yolov7
git clone https://github.com/WongKinYiu/yolov7
git config --global --add safe.directory yolov7
cd yolov7/
python3 -W ignore export.py --weights yolov7-tiny.pt --grid
python3 $_dir/convert.py yolov7-tiny.onnx
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m  yolov7-tiny.xml -d NPU -hint throughput
cd ..

# https://github.com/lukemelas/EfficientNet-PyTorch
$_dir/download_efficientnet-b4.py
$_dir/convert.py efficientnet-b4
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m efficientnet-b4.xml -d NPU
