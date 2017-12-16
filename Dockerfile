FROM centos:latest

RUN yum update


RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime

RUN yum -y install centos-release-scl epel-release
RUN yum update
RUN yum -y install cmake3 devtoolset-4-gcc* hwloc-devel git libmicrohttpd-devel openssl-devel make
RUN scl enable devtoolset-4 bash
RUN git clone https://github.com/fireice-uk/xmr-stak.git
RUN mkdir xmr-stak/build
RUN cd xmr-stak/build && cmake3 .. && make install


COPY ./service service

CMD ./service/start.sh
