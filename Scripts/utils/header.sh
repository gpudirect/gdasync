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

# ======== ENV VARS - Need to be configured ========
export PREFIX="$HOME/gdasync"
export MPI_PATH="/usr/mpi/gcc/openmpi-3.1.0rc2"
export CUDA_PATH="/usr/local/cuda-9.2"
# ==================================================

# ======== PATH SETUP ========
export PREFIX_LIBS="$PREFIX/Libraries"
export PREFIX_APPS="$PREFIX/Apps"

LIBGDSYNC_PATH="$PREFIX_LIBS/libgdsync"
LIBMP_PATH="$PREFIX_LIBS/libmp"

# ======== PATH CHECK ========
[[ -z $PREFIX ]]        && { echo "ERROR: PREFIX env var empy";         		exit 1; }
[[ ! -d $PREFIX ]]        && { echo "ERROR: PREFIX $PREFIX does not exist";       	exit 1; }

[[ -z $MPI_PATH ]]      && { echo "ERROR: MPI_PATH env var empy";       		exit 1; }
[[ ! -d $MPI_PATH ]]      && { echo "ERROR: MPI_PATH $MPI_PATH does not exist";   	exit 1; }

[[ -z $CUDA_PATH ]]     && { echo "ERROR: CUDA_PATH env var empy";   	        	exit 1; }
[[ ! -d $CUDA_PATH ]]     && { echo "ERROR: CUDA_PATH $CUDA_PATH does not exist";	        exit 1; }

# ======== MPI ========
echo "MPI_PATH=$MPI_PATH"
export MPI_HOME=$MPI_PATH
export MPI_NAME=openmpi
export MPI_BIN=$MPI_HOME/bin
export MPI_INCLUDE=$MPI_HOME/include
export MPI_LIB=$MPI_HOME/lib:$MPI_HOME/lib64
export PATH=$MPI_BIN:$PATH

# ======== CUDA ========
echo "CUDA_PATH=$CUDA_PATH"
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

function check_errors {
        local ERROR_FILE=$1
        local LOG_FILE=$2
        local RETURN_VALUE=$3

        if [[ $RETURN_VALUE != 0 ]]; then
		echo "Error: return value $RETURN_VALUE"
                return 1
        elif grep -Eq "ERROR" $LOG_FILE; then
		echo "Error!"
		return 2
        elif grep -Eq "error" $LOG_FILE; then
		echo "Error!"
                return 2
        elif grep -Eq "ERROR" $ERROR_FILE; then
		echo "Error!"
                return 3
        elif grep -Eq "error" $ERROR_FILE; then
		echo "Error!"
                return 3
        fi

        #PASSED
        return 0
}
