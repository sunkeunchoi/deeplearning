docker-machine create --driver amazonec2 \
                  --amazonec2-region us-east-1 \
                  --amazonec2-zone c \
                  --amazonec2-ami ami-f4cc1de2 \
                  --amazonec2-security-group jupyter \
                  --amazonec2-instance-type p2.xlarge \
                  --amazonec2-root-size 12 \
                  --amazonec2-volume-type gp2 \
                  gpu

sudo apt-get update && sudo apt full-upgrade -y && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# Configure nvidia-docker
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update && sudo apt-get install -y --no-install-recommends cuda-drivers

# Install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

sudo nvidia-docker pull gcr.io/tensorflow/tensorflow:latest-gpu-py3
sudo nvidia-docker run -it gcr.io/tensorflow/tensorflow:latest-gpu-py3


pip install --upgrade \
    numpy \
    matplotlib \
    jupyter \
    pillow \
    scikit-learn \
    scikit-image \
    scipy \
    h5py \
    pandas \
    tqdm \
    tensorflow-gpu \
    TFLearn \
    git+https://github.com/fchollet/keras.git \
    \