#!/usr/bin/env bash
# Installe tout l'outillage vidéo (à relancer dans un nouvel environnement).
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v ffmpeg >/dev/null || ! command -v ffprobe >/dev/null; then
  echo "→ Installation de FFmpeg"
  if command -v apt-get >/dev/null; then
    sudo_cmd=""; [ "$(id -u)" -ne 0 ] && sudo_cmd="sudo"
    $sudo_cmd apt-get update -qq && $sudo_cmd apt-get install -y -qq ffmpeg fonts-dejavu fontconfig
  elif command -v brew >/dev/null; then
    brew install ffmpeg
  else
    echo "Installez FFmpeg manuellement : https://ffmpeg.org/download.html" >&2; exit 1
  fi
fi

echo "→ Dépendances npm (HyperFrames, Remotion, React, GSAP)"
npm ci

echo "→ Chrome Headless Shell (rendu HyperFrames + Remotion)"
npx hyperframes browser ensure

cp node_modules/gsap/dist/gsap.min.js hf-demo/assets/vendor/gsap.min.js
echo "✓ Installation terminée — lancez : npm run verify"
