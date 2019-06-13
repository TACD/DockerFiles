# SpineCreator
A DockerFile for the complete [SpineCreator](http://spineml.github.io/spinecreator/) neural modelling application. Downloads from source and builds when necessary:
1. [BRAHMS](https://github.com/BRAHMS-SystemML/brahms)
2. [SpineML to BRAHMS](https://github.com/SpineML/SpineML_2_BRAHMS)
3. [SpineML PreFlight](https://github.com/SpineML/SpineML_PreFlight)
4. [SpineCreator](https://github.com/SpineML/SpineCreator)

## Getting started
1. Download the Docker image with `docker pull tacd/spinecreator`
2. Start the Docker image with `docker run -v $XAUTHORITY:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix -v <YOUR_MODEL_DIRECTORY>:/root/Models -v <YOUR_OUTPUT_DIRECTORY>:/root/SpineML_2_BRAHMS/temp --name spinecreator tacd/spinecreator`
3. After this, you can simply run `docker restart spinecreator` to start SpineCreator
