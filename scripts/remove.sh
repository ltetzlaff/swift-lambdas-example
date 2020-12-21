#!/bin/sh
set -eu
source ./scripts/config.sh
serverless remove --config "./templates/$executable.yml" --stage $1
