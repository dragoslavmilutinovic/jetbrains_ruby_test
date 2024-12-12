# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
# Update package list and install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl g++ gcc autoconf automake bison \
    libc6-dev libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev \
    libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
    libreadline-dev libssl-dev libsqlite3-dev sudo gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install RVM (Ruby Version Manager)
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable

# Set up RVM in the shell

# Install specific Ruby versions
# You can replace these versions with the ones you need
RUN /bin/bash -l -c "rvmsudo rvm pkg install openssl"
RUN /bin/bash -l -c "rvmsudo rvm install 2.4.8 --with-openssl-dir=/usr/local/rvm/usr/"
RUN /bin/bash -l -c "rvmsudo rvm install 2.7.1 --with-openssl-dir=/usr/local/rvm/usr/"
RUN /bin/bash -l -c "rvmsudo rvm install 2.5.7 --with-openssl-dir=/usr/local/rvm/usr/"
RUN /bin/bash -l -c "rvmsudo rvm install 2.6.10 --with-openssl-dir=/usr/local/rvm/usr/"
RUN /bin/bash -l -c  "rvmsudo rvm install 3.0.1 --with-openssl-dir=/usr/local/rvm/usr/"   



# Set the default Ruby version
RUN /bin/bash -l -c "rvm use 3.0.1 --default"

# Verify Ruby installation

# Set the working directory
COPY verify.sh /verify.sh
COPY sample_app/Gemfile /sample_app/Gemfile
COPY sample_app/app.rb /sample_app/app.rb
COPY test_script.rb /test_script.rb

RUN chmod +x /verify.sh

# Set working directory
WORKDIR /

# Default command to run verification
CMD ["/verify.sh"]

