FROM debian:jessie

RUN DEBAIN_FRONTEND=noninteractive \
    apt-get update && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    apt-get install -qqy \
        apt-transport-https \
        netcat-openbsd \
        curl \
        jq \
        lsof \
        net-tools \
        udhcpc \
        isc-dhcp-client \
        dhcpcd5 \
        arping \
        ndisc6 \
        fping \
        sipcalc \
        bc \
        openvswitch-common \
        openvswitch-switch && \
    curl -sSL https://get.docker.com/ | sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD pipework /usr/sbin/pipework
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]

