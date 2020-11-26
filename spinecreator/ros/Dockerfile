## Download all the required source code
FROM ubuntu:bionic AS source

# Install prerequisites
RUN apt-get update && apt-get install -y \
	git \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir src \
	&& cd src \
	&& git clone https://github.com/SpineML/SpineCreator.git \
	&& git clone https://github.com/BRAHMS-SystemML/brahms.git \
	&& git clone https://github.com/SpineML/SpineML_PreFlight.git \
	&& git clone https://github.com/SpineML/SpineML_2_BRAHMS.git /SpineML_2_BRAHMS

##########
## Compile any code that requires it
FROM ubuntu:bionic AS compile

# Copy source files
COPY --from=source /src /src

# Prevents interaction with tzdata - see https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites
RUN apt-get update && apt-get install -y \
	build-essential\
	cmake \
	doxygen \
	libgraphviz-dev \
	libgvc6 \
	libpopt-dev \
	libqt5svg5-dev \
	libwxgtk3.0-dev \
	libxaw7-dev \
	libxt-dev \
	libxv-dev \
	pkg-config \
	python \
	python-dev \
	python-numpy \
	qtbase5-dev \
	qtcreator \
	xsltproc \
	zlib1g-dev \
&& rm -rf /var/lib/apt/lists/*

# Build BRAHMS
RUN mkdir src/brahms/build \
	&& cd src/brahms/build \
	&& cmake -DCOMPILE_PYTHON_BINDING=ON .. \
	&& make -j4 \
	&& make install

# Fix BRAHMS - Some additional commands needed to move component templates into place
RUN cp -r src/brahms/framework/media/ /usr/local/SystemML/BRAHMS/ \
	&& cp -r src/brahms/support/ /usr/local/SystemML/BRAHMS/ \
	&& cp /usr/local/SystemML/BRAHMS/support/template/process/test.m /usr/local/SystemML/BRAHMS/support/template/process/1262/

COPY node.xml /usr/local/SystemML/BRAHMS/support/template/process/1262
COPY release.xml /usr/local/SystemML/BRAHMS/support/template/process/1262

# Build SpineML_PreFlight
RUN mkdir src/SpineML_PreFlight/build \
	&& cd src/SpineML_PreFlight/build \
	&& cmake .. \
	&& make -j4 \
	&& make install

# Build SpineCreator
RUN qmake -qt=qt5 -makefile src/SpineCreator/spinecreator.pro \
	&& make

##########
## Copy over our compiled programs and install only the prerequisites to run them
FROM ros:melodic-ros-core AS final

# Install prerequisites
RUN apt-get update && apt-get install -y \
	libgraphviz-dev \
	libgvc6 \
	libpopt-dev \
	libqt5svg5-dev \
	libwxgtk3.0-dev \
	libxaw7-dev \
	libxt-dev \
	libxv-dev \
	pkg-config \
	python \
	python-dev \
	python-numpy \
	# Extra ROS packages needed for MiRo libraries
	ros-melodic-common-msgs \
	ros-melodic-compressed-image-transport \
	ros-melodic-image-transport \
	ros-melodic-image-view \
	ros-melodic-tf2-ros \
	qtbase5-dev \
	xsltproc \
	zlib1g-dev \
&& rm -rf /var/lib/apt/lists/*

# Define default username and IDs
ARG USER=docker
ARG USER_ID=1000
ARG GROUP=${USER}
ARG GROUP_ID=${USER_ID}

# Create non-root user
RUN groupadd -g ${GROUP_ID} ${GROUP} \
	&& useradd -lmr -u ${USER_ID} -g ${GROUP} ${USER}

# Copy program files
COPY --from=compile	/spinecreator			/bin/spinecreator
COPY --from=compile	/usr/local/SystemML		/usr/local/SystemML
COPY --from=compile	/usr/local/bin			/usr/local/bin
COPY --from=compile	/usr/local/share/man/man1	/usr/local/share/man
COPY --from=source --chown=1000	/SpineML_2_BRAHMS	/home/${USER}/SpineML_2_BRAHMS

# Change S2B ownership (again, but seems to be necessary)
RUN chown -R docker:docker /home/${USER}/SpineML_2_BRAHMS

# Create persistent volume for SpineML_2_BRAHMS
# VOLUME /home/${USER}/SpineML_2_BRAHMS

# Docker environment variables
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1

# BRAHMS environment variables
ENV BRAHMS_NS	/usr/local/SystemML/Namespace
ENV PATH 	/usr/local/SystemML/BRAHMS/bin/:$PATH

# Set default user
USER ${USER}

# Run SpineCreator
CMD spinecreator
