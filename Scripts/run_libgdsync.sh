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

