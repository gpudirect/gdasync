# GPUDirect Async suite

GPUDirect Async suite installation scripts.

In this project we collected LibGDSync along with its dependencies,
GDRCopy and LibMP, in the spirit of making it easier to leverage it in
your applications.

For system requirements please refer to:
- [LibGDSync requirements](https://github.com/gpudirect/libgdsync#requirements)
- [LibMP requirements](https://github.com/gpudirect/libmp#requirements)

### Build

Inside `gdasync` directory type:

```
git submodule init
git submodule update --remote --merge 
```
To fetch the most updated version of all submodules.

At anytime, you can use `Scripts/update_libs.sh` to pull from `master` branch the latest version of `Libraries/*`

In file `Scripts/utils/header.sh` configure the following variables:

```
PREFIX="/path/to/gdasync"
MPI_PATH="/path/to/mpi"
CUDA_PATH="/path/to/cuda"
```

To build libraries, in `Scripts` directory type `./build_libs.sh`. This script stores \*.so and \*.a files in `$PREFIX/lib` and headers in `$PREFIX/include`. Finally, GDAsync binaries (examples and benchmarks) are stored in `$PREFIX/bin`<br/>

To build applications, in `Scripts` directory type `./build_apps.sh`.<br/>

To create an archive with all GDAsync libraries and headers, in `Scripts` directory type `./compress.sh`.<br/>
An example of archive is `gdasync.tar.gz` in the main directory which has been build with:
- OpenMPI 3.0.0
- MLNX_OFED_LINUX-4.3-1.0.1.0
- CUDA 9.0
- GCC 4.8.5

### Execute

In order to execute apps, benchmarks and tests you need to
* add in your `LD_LIBRARY_PATH` the your GDAsync libraries directory. For example:
```
export LD_LIBRARY_PATH=$HOME/gdasync/Libraries/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
* create the `hostfile` in `Scripts` directory

We provide two scripts:
- `run_libgdsync.sh` runs all LibGDSync binaries in `gdasync/Libraries/bin`
- `run_libmp.sh` runs all LibMP binaries in `gdasync/Libraries/bin`

These scripts use:
- `run_bin.sh` useful to run a GPUDirect Async binary setting all possible the environment variables
- `mapper.sh` used by `run_bin.sh` to map, according to the topology of the system, the correct GPU and HCA to each process. We already provide some useful topology for DGX and P9 systems. **You need to add/modify your topology here according to your system.**

## Acknowledging GPUDirect Async

If you find this software useful in your work, please cite:

["GPUDirect Async: exploring GPU synchronous communication techniques for InfiniBand clusters"](https://www.sciencedirect.com/science/article/pii/S0743731517303386), E. Agostini, D. Rossetti, S. Potluri. Journal of Parallel and Distributed Computing, Vol. 114, Pages 28-45, April 2018

["Offloading communication control logic in GPU accelerated applications"](http://ieeexplore.ieee.org/document/7973709), E. Agostini, D. Rossetti, S. Potluri. Proceedings of the 17th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing (CCGrid’ 17), IEEE Conference Publications, Pages 248-257, Nov 2016
