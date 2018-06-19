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

mkdir -p $PREFIX_LIBS/bin
mkdir -p $PREFIX_LIBS/include
mkdir -p $PREFIX_LIBS/lib

# === Building GDAsync libraries
# Configuration cleanup
rm -rf $PREFIX_LIBS/libgdsync/build
rm -rf $PREFIX_LIBS/libgdsync/autom4te.cache
rm -rf $PREFIX_LIBS/libgdsync/config
rm -rf $PREFIX_LIBS/libgdsync/configure

rm -rf $PREFIX_LIBS/libmp/build
rm -rf $PREFIX_LIBS/libmp/autom4te.cache
rm -rf $PREFIX_LIBS/libmp/config
rm -rf $PREFIX_LIBS/libmp/configure

# Libraries cleanup
rm -rf $PREFIX_LIBS/lib/libgdrapi*
rm -rf $PREFIX_LIBS/lib/libgdsync*
rm -rf $PREFIX_LIBS/lib/libmp*
rm -rf $PREFIX_LIBS/lib/libmpcomm*
# Binaries cleanup
rm -rf $PREFIX_LIBS/bin/*

PREFIX_TMP=$PREFIX
export PREFIX=$PREFIX_LIBS
export GDRCOPY=$PREFIX_LIBS

make -f utils/Makefile.libs clean all || exit 1
#export PREFIX=$PREFIX_TMP

echo ""
echo ""
echo "### GDRCopy, LibGDSync and LibMP correctly built ###"
echo "# Libraries in $PREFIX_LIBS/lib"
echo "# Headers in $PREFIX_LIBS/include"
echo "# Binaries in $PREFIX_LIBS/bin"
echo "#####################################################"
echo ""
