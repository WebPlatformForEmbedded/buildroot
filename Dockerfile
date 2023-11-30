FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y file wget cpio rsync build-essential git subversion cvs unzip whois ncurses-dev bc mercurial pmount gcc-multilib g++-multilib libgmp3-dev libmpc-dev liblz4-tool
ARG USER=divya

RUN adduser $USER
RUN git clone https://github.com/WebPlatformForEmbedded/buildroot.git
RUN cd buildroot
RUN cp -rf buildroot/ /home/divya/
WORKDIR /home/divya/buildroot
ENV FORCE_UNSAFE_CONFIGURE=1
RUN make raspberrypi3_wpe_defconfig 
RUN make
