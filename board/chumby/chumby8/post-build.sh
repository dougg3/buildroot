#!/bin/sh

BOARD_DIR="$(dirname $0)"

# Make sure we have a directory to use as a mountpoint
mkdir -p ${TARGET_DIR}/mnt/settings

# Populate settings partition
mkdir -p ${BINARIES_DIR}/settings
cp ${BOARD_DIR}/touchscreen.conf ${BINARIES_DIR}/settings/
