FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -qq -y build-essential flex

ADD . /morpheus
WORKDIR /morpheus

RUN cd src/ && make clean && CFLAGS='-std=gnu89 -fcommon' make && make install
