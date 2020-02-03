#
# Setup tools for Twitter internal use
#
# Authors:
#   xcv58 <i@xcv58.com>
#

function is_twitter_source() {
  local d
  local -a larger_repo_dirs

  larger_repo_dirs=(
  "${HOME}/workspace"
  )

  for d in "${larger_repo_dirs[@]}"; do
    [[ ${PWD} == ${d}* ]] && return 0
  done
  return 1
}

function enter_twitter_source() {
  load_twitter_path
}

function leave_twitter_source() {
  remove_twitter_path
}

function chpwd() {
  is_twitter_source && enter_twitter_source
  is_twitter_source || leave_twitter_source
}

# PATH for twitter
TWITTER_PATH=(
"${HOME}/bin"
/usr/local/mysql/bin
/opt/twitter_mde/homebrew/mde_bin
/opt/twitter_mde/sbin
/opt/twitter_mde/bin
)

function load_twitter_path() {
  for p in "${TWITTER_PATH[@]}"; do
    insert_path "${p}"
  done
}

function remove_twitter_path() {
  for p in "${TWITTER_PATH[@]}"; do
    remove_path "${p}"
  done
}
