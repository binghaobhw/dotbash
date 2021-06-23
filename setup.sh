#!/usr/bin/env bash
CONFIG_DIR="${HOME}/.bash/config"
LINK_DIR="${HOME}"
for i in $(cd ${CONFIG_DIR} && ls .??*)
do
    target_path="${CONFIG_DIR}/$i"
    link_path="${LINK_DIR}/$i"
    ln -sv $target_path $link_path
done

BIN_DIR="${HOME}/.bash/bin"
HOME_BIN_DIR="$HOME/bin"
mkdir -p ${HOME_BIN_DIR}
for i in $(cd ${BIN_DIR} && ls)
do
    ln -sv "$BIN_DIR/$i" "$HOME_BIN_DIR/$i"
done
