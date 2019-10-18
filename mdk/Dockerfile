# The MDK uses ROS Kinetic as standard
FROM ros:kinetic-perception


# Install testing tools
RUN apt-get update && apt-get install -y \
	iputils-ping \
&& rm -rf /var/lib/apt/lists/*


## Set environment variables
# Docker
#ENV DISPLAY :0
#ENV QT_X11_NO_MITSHM 1
#ENV XAUTHORITY /root/.Xauthority

# ROS
ENV CATKIN_SHELL bash
	# ENV ROS_DISTRO 	kinetic
	# ENV ROS_ETC_DIR 	/opt/ros/$ROS_DISTRO/etc/ros
	# ENV ROS_IP 172.17.0.1
	# ENV ROS_MASTER_IP localhost
ENV ROS_IP				localhost
ENV ROS_MASTER_URI 		http://localhost:11311
ENV ROS_PACKAGE_PATH 	/root/mdk/catkin_ws/install/share:/opt/ros/$ROS_DISTRO/share
# ENV ROS_ROOT /opt/ros/$ROS_DISTRO/share/ros

# MiRo
ENV MIRO_DIR_MDK 		/root/mdk
ENV MIRO_DIR_TMP 		/tmp/miro2
ENV MIRO_DIR_USER 		/root/.miro2

ENV MIRO_BRIDGE_FLAGS 	l
ENV MIRO_DIR_BIN 		$MIRO_DIR_MDK/bin/deb64
ENV MIRO_DIR_CONFIG 	$MIRO_DIR_USER/config
	#ENV MIRO_DIR_DUMP /root/tmp/miro2/dump
ENV MIRO_DIR_DUMP 		$MIRO_DIR_TMP/dump
ENV MIRO_DIR_LOG 		$MIRO_DIR_TMP/log

ENV MIRO_DIR_ONBOARD 	$MIRO_DIR_MDK/bin/onboard
ENV MIRO_DIR_SHARE 		$MIRO_DIR_MDK/share
	#ENV MIRO_DIR_STATE /root/tmp/miro2/state
ENV MIRO_DIR_STATE 		$MIRO_DIR_TMP/state
	#ENV MIRO_DIR_TMP /root/tmp/miro2

ENV MIRO_DIR_TRASH 		$MIRO_DIR_USER/trash

ENV MIRO_DYNAMIC_IP_MATCH ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$
ENV MIRO_DYNAMIC_IP_WAIT 60
ENV MIRO_EDITION 		2
ENV MIRO_MDK_RELEASE 	R190518
ENV MIRO_MULTITOOL 		$MIRO_DIR_MDK/bin/onboard/multitool.sh
ENV MIRO_NETWORK_MODE 	static
ENV MIRO_ROBOT_NAME 	miro
ENV MIRO_ROS_RELEASE 	$ROS_DISTRO
ENV MIRO_SPEAK_IP 		1
ENV MIRO_STATIC_IP 		localhost
ENV MIRO_SYSTEM 		deb64
ENV MIRO_TOKEN 			miro2
ENV MIRO_USER_SETUP 	$MIRO_DIR_CONFIG/user_setup.bash

# System
	# ENV CMAKE_PREFIX_PATH /root/mdk/catkin_ws/install:/opt/ros/$ROS_DISTRO
	# ENV PATH /opt/ros/$ROS_DISTRO/bin:/root/bin:/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV LD_LIBRARY_PATH 	/root/mdk/catkin_ws/install/lib:/opt/ros/$ROS_DISTRO/lib:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu
ENV PKG_CONFIG_PATH 	/root/mdk/catkin_ws/install/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/pkgconfig:/opt/ros/$ROS_DISTRO/lib/x86_64-linux-gnu/pkgconfig
ENV PYTHONPATH 			/root/mdk/share/python:/root/mdk/catkin_ws/install/lib/python2.7/dist-packages:/opt/ros/$ROS_DISTRO/lib/python2.7/dist-packages


# Add MiRo MDK and config files
# MDK available from http://labs.consequentialrobotics.com/miro-e/software/
# .miro2 directory generated from a successful MDK install
COPY mdk /root/mdk/
COPY miro2 /root/.miro2

# Execute command
# COPY run.sh /usr/local/bin/run.sh
# RUN chmod +x /usr/local/bin/run.sh
# CMD /usr/local/bin/run.sh
# RUN mkdir -p /root/tmp/miro2/state
CMD roscore
