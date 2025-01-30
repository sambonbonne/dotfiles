# Load zcomet plugin manager (install if required)

ZCOMET_BIN_DIR="${ZDOTDIR:-${HOME}}/.zcomet/bin"

if [[ ! -f "${ZCOMET_BIN_DIR}/zcomet.zsh" ]]; then
  command git clone "https://github.com/agkozak/zcomet.git" "${ZCOMET_BIN_DIR}"
fi

source "${ZCOMET_BIN_DIR}/zcomet.zsh"


# Load plugins

zcomet load "chrissicool/zsh-256color"

zcomet load "zsh-users/zsh-completions"

zcomet load "hlissner/zsh-autopair"

ZSH_COMMAND_TIME_MIN_SECONDS=15
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_EXCLUDE=(distrobox helix hx k9s kak time tmux tmx toolbox vi vim zellij zj)
zcomet load "popstas/zsh-command-time"

# syntax hightlight
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zcomet load "zsh-users/zsh-syntax-highlighting"

# zsh-history-substring-search must be loaded AFTER zsh-syntax-highlight
zcomet load "zsh-users/zsh-history-substring-search"

# zsh-autosuggestions must be loaded AFTER zsh-history-substring-search
zcomet load "zsh-users/zsh-autosuggestions"


# Run compinit

zcomet compinit
autopair-init


# Configure plugins that need to be configured after compinit

# autosuggest
export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
bindkey '^[ ' autosuggest-accept

# history substring search
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=14'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=13'
# in normal mode, up/down keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# in vi mode, j/k keys
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
