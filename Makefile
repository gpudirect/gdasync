# Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

include common.mk

all: checks libs

checks:
	@if [ ! -d $(PREFIX) ]; then echo "PREFIX env not defined"; exit; fi;\
	echo "using PREFIX=$(PREFIX)"

libs: gdrcopy libgdsync libmp

gdrcopy:
	make -C gdrcopy PREFIX=$(PREFIX) DESTLIB=$(PREFIX)/lib clean all install

libgdsync:
	cd libgdsync && ./build.sh

libmp:
	cd libmp && ./build.sh

clean:
	make -C gdrcopy clean && \
	make -C libgdsync clean && \
	make -C libmp clean

.PHONY: checks configure libgdsync libmp clean all libs gdrcopy

