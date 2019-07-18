# SpineCreator
DockerFile for the complete [SpineCreator](http://spineml.github.io/spinecreator/) application stack. Downloads from source and builds when necessary:
1. [BRAHMS](https://github.com/BRAHMS-SystemML/brahms)
2. [SpineML to BRAHMS](https://github.com/SpineML/SpineML_2_BRAHMS)
3. [SpineML PreFlight](https://github.com/SpineML/SpineML_PreFlight)
4. [SpineCreator](https://github.com/SpineML/SpineCreator)

## Getting started
1. Download the Docker image with `docker pull tacd/spinecreator`
2. Start the Docker image with
```
docker run \
-v /tmp/.X11-unix:/tmp/.X11-unix `# Allows display of GUI` \
-v <YOUR_MODEL_DIRECTORY>:/home/docker/Models `# Allows loading of models` \
-v <YOUR_OUTPUT_DIRECTORY>:/home/docker/SpineML_2_BRAHMS/temp `# Allows access to output data from host` \
-v /home/docker/SpineML_2_BRAHMS `# Allows permanent storage of data such as compiled model components` \
--name spinecreator tacd/spinecreator
```
3. After this, you can simply run `docker restart spinecreator` to start SpineCreator

### Notes
* This assumes your local UID is 1000 (the default for a single non-root user); check by entering `id $USER` at a terminal.
