#!/bin/bash
set -eu

NAME="nissi-dev"
IMAGE="${USER}/${NAME}:1.0"
HOSTNAME="nissi-dev"
SRCDIR="${HOME}/dev"
BUILDDIR="${SRCDIR}/docker/ubuntu"

docker run --rm -it --name ${NAME} --hostname=${HOSTNAME} -v ${SRCDIR}:${SRCDIR} ${IMAGE}