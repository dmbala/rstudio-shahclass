#!/usr/bin/env bash

# Load the required environment
setup_env () {
  module purge
  # If you want to use Singularity it is recommended you setup a module similar
  # to the included `example_module` and load it as:
  #
  #     module use "/path/to/example_module/modulefiles"
  #     module load singularity rstudio_singularity/3.4.3
  #
  # Bonus points if you install the `example_module` on the system so you don't
  # need to run `module use`.
  export RSTUDIO_SINGULARITY_HOST_MNT=/
  export RSTUDIO_SINGULARITY_IMAGE=/projects/oarc/staff/acirefs/bd387/sw/shahclass/shahclass.simg
  export RSERVER_LAUNCHER=/projects/oarc/staff/acirefs/bd387/sw/shahclass/scripts/
}
setup_env

#
# Start RStudio Server
#

# PAM auth helper used by RStudio
export RSTUDIO_AUTH="/projects/oarc/staff/acirefs/bd387/sw/shahclass/scripts/auth"

# Generate an `rsession` wrapper script
export RSESSION_WRAPPER_FILE="${PWD}/rsession.sh"
(
umask 077
sed 's/^ \{2\}//' > "${RSESSION_WRAPPER_FILE}" << EOL
  #!/usr/bin/env bash

  # Log all output from this script
  export RSESSION_LOG_FILE="${RSTUDIO_SINGULARITY_HOST_MNT}${PWD}/rsession.log"
  exec &>>"\${RSESSION_LOG_FILE}"

  # Launch the original command
  echo "Launching rsession..."
  set -x
  exec rsession --r-libs-user "${R_LIBS_USER}" "\${@}"
EOL
)
chmod 700 "${RSESSION_WRAPPER_FILE}"

# Define launcher for `rserver` if not using Singularity
#if [[ -z "${RSTUDIO_SINGULARITY_IMAGE}" ]]; then
#  PROOT_BIN="${PROOT_BIN:-"/usr/local/proot/bin/proot-x86_64"}"
#  RSERVER_LAUNCHER="${PROOT_BIN} -b $(mktemp -d):/tmp "
#fi

# Set working directory to home directory
cd "${HOME}"

module load singularity

# Output debug info
module list

# Launch the RStudio Server
echo "Starting up rserver..."
export port="8799"
echo "port is $port"
set -x
#${RSERVER_LAUNCHER}rserver \
#  --www-port ${port} \
#  --auth-none 0 \
#  --auth-pam-helper-path "${RSTUDIO_SINGULARITY_HOST_MNT}${RSTUDIO_AUTH}" \
#  --auth-encrypt-password 0 \
#  --rsession-path "${RSTUDIO_SINGULARITY_HOST_MNT}${RSESSION_WRAPPER_FILE}"

${RSERVER_LAUNCHER}rserver \
  --www-port ${port} 

