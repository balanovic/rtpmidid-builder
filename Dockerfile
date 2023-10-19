# Use an ARM64 compatible Debian base image
FROM arm64v8/debian:bookworm-20211011-slim

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=non-interactive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    pkg-config \ 
    cmake \
    libasound2-dev \
    libavahi-client-dev \
    libfmt-dev \
    libspdlog-dev \
    devscripts \
    debhelper \
    pandoc \
    fakeroot

# Clone the rtpmidid repository
RUN git clone https://github.com/davidmoreno/rtpmidid.git

# Build rtpmidid and the deb package
WORKDIR /rtpmidid

# Comment out CPU scheduling lines in rtpmidid.service
RUN sed -i 's/CPUSchedulingPolicy=fifo/#CPUSchedulingPolicy=fifo/' debian/rtpmidid.service && \
    sed -i 's/CPUSchedulingPriority=10/#CPUSchedulingPriority=10/' debian/rtpmidid.service

RUN mkdir build && cd build && cmake .. && make 
RUN make deb

# Copy the built deb package to /output so it can be retrieved later
RUN mkdir /output
RUN cp ../*.deb /output/
RUN tar -cvf /output/deb_files.tar /output/*.deb


