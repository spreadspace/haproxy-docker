FROM debian:stretch-backports
MAINTAINER Christian Pointner <equinox@spreadspace.org>

RUN set -x \
    && echo 'APT::Install-Recommends "false";' >  /etc/apt/apt.conf.d/02no-recommends \
    && echo 'APT::Install-Suggests "false";' >> /etc/apt/apt.conf.d/02no-recommends \
    && apt-get update -q \
    && apt-get install -y -q -t stretch-backports haproxy hatop \
    && apt-get upgrade -y -q \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --home /srv --no-create-home --system --uid 998 --group app

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-muslc-amd64 /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

USER app
