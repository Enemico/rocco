FROM centos:latest

RUN yum -y update


RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install git cmake gcc gcc-c++ libuv-static libstdc++-static libmicrohttpd-devel zsh
RUN git clone https://github.com/xmrig/xmrig.git
RUN mkdir xmrig/build
RUN yum -y install cmake3 make
RUN cd xmrig/build && cmake3 .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib64/libuv.a
RUN cd xmrig/build && make


COPY ./service service

CMD ./service/start.sh
