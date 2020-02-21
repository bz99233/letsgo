


FROM i386/ubuntu:16.04

RUN apt-get update && apt-get install -y curl file vim git xz-utils unzip tzdata software-properties-common python3-pip \
    && ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*


RUN add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y python3.7 \
    && python3.7 -m pip install --upgrade pip \
    && ln -fs /usr/bin/python3.7 /usr/bin/python3 \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN mkdir /wksp
WORKDIR /wksp
ARG GO_VERSION="go1.13.8.linux-386"
ARG FFMPEG_VERSION="ffmpeg-4.2.1-i686-static"
RUN mkdir -p /wksp/go && curl -O -sSL https://dl.google.com/go/${GO_VERSION}.tar.gz \
    && tar -xf ${GO_VERSION}.tar.gz && rm ${GO_VERSION}.tar.gz
RUN mkdir -p /wksp/avs && cd /wksp/avs && curl -o ffm.xz -sSL https://www.johnvansickle.com/ffmpeg/old-releases/${FFMPEG_VERSION}.tar.xz \
    && tar -xf ffm.xz \
    && mkdir -p ffmpeg/linux \
    && cp ${FFMPEG_VERSION}/ffmpeg ffmpeg/linux \
    && rm -rf ffm.xz ${FFMPEG_VERSION}
    
CMD ["/bin/bash"]
