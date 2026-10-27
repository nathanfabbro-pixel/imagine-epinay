#!/usr/bin/env bash
# Vérifie de bout en bout : rendu HyperFrames, rendu Remotion, montage FFmpeg.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p out

probe() { ffprobe -v error -show_entries stream=codec_name,width,height:format=duration -of compact=p=0 "$1" | tr '\n' ' '; echo; }

echo "== Versions"
ffmpeg -version | head -1
echo "hyperframes $(npx hyperframes --version 2>/dev/null | tail -1)"
echo "remotion $(node -p 'require("remotion/package.json").version')"

echo "== HyperFrames : check + rendu"
(cd hf-demo && npx hyperframes check >/dev/null 2>&1 && npx hyperframes render -o ../out/hf-demo.mp4 --quiet >/dev/null 2>&1)
probe out/hf-demo.mp4

echo "== Remotion : typecheck + rendu"
npx tsc
npx remotion render Demo out/remotion-demo.mp4 --log=error
probe out/remotion-demo.mp4

echo "== FFmpeg : fondu enchaîné + texte + audio"
ffmpeg -hide_banner -loglevel error -y -i out/hf-demo.mp4 -i out/remotion-demo.mp4 -f lavfi -i "sine=frequency=440:duration=7" \
  -filter_complex "[0:v]fps=30,settb=AVTB,format=yuv420p[a0];[1:v]fps=30,settb=AVTB,format=yuv420p[b0];\
[a0][b0]xfade=transition=fade:duration=1:offset=3,drawtext=text='Test FFmpeg':fontcolor=white:fontsize=48:x=(w-tw)/2:y=h-120[v];\
[2:a]afade=t=in:d=0.5,afade=t=out:st=6.5:d=0.5,volume=0.2[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -shortest out/montage-test.mp4
probe out/montage-test.mp4

echo "✓ Tout fonctionne"
