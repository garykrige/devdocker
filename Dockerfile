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
     mosh \
     cron

# Local and Whoami hack for root
RUN locale-gen en_ZA.UTF-8 \
  && mv /usr/bin/whoami /usr/bin/whoami.orig
COPY whoami.sh /usr/bin/whoami

WORKDIR "/opt/"

# Docker and Nodejs
RUN curl -sSL https://get.docker.com/ | sh \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs

# GCloud
RUN curl -sL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-133.0.0-linux-x86_64.tar.gz -o gsdk.tar.gz
RUN tar -vxf gsdk.tar.gz \
    && google-cloud-sdk/install.sh \
    && google-cloud-sdk/bin/gcloud components install kubectl \
    && rm gsdk.tar.gz

# Nuclide
RUN curl -sL https://codeload.github.com/facebook/watchman/tar.gz/v4.7.0 -o watchman.tar.gz \
    && tar -xvf watchman.tar.gz \
    && rm watchman.tar.gz \
    && cd watchman-4.7.0 \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && npm install -g nuclide

# Minikube
RUN curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.12.2/minikube-linux-amd64 \
    && chmod +x minikube && mv minikube /usr/local/bin/

# Linters
RUN easy_install pip && pip install flake8 yapf

COPY entrypoint.sh /
COPY docker /etc/default/docker

WORKDIR "/root/"
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
