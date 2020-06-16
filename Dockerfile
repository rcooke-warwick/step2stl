FROM python:3.6

RUN     apt-get update && \
        apt-get install -y \
            automake \
            bison \
            build-essential \
            cmake \
            libboost-dev \
            libgl1-mesa-dev \
            libglu1-mesa-dev \
            libharfbuzz-dev \
            libpcre3-dev \
            libsm6 \
            wget

WORKDIR /tmp/build

ARG SWIG_VERSION=3.0.9
ARG FREETYPE_VERSION=2.6.3
ARG OCE_VERSION=0.18.3
ARG SMESH_VERSION=6.7.6
ARG PYTHONOCC_CORE_VERSION=0.18.1

COPY build-files/build_swig.sh /tmp
COPY build-files/build_freetype.sh /tmp
COPY build-files/build_oce.sh /tmp
COPY build-files/build_smesh.sh /tmp
COPY build-files/build_pythonocc_core.sh /tmp

copy convert-stl.py /

RUN chmod +x ../*.sh
RUN chmod +x /convert-stl.py

RUN ../build_swig.sh $SWIG_VERSION
RUN ../build_freetype.sh $FREETYPE_VERSION
RUN ../build_oce.sh $OCE_VERSION
RUN ../build_smesh.sh $SMESH_VERSION
RUN ../build_pythonocc_core.sh $PYTHONOCC_CORE_VERSION



WORKDIR /

RUN     apt-get remove --auto-remove -y \
            automake \
            bison \
            build-essential \
            cmake \
            libboost-dev \
            libpcre3-dev \
            wget && \
        rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]