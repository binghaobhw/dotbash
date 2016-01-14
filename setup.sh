#!/usr/bin/env bash
CONFIG_DIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/config"
LINK_DIR=$HOME
for i in $(ls $CONFIG_DIR)
do
    target_path="${CONFIG_DIR}/$i"
    link_path="${LINK_DIR}/.$i"
    ln -bsv $target_path $link_path
done

mkdir -p ~/bin
for i in $(ls bin)
do
    ln -bsv "bin/$i" "~/bin/$i"
done
