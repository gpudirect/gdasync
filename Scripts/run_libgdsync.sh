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
[[ ! -e utils/run_bin.sh ]]	&& { echo "ERROR: utils/run_bin.sh missing"; exit 1; }

now=$(date +%F-%T)
OUT_DIR=$PREFIX/outputs/out_libgdsync_${now}
mkdir -p $OUT_DIR

# ================== gds_sanity ==================

echo "Running gds_sanity"
ofile=$OUT_DIR/gds_sanity.stdout
efile=$OUT_DIR/gds_sanity.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_sanity, NOR"
ofile=$OUT_DIR/gds_sanity_nor.stdout
efile=$OUT_DIR/gds_sanity_nor.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -N 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_sanity, membar"
ofile=$OUT_DIR/gds_sanity_membar.stdout
efile=$OUT_DIR/gds_sanity_membar.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -m 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_sanity, GMEM buffers"
ofile=$OUT_DIR/gds_sanity_gmem.stdout
efile=$OUT_DIR/gds_sanity_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -g 1>$ofile 2>$efile
check_errors $efile $ofile $?


echo "Running gds_sanity, GMEM buffers, NOR"
ofile=$OUT_DIR/gds_sanity_gmem_nor.stdout
efile=$OUT_DIR/gds_sanity_gmem_nor.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -g -N 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_sanity, GMEM buffers, membar"
ofile=$OUT_DIR/gds_sanity_gmem_membar.stdout
efile=$OUT_DIR/gds_sanity_gmem_membar.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -g -m 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_sanity, GMEM buffers, GDR flush"
ofile=$OUT_DIR/gds_sanity_gmem.stdout
efile=$OUT_DIR/gds_sanity_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_sanity -g -f 1>$ofile 2>$efile
check_errors $efile $ofile $?

# ============ gds_kernel_loopback_latency ============

echo "Running gds_kernel_loopback_latency peersync"
ofile=$OUT_DIR/gds_kernel_loopback_latency_peersync.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_peersync.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_loopback_latency peersync, nokernel"
ofile=$OUT_DIR/gds_kernel_loopback_latency_peersync_nok.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_peersync_nok.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -K 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_loopback_latency peersync, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_loopback_latency_peersync_gmem.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_peersync_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -E 1>$ofile 2>$efile
check_errors $efile $ofile $?
# -------------
echo "Running gds_kernel_loopback_latency peersync, descriptors"
ofile=$OUT_DIR/gds_kernel_loopback_latency_peersync_descs.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_peersync_descs.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -U 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_loopback_latency peersync, descriptors, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_loopback_latency_peersync_descs_gmem.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_peersync_descs_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -U -E 1>$ofile 2>$efile
check_errors $efile $ofile $?

# -------------
echo "Running gds_kernel_loopback_latency !peersync, descriptors"
ofile=$OUT_DIR/gds_kernel_loopback_latency_no_peersync.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_no_peersync.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -P -U 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_loopback_latency !peersync, descriptors, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_loopback_latency_no_peersync_gmem.stdout
efile=$OUT_DIR/gds_kernel_loopback_latency_no_peersync_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_kernel_loopback_latency -P -U -E 1>$ofile 2>$efile
check_errors $efile $ofile $?

# ============ gds_kernel_latency ============

echo "Running gds_kernel_latency peersync"
ofile=$OUT_DIR/gds_kernel_latency.stdout
efile=$OUT_DIR/gds_kernel_latency.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_latency peersync, nokernel"
ofile=$OUT_DIR/gds_kernel_latency_nok.stdout
efile=$OUT_DIR/gds_kernel_latency_nok.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -K 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_latency peersync, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_latency_gmem.stdout
efile=$OUT_DIR/gds_kernel_latency_gmem.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -E 1>$ofile 2>$efile
check_errors $efile $ofile $?
# -------------
echo "Running gds_kernel_latency peersync and descriptors"
ofile=$OUT_DIR/gds_kernel_latency_peersync_descs.stdout
efile=$OUT_DIR/gds_kernel_latency_peersync_descs.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -U 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_latency peersync, descriptors, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_latency_peersync_descs_gmem.stdout
efile=$OUT_DIR/gds_kernel_latency_peersync_descs_gmem.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -U -E 1>$ofile 2>$efile
check_errors $efile $ofile $?
# -------------
echo "Running gds_kernel_latency !peersync"
ofile=$OUT_DIR/gds_kernel_latency_no_peersync.stdout
efile=$OUT_DIR/gds_kernel_latency_no_peersync.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -P -U 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_kernel_latency !peersync, GMEM buffers"
ofile=$OUT_DIR/gds_kernel_latency_no_peersync_gmem.stdout
efile=$OUT_DIR/gds_kernel_latency_no_peersync_gmem.stderr
./run_bin.sh 2 $PREFIX_LIBS/bin/gds_kernel_latency -P -U -E 1>$ofile 2>$efile
check_errors $efile $ofile $?

# ============ gds_poll_lat ============
echo "Running gds_poll_lat"
ofile=$OUT_DIR/gds_poll_lat.stdout
efile=$OUT_DIR/gds_poll_lat.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_poll_lat 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_poll_lat, membar"
ofile=$OUT_DIR/gds_poll_lat_membar.stdout
efile=$OUT_DIR/gds_poll_lat_membar.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_poll_lat -m 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_poll_lat, GMEM buffers"
ofile=$OUT_DIR/gds_poll_lat_gmem.stdout
efile=$OUT_DIR/gds_poll_lat_gmem.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_poll_lat -g 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo "Running gds_poll_lat, GMEM buffers, membar"
ofile=$OUT_DIR/gds_poll_lat_gmem_membar.stdout
efile=$OUT_DIR/gds_poll_lat_gmem_membar.stderr
./run_bin.sh 1 $PREFIX_LIBS/bin/gds_poll_lat -g -m 1>$ofile 2>$efile
check_errors $efile $ofile $?

echo ""
echo "Outputs in $OUT_DIR"

