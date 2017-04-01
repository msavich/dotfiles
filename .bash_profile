WHITE="\001\033[0;97m\002"
GREEN="\001\033[0;32m\002"
YELLOW="\001\033[0;33m\002"
BLUE="\001\033[0;34m\002"
RED="\001\033[0;31m\002"
MAGENTA="\001\033[0;35m\002"

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local no_repo=""
  
  if [[ $git_status == $no_repo ]]; then
    echo -e $WHITE
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $BLUE
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $GREEN
  elif [[ $git_status =~ "Changes to be committed" ]]; then
    echo -e $YELLOW
  elif [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $RED
  else
    echo -e $MAGENTA
  fi
}
export -f git_color

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  local no_repo=""
  
  if [[ $git_status == $no_repo ]]; then
    echo "(no repo)"
  elif [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  else
    echo "(error)"
  fi
}
export -f git_branch

export PS1="$WHITE\u | \W | \$(git_color)\$(git_branch)$WHITE $ "

# Setting PATH for Python 2.7
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
