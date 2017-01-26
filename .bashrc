#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias for logging into UIC's supercomputer cluster
alias 'ssh-extreme'='ssh mwolf22@login-1.extreme.uic.edu -o ServerAliveInterval=30'
alias 'ssh-labpi'='ssh pi@10.19.196.45'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export EDITOR=emacs
export TERMINAL=gnome-terminal

# added by Anaconda2 4.0.0 installer
# export PATH="/opt/anaconda/bin/:$PATH"
# export PATH="/home/mwolf/bin/anaconda2/bin:$PATH"

# added by travis gem
[ -f /home/mwolf/.travis/travis.sh ] && source /home/mwolf/.travis/travis.sh

# added by Miniconda3 4.2.12 installer
export PATH="/home/mwolf/miniconda3/bin:$PATH"
