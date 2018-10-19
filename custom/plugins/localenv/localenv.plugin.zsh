export PATH="${HOME}/bin:$PATH"

if [ -e ${HOME}/anaconda2/bin ]; then
  export PATH=${HOME}/anaconda2/bin:${PATH}
fi

export TEXINPUTS="./:"

# Setup source-highlight
export LESS='-C -M -I -j 10 -# 4 -R -F -X '
export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"

function gpgpin() {
  echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
  return $?
}
