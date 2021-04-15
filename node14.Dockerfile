FROM httpd
WORKDIR /app

#--------------------------------------------------------------------------------------------------
# Install base package
#--------------------------------------------------------------------------------------------------

# APT update and install base package
RUN apt-get update
RUN apt-get install -y curl git openssh-client bash vim

#--------------------------------------------------------------------------------------------------
# Install Node v14 LTS
#--------------------------------------------------------------------------------------------------

# "gcc g++ make" is development tools to enable node build native addons
RUN apt-get install -y gcc g++ make
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

#--------------------------------------------------------------------------------------------------
# Skip Host verification for git
#--------------------------------------------------------------------------------------------------

ARG USER_HOME_DIR=/root
RUN mkdir ${USER_HOME_DIR}/.ssh/
RUN echo "StrictHostKeyChecking no " > ${USER_HOME_DIR}/.ssh/config

#--------------------------------------------------------------------------------------------------
# NPM setup
#--------------------------------------------------------------------------------------------------

# Allow root user to execute script command
RUN npm config set unsafe-perm true

#--------------------------------------------------------------------------------------------------
# Setup Apache config
#--------------------------------------------------------------------------------------------------

# Set Apache root directory
ARG APACHE_DOCUMENT_ROOT=/app/build
RUN sed -ri \
    -e "s!/usr/local/apache2/htdocs!$APACHE_DOCUMENT_ROOT!g" \
    -e "s!AllowOverride None!AllowOverride All!g" \
    /usr/local/apache2/conf/httpd.conf
RUN sed -i -e 's/^#\(LoadModule .*mod_rewrite.so\)/\1/' /usr/local/apache2/conf/httpd.conf

# Setup SSL
COPY ./ssl-certificate /ssl-certificate

RUN sed -ri \
    -e "s!/usr/local/apache2/htdocs!$APACHE_DOCUMENT_ROOT!g" \
    -e "s!/usr/local/apache2/conf/server.crt!/ssl-certificate/server.crt!g" \
    -e "s!/usr/local/apache2/conf/server.key!/ssl-certificate/server.key!g" \
    /usr/local/apache2/conf/extra/httpd-ssl.conf

RUN sed -i \
    -e "s/^#\(Include .*httpd-ssl.conf\)/\1/" \
    -e "s/^#\(LoadModule .*mod_ssl.so\)/\1/" \
    -e "s/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/" \
    /usr/local/apache2/conf/httpd.conf
