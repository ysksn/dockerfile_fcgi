FROM ubuntu:16.04
MAINTAINER Yosuke Kabuto

RUN mkdir /fcgi
RUN apt-get update
RUN apt-get -y install \
  build-essential \
  curl

WORKDIR /fcgi
RUN curl -O -k -L https://github.com/FastCGI-Archives/FastCGI.com/raw/master/original_snapshot/fcgi-2.4.1-SNAP-0910052249.tar.gz
RUN tar xvfz fcgi-2.4.1-SNAP-0910052249.tar.gz

WORKDIR /fcgi/fcgi-2.4.1-SNAP-0910052249
RUN ./configure --prefix=/usr/local
RUN mv libfcgi/fcgio.cpp /tmp/original
RUN echo "#include <stdio.h>" > libfcgi/fcgio.cpp
RUN cat /tmp/original >> libfcgi/fcgio.cpp
RUN make
RUN make install
