alias lt='ls -latrGF'
alias ssh_pcmagni="ssh -Y rovere@pcmagni.mib.infn.it"
alias ssh_pomense="ssh -Y rovere@pomense.mib.infn.it"
alias ssh_lxplus="ssh -Y rovere@lxplus.cern.ch"
alias ssh_cmsusr0="ssh -Y rovere@cmsusr0"
alias ssh_cmsusr1="ssh -Y rovere@cmsusr1"
alias ssh_cmsusr2="ssh -Y rovere@cmsusr2"
alias ssh_cmsusr3="ssh -Y rovere@cmsusr3"
alias ssh_pccms94="ssh -Y rovere@pccms94.cern.ch"
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

alias work='cd /afs/cern.ch/work/r/rovere'
alias slc5='export SCRAM_ARCH=slc5_ia32_gcc434'
alias cmst3='export STAGE_HOST=castorcms && export STAGE_SVCCLASS=cmst3'
alias nocmst3='export STAGE_HOST=castorpublic && export STAGE_SVCCLASS=default'
alias setupCrab='source /afs/cern.ch/cms/LCG/LCG-2/UI/cms_ui_env.sh && source /afs/cern.ch/cms/ccs/wm/scripts/Crab/crab.sh'

alias t='/usr/bin/time -f "%E"'

alias make_release_notes='(cd /afs/cern.ch/work/r/rovere/public/ReleaseNotes && release_notes.sh)'
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


# Tmux default layout at CERN
alias tmux_cern="tmux select-layout 'efae,318x98,0,0{140x98,0,0,177x98,141,0[177x32,141,0,177x32,141,33,177x32,141,66]}'"

if [ -d /home/rovere/local/bin ]; then
  export PATH=/home/rovere/local/bin:$PATH
  export LD_LIBRARY_PATH=/home/rovere/local/lib:$LD_LIBRARY_PATH
  export MANPATH=/home/rovere/local/share/man:$MANPATH
fi
