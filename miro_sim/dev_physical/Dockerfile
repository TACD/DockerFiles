# This builds an MDK image for the PHYSICAL MiRo robot

# The MiRo code requires ROS Kinetic and thus Ubuntu 16 (Xenial)
FROM ros:kinetic-perception-xenial

# Install Pip
RUN apt-get update && apt-get install -y \
	python-pip \
&& rm -rf /var/lib/apt/lists/*

# Update python module installation framework
RUN pip install --upgrade \
 	pip \
&& pip install --upgrade \
	setuptools \
	wheel \ 	
# Install python modules needed for various projects
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

# Add MiRo MDK and config files
# MDK available from http://labs.consequentialrobotics.com/miro-e/software/
# .miro2 directory generated from a successful MDK install
COPY mdk-200720 /root/mdk/
COPY miro2 /root/.miro2