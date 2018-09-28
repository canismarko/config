#!/bin/sh

export LD_LIBRARY_PATH=$CONDA_PREFIX/lib/
export FULLPROF=$HOME/build/fullprof
export OLD_PATH=$PATH
export PATH=$FULLPROF:$PATH
