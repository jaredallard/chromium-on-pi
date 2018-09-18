#!/usr/bin/env bash
# Build the containers

docker build -t jaredallard/chromium-rpi:v1.0.1 -f chromium.Dockerfile .
docker build -t jaredallard/xorg-rpi:v1.0.0 -f xorg.Dockerfile .

docker push jaredallard/chromium-rpi:v1.0.1
docker push jaredallard/xorg-rpi:v1.0.0