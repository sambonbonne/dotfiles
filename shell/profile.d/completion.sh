#!/usr/bin/env sh

SHELL_BIN="$(ps -p $$ -ocomm=)"

# Kubernetes completions
command -v kubectl >/dev/null && source <(kubectl completion "${SHELL_BIN}") # TODO not found compdef
command -v kustomize >/dev/null && source <(kustomize completion "${SHELL_BIN}")
command -v helm >/dev/null && source <(helm completion "${SHELL_BIN}")
command -v k9s >/dev/null && source <(k9s completion "${SHELL_BIN}")

# Kubernetes tools completions
command -v argocd >/dev/null && source <(argocd completion "${SHELL_BIN}")
command -v argocd-autopilot >/dev/null && source <(argocd-autopilot completion "${SHELL_BIN}")
command -v flux >/dev/null && source <(flux completion "${SHELL_BIN}")
command -v pluto >/dev/null && source <(pluto completion "${SHELL_BIN}")
command -v nova >/dev/null && source <(nova completion "${SHELL_BIN}")

# Cloud CLI completions
command -v scw >/dev/null && eval "$(scw autocomplete script shell="${SHELL_BIN}")"

# Other tooling completion
command -v just >/dev/null && source <(just --completions "${SHELL_BIN}")
