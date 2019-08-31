FROM gusdecool/httpd

ENV PUBLIC_DIR /app/build

# APT update and install base package
RUN apt-get update
RUN apt-get install -y curl git openssh-client bash

# Install Node v10 LTS, "gcc g++ make" is development tools to enable node build native addons
RUN apt-get install -y gcc g++ make
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Skip Host verification for git
RUN mkdir /root/.ssh/
RUN echo "StrictHostKeyChecking no " > /root/.ssh/config
