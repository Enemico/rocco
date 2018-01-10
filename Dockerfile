FROM centos:7

RUN yum -y update

RUN yum -y install yum-utils
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u
RUN python3.6 -V
RUN yum -y install python36u-pip
RUN pip3.6 install virtualenv


RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install git cmake cmake3 make gcc gcc-c++ libuv-static libstdc++-static libmicrohttpd-devel zsh
RUN cd /root && git clone https://github.com/xmrig/xmrig.git
RUN mkdir /root/xmrig/build
RUN cd /root/xmrig/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib64/libuv.a -DWITH_HTTPD=OFF
RUN cd /root/xmrig/build && make


COPY ./service service

CMD [ "python3.6 -u", "./service/rocco.py" ]
