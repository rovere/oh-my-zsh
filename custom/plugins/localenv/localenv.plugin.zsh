export MAGICK_HOME="/usr/local/ImageMagick"
export PATH="$MAGICK_HOME/bin:$PATH"
export PATH="/usr/texbin:/usr/local/texlive/2015/bin/x86_64-darwin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"

# Setup ROOT
export ROOTSYS="/Users/rovere/root"
export PYTHONPATH="$ROOTSYS/lib"
export PYTHONPATH="/Library/Python/2.7/site-packages/:$PYTHONPATH"
export PATH="$ROOTSYS/bin:$PATH"
export PATH="~$USER/bin:$PATH"
export PATH=/usr/local/MacGPG2/bin:${PATH}
export DYLD_LIBRARY_PATH="$ROOTSYS/lib"

# Setup Go
export PATH="/usr/local/go/bin":${PATH}

export TEXINPUTS="./:$HOME/Documents/Presentazioni:$HOME/CERN-tex/texmf-local/tex/{latex,generic,}//:"

# Setup source-highlight
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '
