#!/usr/bin/env bash

scp configuration.nix bas &&
ssh bas sudo cp configuration.nix /etc/nixos/configuration.nix &&
ssh sudo nixos-rebuild switch
