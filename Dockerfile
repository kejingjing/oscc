FROM ubuntu:16.04

WORKDIR /app

COPY . /app

# common packages
RUN apt-get update && \
    apt-get install -y \
    ca-certificates curl file tar clang libclang-dev \
    build-essential cmake libssl-dev zlib1g-dev \
    ruby-dev libboost-dev git wget && \
    rm -rf /var/lib/apt/lists/*

# install cucumber package
RUN gem install cucumber -v 2.0.0

# install rust toolchain
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain 1.20.0 -y

RUN echo "export PATH=~/.cargo/bin:$PATH" >> ~/.bashrc
RUN echo "export PS1='\u:\w$ '" >> ~/.bashrc

# install arduino toolchain
RUN wget http://arduino.cc/download.php?f=/arduino-1.8.5-linux64.tar.xz -O arduino-1.8.5.tar.xz

RUN tar -xf arduino-1.8.5.tar.xz && \
    cd arduino-1.8.5 && \
    mkdir -p /usr/share/arduino && \
    cp -R * /usr/share/arduino
