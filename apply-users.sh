#!/bin/sh

pushd ~/.dotfiles
home-manager switch -f ./users/piter/home.nix
popd
