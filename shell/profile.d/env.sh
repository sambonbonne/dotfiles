#!/usr/bin/env sh

export GOPATH="${HOME}/.local/go"

if [ ! -S /var/run/docker.sock ] && [ -S "${XDG_RUNTIME_DIR}/podman/podman.sock" ]; then
  export DOCKER_HOST="unix://${XDG_RUNTIME_DIR}/podman/podman.sock"
fi
