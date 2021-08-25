# HOW TO SETUP

```
# export cuda related path
export CUDA_ROOT=/usr/local/cuda-11.0
export CUDA_HOME=$CUDA_ROOT
export CUDA_PATH=$CUDA_ROOT
export PATH=$CUDA_ROOT/bin:$PATH
export CPATH=$CUDA_ROOT/include:$CPATH
export LD_LIBRARY_PATH=$CUDA_ROOT/lib64:$LD_LIBRARY_PATH

# make
make
```
