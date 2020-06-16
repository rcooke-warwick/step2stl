FROM python:2.7


RUN apt-get update && \
    apt-get install -y cmake freeglut3-dev && \
    rm -rf /var/lib/apt/lists/*

# Compile OCE Library
RUN set -ex && \
    git clone git://github.com/tpaviot/oce.git && \
    mkdir oce/build && \
    cd oce/build && \
    cmake .. && \
    make -j2 && \
    make install/strip && \
    cd ../.. \
    && rm -rf oce

RUN apt-get update && \
    apt-get install -y swig3.0 libpython2.7-dev && \
    rm -rf /var/lib/apt/lists/*

# Compile PythonOCC Package
RUN set -ex && \
    git clone git://github.com/tpaviot/pythonocc-core.git && \
    mkdir pythonocc-core/build && \
    cd pythonocc-core/build && \
    cmake .. \
        -DSWIG_EXECUTABLE=/usr/bin/swig3.0 \
        -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
        -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0 && \
        -OpenCASCADE_DIR=/opt/build/occt740/include/opencascade \
    make -j2 && \
    make install && \
    cd ../.. && \
    rm -rf pythonocc-core

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]