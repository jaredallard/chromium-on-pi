FROM resin/rpi-raspbian:jessie

# hadolint ignore=DL4000
MAINTAINER Jared Allard <jaredallard@outlook.com>

# hadolint ignore=DL3015,DL3008
RUN apt-get update \
&&  apt-get install -y xorg jwm socat \
&&  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add the pi user, and add it to the video group
RUN addgroup --gid 1000 pi \
&&  adduser --gid 1000 --uid 1000 --shell /bin/sh --disabled-password pi \
&&  usermod -aG video pi

USER pi

COPY bin/sharex /usr/bin/sharex

ENTRYPOINT [ "/usr/bin/sharex" ]