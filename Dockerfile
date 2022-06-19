FROM continuumio/miniconda3:latest
ARG DIR_WORK=/work
WORKDIR ${DIR_WORK}
RUN apt-get update && apt-get install -y libgomp1
ARG BASE_ENV_YML=base_env.yml
COPY ${BASE_ENV_YML} ${DIR_WORK}/
RUN conda update -y conda && \
    conda env create --file ${BASE_ENV_YML}
ARG DIR_CONDA=/opt/conda
ARG VENV=bioinfo
ENV PATH ${DIR_CONDA}/envs/${VENV}/bin:$PATH
ARG REQ_TXT=requirements.txt
COPY ${REQ_TXT} ${DIR_WORK}/
SHELL ["conda", "run", "--name", "bioinfo", "/bin/bash", "-c"]
RUN pip install --upgrade pip && \
    pip install -r ${REQ_TXT}
