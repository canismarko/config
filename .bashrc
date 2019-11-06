#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.aliases

PS1='[\u@\h \W]\$ '
export EDITOR=emacs

# added by travis gem
[ -f /home/mwolf/.travis/travis.sh ] && source /home/mwolf/.travis/travis.sh

# Run chromium with a previously started SSH tunnel
# ssh -NTvD 4711 user@host
function secure_chromium {
    port=4711
    export SOCKS_SERVER=localhost:$port
    export SOCKS_VERSION=5
    chromium &
    exit
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/b268176/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/b268176/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/b268176/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/b268176/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Install Ruby Gems to ~/gems
# export GEM_HOME="$HOME/gems"
# export PATH="$HOME/gems/bin:$PATH"

# Add CUDA compiler and utils to the path
export PATH=$PATH:/opt/cuda/bin
