#!/bin/bash
set -e

echo "Starting X virtual display..."

Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1

sleep 1

echo "Starting minimal window manager..."
fluxbox >/dev/null 2>&1 &

sleep 1

echo "Starting VNC server..."
x11vnc -display :1 \
  -nopw \
  -forever \
  -shared \
  -rfbport 5900 \
  -bg

sleep 1

echo "Launching Firefox..."
(
  sleep 4
  dbus-launch firefox \
    --no-remote \
    --new-instance \
    --kiosk https://rarestudy.in/
) &

echo "Starting noVNC (websockify foreground)..."

exec websockify \
  --web=/usr/share/novnc/ \
  0.0.0.0:${PORT:-6080} \
  localhost:5900
