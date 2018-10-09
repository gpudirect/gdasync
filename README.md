# GPUDirect Async suite

GPUDirect Async suite installation scripts.

In this project we collected LibGDSync along with its dependencies,
GDRCopy and LibMP, in the spirit of making it easier to leverage it in
your applications.

For system requirements please refer to:
- [LibGDSync requirements](https://github.com/gpudirect/libgdsync#requirements)
- [LibMP requirements](https://github.com/gpudirect/libmp#requirements)

### Build

In order to fetch the most updated version of all submodules:
```
git submodule init
git submodule update --remote --merge 
```
At anytime, you can use `Scripts/update_libs.sh` to pull the latest version of `Libraries/*` from their `master` branch.

In file `Scripts/utils/header.sh` configure the following variables:

```
PREFIX="/path/to/gdasync"
MPI_PATH="/path/to/mpi"
CUDA_PATH="/path/to/cuda"
```

To build libraries, in `Scripts` directory type `./build_libs.sh`. This script stores `\*.so` and `\*.a` files in `$PREFIX/lib`, headers in `$PREFIX/include` and binaries in `$PREFIX/bin`<br/>

To build applications (`gdasync/Apps`), in `Scripts` directory type `./build_apps.sh`.<br/>

To create an archive with all GDAsync libraries and headers, in `Scripts` directory use the `compress.sh` script.<br/>
An example of archive is `gdasync.tar.gz` in the main directory which has been build with:
- OpenMPI 3.0.0
- MLNX_OFED_LINUX-4.3-1.0.1.0
- CUDA 9.0
- GCC 4.8.5

### Execute

In order to execute apps, benchmarks and tests you need to
* add in your `LD_LIBRARY_PATH` the GDAsync libraries directory. For example:
```
export LD_LIBRARY_PATH=$HOME/gdasync/Libraries/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
* create `Scripts/hostfile`

We provide two scripts:
- `run_libgdsync.sh` runs all LibGDSync binaries in `gdasync/Libraries/bin`
- `run_libmp.sh` runs all LibMP binaries in `gdasync/Libraries/bin`

These scripts use:
- `run_bin.sh` useful to run an executable setting all possible the GDAsync environment variables
- `mapper.sh` used by `run_bin.sh` to map, according to the topology of the system, the correct GPU, HCA and CPU to each process. We already provide some useful topology for DGX and P9 systems. **You need to add/change your topology here according to your system.**

## Acknowledging GPUDirect Async

If you find this software useful in your work, please cite:

["GPUDirect Async: exploring GPU synchronous communication techniques for InfiniBand clusters"](https://www.sciencedirect.com/science/article/pii/S0743731517303386), E. Agostini, D. Rossetti, S. Potluri. Journal of Parallel and Distributed Computing, Vol. 114, Pages 28-45, April 2018

["MPI-GDS: High Performance MPI Designs with GPUDirect-aSync for CPU-GPU Control Flow Decoupling"](https://www.computer.org/csdl/proceedings/icpp/2017/1042/00/1042a151-abs.html), A. Venkatesh, C. Chu, K. Hamidouche, S. Potluri, Davide Rossetti, and D. K. Panda. Proceedings of the 46th International Conference on Parallel Processing, Aug 2017, Pages 151-160


["Offloading communication control logic in GPU accelerated applications"](http://ieeexplore.ieee.org/document/7973709), E. Agostini, D. Rossetti, S. Potluri. Proceedings of the 17th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing (CCGrid’ 17), IEEE Conference Publications, Pages 248-257, Nov 2016
