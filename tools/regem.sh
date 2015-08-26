#!/bin/bash

set -e

GEM_NAME="hiera-eyaml-kms"

gem uninstall ${GEM_NAME} --executables
RAKE_OUT=`rake build`
VERSION=`echo ${RAKE_OUT} | awk '{print $2}'`
echo Installing version: ${VERSION} ...
gem install pkg/${GEM_NAME}-${VERSION}.gem --no-ri --no-rdoc

if [ ! -z "$(which eyaml)" ];then
  eyaml version
else
  echo "install hiera-eyaml to see if gem imports correctly"
fi
