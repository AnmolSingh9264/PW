#!/bin/bash
set -e

echo "Cleaning stale X locks..."
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

echo "Starting Xvfb..."
Xvfb :1 -screen 0 1280x720x24 -ac +extension GLX +render -noreset &
export DISPLAY=:1

sleep 2

echo "Starting window manager..."
fluxbox >/dev/null 2>&1 &

sleep 2

echo "Starting VNC..."
x11vnc -display :1 -nopw -forever -shared -rfbport 5900 -bg

sleep 2

echo "Launching Firefox..."
(
  sleep 6
  dbus-launch firefox \
    --no-remote \
    --new-instance \
    --kiosk \
    https://rarestudy.in/
) &

echo "Starting noVNC..."

exec websockify \
  0.0.0.0:${PORT:-6080} \
  localhost:5900
