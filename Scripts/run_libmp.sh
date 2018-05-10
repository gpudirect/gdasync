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
OUT_DIR=$PREFIX_LIBS/out_libmp_${now}
mkdir -p $OUT_DIR

#Examples
echo "### LibMP examples ###"

echo "Running mp_putget..."
ofile=$OUT_DIR/mp_putget.stdout
efile=$OUT_DIR/mp_putget.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_putget 1>$ofile 2>$efile

echo "Running mp_sendrecv..."
ofile=$OUT_DIR/mp_sendrecv.stdout
efile=$OUT_DIR/mp_sendrecv.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_sendrecv 1>$ofile 2>$efile

echo "Running mp_sendrecv_kernel..."
ofile=$OUT_DIR/mp_sendrecv_kernel.stdout
efile=$OUT_DIR/mp_sendrecv_kernel.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_sendrecv_kernel 1>$ofile 2>$efile

echo "Running mp_sendrecv_stream..."
ofile=$OUT_DIR/mp_sendrecv_stream.stdout
efile=$OUT_DIR/mp_sendrecv_stream.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_sendrecv_stream 1>$ofile 2>$efile

#Benchmarks
echo "### LibMP benchmarks ###"

echo "Running mp_pingpong_all..."
ofile=$OUT_DIR/mp_pingpong_all.stdout
efile=$OUT_DIR/mp_pingpong_all.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_pingpong_all 1>$ofile 2>$efile

echo "Running mp_pingpong_kernel..."
ofile=$OUT_DIR/mp_pingpong_kernel.stdout
efile=$OUT_DIR/mp_pingpong_kernel.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_pingpong_kernel 1>$ofile 2>$efile

echo "Running mp_pingpong_kernel_stream..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream 1>$ofile 2>$efile

echo "Running mp_pingpong_kernel_stream_latency..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream_latency.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream_latency.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream_latency 1>$ofile 2>$efile

echo "Running mp_pingpong_kernel_stream_latency_mpi..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream_latency_mpi.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream_latency_mpi.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream_latency_mpi 1>$ofile 2>$efile

echo "Running mp_producer_consumer_kernel_stream..."
ofile=$OUT_DIR/mp_producer_consumer_kernel_stream.stdout
efile=$OUT_DIR/mp_producer_consumer_kernel_stream.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_producer_consumer_kernel_stream 1>$ofile 2>$efile

echo "Running mp_sendrecv_kernel_stream..."
ofile=$OUT_DIR/mp_sendrecv_kernel_stream.stdout
efile=$OUT_DIR/mp_sendrecv_kernel_stream.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/mp_sendrecv_kernel_stream 1>$ofile 2>$efile

echo ""
echo "Outputs in $OUT_DIR"
