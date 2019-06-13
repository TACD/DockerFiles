# MiRo simulator
DockerFile for the virtual MiRo environment, including the [Gazebo](http://gazebosim.org/) simulator and a barebones [ROS](http://www.ros.org/) installation. Uses [Ubuntu 16.04](http://releases.ubuntu.com/16.04/), [ROS Kinetic](http://wiki.ros.org/kinetic), and Gazebo 7 for maximum compatibility with the [MiRo MDK](http://labs.consequentialrobotics.com/miro-e/software/).

## Getting started
1. Download the Docker image with `docker pull tacd/miro_sim`
2. Run the Docker image with `docker run --net host -v $XAUTHORITY:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix --name miro_sim tacd/miro_sim`
3. After this, you can simply run `docker restart miro_sim` to load the simulator

### Notes
* Gazebo will sometimes fail with a BadDrawable error; [this is a known Gazebo bug](https://github.com/vvv-school/assignment_computed-torque/issues/3#issuecomment-364370433), just keep retrying until it works. 
* If you are using this DockerFile to build the image yourself, you will need to download and install the [MiRo MDK](http://labs.consequentialrobotics.com/miro-e/software/) to source a full copy of the `mdk` and `.miro2` folders
