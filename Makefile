RELEASES := 	kinetic \
		melodic \
		noetic

package-xml-batch-dir:
	mkdir -p package_xml_batch

package-xml-batch: package-xml-batch-dir
	find ./uuv_simulator/ -type f -name package.xml -exec cp --parents "{}" package_xml_batch/ \;

uuvsim-%: uuvsim.Dockerfile package-xml-batch
	docker build -t "pszenher/uuvsim:$*" -f "$<" .

test-uuvsim-%: uuvsim-%
	docker run --rm -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=":0" "pszenher/uuvsim:$*" \
		roslaunch uuv_bruce_teleop bruce_autonomous.launch

all: $(addprefix uuvsim-,$(RELEASES))
