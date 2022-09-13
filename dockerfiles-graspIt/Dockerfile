FROM ubuntu:18.04
ARG ros_distro=melodic

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Rome
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Dependencies for glvnd and X11.
RUN apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    apt-utils \
    sudo \
    nano \
    curl \
    wget \
    unzip \
    locales \
    software-properties-common \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
    glmark2  

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen &&\
    update-locale LANG="en_US.UTF-8"
    
RUN apt-get install -y libqt4-dev \
	libqt4-opengl-dev \
	libqt4-sql-psql \ 
	libcoin80-dev \
	libsoqt4-dev \
	libblas-dev \
	liblapack-dev \
	libqhull-dev \
	libeigen3-dev

RUN apt-get install -y \
    git \
    build-essential \
    gdb \
    cmake \
    cmake-curses-gui && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/
	
RUN git clone https://github.com/graspit-simulator/graspit.git

RUN cd graspit && \
	mkdir build && \ 
	cd build && \
	cmake .. && \
	make -j5 && \
	make install 
	
ENV GRASPIT=$PWD/graspit

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-catkin-tools \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && \
    rosdep update

ENV ROS_DISTRO ${ros_distro}
RUN apt-get update && apt-get install -y \
    ros-${ros_distro}-desktop-full \
    ros-${ros_distro}-urdf \
    ros-${ros_distro}-eigen-conversions \
    ros-${ros_distro}-object-recognition-msgs \
    ros-${ros_distro}-roslint \
    ros-${ros_distro}-catkin \
    ros-${ros_distro}-moveit \
    && rm -rf /var/lib/apt/lists/*  

RUN mkdir -p ./catkin_ws/src && \
	cd catkin_ws/src && \ 
	git clone https://github.com/JenniferBuehler/convenience-pkgs.git && \
	git clone https://github.com/JenniferBuehler/urdf-tools-pkgs.git && \
	git clone https://github.com/JenniferBuehler/graspit-pkgs.git && \
	cd .. && \
	source /opt/ros/${ros_distro}/setup.bash && \
	catkin_make && \
  	source /home/catkin_ws/devel/setup.bash
  	
 RUN touch /root/.bashrc && \
  echo "source /opt/ros/${ros_distro}/setup.bash" >> /root/.bashrc  && \ 
  echo "source /home/catkin_ws/devel/setup.bash" >> /root/.bashrc && \
  source /root/.bashrc 
