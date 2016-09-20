#!/usr/bin/env bash

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Append import of common shell config
if [ -z "$TJL_COMMON_IMPORTED" ]; then
  echo "Adding common shell-imports..." 
  printf "source \"%s\"\n" "$DOT_ROOT/shell-imports/common.sh" >> $HOME/.zshrc
fi
