FROM plexinc/pms-docker:latest


RUN apt-get update && \ 
    apt-get -y upgrade && \
    apt-get -y install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libbz2-dev libsqlite3-dev libreadline-gplv2-dev libfuse-dev libssl-dev libxml2-dev make pkg-config locales cron awscli && \
    apt-get clean

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.utf8
ENV LC_ALL=en_US.utf8
ENV LANGUAGE=en_US.utf8

# install python3
RUN git clone git://github.com/yyuu/pyenv.git /tmp/pyenv && \
    cd /tmp/pyenv/plugins/python-build && \
    ./install.sh && \
    rm -rf /tmp/pyenv

RUN python-build 3.6.3 /usr/local/share/python-3.6.3
RUN bash -c "ln -s /usr/local/share/python-3.6.3/bin/{2to3,easy_install,idle,idle3.6,pip3,pydoc,pydoc3.6,python-config,python3-config,python3.6-config,python3.6m-config,pyvenv-3.6,2to3-3.6,easy_install-3.6,idle3,pip,pip3.6,pydoc3,python,python3,python3.6,python3.6m,pyvenv} /usr/local/bin"

RUN pip install pyfileinfo

# install s3fs
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
    cd s3fs-fuse && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf s3fs-fuse

# upgrade s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.1.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY root/ /

ENTRYPOINT ["/init"]
