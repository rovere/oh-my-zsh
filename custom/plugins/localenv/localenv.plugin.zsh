export PYTHONSTARTUP="/afs/cern.ch/user/r/rovere/.pystartup"
VI=$(which vim)
if [ $? -eq 0 ]; then
  export VISUAL=${VI}
fi
export PATH=~/.local/bin/:${PATH}
export PATH=~/tools/:${PATH}

#This is for using stgit
export PATH=~/bin/stgit:${PATH}

# This is needed to use locally compiled git on CERN VMs
export PATH=/usr/local/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# Use custom-compiled emacs on afs everywhere but the new CC7 VM, which has already a newer version of emacs
if [ $HOSTNAME != "mrovere-slc7.cern.ch" ]; then
  export PATH=/afs/cern.ch/work/r/rovere/emacs/bin:${PATH}
fi

# If nvim is there, put it into the PATH env variable
if [ -e /data/rovere/nvim/nvim-linux-x86_64/bin ]; then
  export PATH=/data/rovere/nvim/nvim-linux-x86_64/bin:${PATH}
fi
if [ -e /shared/rovere/nvim-linux-x86_64/bin ]; then
  export PATH=/shared/rovere/nvim-linux-x86_64/bin:${PATH}
fi

# If lazyvim is there, put it into the PATH env variable
if [ -e /data/rovere/lazygit ]; then
  export PATH=/data/rovere/lazygit:${PATH}
  alias lg=lazygit
fi
if [ -e /shared/rovere/lazygit ]; then
  export PATH=/shared/rovere/lazygit:${PATH}
  alias lg=lazygit
fi

# If Node is there, configure it to make LSP work inside nvim
if [ -e /data/rovere/Node/bin ]; then
  export PATH=/data/rovere/Node/bin:${PATH}
fi
if [ -e /shared/rovere/node-v22.15.0-linux-x64 ]; then
  export PATH=/shared/rovere/node-v22.15.0-linux-x64/bin:${PATH}
fi

if [ -e /data/rovere/tree-sitter-cli/ ]; then
  export PATH=/data/rovere/tree-sitter-cli/:${PATH}
fi

export LS_COLORS="no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:*.py=00;33:*.cfg=00;34:*.cc=01;31:*.h=00;33:*.xml=00;37"

export LESS='-C -M -I -j 10 -# 4 -R -X'

# Use vim as pager

#if [ -e ${HOME}/vimpager/vimpager ]; then
#  export PAGER=${HOME}/vimpager/vimpager
#fi

# GPG-AGENT stuff
#

# First test if gpg-agent is already running

function checkgpg() {
  if pgrep -u ${USER} gpg-agent > /dev/null 2>&1 ; then
    echo "GPG-AGENT Running with PID: $(pgrep -u ${USER} gpg-agent)"
    if [ -f "$HOME/.gpg-agent-info_${HOSTNAME}" ]; then
      if [ -n "${GPG_AGENT_INFO+1}" ]; then
        echo "GPG_AGENT_INFO: ${GPG_AGENT_INFO}"
        if [ $(echo "$GPG_AGENT_INFO" | tr ':' ' ' | awk '{print $2}') = $(pgrep -u ${USER} gpg-agent) ];  then
        else
          echo "GPG Agent is running most likely in another shell" 
          return 1
        fi
      else
        echo "GPG Agent is running most likely in another shell"
        return 1
      fi
      echo "GPG_TTY: ${GPG_TTY}"
    else
      echo "GPG Agent is running but has no active configuration"
      return 1
    fi
  else
    echo "GPG Agent is not running"
    return 1
  fi
  return 0
}

function loadgpgFromCfgfile() {
  if [ -f "$HOME/.gpg-agent-info_${HOSTNAME}" ]; then
    . $HOME/.gpg-agent-info_${HOSTNAME}
    export GPG_AGENT_INFO
    GPG_TTY=$(tty)
    export GPG_TTY
  else
    echo "Missing configuration file for this host"
  fi
}

function loadgpg() {
  if pgrep -u ${USER} gpg-agent > /dev/null 2>&1 ; then
    if [ -f "$HOME/.gpg-agent-info_${HOSTNAME}" ]; then
      loadgpgFromCfgfile
    else
      echo "GPG Agent could not be setup"
    fi
  else
    gpg-agent --daemon -v --debug-level 2 --disable-scdaemon --write-env-file "$HOME/.gpg-agent-info_${HOSTNAME}" --no-use-standard-socket --default-cache-ttl 43200 --default-cache-ttl-ssh 43200 --max-cache-ttl 43200 --max-cache-ttl-ssh 43200
    if [ $? -ne 0 ]; then
      echo "gpg-agent could not be started'"
    else
      loadgpgFromCfgfile
    fi
  fi
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

if [[ ${machine} == "olivb-25"  || ${machine} == "olivb-26" ]]; then
  loadgpg
fi

# Check if GPG_TTY is ok for the current shell with the current tty

function checkGPGTTY () {
  if pgrep -u ${USER} gpg-agent > /dev/null 2>&1 ; then
    if [ -n "${GPG_TTY+1}" ]; then
      THIS_TERM=`tty`
      if [[ $GPG_TTY == $THIS_TERM ]]; then
        return 0
      fi
    fi
  fi
  return 1
}

# We setup this env every single time we enter a new shell session. If gpg is
# active, it will pick up the corret tty, if it is not, it will once it will be
# active.
unset GPG_TTY
GPG_TTY=$(tty)
# GIT_ASKPASS=$(which pinentry-curses)
export GPG_TTY
# export GIT_ASKPASS
#
#
# TO BE FINALIZED
prompt_my_krb_validity() {
  if [[ "$HOSTNAME" =~ "cern.ch" ]]; then
    local now=$(date "+%s")
    local end_current=$(date -d "$(klist | grep krbtgt | awk '{print $3, $4}')" "+%s")
    local end_renew=$(date -d "$(klist | grep renew | uniq | awk '{print $3, $4}')" "+%s")
    local days=$(( ($end_current - $now ) / 86400 ))
    local hours=$(( (($end_current - $now) - $days * 86400) / 3600 ))
    local minutes=$(( (($end_current - $now) - $days * 86400 - $hours * 3600) / 60  ))
    local renew_days=$(( ($end_renew - $now) / 86400 ))
    local renew_hours=$(( (($end_renew - $now) - $renew_days * 86400) / 3600 ))
    local renew_minutes=$(( (($end_renew - $now) - $renew_days * 86400 - $renew_hours * 3600) / 60  ))

    if [[ ${renew_days} -eq 0 ]]; then
      p10k segment -s HOT -f red -t "${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m"
    else
      p10k segment -s NORMAL -f green -t "${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m"
    fi
  fi
}
