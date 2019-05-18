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
export PATH="$HOME/miniconda3/bin:$PATH"

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
. /home/mwolf/miniconda3/etc/profile.d/conda.sh

