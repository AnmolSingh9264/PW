# ============================================================
#  Cloud Browser Desk — Firefox (Stable for low RAM)
# ============================================================

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1024x768x16

# ── Install system + desktop + Firefox ──────────────────────
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    x11vnc \
    xvfb \
    fluxbox \
    wget \
    curl \
    net-tools \
    novnc \
    websockify \
    firefox \
    && rm -rf /var/lib/apt/lists/*

# ── Copy startup script ─────────────────────────────────────
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
