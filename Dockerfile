FROM ubuntu:22.04

# Install system packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libvpx-dev \
    libsdl2-dev \
    wget \
    git \
    g++ \
    ca-certificates \
    && apt-get clean

# Set working directory
WORKDIR /ringmaster

# Copy code into container
COPY . .

# Build Ringmaster
RUN ./autogen.sh && ./configure && make -j

# Download test video
RUN mkdir -p /data && \
    wget -O /data/ice_4cif_30fps.y4m https://media.xiph.org/video/derf/y4m/ice_4cif_30fps.y4m

# Default command opens shell for you to test manually
CMD ["/bin/bash"]

