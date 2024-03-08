ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
ZINIT_MAIN="${ZINIT_HOME}/zinit.zsh"

if [ ! -f "${ZINIT_MAIN}" ]; then
  mkdir -p "${ZINIT_HOME}"
  git clone --progress https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}"
fi

source "${ZINIT_MAIN}"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice src"src" wait lucid
zinit load "zsh-users/zsh-completions"

# seem to not work with ice wait
zinit ice wait'!' lucid atload"bindkey '^[ ' autosuggest-accept"
zinit load "zsh-users/zsh-autosuggestions"
# bindkey '^[ ' autosuggest-accept

zinit ice wait lucid
zinit load "hlissner/zsh-autopair"

# seem to bug with auto-suggestions with ice wait
zinit ice wait'!' lucid atload"\
  # in normal mode, up/down keys
  bindkey \"^[[A\" history-substring-search-up;\
  bindkey \"^[[B\" history-substring-search-down;\
  # in vi mode, j/k keys
  bindkey -M vicmd 'k' history-substring-search-up;\
  bindkey -M vicmd 'j' history-substring-search-down"
zinit load "zsh-users/zsh-history-substring-search"

zinit load "chrissicool/zsh-256color"

zinit ice wait lucid
zinit load "jreese/zsh-titles"

# # zplug "MichaelAquilina/zsh-auto-notify", if:"{ command -v notify-send ; } >/dev/null 2>&1"
# # export AUTO_NOTIFY_THRESHOLD=20
# # export AUTO_NOTIFY_TITLE="· %command → %exit_code ·"
# # export AUTO_NOTIFY_BODY="Duration: %elapsed seconds"
# zplug "marzocchi/zsh-notify", if:"{ command -v notify-send ; } >/dev/null 2>&1"
# #zstyle ':notify:*' blacklist-regex 'kak|nvim|vim'
# zstyle ':notify:*' enable-on-ssh yes
# zstyle ':notify:*' command-complete-timeout 20
# zstyle ':notify:*' error-title "(╯°□°)╯ ︵ ┻━┻"
# zstyle ':notify:*' success-title "(⌐■_■)"

ZSH_COMMAND_TIME_MIN_SECONDS=15
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_EXCLUDE=(time hx k9s kak tmx tmux toolbox vi vim zellij)
zinit ice wait lucid
zinit load "popstas/zsh-command-time"

# syntax highlight plugins need to be the last loaded
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zinit ice wait lucid atinit'zicompinit'
zinit load "zsh-users/zsh-syntax-highlighting"

zinit compinit

# configure some plugins after loading
export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=14'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=13'
