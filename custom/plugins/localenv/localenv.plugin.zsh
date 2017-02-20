export PYTHONSTARTUP="/afs/cern.ch/user/r/rovere/.pystartup"
VI=$(which vim)
if [ $? -eq 0 ]; then
  export VISUAL=${VI}
fi
export PATH=~/.local/bin/:${PATH}

#This is for using stgit
export PATH=~/bin/stgit:${PATH}

# This is needed to use locally compiled git on CERN VMs
export PATH=/usr/local/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# Use custom-compiled emacs on afs everywhere but the new CC7 VM, which has already a newer version of emacs
if [ $HOSTNAME != "mrovere-slc7.cern.ch" ]; then
  export PATH=/afs/cern.ch/work/r/rovere/emacs/bin:${PATH}
fi

export LS_COLORS="no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:*.py=00;33:*.cfg=00;34:*.cc=01;31:*.h=00;33:*.xml=00;37"


# GPG-AGENT stuff
#

# First test if gpg-agent is already running

function loadgpg() {
  if pgrep -u ${USER} gpg-agent > /dev/null 2>&1 ; then
    if [ -f "$HOME/.gpg-agent-info_${HOSTNAME}" ]; then
	    . "$HOME/.gpg-agent-info_${HOSTNAME}"
	    export GPG_AGENT_INFO
	    export SSH_AUTH_SOCK
    else
	    echo "GPG Agent could not be setup"
    fi
  else
    gpg-agent --daemon -v --debug-level 6 --enable-ssh-support --pinentry-program /usr/bin/pinentry-curses --disable-scdaemon --write-env-file "$HOME/.gpg-agent-info_${HOSTNAME}"
    if [ $? -ne 0 ]; then
      echo "gpg-agent could not be started'"
    else
      . "${HOME}/.gpg-agent-info_${HOSTNAME}"
	    export GPG_AGENT_INFO
	    export SSH_AUTH_SOCK
    fi
  fi
  GPG_TTY=$(tty)
  export GPG_TTY
}

# Kill gpg-agent, if active

function killgpg() {
    if pgrep -u ${USER} gpg-agent > /dev/null 2>&1 ; then
       kill -s TERM $(pgrep -u ${USER} gpg-agent)
       if [ -f "$HOME/.gpg-agent-info_${HOSTNAME}" ]; then
         rm "$HOME/.gpg-agent-info_${HOSTNAME}"
       fi
    fi
    unset GPG_AGENT_INFO
    unset SSH_AUTH_SOCK
    unset GPG_TTY
}

# Force reload gpg-agent

reloadgpg () {
    killgpg
    loadgpg
}

# Activate gpg only on vinavx2, not on any generic machine.
# The functions are anyway available to activate it on-demand
machine=$(hostname -s)
if [[ ${machine} == "vinavx2" ]]; then
  loadgpg
fi
