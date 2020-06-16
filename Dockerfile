FROM python:3.6

USER root

RUN apt-get update

RUN apt-get install -y wget git build-essential libgl1-mesa-dev libfreetype6-dev libglu1-mesa-dev libzmq3-dev libsqlite3-dev libicu-dev python3-dev libgl2ps-dev libfreeimage-dev libtbb-dev ninja-build bison autotools-dev automake libpcre3 libpcre3-dev tcl8.5 tcl8.5-dev tk8.5 tk8.5-dev libxmu-dev libxi-dev libopenblas-dev libboost-all-dev swig libxml2-dev


# cmake
WORKDIR /opt/build
RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5.tar.gz
RUN tar -zxvf cmake-3.15.5.tar.gz
WORKDIR /opt/build/cmake-3.15.5
RUN ./bootstrap && make -j3 && make install

WORKDIR /opt/build
RUN wget https://github.com/tpaviot/oce/releases/download/official-upstream-packages/opencascade-7.4.0.tgz
RUN tar -zxvf opencascade-7.4.0.tgz >> installed_occt740_files.txt
RUN mkdir opencascade-7.4.0/build
WORKDIR /opt/build/opencascade-7.4.0/build

RUN ls /usr/include
RUN cmake -G Ninja \
 -DINSTALL_DIR=/opt/build/occt740 \
 -DBUILD_RELEASE_DISABLE_EXCEPTIONS=OFF \
 ..

RUN ninja install

RUN echo "/opt/build/occt740/lib" >> /etc/ld.so.conf.d/occt.conf
RUN ldconfig

RUN ls /opt/build/occt740
RUN ls /opt/build/occt740/lib

#############
# pythonocc #
#############
WORKDIR /opt/build
RUN git clone https://github.com/tpaviot/pythonocc-core
WORKDIR /opt/build/pythonocc-core
RUN git checkout 7.4.0
WORKDIR /opt/build/pythonocc-core/build

RUN cmake -G Ninja \
 -DOCE_INCLUDE_PATH=/opt/build/occt740/include/opencascade \
 -DOCE_LIB_PATH=/opt/build/occt740/lib \
 -DPYTHONOCC_BUILD_TYPE=Release \
 ..
 
RUN ninja install

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]