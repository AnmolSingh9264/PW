#!/bin/bash

echo "Starting virtual display..."
Xvfb $DISPLAY -screen 0 $RESOLUTION &

sleep 2

echo "Starting window manager..."
fluxbox &

echo "Starting VNC server..."
x11vnc -display $DISPLAY -nopw -forever -shared &

echo "Starting noVNC on port $PORT ..."
websockify --web=/usr/share/novnc ${PORT:-6080} localhost:5900 &

sleep 5

echo "Launching browser..."

chromium-browser \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu \
  --start-maximized \
  https://rarestudy.in

wait
