#!/bin/bash

echo "Starting noVNC server FIRST..."

websockify \
  --web=/usr/share/novnc \
  --index vnc_lite.html \
  ${PORT:-6080} localhost:5900 &

echo "Starting virtual display..."
Xvfb :1 -screen 0 1024x768x16 &

sleep 2

echo "Starting window manager..."
DISPLAY=:1 fluxbox &

sleep 2

echo "Starting VNC..."
x11vnc -display :1 -nopw -forever -shared &

# 🔥 Do NOT block startup — launch browser in background
echo "Launching Firefox..."

(
  sleep 5
  DISPLAY=:1 firefox \
    --no-remote \
    --new-instance \
    --kiosk \
    https://rarestudy.in
) &

# Keep container alive
tail -f /dev/null
