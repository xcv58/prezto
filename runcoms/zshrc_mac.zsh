# for MacVim
alias macvim="open -a MacVim"

# for Preview open pdf
alias o="open -a Preview"

# filetree, don't need because brew install tree
# alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

exportENV VIMRUNTIME /Applications/MacVim.app/Contents/Resources/vim/runtime

# Path for Shell script
function setMacHome() {
  [[ $# != 1 ]] && return;
  [[ -d $1 ]] || return;
  local MAC_HOME=$1
  local MAC_PATH
  MAC_PATH=(
    ${MAC_HOME}
    ${MAC_HOME}/Shell_script
    ${MAC_HOME}/Shell_script/AppleScript
    ${MAC_HOME}/OS-161-Scripts
  )
  for i in "${MAC_PATH[@]}"; do
    insert_path "${i}"
  done
}

setMacHome ~/MacHome

# Path for LaTeX
insert_path /usr/local/texlive/2015/bin/universal-darwin

# Path for Emacs
insert_path /Applications/Emacs.app/Contents/MacOS
insert_path /Applications/Emacs.app/Contents/MacOS/bin

## rvm
# shellcheck disable=SC1091
[[ -s "/opt/twitter/rvm/scripts/rvm" ]] && source "/opt/twitter/rvm/scripts/rvm"

# alias atom-beta to atom
# command -v atom-beta >/dev/null 2>&1 && alias atom="atom-beta"

# alias for Emacs in Terminal
command -v Emacs >/dev/null 2>&1 && alias emacs="Emacs -nw"

# Path for MacVim
insert_path /Applications/MacVim.app/Contents/MacOS

# Path for Calibre
insert_path /Applications/calibre.app/Contents/MacOS

# alias vim to Vim for compatible
command -v Vim >/dev/null 2>&1 && alias vim=Vim

# Path for Matlab
insert_path /Applications/MATLAB_R2014b.app/bin

# Set JAVA_HOME, this is Mac OS only
# for Ubuntu please use sudo update-alternatives --config java
function jdk() {
    JVM_PATH=/Library/Java/JavaVirtualMachines
    [[ ! -d ${JVM_PATH} ]] && return

    JAVA_CANDIDATE=($(ls ${JVM_PATH}))
    if [[ $# == 0 ]]; then
      select opt in "${JAVA_CANDIDATE[@]}"
      do
        [[ ${opt} != "" ]] && break;
      done
    else
      opt=$*
    fi

    for i in "${JAVA_CANDIDATE[@]}"
    do
        [[ ${i} == *${opt}* ]] && export JAVA_HOME="${JVM_PATH}/${i}/Contents/Home"; export STUDIO_JDK="${JVM_PATH}/${i}"
    done
    echo "Set JAVA_HOME to ${JAVA_HOME}"
    echo "Set STUDIO_JDK to ${JAVA_HOME}"
}

# set default JDK to 1.8
jdk 1.7 > /dev/null

source_file "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh"
source_file "/usr/local/opt/autoenv/activate.sh"

function mountAndroid() { hdiutil attach ~/android.dmg.sparseimage -mountpoint /Volumes/android; }
function umountAndroid() { hdiutil detach /Volumes/android; }
