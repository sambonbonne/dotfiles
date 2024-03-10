# Global variables
if [ -f /etc/zsh/zprofile ]; then
  source /etc/zsh/zprofile
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [[ $TERM == xterm-termite && -f /etc/profile.d/vte.sh ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

COMMAND_NOT_FOUND_FILE="/usr/share/doc/pkgfile/command-not-found.zsh"
test -f "${COMMAND_NOT_FOUND_FILE}" && source $COMMAND_NOT_FOUND_FILE

# Lines configured by zsh-newuser-install
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
# End of lines configured by zsh-newuser-install

zstyle :compinstall filename '/home/samuel/.zshrc'

### My own configuration
ZSH_CONFIG_PATH="${HOME}/.zsh"
function load_zsh_config() {
  source "${ZSH_CONFIG_PATH}/${1}.zsh"
}

## autocorrect is really good
setopt correct

## Of course we want colors
autoload -U colors && colors

# (shared) history
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=16384
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS

## Completion is a basic
load_zsh_config "completion"

## And some mapping
load_zsh_config "map"

## Don't forget abbreviations
load_zsh_config "abbreviations"

eval $(dircolors ~/.dircolors)

# Pload plugins
load_zsh_config "plugins"

# Load prompt
if command -v starship 2>&1 >/dev/null; then
  eval "$(starship init zsh)"
else
  export PROMPT="%n @ %m %B%~%b ❯ "
	echo "Starship is not installed, basic prompt set."
fi

# If we have custom configuration
_custom_configuration_file="${ZSH_CONFIG_PATH}/custom.zsh"
[[ -f "${_custom_configuration_file}" ]] && source "${_custom_configuration_file}"
