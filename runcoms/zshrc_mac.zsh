# for MacVim
alias macvim="open -a MacVim"

# for Preview open pdf
alias o="open -a Preview"

# filetree, don't need because brew install tree
# alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

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
    for i in ${MAC_PATH[@]}; do
        insertPath ${i}
    done
}

setMacHome ~/Dropbox/MacHome

# Path for Emacs
insertPath /Applications/Emacs.app/Contents/MacOS
insertPath /Applications/Emacs.app/Contents/MacOS/bin

# alias for Emacs in Terminal
command -v Emacs >/dev/null 2>&1 && alias emacs="Emacs -nw"

# Path for MacVim
insertPath /Applications/MacVim.app/Contents/MacOS

# Path for Calibre
insertPath /Applications/calibre.app/Contents/MacOS

# alias vim to Vim for compatible
command -v Vim >/dev/null 2>&1 && alias vim=Vim

# Path for Matlab
insertPath /Applications/MATLAB_R2014b.app/bin

# Set JAVA_HOME, this is Mac OS only
# for Ubuntu please use sudo update-alternatives --config java
function jdk() {
    JVM_PATH=/Library/Java/JavaVirtualMachines
    [[ ! -d ${JVM_PATH} ]] && return
    JAVA_CANDIDATE=($(ls ${JVM_PATH}))
    [[ $# == 0 ]] && select opt in "${JAVA_CANDIDATE[@]}"; do; [[ ${opt} != "" ]] && break; done || opt=$*
    for i in ${JAVA_CANDIDATE[@]}
    do
        [[ ${i} == *${opt}* ]] && export JAVA_HOME="${JVM_PATH}/${i}/Contents/Home"
    done
    echo "Set JAVA_HOME to ${JAVA_HOME}"
}

# set default JDK to 1.8
jdk 1.8 > /dev/null

sourceFile "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh"
