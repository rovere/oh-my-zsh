export PATH="${HOME}/bin:$PATH"

export TEXINPUTS="./:"

# Setup source-highlight
export LESS='-C -M -I -j 10 -# 4 -R -F -X '
export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"
