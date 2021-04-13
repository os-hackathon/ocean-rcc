#!/bin/bash

yum install -y yum-utils
# Install cudnn
yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
yum clean all
yum install -y libcudnn8
yum install -y libcudnn8-devel

# Install OpenCV
yum install -y opencv opencv-devel opencv-python
