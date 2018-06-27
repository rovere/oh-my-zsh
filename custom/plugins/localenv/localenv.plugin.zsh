export PATH="${HOME}/bin:$PATH"

export TEXINPUTS="./:"

# Setup source-highlight
export LESS='-C -M -I -j 10 -# 4 -R -F -X '
export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"

function gpgpin() {
  echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
  return $?
}
