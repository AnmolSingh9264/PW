#!/bin/bash
set -e

echo "Starting virtual display..."

Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

sleep 1

echo "Starting window manager..."
fluxbox &

sleep 1

echo "Starting VNC server..."
x11vnc -display :1 -nopw -forever -shared -rfbport 5900 &

sleep 1

echo "Starting Firefox..."
(
  sleep 5
  firefox --no-remote --new-instance --kiosk https://rarestudy.in/
) &

echo "Starting noVNC (websockify)..."

exec websockify \
  --web=/usr/share/novnc/ \
  ${PORT:-6080} \
  localhost:5900
