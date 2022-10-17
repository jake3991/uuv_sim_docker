# uuv_sim_docker
docker stuff for UUV sim

This repo contains the neccasary files to build a docker image for the UUV simulator. When using this docker image please clone the following

```
git clone https://github.com/ivanacollg/uuv_simulator.git
git checkout docker_project
```

To build use the following command
```
sudo make uuvsim-melodic
```

To run use the following commands
```
xhost local:root
sudo docker run --rm -it --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY="$DISPLAY" --privileged pszenher/uuvsim:melodic bash
```
