#!/usr/bin/env bash

# Copies configuration.nix to a home directory
# and uses sudo to copy it /etc/nixos

ssh bas "mkdir -p /tmp/rebuild && rm -rf /tmp/rebuild/*"
scp *.nix bas:/tmp/rebuild/ &&
ssh bas "sudo mv /tmp/rebuild/*.nix /etc/nixos/ && sudo nixos-rebuild switch"
