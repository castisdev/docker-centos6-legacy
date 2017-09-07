# Pull base image
FROM centos:6

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

# Install
RUN yum install -y \
  sudo \
  wget \
  gcc \
  gcc-c++ \
  make \
  unzip \
  openssl-devel \
  git \
  subversion \
  tar \
  boost-devel \
  boost-static \
  glibc-devel \
  libuuid-devel \
  gdb \
  valgrind \
  mysql-devel \
  cppcheck \
  postgresql93-devel \
  curl-devel \
  xz \
  file \
  vim-enhanced \
  unixODBC-devel \
  mysql-connector-odbc \
  sysstat; \
  yum -y clean all

ADD install_xercesc280.sh /script/
RUN /script/install_xercesc280.sh

ADD install_cmake372.sh /script/
RUN /script/install_cmake372.sh

ADD install_cryptopp565.sh /script/
RUN /script/install_cryptopp565.sh

ADD install_googletest170.sh /script/
RUN /script/install_googletest170.sh

ADD install_python2713.sh /script/
RUN /script/install_python2713.sh

ADD install_python360.sh /script/
RUN /script/install_python360.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_zsh531.sh /script/
RUN /script/install_zsh531.sh

ADD install_ninja172.sh /script/
RUN /script/install_ninja172.sh

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root

# Define default command
CMD ["zsh"]
