#!/usr/bin/env bash

# Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


source utils/header.sh
RUN_BIN="utils/run_bin.sh"

[[ ! -e $RUN_BIN ]] && { echo "ERROR: $RUN_BIN missing"; exit 1; }

now=$(date +%F-%T)
OUT_DIR=$PREFIX/outputs/out_libmp_${now}
mkdir -p $OUT_DIR

#Examples
printf "\n### LibMP Examples ###\n"

echo "Running mp_putget..."
ofile=$OUT_DIR/mp_putget.stdout
efile=$OUT_DIR/mp_putget.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_putget 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_sendrecv..."
ofile=$OUT_DIR/mp_sendrecv.stdout
efile=$OUT_DIR/mp_sendrecv.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_sendrecv 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_sendrecv_kernel..."
ofile=$OUT_DIR/mp_sendrecv_kernel.stdout
efile=$OUT_DIR/mp_sendrecv_kernel.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_sendrecv_kernel 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_sendrecv_stream..."
ofile=$OUT_DIR/mp_sendrecv_stream.stdout
efile=$OUT_DIR/mp_sendrecv_stream.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_sendrecv_stream 1>$ofile 2>$efile
check_errors $efile $ofile $?

#Benchmarks
printf "\n### LibMP Benchmarks ###\n"

echo "Running mp_pingpong_all..."
ofile=$OUT_DIR/mp_pingpong_all.stdout
efile=$OUT_DIR/mp_pingpong_all.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_pingpong_all 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_pingpong_kernel..."
ofile=$OUT_DIR/mp_pingpong_kernel.stdout
efile=$OUT_DIR/mp_pingpong_kernel.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_pingpong_kernel 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_pingpong_kernel_stream..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_pingpong_kernel_stream_latency..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream_latency.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream_latency.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream_latency 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_pingpong_kernel_stream_latency_mpi..."
ofile=$OUT_DIR/mp_pingpong_kernel_stream_latency_mpi.stdout
efile=$OUT_DIR/mp_pingpong_kernel_stream_latency_mpi.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_pingpong_kernel_stream_latency_mpi 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_producer_consumer_kernel_stream..."
ofile=$OUT_DIR/mp_producer_consumer_kernel_stream.stdout
efile=$OUT_DIR/mp_producer_consumer_kernel_stream.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_producer_consumer_kernel_stream 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running mp_sendrecv_kernel_stream..."
ofile=$OUT_DIR/mp_sendrecv_kernel_stream.stdout
efile=$OUT_DIR/mp_sendrecv_kernel_stream.stderr
$RUN_BIN 2 0 0 0 $PREFIX_LIBS/bin/mp_sendrecv_kernel_stream 1>$ofile 2>$efile
check_errors $efile $ofile $?

:<<COMMENT

printf "\n### LibMP-COMM ###\n"

echo "Running comm_pingpong..."
ofile=$OUT_DIR/comm_pingpong.stdout
efile=$OUT_DIR/comm_pingpong.stderr
$RUN_BIN 2 1 1 0 $PREFIX_LIBS/bin/comm_pingpong 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running comm_pingpong, I-ODP..."
ofile=$OUT_DIR/comm_pingpong_iodp.stdout
efile=$OUT_DIR/comm_pingpong_iodp.stderr
$RUN_BIN 2 1 1 0 $PREFIX_LIBS/bin/comm_pingpong -o 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running comm_pingpong, GMEM..."
ofile=$OUT_DIR/comm_pingpong_gmem.stdout
efile=$OUT_DIR/comm_pingpong_gmem.stderr
$RUN_BIN 2 1 1 0 $PREFIX_LIBS/bin/comm_pingpong -g 1>$ofile 2>$efile
check_errors $efile $ofile $?

COMMENT

echo ""
echo "Outputs in $OUT_DIR"
