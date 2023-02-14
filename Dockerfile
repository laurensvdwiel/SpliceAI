# Use an existing image as the base image
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y tzdata
RUN echo "America/Los_Angeles" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Install SpliceAI dependencies
RUN apt-get install -y libbz2-dev liblzma-dev
RUN apt-get install -y \
    python3 \
    python3-pip \
    tabix \
    bcftools \
    samtools

# Install SpliceAI and TensorFlow
RUN pip3 install tensorflow
RUN pip3 install spliceai

# Set the working directory
WORKDIR /data

# Run SpliceAI when the container is started
CMD ["spliceai"]
