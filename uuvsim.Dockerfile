ARG ROS_DISTRO=melodic
FROM ros:${ROS_DISTRO}

ARG DEBIAN_FRONTEND=noninteractive 

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    nvidia-driver-470 \
    ros-melodic-nav-core \
    ros-melodic-cv-bridge \
    ros-melodic-tf2-geometry-msgs \
    ros-melodic-rviz \
    && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p catkin_ws/src && \
#    git clone "https://github.com/ivanacollg/uuv_simulator.git" "catkin_ws/src/uuv_simulator" --branch feature_sim_rov

COPY package_xml_batch catkin_ws/src

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    rosdep install -iy --from-paths "catkin_ws/src/uuv_simulator" \
    && rm -rf /var/lib/apt/lists/*

COPY uuv_simulator catkin_ws/src

RUN /ros_entrypoint.sh catkin_make --directory catkin_ws

RUN sed -i "$(wc -l < /ros_entrypoint.sh)i\\source \"/catkin_ws/devel/setup.bash\"\\" /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]
