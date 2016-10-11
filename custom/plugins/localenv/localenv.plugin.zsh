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

# Use custom-compiled emacs on afs
export PATH=/afs/cern.ch/work/r/rovere/emacs/bin:${PATH}

export LS_COLORS="no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:*.py=00;33:*.cfg=00;34:*.cc=01;31:*.h=00;33:*.xml=00;37"
