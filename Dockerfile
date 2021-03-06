# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER
# Maintainer of the base container: LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER $NB_UID
COPY requirements.txt /tmp/
RUN pip install --default-timeout=15000 --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY detector_de_cola.py .
COPY detector_de_cola.ipynb .

# cache transformer model in the docker image
RUN python -c "import detector_de_cola; d=detector_de_cola.DetectorDeCola()"
