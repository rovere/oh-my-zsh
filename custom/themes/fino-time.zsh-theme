# fino-time.zsh-theme

# Use with a dark background and 256-color terminal!
# Meant for people with RVM and git. Tested only on OS X 10.7.

# You can set your computer name in the ~/.box-name file if you want.

# Borrowing shamelessly from these oh-my-zsh themes:
#   bira
#   robbyrussell
#
# Also borrowing from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# To print the full list of 256 available colors, use this command:
#
# curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/e50a28ec54188d2413518788de6c6367ffcea4f7/print256colours.sh | bash

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '⠠⠵' && return
    echo '○'
}

function box_name {
  local box="${SHORT_HOST:-$HOST}"
  [[ -f ~/.box-name ]] && box="$(< ~/.box-name)"
  echo "${box:gs/%/%%}"
}

prompt_git_summary() {
  git rev-parse --git-dir &> /dev/null
  if [[ "$?" == 0 ]]; then
#  if git rev-parse --is-inside-work-tree > /dev/null 2>&1 ; then
    local added=$(git --no-pager diff --shortstat | gawk 'match($0, /([0-9]+) \w+\(\+\)/, a) {print a[1]}')
    if [[ "$added" = "" ]] ; then
      added="0"
    fi
    local deleted=$(git --no-pager diff --shortstat | gawk 'match($0, /([0-9]+) \w+\(\-\)/, a) {print a[1]}')
    if [[ "$deleted" = "" ]] ; then
      deleted="0"
    fi
    echo " %{$FG[239]%}[%{$FG[040]%}+$added%{$reset_color%}%{$FG[196] -$deleted%}%{$reset_color%}%{$FG[239]%}]%{$reset_color%}"
  fi
}

prompt_gpg() {
  if [[ "$HOSTNAME" =~ "cern.ch" ]]; then
    checkGPGTTY
    if [[ $? == 0 ]]; then
      echo "%{$fg_bold[blue]%}ok%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}!!%{$reset_color%}"
    fi
  fi
}

prompt_krb() {
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
      echo "%{$FG[040]%} ${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m%{$reset_color%} "
    else
      echo "%{$FG[040]%} ${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m%{$reset_color%} "
    fi
  else
    echo "%{$FG[040]%}NoKRB%{$reset_color%} "
  fi
}

PROMPT="╭─%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}%~%{$reset_color%} \$(prompt_krb)\$(git_prompt_info)\$(prompt_git_summary)\$(ruby_prompt_info)
╰─\$(virtualenv_info)\$(prompt_char) "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[239]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[202]%}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[040]%}✔"
ZSH_THEME_RUBY_PROMPT_PREFIX=" %{$FG[239]%}using%{$FG[243]%} ‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"
