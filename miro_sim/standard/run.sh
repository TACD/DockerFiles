#!/bin/bash

# Run a ROS core in the background and Gazebo in foreground
roscore \
& gazebo /root/mdk/sim/worlds/miro.world --verbose \
echo "If Gazebo has failed with a BadDrawable error, just keep retrying until it works!"
