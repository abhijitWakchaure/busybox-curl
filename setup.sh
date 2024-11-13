#!/usr/bin/env bash

# create tmp dir
tmpDir="./tmp"
rm -rf ${tmpDir}
mkdir ${tmpDir}

# create bin dir
binDir="./bin"
rm -rf ${binDir}
mkdir ${binDir} 

# Tools versions
CURL_VERSION="8.9.1"
YQ_VERSION="3.4.1"
JQ_VERSION="1.7.1"

echo "Downloading curl ${CURL_VERSION}..."
wget -q -O ${tmpDir}/curl.tar.gz https://github.com/stunnel/static-curl/releases/download/${CURL_VERSION}/curl-linux-x86_64-${CURL_VERSION}.tar.xz


echo "Extracting curl.tar.gz..."
pushd ${tmpDir}
	mkdir extract-curl
	tar -xf curl.tar.gz -C ./extract-curl
	mv extract-curl/curl ../${binDir}
	# cleanup
	rm -rf extract-curl curl.tar.gz
popd
echo "Copied curl to ${binDir}"

echo "Downloading yq ${YQ_VERSION}..."
wget -q -O ${tmpDir}/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64
chmod +x ${tmpDir}/yq
mv ${tmpDir}/yq ${binDir}
echo "Copied yq to ${binDir}"

echo "Downloading jq ${JQ_VERSION}..."
wget -q -O ${tmpDir}/jq https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64
chmod +x ${tmpDir}/jq
mv ${tmpDir}/jq ${binDir}
echo "Copied jq to ${binDir}"

# Check if upx is installed
if command -v upx &> /dev/null
then
    echo "UPX is installed. Compressing binaries..."
    upx -9 ${binDir}/*
else
    echo "UPX is not installed. Skipping compression."
fi
