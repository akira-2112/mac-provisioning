#!/bin/bash

set -euxo pipefail

##############################################################################
#  Variables
##############################################################################
readonly HOMEBREW_EXEC_PATH=/opt/homebrew/bin

##############################################################################
#  function
##############################################################################
function _is_homebrew_existing() {
  test -x ${HOMEBREW_EXEC_PATH}/brew
}

function _install_homebrew() {
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
}

##############################################################################
#  main
##############################################################################
function main() {
  if _is_homebrew_existing; then
    : DO NOTHING
  else
    _install_homebrew
  fi
}

main
