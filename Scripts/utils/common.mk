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
