#!/bin/bash
CONFIG_DIR="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/config"
LINK_DIR=$HOME
for i in $(ls $CONFIG_DIR)
do
    target_path="${CONFIG_DIR}/$i"
    link_path="${LINK_DIR}/.$i"
    ln -bsv $target_path $link_path
done
