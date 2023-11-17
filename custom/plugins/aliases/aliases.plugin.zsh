alias lt='ls -latrGF'
alias els='exa -lFam -s modified'
alias ssh_lxplus="ssh -t -Y rovere@lxplus.cern.ch"
alias ssh_cmsusr0="ssh -t -Y rovere@cmsusr0"
alias ssh_cmsusr1="ssh -t -Y rovere@cmsusr1"
alias ssh_cmsusr2="ssh -t -Y rovere@cmsusr2"
alias ssh_cmsusr3="ssh -t -Y rovere@cmsusr3"
alias ssh_pccms94="ssh -t -Y rovere@pccms94.cern.ch"
alias proxyCern="ssh -t -D 1934 rovere@lxplus.cern.ch"
alias proxyP5="ssh -t -L 1934:localhost:1080 rovere@lxplus.cern.ch ssh -t -D 1080 rovere@cmsusr1"
alias proxyCernP5="ssh -D 1934 rovere@cmsusr1"
alias lumi="ssh -i .ssh/id_rsa_lumi marovere@lumi.csc.fi"

alias b150="ssh -t -Y lxbuild150.cern.ch"
alias b046="ssh -t -Y lxbuild046.cern.ch" 
alias b050="ssh -t -Y lxbuild050.cern.ch" 
alias vocms116="ssh -t -Y vocms116.cern.ch" 
alias vocms138="ssh -t -Y vocms138.cern.ch" 
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

# Edit file in readonly mode using vim
alias lr='vim -R'
fzf-vim() {
    ls -1rt "$@" | grep -v / | fzf --tac --preview "batcat --color=always {}" --preview-window=right:50%:wrap | xargs -r -d '\n' vim
}

# Set up a pbcopy-like alias
alias pbcopy='xsel --primary --input'
alias cbcopy='xsel --clipboard --input'
alias showsel='echo PRIMARY is $(xsel -p); echo SECONDARY is $(xsel -s); echo CLIPBOARD is $(xsel -b)'

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
