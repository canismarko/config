# 12/04/02 APS
##################################################################
#
#         .profile file
#
#         Read in when you log in.   Not read in for subsequent 
#         shells.  For setting up terminal and global environment
#         characteristics.
#
##################################################################

OSVER=`uname -s `
case ${OSVER} in
        # Add SunOS 4.1.X Path and Environmental Variables here.
        Linux)
            lpath="${HOME}:${HOME}/bin"   # prepend to system path
            lpath_post=""                 # append to system path
            PATH="${lpath}:${PATH}:${lpath_post}:."
            ;;
 
        # Add Solaris Path and Environmental Variables here.
        SunOS)
            lpath="${HOME}:${HOME}/bin"   # prepend to system path
            lpath_post=""                 # append to system path
            PATH="${lpath}:${PATH}:${lpath_post}:."
            ;;
esac
export PATH

if [ -f "${HOME}/.env" ] ; then
   ENV="${HOME}/.env"
   export ENV
fi

#         general terminal characteristics

#stty -crterase
#stty -tabs
#stty crt
#stty erase '^?'
#stty werase '^?'
#stty kill '^['
#stty new

#         environment variables

#setenv EXINIT 'set sh=/bin/csh sw=4 ai report=2'
#setenv MORE '-c'
PRINTER=lp
export PRINTER
# MEDM PRINTER
PSPRINTER=lp
export PSPRINTER

export PATH=$PATH:$(ruby -r rubygems -e "puts Gem.user_dir")/bin:$HOME/bin
# export PYTHONPATH=$PYTHONPATH:$HOME/src/

# Import any local settings
[[ -f "$HOME/.profile-local" ]] && source "$HOME/.profile-local"

[[ -f "$HOME/.xprofile" ]] && source "$HOME/.xprofile"

# Load fcitx for chinese input
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx -d -r

