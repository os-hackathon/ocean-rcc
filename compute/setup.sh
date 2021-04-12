#!/bin/bash

yum install -y yum-utils
# Install cudnn
yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
yum clean all
yum -y update
yum install -y libcudnn8
yum install -y libcudnn8-devel

# Install OpenCV
yum install -y opencv opencv-devel opencv-python


# Revert to ROCm 4.0.1
yum remove -y rocm-dev
cat > /etc/yum.repos.d/rocm.repo  << EOL
[ROCm]
name=ROCm
baseurl=https://repo.radeon.com/rocm/yum/4.0.1
enabled=1
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOL
yum clean all
yum update -y
yum install -y rocm-dev

