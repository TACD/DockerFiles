# This builds an MDK image for the VIRTUAL MiRo robot

# The MiRo simulator uses Gazebo 7, which requires ROS Kinetic and thus Ubuntu 16 (Xenial)
FROM gazebo:libgazebo7-xenial

##########
# Setup ROS keys and sources
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
&& echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list

# TODO: Include (and test) python-gi for running client_gui

# Install ROS packages
RUN apt-get update && apt-get install -y \
	ros-kinetic-perception \
	python-pip \
&& rm -rf /var/lib/apt/lists/*

# Bootstrap rosdep
RUN rosdep init \
&& rosdep update
	
# Update module installation framework
RUN pip install --upgrade \
 	pip \
&& pip install --upgrade \
	setuptools \
	wheel \ 	
# Install modules needed for various projects
&& pip install --upgrade --ignore-installed \
	# MiRo MDK
	apriltag==0.0.16 \
	# Dashboard
	dash==1.16.2 \
	dash-bootstrap-components==0.10.6 \
	dash-daq==0.5.0 \
	opencv-python-headless==4.2.0.32 \
	Pillow==6.2.2 \
	PyYAML==5.3.1 \
	# Hypothalamus model
	scipy==1.2.3

##########
# Docker environment variables
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
ENV XAUTHORITY /root/.Xauthority

# ROS environment variables
ENV CATKIN_SHELL bash
ENV ROS_DISTRO kinetic
ENV ROS_ETC_DIR /opt/ros/$ROS_DISTRO/etc/ros
ENV ROS_IP 172.17.0.1
ENV ROS_MASTER_URI http://localhost:11311
ENV ROS_PACKAGE_PATH /root/mdk/catkin_ws/install/share:/opt/ros/$ROS_DISTRO/share
ENV ROS_ROOT /opt/ros/$ROS_DISTRO/share/ros

# Gazebo environment variables
ENV GAZEBO_MODEL_PATH /root/mdk/sim/models
ENV GAZEBO_PLUGIN_PATH /root/mdk/bin/deb64
ENV GAZEBO_RESOURCE_PATH /root/mdk/sim

# MiRo environment variables
ENV MIRO_BRIDGE_FLAGS l
ENV MIRO_DIR_BIN /root/mdk/bin/deb64
ENV MIRO_DIR_CONFIG /root/.miro2/config
ENV MIRO_DIR_DUMP /tmp/miro2/dump
ENV MIRO_DIR_LOG /tmp/miro2/log
ENV MIRO_DIR_MDK /root/mdk
ENV MIRO_DIR_ONBOARD /root/mdk/bin/onboard
ENV MIRO_DIR_SHARE /root/mdk/share
ENV MIRO_DIR_STATE /tmp/miro2/state
ENV MIRO_DIR_TMP /tmp/miro2
ENV MIRO_DIR_TRASH /root/.miro2/trash
ENV MIRO_DIR_USER /root/.miro2
ENV MIRO_EDITION 2
ENV MIRO_MDK_RELEASE R200720
ENV MIRO_MULTITOOL /root/mdk/bin/onboard/multitool.sh
ENV MIRO_ROBOT_NAME miro
ENV MIRO_ROS_RELEASE $ROS_DISTRO
ENV MIRO_SYSTEM deb64
ENV MIRO_TOKEN miro2
ENV MIRO_USER_SETUP /root/.miro2/config/user_setup.bash

# System environment variables
ENV CMAKE_PREFIX_PATH /root/mdk/catkin_ws/install:/opt/ros/$ROS_DISTRO
ENV LD_LIBRARY_PATH /root/mdk/catkin_ws/install/lib:/opt/ros/$ROS_DISTRO/lib:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu/gazebo-7/plugins
ENV PATH /opt/ros/$ROS_DISTRO/bin:/root/bin:/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH /root/mdk/catkin_ws/install/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu/pkgconfig
ENV PYTHONPATH /root/mdk/share/python:/root/mdk/catkin_ws/install/lib/python2.7/dist-packages:/opt/ros/$ROS_DISTRO/lib/python2.7/dist-packages

# Add MiRo MDK and config files
# MDK available from http://labs.consequentialrobotics.com/miro-e/software/
# .miro2 directory generated from a successful MDK install
COPY mdk-200720 /root/mdk/
COPY miro2 /root/.miro2

# Execute command
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
CMD /usr/local/bin/run.sh
