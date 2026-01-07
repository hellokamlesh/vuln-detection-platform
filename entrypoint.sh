#!/usr/bin/env bash
set -euo pipefail

PORT="${CANDY_WEB_PORT:-8787}"
HOST="${CANDY_WEB_HOST:-0.0.0.0}"

cat <<BANNER
[candys-crew] Docker container is up. Control plane will be served at http://${HOST}:${PORT}
[candys-crew] If you mapped the port (e.g. -p ${PORT}:${PORT}), open that URL from your browser.
[candys-crew] Press Ctrl+C to stop the container.
BANNER

if command -v mountpoint >/dev/null 2>&1; then
  if ! mountpoint -q /opt/candy/output; then
    echo "[candys-crew] Tip: mount your host output directory (-v \"\$(pwd)/output:/opt/candy/output\") to persist scans between containers."
  fi
fi

exec python -m candy_web
