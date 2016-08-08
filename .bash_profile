#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Matlab compiled runtime
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/sys/java/jre/glnxa64/jre/lib/amd64

# export XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Compiler_Runtime/v81/X11/app-defaults

# ASTRA Toolbox includes
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/astra/lib
# export PYTHONPATH=$PYTHONPATH:/usr/local/astra/python

# Fullprof Rietveld refinement
export FULLPROF=$HOME/bin/fullprof
export PATH=$PATH:$FULLPROF

export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin:$HOME/bin
export PYTHONPATH=$PYTHONPATH:$HOME/src/
export PYTHONPATH=$PYTHONPATH:/usr/lib/paraview-5.0/site-packages/
export PYTHONPATH=$PYTHONPATH:/usr/lib/paraview-5.0/site-packages/vtk/
