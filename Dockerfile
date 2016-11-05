FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
     curl \
     build-essential \
     python \
     autoconf \
     automake \
     python-setuptools \
     python-dev \
     openssh-server \
     vim \
     mosh
RUN curl -sSL https://get.docker.com/ | sh \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs
RUN curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-133.0.0-linux-x86_64.tar.gz -o gsdk.tar.gz
RUN tar -vxf gsdk.tar.gz \
    && google-cloud-sdk/install.sh \
    && /google-cloud-sdk/bin/gcloud components install kubectl
RUN curl -sL https://codeload.github.com/facebook/watchman/tar.gz/v4.7.0 -o watchman.tar.gz \
    && tar -xvf watchman.tar.gz \
    && cd watchman && git checkout v4.7.0\
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && npm install -g nuclide
RUN locale-gen en_ZA.UTF-8
RUN easy_install pip && pip install flake8 yapf
COPY entrypoint.sh /
WORKDIR "/root/"
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
