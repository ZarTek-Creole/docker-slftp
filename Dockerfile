FROM debian:sid-slim AS creole_slftp_builder

# TODO:
# - use multi stage builds -> https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds (THANK to harrox)
# - Clean list of packages
#
# COMMANDS :
# - slftp_run    -> Start an screen session with slftp (auto on startup)
# - slftp_screen -> Join the screen (docker exec -it <slftp> -it slftp_screen)
# CTRL+a d       -> leave screen

LABEL maintainer="MalaGaM <MalaGaM.ARTiSPRETiS@GMail.com>" \
    org.opencontainers.image.title="SLFTP" \
    org.opencontainers.image.description="SLFTP on debian" \
    org.opencontainers.image.authors="MalaGaM <MalaGaM.ARTiSPRETiS@GMail.com>" \
    org.opencontainers.image.vendor="Creole Family" \
    org.opencontainers.image.documentation="https://github.com/MalaGaM/docker-slftp" \
    org.opencontainers.image.licenses="Apache License 2.0" \
    org.opencontainers.image.version="0.0.1" \
    org.opencontainers.image.url="https://github.com/MalaGaM/docker-slftp" \
    org.opencontainers.image.source="https://github.com/MalaGaM/docker-slftp.git" 

ARG FPC_VERSION="3.2.0" \
    FPC_ARCH="x86_64-linux" \
    SLFTP_VERSION \
    UID=1000 \
    GID=1000

ENV SLFTP_LIB_LIST=libssl.so\ libsqlite3.so\ libcrypto.so \
    SLFTP_VERSION=$SLFTP_VERSION \
    UID=$UID \
    GID=$GID \
    USER_NAME="slftp" \
    USER_GROUP="slftp" \
    DATADIR="/slftp-data" \
    SOURCEDIR="/slftp-src"
# Create user and group
RUN groupadd -g ${GID} ${USER_GROUP} \
    && useradd -u ${UID} -g ${USER_GROUP} -s /bin/sh ${USER_NAME} \
    # Config apt option value
    && echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/01buildconfig \
    && echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf.d/01buildconfig \
    && echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01buildconfig \
    && echo 'Dpkg::Use-Pty"0";' >> /etc/apt/apt.conf.d/01buildconfig \
    # config dpkg value for save disk space and/or network bandwidth
    && echo 'path-exclude /usr/share/doc/*' >/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/man/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/groff/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/info/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/lintian/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/linda/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-exclude /usr/share/locale/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-include /usr/share/locale/en*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    && echo 'path-include /usr/share/man/man1/*' >>/etc/dpkg/dpkg.cfg.d/docker-minimal \
    # Update package list
    && apt-get update -q \
    # Install packages list
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y  \
      # lib for ssl use
    libsqlite3-dev \
    libssl-dev \
      # Core packages
    screen \
    git \
    wget \
    ca-certificates \
       # Build packages
    make \
    perl \
    gcc \
    cmake-data \
    g++-10 \
    procps \
       # Librairies packages
    zlib1g-dev \
    libc6-dev \
    libncurses-dev \
    libarchive13 \
    libcurl4 \
    libdpkg-perl \
    libfakeroot \
    libicu67 \
    libjsoncpp24 \
    libprocps8 \
    librhash0 \
    libstdc++-10-dev \
    libuv1 \
    libxml2 \
      # free pascal compiler install
    fp-compiler-${FPC_VERSION} \
    fp-units-base-${FPC_VERSION} \
    fp-units-fcl-${FPC_VERSION} \
    fp-units-misc-${FPC_VERSION} \
    # Cleaning :
    && apt-get -q clean
# Get and install slftp
RUN mkdir $SOURCEDIR \
    && cd $SOURCEDIR \
    # git: turn the detached message off \
    && git config --global advice.detachedHead false \
    && git clone --branch ${SLFTP_VERSION} https://gitlab.com/slftp/slftp.git $SOURCEDIR \
    && sed -i -e 's@~/slftp@${DATADIR}@' $SOURCEDIR/Makefile \
    && mkdir ${DATADIR} \
    && echo "RUN make all_64 : Please wait..." \
    && make all_64 >/dev/null
# Copy needed stuff
COPY app/entrypoint.sh /
COPY app/startup-sequence /startup-sequence/
COPY app/slftp* /bin/
WORKDIR ${DATADIR}
# Fix files right
RUN chmod 0777 /entrypoint.sh /startup-sequence/* /bin/slftp*

ENTRYPOINT ["/entrypoint.sh"]
