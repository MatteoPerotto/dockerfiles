FROM ubuntu:18.04

MAINTAINER Matteo Perotto <perotto.matteo@gmail.com>

# ======================================
# Set up some basic packages
# ======================================

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    apt-utils \
    sudo \
    nano \
    curl \
    wget \
    unzip \
    locales \
    software-properties-common 

# ======================================
# Set up locales
# ======================================

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen &&\
    update-locale LANG="en_US.UTF-8"


# ======================================
# Create user and switch to it 
# ======================================
#RUN useradd -l -G sudo -md /home/user -s /bin/bash -p user user && \
#    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
#USER user


# ======================================
# Set up development packages
# ======================================

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gdb \
    cmake \
    cmake-curses-gui 

# ======================================
# Set up development miniconda
# ======================================

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda update -n base -c defaults conda

COPY env.yml .
RUN conda env create -f ./env.yml 

#RUN apt-get install -y \
#    qt5-default
     
# ======================================
# Create conda environment 
# ======================================
#WORKDIR /home/user 

RUN git clone https://github.com/MatteoPerotto/GPIS.git

ADD ./entrypoint.sh /home/user
ENTRYPOINT ["./entrypoint.sh"]
CMD ["bash"]


