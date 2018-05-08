# Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# install path
PREFIX ?= /path/to/gdasync/peersync

CUDA_LIB :=
CUDA_INC :=

# add standard CUDA dir
CUDA      ?= /usr/local/cuda
CUDA_LIB += $(CU_LDFLAGS) -L$(CUDA)/lib64 -L$(CUDA)/lib -L/usr/lib64/nvidia -L/usr/lib/nvidia
CUDA_INC += $(CU_CPPFLAGS) -I$(CUDA)/include

# GPUDirect Async library
GDSYNC      = $(PREFIX)
GDSYNC_INC  = -I $(GDSYNC)/include
GDSYNC_LIB  = -L $(GDSYNC)/lib

# MP library
MP     ?= $(PREFIX)
MP_INC  = -I $(MP)/include
MP_LIB  = -L $(MP)/lib

# GPUDirect RDMA Copy library
GDRCOPY     ?= $(PREFIX)
GDRCOPY_INC  = -I $(GDRCOPY)/include
GDRCOPY_LIB  = -L $(GDRCOPY)/lib

# MPI is used in some tests
MPI_HOME ?= /ivylogin/home/spotluri/MPI/mvapich2-2.0-cuda-gnu-install
MPI_INC   = -I $(MPI_HOME)/include
MPI_LIB   = -L $(MPI_HOME)/lib64

#------------------------------------------------------------------------------
# build tunables
#------------------------------------------------------------------------------

CXX:=g++
CC:=gcc
NVCC:=nvcc
LD:=g++
COMMON_CFLAGS:=-O2
CPPFLAGS+=-DGDS_USE_EXP_INIT_ATTR -DGDS_OFED_HAS_PEER_DIRECT_ASYNC
NVCC_ARCHS:=-gencode arch=compute_35,code=sm_35
NVCC_ARCHS+=-gencode arch=compute_50,code=compute_50
NVCC_ARCHS+=-gencode arch=compute_60,code=compute_60

# static or dynamic
LIBS_TYPE=static

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) $(CPPFLAGS) -c $<
