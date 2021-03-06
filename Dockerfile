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

RUN wget -P /usr/share/keyrings https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp-archive-keyring.gpg && \
    wget -P /etc/apt/sources.list.d https://github.com/smlsharp/repos/raw/main/debian/dists/buster/smlsharp.list

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      smlsharp \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
