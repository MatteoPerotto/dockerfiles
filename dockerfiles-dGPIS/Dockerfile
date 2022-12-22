FROM nvidia/cuda:11.3.1-base-ubuntu18.04

LABEL Matteo Perotto <perotto.matteo@gmail.com>

# ======================================
# Set up some basic packages
# ======================================
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Remove any third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

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
# Set up development packages
# ======================================
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gdb \
    cmake \
    cmake-curses-gui \
    libx11-6

# ======================================
# Install packages 
# ======================================
RUN apt-get install -y \
    libgl1-mesa-glx \
    qt5-default \
&& rm -rf /var/lib/apt/lists/*

# ======================================
# Create user and switch to it 
# ======================================
RUN useradd -l -G sudo -md /home/user -s /bin/bash -p user user && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
USER user
WORKDIR /home/user

# ======================================
# Set up development miniconda
# ======================================
ENV PATH="/home/user/miniconda3/bin:${PATH}"
ARG PATH="/home/user/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda update -n base -c defaults conda

COPY env.yml .
RUN conda env update -n base -f ./env.yml \
 && conda clean -ya
RUN conda init bash 
     
# ======================================
# Clone repositories
# ======================================
WORKDIR /home/user
 
RUN git clone https://github.com/MatteoPerotto/GPIS.git
RUN git clone https://github.com/MatteoPerotto/implicit_representation_benchmark.git

RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gmcDD-5bkJfcMKLZb3zGgH_HUFbulQWu' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1gmcDD-5bkJfcMKLZb3zGgH_HUFbulQWu" -O YCB_Video_Models.zip && rm -rf /tmp/cookies.txt
RUN unzip YCB_Video_Models.zip -d ./YCB_Video_Models && rm -rf YCB_Video_Models.zip

# ======================================
# Add to bashrc 
# ======================================
RUN echo 'export PYTHONPATH="${PYTHONPATH}=/home/user/implicit_representation_benchmark"'>> ~/.bashrc 

CMD ["bash"]

# After 
# copy partial meshes and YCM_video_models


