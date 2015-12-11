export PYTHONSTARTUP="/afs/cern.ch/user/r/rovere/.pystartup"
VI=$(which vim)
if [ $? -eq 0 ]; then
  export VISUAL=${VI}
fi
