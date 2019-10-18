# DockerFile for MiRo dashboard
FROM ros:melodic-perception

##########
# Install ROS packages
RUN apt-get update && apt-get install -y \
	python-pip \
	git \
	nano \
	net-tools \
	wget \
	wmctrl \
&& rm -rf /var/lib/apt/lists/*

# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

# Install Dashboard components
RUN pip install \
	dash \
	dash-daq \
	dash-bootstrap-components \
	opencv-python-headless \
	Pillow \
	plotly \
	numpy

##########
# Docker environment variables
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
ENV XAUTHORITY /root/.Xauthority

# ROS environment variables
ENV CATKIN_SHELL bash
ENV ROS_DISTRO melodic
ENV ROS_ETC_DIR /opt/ros/$ROS_DISTRO/etc/ros
ENV ROS_IP 192.168.1.196
ENV ROS_MASTER_URI http://192.168.1.116:11311
ENV ROS_PACKAGE_PATH /root/mdk/catkin_ws/install/share:/opt/ros/$ROS_DISTRO/share
ENV ROS_ROOT /opt/ros/$ROS_DISTRO/share/ros

# MiRo environment variables
ENV MIRO_DIR_CONFIG /root/.miro2/config

# System environment variables
ENV CMAKE_PREFIX_PATH /root/mdk/catkin_ws/install:/opt/ros/$ROS_DISTRO
ENV LD_LIBRARY_PATH /root/mdk/catkin_ws/install/lib:/opt/ros/$ROS_DISTRO/lib:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu
ENV PATH /opt/ros/$ROS_DISTRO/bin:/root/bin:/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH /root/mdk/catkin_ws/install/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu/pkgconfig
# Why does the catkin_ws path need to be here twice? How is one instance of it getting removed? WTF?
ENV PYTHONPATH $PYTHONPATH:/root/mdk/share/python:/root/mdk/catkin_ws/install/lib/python2.7/dist-packages:/root/mdk/catkin_ws/install/lib/python2.7/dist-packages


## These variables are set by the MDK but are not needed unless running client_demo from within Docker
#ENV MIRO_BRIDGE_FLAGS l
ENV MIRO_DIR_BIN /root/mdk/bin/deb64
#ENV MIRO_DIR_DUMP /tmp/miro2/dump
#ENV MIRO_DIR_LOG /tmp/miro2/log
#ENV MIRO_DIR_MDK /root/mdk
#ENV MIRO_DIR_ONBOARD /root/mdk/bin/onboard
#ENV MIRO_DIR_SHARE /root/mdk/share
ENV MIRO_DIR_STATE /tmp/miro2/state
#ENV MIRO_DIR_TMP /tmp/miro2
#ENV MIRO_DIR_TRASH /root/.miro2/trash
#ENV MIRO_DIR_USER /root/.miro2
#ENV MIRO_EDITION 2
#ENV MIRO_MDK_RELEASE R190828
#ENV MIRO_MULTITOOL /root/mdk/bin/onboard/multitool.sh
ENV MIRO_ROBOT_NAME miro
#ENV MIRO_ROS_RELEASE $ROS_DISTRO
#ENV MIRO_SYSTEM deb64
#ENV MIRO_TOKEN miro2
#ENV MIRO_USER_SETUP /root/.miro2/config/user_setup.bash


# Add MiRo MDK and config files
# MDK available from http://labs.consequentialrobotics.com/miro-e/software/
# .miro2 directory generated from a successful MDK install
COPY mdk /root/mdk/
COPY miro2 /root/.miro2

# Clone Dashboard from web
RUN git clone https://github.com/TACD/dashboard.git /root/mdk/share/python/miro2/dashboard

EXPOSE 8050

# Execute command
# CMD python /root/mdk/share/python/miro2/dashboard/app.py
CMD /bin/bash