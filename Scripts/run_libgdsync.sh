#!/usr/bin/env bash

# Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

source header.sh
[[ ! -e run_bin.sh ]]	&& { echo "ERROR: run_bin.sh missing"; exit 1; }

now=$(date +%F-%T)
OUT_DIR=$PREFIX_LIBS/out_libgdsync_${now}
mkdir -p $OUT_DIR

echo "Running gds_sanity..."
ofile=$OUT_DIR/gds_sanity.stdout
efile=$OUT_DIR/gds_sanity.stderr
./run_bin.sh 1 gds_sanity 1>$ofile 2>$efile

echo "Running gds_kernel_loopback_latency..."
ofile=$OUT_DIR/gds_kernel_loopback_latency.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency.stderr
./run_bin.sh 1 gds_kernel_loopback_latency 1>$ofile 2>$efile

echo "Running gds_kernel_latency..."
ofile=$OUT_DIR/gds_kernel_latency.stdout
efile=$OUT_DIR/gds_kernel_latency.stderr
./run_bin.sh 2 gds_kernel_latency 1>$ofile 2>$efile

echo "Running gds_poll_lat..."
ofile=$OUT_DIR/gds_poll_lat.stdout
efile=$OUT_DIR/gds_poll_lat.stderr
./run_bin.sh 2 gds_poll_lat 1>$ofile 2>$efile

echo ""
echo "Outputs in $OUT_DIR"
