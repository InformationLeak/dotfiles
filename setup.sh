#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOMEDIR=${HOME}
ignoredfiles=(.git README.md LICENSE.md push.sh setup.sh update.sh install.sh )

function createLinks() {
    for f in `ls -A $DIR`; do
        filename=$(basename $f)
        if [[ ${ignoredfiles[*]} =~ "$filename" ]]; then
            continue
        fi
        rm "$HOMEDIR/$filename"
        ln -s $DIR/$filename $HOMEDIR/$filename
    done
    source $HOMEDIR/.bashrc
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    createLinks
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        createLinks
    fi
fi
unset createLinks
