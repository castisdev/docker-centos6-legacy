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
  sysstat \
  yum-utils \
  gperftools-devel; \
  yum -y clean all

# Install Intel TBB
RUN yum-config-manager -y --add-repo https://yum.repos.intel.com/tbb/setup/intel-tbb.repo; \
  yum install -y tbb-devel; \
  yum -y clean all

ADD install_xercesc280.sh /script/
RUN /script/install_xercesc280.sh

ADD install_cmake3123.sh /script/
RUN /script/install_cmake3123.sh

ADD install_cryptopp700.sh /script/
RUN /script/install_cryptopp700.sh

ADD install_googletest180.sh /script/
RUN /script/install_googletest180.sh

ADD install_python2715.sh /script/
RUN /script/install_python2715.sh

ADD install_python367.sh /script/
RUN /script/install_python367.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

ADD install_zsh562.sh /script/
RUN /script/install_zsh562.sh

ADD install_ninja182.sh /script/
RUN /script/install_ninja182.sh

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root

# Define default command
CMD ["zsh"]
