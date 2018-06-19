#!/usr/bin/env bash

# C# Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
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


source header.sh

[[ ! -e hostfile ]]	&& { echo "ERROR: hostfile missing"; exit 1; }
[[ ! -e mapper.sh ]]    && { echo "ERROR: mapper.sh missing"; exit 1; }

if [[ $# -lt 2 ]]; then
    echo "Usage: <num procs> <exec path> <params>"
    exit 1
fi

NP=$1
if [[ $NP -lt 1 ]]; then
    echo "Illegal procs number: $NP"
    exit 1
fi

EXEC=$2
[[ ! -e $EXEC ]]    && { echo "ERROR: $EXEC not found"; exit 1; }
shift 2
PARAMS=$@

#Other parameters
COMM=0
COMM_SA=0 #if 1, use SA Model
COMM_KI=0 #if 1, use KI Model
TIME=5
SIZE=131072

#Assuming OpenMPI
OMPI_params="$OMPI_params --mca btl openib,self"
OMPI_params="$OMPI_params --mca btl_openib_want_cuda_gdr 1"
OMPI_params="$OMPI_params --mca btl_openib_warn_default_gid_prefix 0"

export PATH=$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

#set -x
$MPI_HOME/bin/mpirun -verbose  $OMPI_params   	\
        -x MP_ENABLE_DEBUG=0 			\
        -x MP_ENABLE_WARN=0 			\
        -x GDS_ENABLE_DEBUG=0 			\
        -x MLX5_DEBUG_MASK=0 			\
        -x ENABLE_DEBUG_MSG=0 			\
        \
        -x MP_DBREC_ON_GPU=0 			\
        -x MP_RX_CQ_ON_GPU=0 			\
        -x MP_TX_CQ_ON_GPU=0 			\
        \
        -x MP_EVENT_ASYNC=0 			\
        -x MP_GUARD_PROGRESS=0 			\
        \
        -x GDS_DISABLE_WRITE64=0           	\
        -x GDS_SIMULATE_WRITE64=0          	\
        -x GDS_DISABLE_INLINECOPY=0        	\
        -x GDS_DISABLE_WEAK_CONSISTENCY=0  	\
        -x GDS_DISABLE_MEMBAR=0            	\
        -x GDS_DISABLE_REMOTE_FLUSH=1       \
		-x GDS_DISABLE_WAIT_NOR=1			\
        -x GDS_ENABLE_WAIT_CHECKER=0        \
        -x GDS_FLUSHER_TYPE=0 		 	  	\
        \
        -x MLX5_FREEZE_ON_ERROR_CQE=0 		\
        -x GPU_ENABLE_DEBUG=0 				\
        -x GDRCOPY_ENABLE_LOGGING=0 		\
        -x GDRCOPY_LOG_LEVEL=0 				\
        \
        -x USE_CALC_SIZE=0 				\
        -x KERNEL_TIME=$TIME 			\
        -x MAX_SIZE=$SIZE 				\
        -x USE_GPU_BUFFERS=0 			\
        -x ENABLE_VALIDATION=0 			\
        \
        -x COMM_USE_COMM=$COMM 			\
        -x COMM_USE_ASYNC_SA=$COMM_SA 	\
        -x COMM_USE_ASYNC_KI=$COMM_KI 	\
        \
        -x LD_LIBRARY_PATH -x PATH 		\
        --map-by node -np $NP -hostfile hostfile ./mapper.sh $EXEC $PARAMS


# nvprof -o nvprof-kernel.%q{OMPI_COMM_WORLD_RANK}.nvprof
