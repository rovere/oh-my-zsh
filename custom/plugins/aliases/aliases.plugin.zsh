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

alias b150="ssh -t -Y lxbuild150.cern.ch"
alias b046="ssh -t -Y lxbuild046.cern.ch" 
alias b050="ssh -t -Y lxbuild050.cern.ch" 
alias vocms116="ssh -t -Y vocms116.cern.ch" 
alias vocms138="ssh -t -Y vocms138.cern.ch" 
alias vocms139="ssh -t -Y vocms139.cern.ch" 

alias work='cd /afs/cern.ch/work/r/rovere'
alias slc5='export SCRAM_ARCH=slc5_ia32_gcc434'
alias cmst3='export STAGE_HOST=castorcms && export STAGE_SVCCLASS=cmst3'
alias nocmst3='export STAGE_HOST=castorpublic && export STAGE_SVCCLASS=default'
alias setupCrab='source /afs/cern.ch/cms/LCG/LCG-2/UI/cms_ui_env.sh && source /afs/cern.ch/cms/ccs/wm/scripts/Crab/crab.sh'
 
alias t='/usr/bin/time -f "%E"'
