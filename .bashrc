#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.aliases

PS1='[\u@\h \W]\$ '
export EDITOR=emacs

# added by Anaconda2 4.0.0 installer
# export PATH="/opt/anaconda/bin/:$PATH"
# export PATH="/home/mwolf/bin/anaconda2/bin:$PATH"

# added by travis gem
[ -f /home/mwolf/.travis/travis.sh ] && source /home/mwolf/.travis/travis.sh

# Miniconda3 binaries
# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize

# Run chromium with a previously started SSH tunnel
# ssh -NTvD 4711 user@host
function secure_chromium {
    port=4711
    export SOCKS_SERVER=localhost:$port
    export SOCKS_VERSION=5
    chromium &
    exit
}

# Added conda path
# echo ". /home/mwolf/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
# . /home/mwolf/miniconda3/etc/profile.d/conda.sh  # commented out by conda initialize


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mwolf/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mwolf/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mwolf/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mwolf/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

