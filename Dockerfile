FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -qq -y build-essential flex

ADD . /morpheus
WORKDIR /morpheus

RUN cd src/ && make clean && CFLAGS='-std=gnu89' make && make install

RUN cd stemlib/Latin && make clean && PATH=$PATH:../../bin MORPHLIB=.. make && PATH=$PATH:../../bin MORPHLIB=.. make
RUN cd stemlib/Greek && make clean && PATH=$PATH:../../bin MORPHLIB=.. make && PATH=$PATH:../../bin MORPHLIB=.. make
