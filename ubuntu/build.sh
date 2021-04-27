#!/bin/bash
set -eu

DNAME="${USER}/nissi-dev:1.0"
docker build -t ${DNAME} .
