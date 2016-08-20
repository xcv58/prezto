#!/usr/bin/env zsh
usage() {
    echo "link_dir should follow two arguments:"
    echo "1. the shell script file path"
    echo "2. the target directory path"
    exit
}

link_dir() {
    if [[ $# != 2 ]]; then
        usage
    fi
    SCRIPT_FILE=$1
    TARGET=$2
    SCRIPT_PATH=$(dirname $SCRIPT_FILE)

    cd ${SCRIPT_PATH}
    dir=$(basename ${PWD})
    cd ..
    SOURCE="${PWD}/${dir}"

    if [[ -d ${TARGET} ]]; then
        realpath=$(readlink ${TARGET})
        if [[ ${realpath} == ${SOURCE} ]]; then
            echo "${TARGET} already installed!"
            exit
        else
            back_old_command="mv \"${TARGET}\" \"${TARGET}_BACK_`date +%s`\""
            echo "${back_old_command}"
            eval "${back_old_command}"
        fi
    fi

    link_command="ln -sf \"${SOURCE}\" \"${TARGET}\""

    echo ${link_command}
    eval ${link_command}
}

deploy_base() {
    local ORIGIN="./base.zsh"
    for target in `find . -name "base.zsh"`
    do
        if [[ ${ORIGIN} == ${target} ]]; then
            echo "skip myself: ${ORIGIN}"
        else
            command="cp \"${ORIGIN}\" \"${target}\""
            echo ${command}
            eval ${command}
        fi
    done
}

if [[ $@ == "deploy" ]]; then
    echo "deploy ./base.zsh"
    deploy_base
fi