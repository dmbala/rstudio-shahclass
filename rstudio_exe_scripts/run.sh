#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo "SCRIPT PATH" 
echo "$SCRIPTPATH"
singularity run $SCRIPTPATH/*.img
