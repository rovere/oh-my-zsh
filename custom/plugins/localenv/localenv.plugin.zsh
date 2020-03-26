export PATH="${HOME}/bin:$PATH"

if [ -e ${HOME}/anaconda2/bin ]; then
  export PATH=${HOME}/anaconda2/bin:${PATH}
fi

if [ -e ${HOME}/Firefox ]; then
  export PATH=${HOME}/Firefox:${PATH}
fi

export TEXINPUTS="./:"

# Setup source-highlight
export LESS='-C -M -I -j 10 -# 4 -R -F -X '
export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"

function gpgpin() {
  echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
  return $?
}

function prdates() {
  token=$(cat ~/.private/.github.token)
  prjson=$(curl -H "Authorization: token ${token}" https://api.github.com/repos/cms-sw/cmssw/issues/$1 2>/dev/null)
  title=$(echo ${prjson} | tr '\r\n' ' ' | jq '.title' |tr -d '"')
  user=$(echo ${prjson} | tr '\r\n' ' ' | jq '.user.login')
  d1=$(echo ${prjson} | tr '\r\n' ' ' | jq '.created_at' | tr -d '"')
  d2=$(echo ${prjson} | tr '\r\n' ' ' | jq '.closed_at'  | tr -d '"')
  body=$(echo ${prjson} | tr '\r\n' ' ' | jq '.body')
  echo "PR $1 has title: $title"
  echo "PR $1 submitted by $user"
  echo "PR $1 description:\n ${body}"
  echo "PR $1 created on: ${d1}"
  echo "PR $1 closed  on: ${d2}"
  d1=$(date -d $d1 +%s)
  d2=$(date -d $d2 +%s)
  days=$(( (d2 - d1) / 86400 ))
  echo ${days} days
  echo "\`\`${title}'' [\\\emph{${user}}, ${days} days]"
}

function openpr() {
  token=$(cat ~/.private/.github.token)
  prjson=$(curl -H "Authorization: token ${token}" https://api.github.com/repos/cms-sw/cmssw/issues 2>/dev/null)
  echo "${prjson}" | sed -e 's/[\r\t]/ /g' | tr '\n' ' ' | jq '.[] | .number,.user.login,.title,.body,.labels[].name'
}

function openprlabel() {
  token=$(cat ~/.private/.github.token)
  prjson=$(curl -H "Authorization: token ${token}" "https://api.github.com/repos/cms-sw/cmssw/issues?labels=$1" 2>/dev/null)
  echo "${prjson}" | sed -e 's/[\r\t]/ /g' | tr '\n' ' ' | jq '.[] | .number,.user.login,.title,.body,.labels[].name'
}

function pdf2png() {
  in=$1
  out=$(basename $in)
  out=${out%.pdf} # Strip pdf from the output filename
  convert           \
   -verbose       \
   -density 150   \
   -trim          \
    ${in}      \
   -quality 100   \
   -flatten       \
   -sharpen 0x1.0 \
    $out.png
}
