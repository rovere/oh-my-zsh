alias lt='ls -latrGF'
alias ssh_pcmagni="ssh -t -Y rovere@pcmagni.mib.infn.it"
alias ssh_pomense="ssh -t -Y rovere@pomense.mib.infn.it"
alias ssh_lxplus="ssh -t -Y rovere@lxplus.cern.ch"
alias ssh_cmsusr0="ssh -t -Y rovere@cmsusr0"
alias ssh_cmsusr1="ssh -t -Y rovere@cmsusr1"
alias ssh_cmsusr2="ssh -t -Y rovere@cmsusr2"
alias ssh_cmsusr3="ssh -t -Y rovere@cmsusr3"
alias ssh_pccms94="ssh -t -Y rovere@pccms94.cern.ch"
alias proxyCern="ssh -t -D 1934 rovere@lxplus.cern.ch"
alias proxyP5="ssh -t -L 1934:localhost:1080 rovere@lxplus.cern.ch ssh -t -D 1080 rovere@cmsusr1"
alias proxyCernP5="ssh -D 1934 rovere@cmsusr1"

alias b046="ssh -t -Y lxbuild046.cern.ch"
alias b050="ssh -t -Y lxbuild050.cern.ch"
alias vocms116="ssh -t -Y vocms116.cern.ch"
alias vocms138="ssh -t -Y vocms138.cern.ch"
alias vocms139="ssh -t -Y vocms139.cern.ch"
alias vocms133="ssh -t -Y vocms133.cern.ch"
alias vocms132="ssh -t -Y vocms132.cern.ch"
alias vocms127="ssh -t -Y vocms127.cern.ch"
alias vocms139="ssh -t -Y vocms139.cern.ch"
alias vocms0138="ssh -t -Y vocms0138.cern.ch"
alias vocms0131="ssh -t -Y vocms0131.cern.ch"
alias vocms0139="ssh -t -Y vocms0139.cern.ch"
alias vocms0738="ssh -t -XY vocms0738.cern.ch"
alias vocms0739="ssh -t -XY vocms0739.cern.ch"
alias vo55="ssh -t -XY vocms055.cern.ch"
alias vo22="ssh -t -XY vocms022.cern.ch"
alias v2="ssh -t -XY vinavx2.cern.ch"
alias o9="ssh -t -XY olsnbc09.cern.ch"
alias m7="ssh -t -XY mrovere-slc7.cern.ch"
alias d7="ssh -t -XY dqmgui7.cern.ch"

alias work='cd /afs/cern.ch/work/r/rovere'
alias slc5='export SCRAM_ARCH=slc5_ia32_gcc434'
alias cmst3='export STAGE_HOST=castorcms && export STAGE_SVCCLASS=cmst3'
alias nocmst3='export STAGE_HOST=castorpublic && export STAGE_SVCCLASS=default'
alias setupCrab='source /afs/cern.ch/cms/LCG/LCG-2/UI/cms_ui_env.sh && source /afs/cern.ch/cms/ccs/wm/scripts/Crab/crab.sh'

alias t='/usr/bin/time -f "%E"'

alias make_release_notes='(cd /afs/cern.ch/work/r/rovere/public/ReleaseNotes && release_notes.sh)'

# CMSSW

check_cmssw_env () {
: ${LOCALRT:?"Source CMSSW environment first"}
}

scrb () {
  (
  check_cmssw_env
  pushd $LOCALRT/src &> /dev/null
  scram b -j 2>&1 | tee errors.log
  popd &> /dev/null
  )
}

scrbv () {
  (
  check_cmssw_env
  pushd $LOCALRT/src &> /dev/null
  scram b -v -j 2>&1 | tee errors.log
  popd &> /dev/null
  )
}

scrbr () {
  (
  check_cmssw_env
  echo "RESETTING SCRAM AREA"
  pushd $LOCALRT/src &> /dev/null
  scram b -r clean 2>&1 | tee errors.log
  popd &> /dev/null
  )
}

scrbd () {
  (
  check_cmssw_env
  echo "ENABLING DEBUGGING AND VERBOSE OUTPUT"
  pushd $LOCALRT/src &> /dev/null
  env  USER_CXXFLAGS='-g' scram b -v -j 2>&1 | tee errors.log
  popd &> /dev/null
  )
}

hless () {highlight -A $* | less -n -r}
eosrmdir () {
  eosrepo=$*
   for f in $(eoscms ls ${eosrepo}); do echo -n "Removing ${eosrepo}$f\n" && eoscms rm ${eosrepo}$f; done
}

# directly search for files under the CMSSW_RELASE_BASE, if set.
rless () {
# See here: http://stackoverflow.com/questions/307503/whats-a-concise-way-to-check-that-environment-variables-are-set-in-unix-shellsc
: ${CMSSW_RELEASE_BASE:?"Source CMSSW environment first"}
 less ${CMSSW_RELEASE_BASE}/src/$*
}

rlt() {
: ${CMSSW_RELEASE_BASE:?"Source CMSSW environment first"}
 ls -latr ${CMSSW_RELEASE_BASE}/src/$*
}

checkfiles () {
compare_using_files.py -C -s b2b -t 0.999999 $*
}

createTags() {
  find ./ -regextype posix-egrep -regex '.*\.(h|cc|icc|cpp)$' > source_files.txt
  cscope -b -i source_files.txt
  /usr/bin/ctags --extra=+fq -L source_files.txt
}


showMatrix() {
  setopt shwordsplit
  local -a samples
  counter=1
  echo "Select type, space separated"
  for w in relval_standard relval_highstats relval_pileup relval_generator relval_extendedgen relval_production relval_ged relval_upgrade relval_2017 relval_2023 relval_identity relval_machine relval_unschrelval_premix; 
  do
    echo "${counter})\t${w}";
    samples[counter]=${w}
    (( counter+=1 ))
  done
  while true;
  do
    read selected
    # Split using spaces
    saveIFS="$IFS"
    IFS=' '
    sel=(${selected})
    IFS="$saveIFS"
    for w in $sel;
    do
      echo $samples[${w}]
      runTheMatrix.py -w $samples[${w}] -n -e | grep -P "^\d{3}+" | cut -d '[' -f 1 | less 2>/dev/null;
    done
  done
}

#
# Tmux default layout at CERN
alias tmux_cern="tmux select-layout 'efae,318x98,0,0{140x98,0,0,177x98,141,0[177x32,141,0,177x32,141,33,177x32,141,66]}'"

if [ -d /home/rovere/local/bin ]; then
  export PATH=/home/rovere/local/bin:$PATH
  export LD_LIBRARY_PATH=/home/rovere/local/lib:$LD_LIBRARY_PATH
  export MANPATH=/home/rovere/local/share/man:$MANPATH
fi
