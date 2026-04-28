# ============================================================
#  Cloud UI Streaming — Firefox + noVNC (Clean UX)
# ============================================================

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1280x800x16

# ── Install minimal system + Firefox ────────────────────────
RUN apt-get update && apt-get install -y \
    firefox \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

# ── Copy startup script ─────────────────────────────────────
COPY start.sh /start.sh
RUN chmod +x /start.sh

# ── Expose port (Render uses PORT env) ──────────────────────
EXPOSE 6080

CMD ["/start.sh"]
