FROM gusdecool/httpd

WORKDIR /app
ENV PUBLIC_DIR /app/build

#--------------------------------------------------------------------------------------------------
# Install base package
#--------------------------------------------------------------------------------------------------

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

#--------------------------------------------------------------------------------------------------
# Create & use "app" user
#
# We didn't use "root", because package manager like "npm" and "composer" will not execute
# some script like "npm run prepare" if we use "root" user.
#--------------------------------------------------------------------------------------------------

ENV USER_HOME_DIR /home/app

RUN useradd -rm -d ${USER_HOME_DIR} -s /bin/bash -g root -G sudo -u 1000 app
RUN chown app /app

# From here, we switch user to "app"
USER app

# Skip Host verification for git
RUN mkdir ${USER_HOME_DIR}/.ssh/
RUN echo "StrictHostKeyChecking no " > ${USER_HOME_DIR}/.ssh/config
