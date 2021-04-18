FROM debian:buster-slim

WORKDIR /mlpractice

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      gnupg \
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

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-11 main" >> /etc/apt/sources.list

RUN wget -P /usr/share/keyrings https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp-archive-keyring.gpg && \
    wget -P /etc/apt/sources.list.d https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp.list

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      smlsharp \
      clang-11 \
      lld-11 \
      libgmp10 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
