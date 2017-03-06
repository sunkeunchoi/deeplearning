#FROM nvidia/cuda:8.0-cudnn5-devel
#FROM tensorflow/tensorflow:latest-devel-gpu-py3
FROM fluxcapacitor/gpu-tensorflow:latest

# prevent shell interactions
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# prepare for pip3
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libcurl3-dev \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        git \
        vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

# Install basic requirments
RUN pip --no-cache-dir install \
        requests \
        Pillow \
        pydash \
        scipy \
        falcon \
        gunicorn \
        matplotlib \
        scikit-learn \
        PyYAML \
        psutil \
        pandas \
        gensim \
        openpyxl \
        boto3 \
        h5py \
        keras \
        beautifulsoup4
# setup missing locale
RUN locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

ENV KERAS_BACKEND=tensorflow

ADD https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh tmp/Miniconda3-4.2.12-Linux-x86_64.sh
RUN bash tmp/Miniconda3-4.2.12-Linux-x86_64.sh -b
ENV PATH $PATH:/root/miniconda3/bin/

COPY environment-gpu.yml  ./environment.yml
RUN conda env create -f=environment.yml --name tensorflow --debug -v -v

# cleanup tarballs and downloaded package files
RUN conda clean -tp -y

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Term 1 workdir
RUN mkdir /src
WORKDIR "/src"

# Make sure CUDNN is detected
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64/:$LD_LIBRARY_PATH
RUN ln -s /usr/local/cuda/lib64/libcudnn.so.5 /usr/local/cuda/lib64/libcudnn.so

# TensorBoard
EXPOSE 6006
# Jupyter
EXPOSE 8888
# Flask Server
EXPOSE 4567

## Two Birds, One Stone
# 1. sources conda environment
# 2. prevents the zombie container issue when started as pid 1
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
