#!/usr/bin/env bash

# Copyright (c) 2011-2018, NVIDIA CORPORATION. All rights reserved.
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

# ======== PATH SETUP ========
export PREFIX="/path/to/gdasync"
MPI_PATH="/path/to/mpi"
CUDA_PATH="/path/to/cuda"

LIBGDSYNC_PATH="$PREFIX/libgdsync"
LIBMP_PATH="$PREFIX/libmp"

# ======== MPI ========
if [ -d $MPI_PATH ]; then
    export MPI_HOME=$MPI_PATH
else
    echo "ERROR: cannot find OpenMPI in $MPI_PATH "
fi

echo "MPI_HOME=$MPI_HOME"
export MPI_NAME=openmpi
export MPI_BIN=$MPI_HOME/bin
export MPI_INCLUDE=$MPI_HOME/include
export MPI_LIB=$MPI_HOME/lib:$MPI_HOME/lib64

# ======== CUDA ========
if [ ! -z "$CUDA" ]; then
	echo "WARNING: CUDA is already defined ($CUDA), overwriting it..."
fi

if [ -e $CUDA_PATH ]; then
	echo "loading $CUDA_PATH environment..."
	export CUDA=$CUDA_PATH
	export CUDA_PATH=$CUDA_PATH
	export CUDA_HOME=$CUDA
fi

CUDADRV=$CUDA
CUDADRVLIB=$CUDADRV/lib64 #/usr/lib64
CUDADRVINC=$CUDADRV/include

CU_LDFLAGS=
CU_CPPFLAGS=
# compiler paths
if [ ! -z "$CUDADRV" ]; then
[ ! -d $CUDADRV ] && echo "CUDADRV does not exist"
[ -d $CUDADRVLIB ] && CU_LDFLAGS="-L$CUDADRVLIB $CU_LDFLAGS"
[ -d $CUDADRVINC ] && CU_CPPFLAGS="-I$CUDADRVINC $CU_CPPFLAGS"
fi

CU_LDFLAGS="$CU_LDFLAGS -L/usr/lib64"

export CUDADRV
export CU_CPPFLAGS CU_LDFLAGS

[[ -z $PREFIX ]] 	&& { echo "ERROR: PREFIX env var empy";		exit 1; }
[[ -z $MPI_HOME ]] 	&& { echo "ERROR: MPI_HOME env var empy";	exit 1; }
[[ -z $CUDA ]] 		&& { echo "ERROR: CUDA env var empy";		exit 1; }

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/include
mkdir -p $PREFIX/lib

# Configuration cleanup
rm -rf $PREFIX/libgdsync/build
rm -rf $PREFIX/libmp/build
# Libraries cleanup
rm -rf $PREFIX/lib/*
# Binaries cleanup
rm -rf $PREFIX/bin/*

make all || exit 1

echo ""
echo ""
echo "### GDRCopy, LibGDSync and LibMP correctly built ###"
echo "# Libraries in $PREFIX/lib"
echo "# Headers in $PREFIX/include"
echo "# Binaries in $PREFIX/bin"
echo "#####################################################"
echo ""
echo ""

# ======== Set LD_LIBRARY_PATH ========
#export LD_LIBRARY_PATH=$PREFIX/lib:${LD_LIBRARY_PATH}