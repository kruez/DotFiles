# Further customization options available at https://github.com/eendroroy/alien

ZSH_THEME="alien/alien"
export ALIEN_THEME="gruvbox"
export ALIEN_USE_NERD_FONT=1

export ALIEN_SECTIONS_LEFT=(
  exit
  path 
  vcs_branch:async 
  vcs_status:async 
  vcs_dirty:async 
  versions:async 
  newline 
  venv 
  prompt
)

#export ALIEN_SECTIONS_RIGHT=(
#  time
#)
#
#export ALIENT_VERSIONS_PROMPT='PYTHON_S NODE_S JAVA_S'

ALIEN_ZSH=~/.oh-my-zsh/custom/themes/alien/alien.zsh
[[ ! -f $ALIEN_ZSH ]] || source $ALIEN_ZSH

