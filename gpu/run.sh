#!/bin/bash
set -e
. activate tf

if [ -z "$1" ]
  then
    jupyter notebook 
elif [ "$1" == *".ipynb"* ]
  then
    jupyter notebook "$1"
else
    exec "$@"
fi