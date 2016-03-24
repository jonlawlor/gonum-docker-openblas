# Adapted in part from ogrisel/openblas
FROM ubuntu:latest
MAINTAINER Jonathan J Lawlor <jonathan.lawlor@gmail.com>

ADD install_openblas.sh install_openblas.sh
RUN bash install_openblas.sh
