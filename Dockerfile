ARG NVIDIA_CUDA_TAG=latest
FROM nvidia/cuda:${NVIDIA_CUDA_TAG}

COPY sources.list /etc/apt/

# For: rm /etc/apt/sources.list.d/cuda.list && rm -rf /var/lib/apt/lists/*
# see https://github.com/NVIDIA/nvidia-docker/issues/658#issuecomment-371923355
RUN rm /etc/apt/sources.list.d/cuda.list \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get install -y zsh vim htop tree ssh sshfs iputils-ping net-tools git curl openssh-server python3 python3-pip

# X11UseLocalhost yes -> X11UseLocalhost no for X11 forwarding
# for Linux make sure $DISPLAY is set, localhost:0.0 
# for Windows/Max should start X11 server and then correct config it, e.g Putty set X11 forwarding.
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 \
    && mkdir ~/.pip/ \
    && echo "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf \
    && ssh-keygen -A \
    && mkdir -p /run/sshd \
    && echo 'root:docker' | chpasswd \
    && sed -i -r 's/.*?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i -r 's/.*?X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
