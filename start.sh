#!/bin/bash

echo "Starting web server first (important for Render)..."

# Start noVNC immediately (prevents timeout)
websockify --web=/usr/share/novnc \
  --index vnc_lite.html \
  ${PORT:-6080} localhost:5900 &

echo "Starting virtual display..."
Xvfb :1 -screen 0 1024x768x16 &

sleep 2

echo "Starting window manager..."
DISPLAY=:1 fluxbox &

sleep 2

echo "Starting VNC server..."
x11vnc -display :1 -nopw -forever -shared &

echo "Launching Firefox after delay..."

# Launch browser in background (don’t block startup)
(
  sleep 6
  DISPLAY=:1 firefox \
    --no-remote \
    --new-instance \
    --kiosk \
   https://rarestudy.in/
) &

# Keep container alive
while true; do sleep 1000; done
