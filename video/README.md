# Outillage vidéo

| Outil | Version | Rôle |
|---|---|---|
| HyperFrames | 0.8.209 | Vidéos en HTML/CSS + GSAP (`hf-demo/`) |
| Remotion | 4.0.539 | Vidéos en React (`remotion/src/`) |
| FFmpeg | système | Montage, encodage, audio |
| Chrome Headless Shell | géré par HyperFrames | Rendu (partagé avec Remotion) |

## Installation

```bash
npm run setup     # FFmpeg (si absent), npm ci, Chrome headless
npm run verify    # rendu HyperFrames + Remotion + montage FFmpeg → out/
```

## Commandes

```bash
npm run hf:preview        # studio HyperFrames
npm run hf:render         # → out/hf-demo.mp4
npm run remotion:studio   # studio Remotion
npm run remotion:render   # → out/remotion-demo.mp4
```

GSAP est servi en local (`hf-demo/assets/vendor/`) : le Chrome de rendu n'accède pas toujours aux CDN.
