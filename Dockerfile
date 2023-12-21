FROM ubuntu:22.04

# Dependencies
RUN apt-get update
RUN apt-get install -y file wget cpio rsync build-essential git subversion cvs unzip whois ncurses-dev bc mercurial pmount gcc-multilib g++-multilib libgmp3-dev libmpc-dev liblz4-tool

# User & Workdir
ARG USER=metrological
RUN adduser --disabled-password $USER
WORKDIR $USER

# Copy Resources
COPY arch arch
COPY board board
COPY boot boot
COPY configs configs
COPY fs fs
COPY linux linux
COPY package package
COPY system system
COPY toolchain toolchain
COPY utils utils
COPY Makefile .
COPY Makefile.legacy .

# Run Build
#WORKDIR $USER/buildroot/
#RUN echo WPEFRAMEWORK_OVERRIDE_SRCDIR=../thunder > local.mk
#RUN echo WPEFRAMEWORK_CLIENTLIBRARIES_OVERRIDE_SRCDIR=../thunder-client-libraries >> local.mk
#RUN echo WPEFRAMEWORK_INTERFACES_OVERRIDE_SRCDIR=../thunder-interfaces >> local.mk
#RUN echo WPEFRAMEWORK_PLUGINS_OVERRIDE_SRCDIR=../thunder-plugins >> local.mk
#RUN echo WPEFRAMEWORK_RDKSERVICES_OVERRIDE_SRCDIR=../thunder-rdk-services >> local.mk
#RUN echo WPEFRAMEWORK_TOOLS_OVERRIDE_SRCDIR=../thunder-tools >> local.mk

ENV FORCE_UNSAFE_CONFIGURE=1
RUN ls
RUN pwd
RUN make raspberrypi3_wpe_defconfig 
RUN make
