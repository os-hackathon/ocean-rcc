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


cat <<EOT >> /opt/spack/etc/spack/packages.yaml
  hip:
    buildable: false
    externals:
    - spec: hip@4.3.1
      prefix: /opt/rocm
EOT

COMPILERS=("gcc@11.2.0"
           "gcc@10.3.0"
	   "gcc@9.4.0")

for COMPILER in "${COMPILERS[@]}"; do
    spack_install "hipfort@4.3.1 % ${COMPILER} target=x86_64"
done

if [[ -n "$SPACK_BUCKET" ]]; then
    spack mirror rm RCC
fi

spack gc -y

cat /dev/null > /var/log/messages
