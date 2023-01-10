#!/bin/bash -l

set -eo pipefail

# Check configuration

err=0

if [ -z "$AWS_REGION" ]; then
  echo "error: AWS_REGION is not set"
  err=1
fi

if [ $err -eq 1 ]; then
  exit 1
fi

# Install Hugo
# HUGO_VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.tag_name')
mkdir tmp/ && cd tmp/          
curl -sSL https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_Linux-64bit.tar.gz | tar -xvzf-
mv hugo /usr/local/bin/
cd .. && rm -rf tmp/
cd ${GITHUB_WORKSPACE}
hugo version || exit 1

# Build
if [ "$MINIFY" = "true" ]; then
  hugo --minify
else
  hugo
fi

# Deploy as configured in your repo
hugo deploy

EOF
