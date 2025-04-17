#!/usr/bin/env bash
# Test runner for install.sh in both local and container isolation
#+ usage: test-install.sh [--local]
#+  --local   Run the install script in a local sandbox (no containers)
set -euo pipefail
# Parse optional flags
LOCAL_MODE=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --local) LOCAL_MODE=true; shift;;
    *) echo "Usage: $0 [--local]"; exit 1;;
  esac
done

# Determine absolute repo path
REPO_HOST_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ "$LOCAL_MODE" = true ]; then
  echo "Running local sandbox test (no containers)"
  TEST_HOME="$(mktemp -d)"
  echo "Using TEST_HOME=$TEST_HOME"
  export HOME="$TEST_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$REPO_HOST_DIR"
  echo "Invoking install.sh in local mode..."
  ./install.sh home
  echo "Local sandbox test complete. See $TEST_HOME for state."
  exit 0
fi

# Base image for testing (Ubuntu 22.04)
IMAGE="ubuntu:22.04"

echo "Starting isolated install test in Docker or Podman ($IMAGE)"


# Container path where the repo will be mounted (outside HOME)
CONTAINER_REPO_DIR="/dotfiles"

 # Determine which container runtime to use (docker or podman)
CMD=
if command -v docker >/dev/null 2>&1; then
  CMD=docker
elif command -v podman >/dev/null 2>&1; then
  CMD=podman
else
  echo "Neither Docker nor Podman found. Attempting to install Podman..."
  if [ "$(uname)" = "Linux" ]; then
    sudo apt-get update && sudo apt-get install -y podman
    CMD=podman
  elif [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew >/dev/null 2>&1; then
      echo "Homebrew not found. Please install Homebrew to install Podman."
      exit 1
    fi
    brew install podman
    CMD=podman
  else
    echo "Unsupported OS: $(uname). Install Docker or Podman manually."
    exit 1
  fi
fi

echo "Using container runtime: $CMD"

"$CMD" run --rm -it \
  -v "$REPO_HOST_DIR":$CONTAINER_REPO_DIR:ro \
  --workdir $CONTAINER_REPO_DIR \
  $IMAGE \
  bash -lc "
    set -euo pipefail
    apt-get update && apt-get install -y sudo git curl zsh stow pkg-config build-essential
    useradd -m -s /bin/bash testuser
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    echo 'Running install.sh as testuser...'
    su - testuser -c 'cd $CONTAINER_REPO_DIR && ./install.sh home'
"
echo "Isolated test complete. Verify above output for errors."