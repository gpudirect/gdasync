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

# ======== INPUT PARAMS ========
BUILD_LIBS=1
BUILD_APPS=1
#Build Libraries only
if [[ $1 -eq 1 ]]; then BUILD_APPS=0; fi
#Build Apps only
if [[ $1 -eq 2 ]]; then BUILD_LIBS=0; fi

# ======== PATH SETUP ========
export PREFIX="$HOME/gdasync"
export PREFIX_LIBS="$PREFIX/Libraries"
export PREFIX_APPS="$PREFIX/Apps"

export MPI_PATH="$HOME/openmpi-2.1.3/build"
export CUDA_PATH="/usr/local/cuda-9.0"

LIBGDSYNC_PATH="$PREFIX_LIBS/libgdsync"
LIBMP_PATH="$PREFIX_LIBS/libmp"

# ======== PATH CHECK ========
[[ -z $PREFIX ]]        && { echo "ERROR: PREFIX env var empy";         		exit 1; }
[[ ! -d $PREFIX ]]        && { echo "ERROR: PREFIX $PREFIX does not exist";       	exit 1; }

[[ -z $MPI_HOME ]]      && { echo "ERROR: MPI_HOME env var empy";       		exit 1; }
[[ ! -d $MPI_HOME ]]      && { echo "ERROR: MPI_HOME $MPI_HOME does not exist";   	exit 1; }

[[ -z $CUDA_PATH ]]     && { echo "ERROR: CUDA_PATH env var empy";   	        	exit 1; }
[[ ! -d $CUDA_PATH ]]     && { echo "ERROR: CUDA_PATH $CUDA_PATH does not exist";	        exit 1; }


mkdir -p $PREFIX_LIBS/bin
mkdir -p $PREFIX_LIBS/include
mkdir -p $PREFIX_LIBS/lib


# ======== MPI ========
export MPI_HOME=$MPI_PATH
echo "MPI_HOME=$MPI_HOME"
export MPI_NAME=openmpi
export MPI_BIN=$MPI_HOME/bin
export MPI_INCLUDE=$MPI_HOME/include
export MPI_LIB=$MPI_HOME/lib:$MPI_HOME/lib64
export PATH=$MPI_BIN:$PATH

# ======== CUDA ========
echo "loading $CUDA_PATH environment..."
export CUDA=$CUDA_PATH
export CUDA_PATH=$CUDA_PATH
export CUDA_HOME=$CUDA
export PATH=$CUDA/bin:$PATH

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

PREFIX_TMP=$PREFIX
export PREFIX=$PREFIX_LIBS

# === Building GDAsync libraries
if [[ $BUILD_LIBS -eq 1 ]]; then
	# Configuration cleanup
	rm -rf $PREFIX_LIBS/libgdsync/build
	rm -rf $PREFIX_LIBS/libmp/build
	# Libraries cleanup
	rm -rf $PREFIX_LIBS/lib/*
	# Binaries cleanup
	rm -rf $PREFIX_LIBS/bin/*

	make -f Makefile.libs all || exit 1
	#export PREFIX=$PREFIX_TMP
	
	echo ""
	echo ""
	echo "### GDRCopy, LibGDSync and LibMP correctly built ###"
	echo "# Libraries in $PREFIX_LIBS/lib"
	echo "# Headers in $PREFIX_LIBS/include"
	echo "# Binaries in $PREFIX_LIBS/bin"
	echo "#####################################################"
	echo ""

fi

# ======== Set LD_LIBRARY_PATH ========
#export LD_LIBRARY_PATH=$PREFIX/lib:${LD_LIBRARY_PATH}

# === Building GDAsync applications
if [[ $BUILD_APPS -eq 1 ]]; then
	echo "Building apps..."
	make -f Makefile.apps all || exit 1
fi
