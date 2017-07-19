#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# ASTRA Toolbox includes
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/astra/lib
# export PYTHONPATH=$PYTHONPATH:/usr/local/astra/python

# Fullprof Rietveld refinement
export FULLPROF=$HOME/bin/fullprof
export PATH=$PATH:$FULLPROF

export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin:$HOME/bin
# export PYTHONPATH=$PYTHONPATH:$HOME/src/
# export PYTHONPATH=$PYTHONPATH:/usr/lib/paraview-5.0/site-packages/
# export PYTHONPATH=$PYTHONPATH:/usr/lib/paraview-5.0/site-packages/vtk/

[[ -f $HOME/.bash_profile-local ]] && . $HOME/.bash_profile-local
