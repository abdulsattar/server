#!/usr/bin/env bash

# Copies configuration.nix to a home directory
# and uses sudo to copy it /etc/nixos

scp configuration.nix bas:configuration.nix &&
ssh bas "sudo mv configuration.nix /etc/nixos/configuration.nix && sudo nixos-rebuild switch"
