#!/bin/bash

set -euxo pipefail

##############################################################################
#  Variables
##############################################################################
readonly NIX_EXEC_PATH=/nix/var/nix/profiles/default/bin

##############################################################################
#  function
##############################################################################
function _is_nix_existing() {
  test -x ${NIX_EXEC_PATH}/nix
}

function _install_nix() {
  if _is_nix_existing; then
    : DO NOTHING
  else
    # Use Determinate Nix Installer
    # https://github.com/DeterminateSystems/nix-installer
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  fi
}

function _update_nix_channel() {
  local -r nix_channel=${NIX_EXEC_PATH}/nix-channel
  local -r nixpkgs_channel_url=https://nixos.org/channels/nixpkgs-unstable

  if ${nix_channel} --list | grep -q '^nixpkgs'; then
    : DO NOTHING
  else
    ${nix_channel} --add ${nixpkgs_channel_url}
    ${nix_channel} --update
  fi
}

##############################################################################
#  main
##############################################################################
function main() {
  _install_nix
  _update_nix_channel
}

main
