module load singularity
RSTUDIO_AUTH=/projects/community/classes/genetics/gen303/container/rstudio_shahclass/scripts/auth
SINGULARITY_IMAGE=/projects/community/classes/genetics/gen303/container/rstudio_shahclass/shahclass.sif
PORT=8787
TMPDIR=$(mktemp -d) 

SERVER_DATA_DIR=$(TMPDIR=/tmp mktemp -d)
mkdir -p ${SERVER_DATA_DIR}/var/{lib,run}
chmod a+rw ${SERVER_DATA_DIR}/var/run
chmod +t ${SERVER_DATA_DIR}/var/run


BINDS=/scratch,/home,/data,${SERVER_DATA_DIR}/var/lib:/var/lib/rstudio-server,${SERVER_DATA_DIR}/var/run:/var/run/rstudio-server

singularity exec --bind $BINDS \
      $SINGULARITY_IMAGE /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} --auth-none=1 
#      --bind $SINGULARITY_LOCALCACHEDIR/tmp:/tmp \
#      --bind $SINGULARITY_LOCALCACHEDIR/run:/run \
#      --bind /home \
      #$SINGULARITY_IMAGE /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} --auth-none=0 --auth-pam-helper-path=pam-helper --server-data-dir "/tmp/rserver-data" --secure-cookie-key-file "/tmp/rstudio-server/secure-cookie-key" 
#PASSWORD='xyz' singularity exec --bind=/project    $SINGULARITY_IMAGE /usr/lib/rstudio-server/bin/rserver --auth-none=0  --auth-pam-helper-path=pam-helper --www-address=127.0.0.1

