# syntax=docker/dockerfile:1
FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chencichen"

# Download all dependencies
RUN apt-get update \ 
	&& DEBIAN_FRONTEND="noninteractive" \ 
	apt-get install -y \
	wget \
	git \
	libxml2 \
        libgl1 \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
        ninja-build \
        sudo \
        && rm -rf /var/lib/apt/lists/* \
	&& apt-get clean

# add install bash script
COPY custom-cont-init.d /custom-cont-init.d/

# make executable and run bash scripts to install app
RUN chmod +x /custom-cont-init.d/init-d.sh
    
# global environment settings
ENV XDG_CONFIG_HOME=/config
ENV HOME=/config
RUN chown -R abc:abc /config
  
# Download latest of miniconda3
RUN cd /tmp \
	&& wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
	&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda \
	&& rm -f Miniconda3-latest-Linux-x86_64.sh \
 	&& chown -R abc:abc /root

# Make non-activate conda commands available.
ENV PATH=/root/miniconda/bin:$PATH

# Make conda activate command available from /bin/bash --login shells.
RUN echo "source /root/miniconda/etc/profile.d/conda.sh" >> ~/.profile    

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ports and volumes
EXPOSE 7860/tcp
VOLUME /config
