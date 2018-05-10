# GDAsync

GPUDirect Async suite installation scripts.
Here we merge all libraries and headers you need to leverage your application with GPUDirect Async: GDRCopy, LibGDSync and LibMP.

For system requirements please refer to:
- [LibGDSync requirements](https://github.com/gpudirect/libgdsync#requirements)
- [LibMP requirements](https://github.com/gpudirect/libmp#requirements)

### Scripts

Build:
- `headers.sh` contains common variables
- `build_libs.sh` builds all submodules in `gdasync/Libraries` directory
- `build_apps.sh` builds all submodules in `gdasync/Apps` directory
- `compress.sh` builds all submodules in `gdasync/Libraries` directory and creates a `gdasync.tar.gz` archive in the main directoy

Execute:
- `run_bin.sh` useful to run a GPUDirect Async binary with all the environment variables
- `mapper.sh` used by `run_bin.sh` to map, according to the topology of the system, the correct GPU and HCA to each process. You need to add your topology here.
- `run_libgdsync.sh` runs all LibGDSync binaries in `gdasync/Libraries/bin`
- `run_libmp.sh` runs all LibMP binaries in `gdasync/Libraries/bin`

### Build

Inside `gdasync` directory type:

```
git submodule init
git submodule update --remote --merge 
```
To fetch the most updated version of all submodules.

In file *header.sh* configure the following variables:

```
PREFIX="/path/to/gdasync"
MPI_PATH="/path/to/mpi"
CUDA_PATH="/path/to/cuda"
```

To build GDAsync libraries `cd Scripts && ./build_libs.sh`.<br/>
To build GDAsync applications `cd Scripts && ./build_apps.sh`.<br/>
To create an archive with all GDAsync libraries and headers `cd Scripts && ./compress.sh`.<br/>

N.B. You need to include in you `LD_LIBRARY_PATH` the lib directory. For instance:
```
export LD_LIBRARY_PATH=$HOME/gdasync/Libraries/lib:${LD_LIBRARY_PATH}
```

Libraries are built in `$PREFIX/lib` <br>
Headers are built in `$PREFIX/include` <br>
Binaries (examples and benchmarks) are built in `$PREFIX/bin` <br>
Compressed archive is `gdasync.tar.gz` in the main directory.<br>
The default `gdasync.tar.gz` has been built with:
- OpenMPI 3.0.0
- MLNX_OFED_LINUX-4.3-1.0.1.0
- CUDA 9.0
- GCC 4.8.5

## Acknowledging GPUDirect Async

If you find this software useful in your work, please cite:

["GPUDirect Async: exploring GPU synchronous communication techniques for InfiniBand clusters"](https://www.sciencedirect.com/science/article/pii/S0743731517303386), E. Agostini, D. Rossetti, S. Potluri. Journal of Parallel and Distributed Computing, Vol. 114, Pages 28-45, April 2018

["Offloading communication control logic in GPU accelerated applications"](http://ieeexplore.ieee.org/document/7973709), E. Agostini, D. Rossetti, S. Potluri. Proceedings of the 17th IEEE/ACM International Symposium on Cluster, Cloud and Grid Computing (CCGrid’ 17), IEEE Conference Publications, Pages 248-257, Nov 2016
