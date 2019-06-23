FROM debian:stretch-slim

# File Author / Maintainer
MAINTAINER paperbenni

RUN \
# MAN folder needed for jre install
     mkdir -p /usr/share/man/man1 \
  && mkdir -p /sheep/cache \
# Install JRE and curl
  && apt-get update \
  && apt-get install -y --no-install-recommends \
	openjdk-8-jre-headless \
	curl \
	#Blender dependencies
	libsdl1.2debian \
	libxxf86vm1 \
	libgl1-mesa-glx \
	libglu1-mesa \
	libxi6 \
 	libxrender1 \
	libxfixes3 \
  subversion \
  busybox-static

ADD startrenderer.sh /sheep/startrenderer.sh
RUN chmod +x /sheep/startrenderer.sh

WORKDIR /sheep

CMD ./startrenderer.sh
