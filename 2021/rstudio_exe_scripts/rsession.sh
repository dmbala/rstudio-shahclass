#!/usr/bin/env bash

# Log all output from this script
#export R_LIB_USER="/projects/community/py-image/2019.10A/bd387/anaconda3-intel17/envs/shahclass/lib/R/library"
# Launch the original command
echo "Launching rsession..."
set -x
exec rsession --r-libs-user "${USER}" "${@}"
