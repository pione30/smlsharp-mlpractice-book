FROM debian:buster-slim

WORKDIR /mlpractice

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/massivethreads/massivethreads/archive/refs/tags/v1.00.tar.gz && \
    tar -zxf v1.00.tar.gz && \
    cd massivethreads-1.00 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd ../ && \
    rm -rf v1.00.tar.gz massivethreads-1.00

RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11 && \
    rm ./llvm.sh

RUN wget -P /usr/share/keyrings https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp-archive-keyring.gpg
RUN wget -P /etc/apt/sources.list.d https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp.list

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      smlsharp \
      libgmp10 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
