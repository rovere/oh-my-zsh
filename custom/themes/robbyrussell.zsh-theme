# gpg: check if gpg terminal is properly setup
prompt_gpg() {
  checkGPGTTY
  if [[ $? == 0 ]]; then
    echo "%{$fg_bold[blue]%}ok%{$reset_color%}"
  else
    echo "%{$fg_bold[red]%}!!%{$reset_color%}"
  fi
}

close_prompt() {
    echo "\nat %{$fg_bold[yellow]%T%} %{$fg_bold[green]%} ❯ %{$reset_color%}"
}

prompt_user_machine() {
    echo "%{$fg_bold[yellow]%}%n%{$reset_color%} in %{$fg_bold[green]%m%}%{$reset_color%}"
}

prompt_git_summary() {
  local added=$(git --no-pager diff --shortstat | gawk 'match($0, /([0-9]+) \w+\(\+\)/, a) {print a[1]}')
  if [[ "$added" = "" ]] ; then
    added="0"
  fi
  local deleted=$(git --no-pager diff --shortstat | gawk 'match($0, /([0-9]+) \w+\(\-\)/, a) {print a[1]}')
  if [[ "$deleted" = "" ]] ; then
    deleted="0"
  fi
  echo "%{$fg_bold[green]%}+$added%{$reset_color%}%{$fg_bold[red] -$deleted%}%{$reset_color%} "
}

prompt_krb() {
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
    echo "%{$fg_bold[green] ${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m%}%{$reset_color%}"
  else
    echo "%{$fg_bold[green] ${days}d${hours}h${minutes}m ${renew_days}d${renew_hours}h${renew_minutes}m%}%{$reset_color%}"
  fi
}

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $(prompt_user_machine)"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)$(prompt_git_summary)'
PROMPT+='$(prompt_gpg)$(prompt_krb)$(close_prompt)'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
