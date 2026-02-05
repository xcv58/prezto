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

# Path for Mono
insert_path /Library/Frameworks/Mono.framework/Versions/Current/bin/

# Path for Emacs
insert_path /Applications/Emacs.app/Contents/MacOS
insert_path /Applications/Emacs.app/Contents/MacOS/bin

insert_path "${ZDOTDIR:-$HOME}/.fastlane/bin"
insert_path /usr/local/opt/ruby/bin

insert_path "${ZDOTDIR:-$HOME}/Library/flutter/bin"

## rvm (lazy-loaded)
function load_rvm() {
    [[ -s "/opt/twitter/rvm/scripts/rvm" ]] && source "/opt/twitter/rvm/scripts/rvm"
}
lazy_load load_rvm rvm

# alias atom-beta to atom
# command -v atom-beta >/dev/null 2>&1 && alias atom="atom-beta"

# alias for Emacs in Terminal
command -v Emacs >/dev/null 2>&1 && alias emacs="Emacs -nw"

# alias for Metoer
command -v meteor >/dev/null 2>&1 && alias m="meteor"

# Path for MacVim
insert_path /Applications/MacVim.app/Contents/MacOS

# Path for Calibre
insert_path /Applications/calibre.app/Contents/MacOS

# alias vim to Vim for compatible
command -v Vim >/dev/null 2>&1 && alias vim=Vim

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

# set default JDK (lazy - runs on first java/javac call)
function load_jdk() {
    jdk 20 > /dev/null
}
lazy_load load_jdk java javac jar
# source_file "/usr/local/opt/autoenv/activate.sh"

function mountAndroid() { hdiutil attach ~/android.dmg.sparseimage -mountpoint /Volumes/android; }
function umountAndroid() { hdiutil detach /Volumes/android; }

# z.lua directory jumping (lazy-loaded)
function load_zlua() {
    command -v lua >/dev/null 2>&1 && eval "$(lua ${ZDOTDIR:-$HOME}/.zprezto/z.lua/z.lua --init zsh)"
}
lazy_load load_zlua z

function install_brew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  source "${ZDOTDIR:-$HOME}/.zshrc"
}

function init_brew {
  command -v brew >/dev/null 2>&1 || install_brew
  brew bundle --file=${ZDOTDIR:-$HOME}/MacHome/zprezto/Brewfile
}

insert_path /opt/homebrew/bin
