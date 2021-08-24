############################################################
# Dockerfile to build bunch of r packages
############################################################

## 'R-base' Debian-based image
##FROM rocker/r-base:latest
##FROM rocker/rstudio-stable:latest
#FROM bioconductor/release_base2:latest
FROM rocker/rstudio:4.1.0

# File Author / Maintainer
MAINTAINER Bala Desinghu <dmbala@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean all && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    libhdf5-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    libpng-dev \
    libxt-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libglpk40 \
    libgit2-28 \
  && apt-get clean all && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN Rscript -e "install.packages(c('rmarkdown', 'tidyverse', 'workflowr', 'BiocManager'));"
RUN Rscript -e "BiocManager::install()"
## Update package lists 


## install devtools
RUN install2.r devtools remotes


ADD pkgs_cran.r /tmp/
RUN R -f /tmp/pkgs_cran.r

ADD pkgs_bioc.r /tmp/
RUN R -f /tmp/pkgs_bioc.r


ADD pkgs_db.r /tmp/
RUN R -f /tmp/pkgs_db.r

RUN rm /var/lib/rstudio-server/rstudio.sqlite
RUN chmod -R +rwx /var/lib/rstudio-server
RUN mkdir -p /var/run/rstudio-server
RUN chmod -R +rwx /var/run/rstudio-server
RUN chmod -R +rwx /etc/rstudio

#RUN rm /tmp/*.R
# required directories
RUN mkdir -p /scratch
