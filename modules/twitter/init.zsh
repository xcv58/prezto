#
# Setup tools for Twitter internal use
#
# Authors:
#   xcv58 <i@xcv58.com>
#

function exists() {
  whence -w $1 >/dev/null
}

function is_twitter_source() {
  local d
  local -a larger_repo_dirs

  larger_repo_dirs=(
    "${HOME}/workspace/source"
  )

  for d in ${larger_repo_dirs}; do
    [[ ${PWD} == ${d}* ]] && return 0
  done
  return 1
}

function enter_twitter_source() {
  alias git="/opt/twitter_mde/bin/git"
}

function leave_twitter_source() {
  unalias git 2>/dev/null
}

function chpwd() {
  is_twitter_source && enter_twitter_source || leave_twitter_source
}

# PATH for twitter
insertPath /opt/twitter_mde/sbin
insertPath /usr/local/mysql/bin
insertPath "${HOME}/bin"
insertPath /opt/twitter_mde/homebrew/mde_bin
insertPath /opt/twitter_mde/bin

