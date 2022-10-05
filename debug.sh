#!/bin/bash
set -e
set -x

usage() {
        echo "Usage:"
        echo "        $0 <destination path>"
}

if [[ $# != 1 ]]; then
        usage
        exit 1
fi

path="$1"

# set the Makefile
cp -f config/Makefile ${path}/Makefile
