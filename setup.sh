#!/usr/bin/env bash

# create tmp dir
tmpDir="./tmp"
rm -rf ${tmpDir}
mkdir ${tmpDir}

# create bin dir
binDir="./bin"
rm -rf ${binDir}
mkdir ${binDir} 

# Download curl
CURL_VERSION="8.9.1"

wget -O ${tmpDir}/curl.tar.gz https://github.com/stunnel/static-curl/releases/download/${CURL_VERSION}/curl-linux-x86_64-${CURL_VERSION}.tar.xz

echo "Extracting curl.tar.gz..."
pushd ${tmpDir}
	mkdir extract-curl
	tar -xvf curl.tar.gz -C ./extract-curl
	mv extract-curl/curl ../${binDir}
	# cleanup
	rm -rf extract-curl curl.tar.gz
popd
echo "Copied curl to ${binDir}"

