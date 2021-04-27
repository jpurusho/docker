#!/bin/bash
set -eu

IMAGE_TAG="${USER}/nissi-dev:1.0"
docker build -t ${IMAGE_TAG} .
