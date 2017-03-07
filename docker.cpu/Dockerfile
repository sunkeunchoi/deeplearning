#FROM nvidia/cuda:8.0-cudnn5-devel
#FROM nvidia/cuda:8.0-cudnn5-runtime
#FROM tensorflow/tensorflow:latest-devel-gpu-py3
#FROM tensorflow/tensorflow:latest-gpu-py3
FROM tensorflow/tensorflow:latest-cpu-py3

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
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
#RUN ln -s /usr/bin/python3 /usr/bin/python

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Configure the build for our CUDA configuration.
#ENV CI_BUILD_PYTHON python
#ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
#ENV TF_NEED_CUDA 1
# Make sure CUDNN is detected
#ENV LD_LIBRARY_PATH /usr/local/cuda/lib64/:$LD_LIBRARY_PATH
#RUN ln -s /usr/local/cuda/lib64/libcudnn.so.5 /usr/local/cuda/lib64/libcudnn.so

RUN pip --no-cache-dir install --upgrade \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        pillow \
        scikit-learn \
        scikit-image \
        h5py \
        pandas \
        tqdm \
        tensorflow-gpu \
        TFLearn \
        git+https://github.com/fchollet/keras.git \
        && \
        python -m ipykernel.kernelspec

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Term 1 workdir
RUN mkdir /src
WORKDIR "/src"

# TensorBoard
EXPOSE 6006
# Jupyter
EXPOSE 8888

COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]