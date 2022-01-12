# Pull base image
FROM centos:6

LABEL org.opencontainers.image.source https://github.com/castisdev/docker-centos6-legacy

RUN sed -i -e 's/^mirrorlist/#mirrorlist/g' -e 's/^#baseurl=http:\/\/mirror.centos.org\/centos\/$releasever\//baseurl=http:\/\/vault.centos.org\/6.10\//g' /etc/yum.repos.d/CentOS-Base.repo

# Install EPEL repo
RUN yum install -y epel-release; yum -y clean all

RUN yum -y install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm; yum -y clean all

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
  gperftools-devel \
  ccache \
  libunwind-devel \
  && yum -y clean all

# Install Intel TBB
RUN yum-config-manager -y --add-repo https://yum.repos.intel.com/tbb/setup/intel-tbb.repo \
  && yum install -y tbb-devel \
  && yum -y clean all

ADD install_xercesc280.sh /script/
RUN /script/install_xercesc280.sh

ADD install_cmake3221.sh /script/
RUN /script/install_cmake3221.sh

ADD install_cryptopp860.sh /script/
RUN /script/install_cryptopp860.sh

ADD install_googletest180.sh /script/
RUN /script/install_googletest180.sh

ADD install_openssl102u.sh /script/
RUN /script/install_openssl102u.sh

ADD install_python2718.sh /script/
RUN /script/install_python2718.sh

ADD install_python399.el6.sh /script/
RUN /script/install_python399.el6.sh

ADD install_cpptools.sh /script/
RUN /script/install_cpptools.sh

# cppcheck 빌드하려면 gcc 4.6 이상이 필요함
# ADD install_cppcheck23.sh /script/
# RUN /script/install_cppcheck23.sh

ADD install_zsh58.el6.sh /script/
RUN /script/install_zsh58.el6.sh

ADD install_ninja1102.sh /script/
RUN /script/install_ninja1102.sh

ADD install_ffmpeg441.el6.sh /script/
RUN /script/install_ffmpeg441.el6.sh

ADD install_golang1176.sh /script/
RUN /script/install_golang1176.sh

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Add root files
ADD .bashrc /root/.bashrc

# Set environment variables
ENV HOME /root
ENV PATH="${PATH}:${HOME}/go/bin:/usr/local/go/bin"

# Define default command
CMD ["zsh"]
