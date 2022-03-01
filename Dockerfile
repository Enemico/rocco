FROM debian:bullseye-slim

RUN apt-get update

RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Oslo /etc/localtime
RUN useradd -ms /bin/bash rocco

COPY ./service /home/rocco/service
RUN chown -R rocco:rocco /home/rocco/service
RUN apt-get install -y git build-essential cmake automake libtool autoconf libhwloc-dev libuv1-dev libssl-dev

USER rocco
WORKDIR /home/rocco

RUN git clone https://github.com/xmrig/xmrig.git
RUN mkdir /home/rocco/xmrig/build
COPY ./service/donate.h /home/rocco/xmrig/src/
RUN cd /home/rocco/xmrig/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DWITH_HTTPD=OFF
RUN cd /home/rocco/xmrig/build && make


USER rocco
ENTRYPOINT ["/home/rocco/service/start.sh"]
