#!/bin/sh
set -eu
source ./scripts/config.sh

workspace="$(pwd)"

docker build . -t builder
docker run --rm -v "$workspace":/workspace -w /workspace builder \
       bash -cl "swift build --product $executable -c release"
docker run --rm -v "$workspace":/workspace -w /workspace builder \
       bash -cl "./scripts/package.sh $executable"
echo "done"

serverless deploy --config "./templates/$executable.yml" --stage $1
