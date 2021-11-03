#!/bin/bash

spack_install() {
  # This function attempts to install from the cache. If this fails, 
  # then it will install from source and create a buildcache for this package
  source /etc/profile.d/z10_spack_environment.sh 
  if [[ -n "$SPACK_BUCKET" ]]; then
    spack buildcache install "$1" || \
  	  ( spack install --no-cache "$1" && \
  	    spack buildcache create -a --rebuild-index \
  	                            -k ${INSTALL_ROOT}/spack/share/RCC_gpg \
				    -m RCC \
				    -f "$1" )
  else
     spack install "$1"
  fi
}

source /etc/profile.d/z10_spack_environment.sh 
spack install cmake % gcc@4.8.5
spack load cmake
spack load gcc@10.3.0
git clone https://github.com/ROCmSoftwarePlatform/hipfort /tmp/hipfort
mkdir /tmp/hipfort/build ; cd /tmp/hipfort/build
cmake -DHIPFORT_INSTALL_DIR=/opt/rocm ..
make install

if [[ -n "$SPACK_BUCKET" ]]; then
    spack mirror rm RCC
fi

cat /dev/null > /var/log/messages
