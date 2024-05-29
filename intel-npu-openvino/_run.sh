#!/bin/bash
source /opt/intel/openvino_2024.1.0/setupvars.sh
/root/openvino_cpp_samples_build/intel64/Release/hello_query_device
python3 ./download_resnet50.py
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d CPU -hint throughput 
/root/openvino_cpp_samples_build/intel64/Release/benchmark_app -m model/ir_model/resnet50_fp16.xml -d NPU -hint throughput 
