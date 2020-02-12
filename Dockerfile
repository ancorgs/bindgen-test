FROM registry.opensuse.org/opensuse/leap:15.1

# do not install the files marked as documentation (use "rpm --excludedocs")
RUN sed -i -e "s/^.*rpm.install.excludedocs.*/rpm.install.excludedocs = yes/" /etc/zypp/zypp.conf

RUN zypper --non-interactive in --force-resolution \
  llvm clang5 libyaml-devel gc-devel pcre-devel zlib-devel clang5-devel \
  patterns-devel-C-C++-devel_C_C++ which curl

RUN rpm --import https://dist.crystal-lang.org/rpm/RPM-GPG-KEY
RUN zypper --non-interactive ar -e -f -t rpm-md https://dist.crystal-lang.org/rpm/ Crystal
RUN zypper --non-interactive in crystal
RUN zypper rr Crystal

RUN zypper --non-interactive in git vim

RUN zypper --non-interactive in --no-recommends --force-resolution \
  autoconf \
  automake \
  boost-devel \
  brp-check-suse \
  brp-extract-appdata \
  build \
  ccache \
  doxygen \
  gcc-c++ \
  git \
  graphviz \
  libboost_test-devel \
  libjson-c-devel \
  libtool \
  libxml2-devel \
  obs-service-source_validator \
  python3-devel \
  rpm-build \
  ruby-devel \
  swig \
  && zypper clean -a \
  && rm -rf /usr/share/doc/

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
