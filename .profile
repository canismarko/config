# Fullprof Rietveld refinement
export FULLPROF=$HOME/bin/fullprof
export PATH=$PATH:$FULLPROF

export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin:$HOME/bin
export PYTHONPATH=$PYTHONPATH:$HOME/src/
