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

alias vocms0138="ssh -t -Y vocms0138.cern.ch"
alias vocms0131="ssh -t -Y vocms0131.cern.ch"
alias vocms0139="ssh -t -Y vocms0139.cern.ch"
alias vocms0738="ssh -t -XY vocms0738.cern.ch"
alias vocms0739="ssh -t -XY vocms0739.cern.ch"
alias v2="ssh -t -XY vinavx2.cern.ch"
alias o9="ssh -t -XY olsnbc09.cern.ch"
alias o25="ssh -t -XY olivb-25.cern.ch"
alias p2="ssh -t -XY patatrack02.cern.ch"
alias m7="ssh -t -XY mrovere-slc7.cern.ch"
alias d7="ssh -t -XY dqmgui7.cern.ch"
alias p2="ssh -t -XY patatrack02.cern.ch"

alias work='cd /afs/cern.ch/work/r/rovere'
alias slc5='export SCRAM_ARCH=slc5_ia32_gcc434'
alias cmst3='export STAGE_HOST=castorcms && export STAGE_SVCCLASS=cmst3'
alias nocmst3='export STAGE_HOST=castorpublic && export STAGE_SVCCLASS=default'
alias setupCrab='source /afs/cern.ch/cms/LCG/LCG-2/UI/cms_ui_env.sh && source /afs/cern.ch/cms/ccs/wm/scripts/Crab/crab.sh'

alias t='/usr/bin/time -f "%E"'

# Set up a pbcopy-like alias
alias pbcopy='xsel --clipboard --input'

hless () {highlight -A $* | less -n -r}

createTags() {
  find ./ -regextype posix-egrep -regex '.*\.(h|cc|icc|cpp)$' > source_files.txt
  cscope -b -i source_files.txt
  ctags --extra=+fq -L source_files.txt --verbose
}

pomodoro() {
 (sleep 1500 && notify-send -t 100000 "Pomodoro session is over") &
 disown
}
