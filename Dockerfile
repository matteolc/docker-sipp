FROM debian:jessie

LABEL \
	io.voxbox.build-date=${BUILD_DATE} \
	io.voxbox.name=docker-sipp \
	io.voxbox.vendor=voxbox.io \
    maintainer=matteo@voxbox.io \
	io.voxbox.vcs-url=https://github.com/matteolc/docker-sipp.git \
	io.voxbox.vcs-ref=${VCS_REF} \
	io.voxbox.license=MIT
	
ENV SIPP_VERSION 3.5.1

WORKDIR /src

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl automake ncurses-dev libssl-dev libsctp-dev libpcap-dev && \
    curl -sqLkv https://github.com/SIPp/sipp/releases/download/v${SIPP_VERSION}/sipp-${SIPP_VERSION}.tar.gz | tar xvzf - --strip-components=1 && \
    ./build.sh --with-openssl --with-pcap --with-rtpstream --with-sctp && \
    mv sipp /usr/bin && \
    apt-get remove build-essential automake -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "sipp" ]