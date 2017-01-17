#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias for logging into UIC's supercomputer cluster
alias 'ssh-extreme'='ssh mwolf22@login-1.extreme.uic.edu -o ServerAliveInterval=30'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export EDITOR=emacs
export TERMINAL=gnome-terminal

# added by Anaconda2 4.0.0 installer
export PATH="/opt/anaconda/bin/:$PATH"
# export PATH="/home/mwolf/bin/anaconda2/bin:$PATH"
