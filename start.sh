#!/bin/bash

echo "Starting virtual display..."
Xvfb $DISPLAY -screen 0 $RESOLUTION &

sleep 2

echo "Starting window manager..."
fluxbox &

sleep 2

echo "Starting VNC server..."
x11vnc -display $DISPLAY -nopw -forever -shared &

echo "Starting noVNC (auto UI)..."
websockify \
  --web=/usr/share/novnc \
  --index vnc_lite.html \
  ${PORT:-6080} localhost:5900 &

# Give everything time to stabilize
sleep 8

echo "Launching Firefox in kiosk mode..."

DISPLAY=:1 firefox \
  --no-remote \
  --new-instance \
  --kiosk \
  https://rarestudy.in

wait
