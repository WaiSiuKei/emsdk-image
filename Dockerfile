FROM debian:buster

RUN apt-get update && apt-get install -y build-essential git python clang llvm cmake libxml2 wget python-pip python3 python3-pip zip unzip ca-certificates

RUN mkdir -p /emsdk

WORKDIR /
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR /emsdk

RUN git checkout tags/3.1.16
RUN ./emsdk install sdk-upstream-master-64bit

FROM debian:buster

RUN apt-get update && apt-get install -y python
COPY --from=0 /emsdk /emsdk
WORKDIR /emsdk
RUN ./emsdk activate sdk-upstream-master-64bit
