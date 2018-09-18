FROM resin/rpi-raspbian:jessie

# hadolint ignore=DL4000
MAINTAINER Jared Allard <jaredallard@outlook.com>

# hadolint ignore=DL3015,DL3008
RUN apt-get update \
&&  apt-get install -y ca-certificates ttf-mscorefonts-installer libexif-dev libpango1.0-0 libv4l-0 chromium-browser libx11-xcb1 lsb-release \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add the pi user, and add it to the video group
RUN addgroup --gid 1000 pi \
&&  adduser --gid 1000 --uid 1000 --shell /bin/sh --disabled-password pi \
&&  usermod -aG video pi

USER pi

COPY bin/takex /usr/bin/takex

ENTRYPOINT ["/usr/bin/takex", "/usr/bin/chromium-browser", "--no-sandbox",\
            "--user-data-dir=/tmp", "--disable-setuid-sandbox"]