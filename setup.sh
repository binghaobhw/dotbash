#!/usr/bin/env bash
CONFIG_DIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/config"
LINK_DIR="$HOME"
for i in $(ls $CONFIG_DIR)
do
    target_path="${CONFIG_DIR}/$i"
    link_path="${LINK_DIR}/.$i"
    ln -bsv $target_path $link_path
done
rm -v $LINK_DIR/.bhwang.zsh-theme

BIN_DIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/bin"
LINK_DIR="$HOME/bin"
mkdir -p $LINK_DIR
for i in $(ls $BIN_DIR)
do
    ln -bsv "$BIN_DIR/$i" "$LINK_DIR/$i"
done
