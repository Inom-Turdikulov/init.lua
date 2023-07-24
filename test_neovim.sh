#!/bin/sh
cd "$(dirname "$0")"
export XDG_CONFIG_HOME="$(pwd)/.."
nvim
