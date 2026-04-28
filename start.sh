#!/bin/bash

echo "Starting virtual display..."
Xvfb $DISPLAY -screen 0 $RESOLUTION &

sleep 3

echo "Starting window manager..."
fluxbox &

sleep 3

echo "Starting VNC..."
x11vnc -display $DISPLAY -nopw -forever -shared &

echo "Starting noVNC..."
websockify --web=/usr/share/novnc ${PORT:-6080} localhost:5900 &

# 🔥 Give everything time to stabilize
sleep 10

echo "Launching Firefox..."

DISPLAY=:1 firefox \
  --no-remote \
  --new-instance \
  --kiosk \
  https://rarestudy.in

wait
