#!/bin/bash
set -e

echo "Starting virtual display (Xvfb)..."
Xvfb :1 -screen 0 1280x720x24 -ac +extension GLX +render -noreset &
export DISPLAY=:1

sleep 2

echo "Starting window manager (fluxbox)..."
fluxbox >/dev/null 2>&1 &

sleep 2

echo "Starting VNC server..."
x11vnc -display :1 \
  -nopw \
  -forever \
  -shared \
  -rfbport 5900 \
  -bg

sleep 2

echo "Launching Firefox (shared session)..."
(
  sleep 6
  dbus-launch firefox \
    --no-remote \
    --new-instance \
    --kiosk \
    https://rarestudy.in/
) &

echo "Starting noVNC (auto web UI)..."

exec websockify \
  --web=/usr/share/novnc/ \
  --index vnc.html \
  0.0.0.0:${PORT:-6080} \
  localhost:5900
