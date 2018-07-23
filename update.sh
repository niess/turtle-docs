#!/bin/bash

# Script base directory
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check the status of the output repository
cd $basedir
status="$(git status --porcelain)"
if [ -n "$status" ]; then
    echo "error: clean the output repository first"
    echo "$status"
    exit 1
fi

# Generate the doc with Docurium
cd $basedir/..
docs/docurium/bin/cm doc docs/api.docurium
rm -f mkmf.log

# Synchronize the local folder
cd $basedir
git reset HEAD
git checkout -- .
