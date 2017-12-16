FROM centos:latest

RUN yum -y update


RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install git python34 cmake cmake3 make gcc gcc-c++ libuv-static libstdc++-static libmicrohttpd-devel zsh
RUN cd /root && git clone https://github.com/xmrig/xmrig.git
RUN mkdir /root/xmrig/build
RUN cd /root/xmrig/build && cmake3 .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib64/libuv.a
RUN cd /root/xmrig/build && make


COPY ./service service

CMD ./service/rocco.py
