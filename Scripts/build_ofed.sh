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

# ======== PATH SETUP ========
export PREFIX="$HOME/gdasync"
export PREFIX_INSTALL="/install/path"
export PREFIX_LIBS="$PREFIX/Libraries"
export PREFIX_APPS="$PREFIX/Apps"
# ======== PATH CHECK ========

mkdir -p $PREFIX_LIBS/bin
mkdir -p $PREFIX_LIBS/include
mkdir -p $PREFIX_LIBS/lib

#:<<COMMENT
rm -rf $PREFIX_LIBS/libibverbs/build $PREFIX_LIBS/libibverbs/config $PREFIX_LIBS/libibverbs/autom4te.cache $PREFIX_LIBS/libibverbs/configure
mkdir -p $PREFIX_LIBS/libibverbs/build
cd $PREFIX_LIBS/libibverbs
./autogen.sh
cd $PREFIX_LIBS/libibverbs/build
../configure --prefix=$PREFIX_INSTALL --sysconfdir=/etc
#LDFLAGS="-L$PREFIX_LIBS/lib -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/lib64 -L/usr/lib64 -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/extras/CUPTI/lib64 -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/nvvm/lib64" CFLAGS="-I$PREFIX_LIBS/include" CPPFLAGS="-I$PREFIX_LIBS/include" CXXFLAGS="-I$PREFIX_LIBS/include -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/include -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/samples/common/inc -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/include/CL -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/extras/CUPTI/include -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/extras/Debugger/include -I/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/nvvm/include"
make clean
make -j16
make install
#COMMENT

rm -rf $PREFIX_LIBS/libmlx5/build $PREFIX_LIBS/libmlx5/config $PREFIX_LIBS/libmlx5/autom4te.cache $PREFIX_LIBS/libmlx5/configure
mkdir -p $PREFIX_LIBS/libmlx5/build
cd $PREFIX_LIBS/libmlx5
./autogen.sh
cd $PREFIX_LIBS/libmlx5/build
../configure --oldincludedir=$PREFIX_LIBS/include --prefix=$PREFIX_INSTALL --with-mlx5_debug CPPFLAGS="-I$PREFIX_LIBS/include" CFLAGS="-I$PREFIX_LIBS/include" 
#LDFLAGS="-L$PREFIX_LIBS/lib -libverbs -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/lib64 -L/usr/lib64 -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/extras/CUPTI/lib64 -L/cm/extra/apps/CUDA.linux86-64/9.2.88.1_396.26/nvvm/lib64"
#mv Makefile Makefile.orig
#cat Makefile.orig | sed 's/CPPFLAGS =/#CPPFLAGS =/' | sed 's/enumerations.txt $(DESTDIR)/enumerations.txt $(prefix)/  ' >Makefile
make clean
make -j16 
make install


#./configure --prefix=/home/lab/gdasync/openmpi-3.0.0/build_exp -with-cuda --with-verbs=/home/lab/gdasync/gdasync/Libraries
