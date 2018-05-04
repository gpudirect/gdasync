# GDAsync

GPUDirect Async suite installation scripts.
Here we merge all libraries and headers you need to leverage your application with GPUDirect Async: GDRCopy, LibGDSync and LibMP.

For system requirements please refer to:
- [LibGDSync requirements](https://github.com/gpudirect/libgdsync#requirements)
- [LibMP requirements](https://github.com/gpudirect/libmp#requirements)

### Build

Inside `gdasync` directory type:

```
git submodules init
git submodule update --remote --merge 
```

In file *build.sh* configure the following variables:

```
PREFIX="/path/to/gdasync"
MPI_PATH="/path/to/mpi"
CUDA_PATH="/path/to/cuda"
```

Then type `./build.sh`

### Results

Libraries are built in `$PREFIX/lib`
Headers are built in `$PREFIX/include`
Binaries (examples and benchmarks) are built in `$PREFIX/bin`

## Acknowledging GPUDirect Async

If you find this software useful in your work, please cite:

["GPUDirect Async: exploring GPU synchronous communication techniques for InfiniBand clusters"](https://www.sciencedirect.com/science/article/pii/S0743731517303386), E. Agostini, D. Rossetti, S. Potluri. Journal of Parallel and Distributed Computing, Vol. 114, Pages 28-45, April 2018

["Offloading communication control logic in GPU accelerated applications"](http://ieeexplore.ieee.org/document/7973709), E. Agostini, D. Rossetti, S. Potluri. Proceedings of the 17th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing (CCGrid’ 17), IEEE Conference Publications, Pages 248-257, Nov 2016
