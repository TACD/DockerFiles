#!/bin/bash

# Run ROS Core in the background and Gazebo in foreground
roscore \
& gazebo /root/mdk/sim/worlds/miro.world --verbose \
#& /root/mdk/share/python/miro2/core/client_demo.py - caml \
#& /root/mdk/share/python/miro2/core/client_demo.py - camr \
#/root/mdk/share/python/miro2/core/client_demo.py
echo "Gazebo will sometimes fail with a BadDrawable error; just keep retrying until it works!"
