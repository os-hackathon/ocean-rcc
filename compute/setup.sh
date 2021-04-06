#!/bin/bash


# Disable repos that are currently causing issues with yum
yum install -y yum-utils
yum-config-manager --disable gcsfuse
yum-config-manager --disable google-cloud-logging
yum-config-manager --disable google-cloud-monitoring
yum-config-manager --disable google-cloud-sdk
yum-config-manager --disable google-compute-engine
yum clean all
yum -y update

# Install cudnn
yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
yum clean all
yum -y update
yum install -y libcudnn8
yum install -y libcudnn8-devel


