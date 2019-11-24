#!/bin/sh

# OpenSCAD dependency management through Git.
# Probably works for other things, too.
# Edit dependencies, run, then in your scads do e.g.:
# use <deps.link/BOSL/joiners.scad>
# MIT License; do what you want.  -Erhannis

LOCAL=deps.link
REMOTE=~/.scad_deps/
while getopts hl:r: option
do
    case "${option}"
    in
	h) echo $'./get_deps.sh [-h] [-l LOCAL=deps.link] [-r REMOTE=~/.scad_deps]';;
	l) LOCAL=${OPTARG};;
	r) REMOTE=${OPTARG};;
    esac
done

# Setup
if [ ! -e "$LOCAL" ]; then
  mkdir -p "$REMOTE"
  ln -s "$REMOTE" "$LOCAL"
fi

#TODO Should recursively fetch dependencies
#TODO Should MAYBE update dependencies

# Dependencies
cd "$REMOTE"
git clone https://github.com/erhannis/getriebe
git clone https://github.com/erhannis/erhannisScad
