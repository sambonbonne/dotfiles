SHELL_BIN="$(ps -p $$ -ocomm=)"

source_completion() {
  if command -v "${1}" 2>&1 >/dev/null; then
    source <(eval "$@") >/dev/null
  fi
}

# Kubernetes completions
source_completion kubectl completion "${SHELL_BIN}"
source_completion kustomize completion "${SHELL_BIN}"
source_completion k9s completion "${SHELL_BIN}"
source_completion helm completion "${SHELL_BIN}"

# Kubernetes tools completions
source_completion argocd completion "${SHELL_BIN}"
source_completion argocd-autopilot completion "${SHELL_BIN}"
source_completion flux completion "${SHELL_BIN}"
source_completion pluto completion "${SHELL_BIN}" 2>/dev/null # remove Fairwinds Insights message
source_completion nova completion "${SHELL_BIN}"

# Cloud CLI completions
source_completion scw autocomplete script "shell=${SHELL_BIN}"

# Other tooling completion
source_completion just --completions "${SHELL_BIN}"
source_completion dotter gen-completions --shell "${SHELL_BIN}"
