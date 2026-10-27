# Changelog

## 2.0.0 (2026-10-27)

Renamed from Wallop Lite (trademark clash); no behaviour change. The public names changed, so this is a major version.
The Godot Asset Library entry keeps its asset number; the GitHub repository is now `pnscripts/godot-whumpkit-lite` (the old URL redirects).

Migration from 1.0.0 (Wallop Lite):

- Addon folder `addons/wallop_lite` -> `addons/whumpkit_lite`; enable **Whumpkit Lite** in Project Settings > Plugins.
- Node and class names: `WallopLiteShake2D` -> `WhumpkitLiteShake2D`, `WallopLiteShake3D` -> `WhumpkitLiteShake3D`, `WallopLiteHitStop` -> `WhumpkitLiteHitStop`;
  the handle class `WallopLite` -> `WhumpkitLite`.
- Script files `wallop_*.gd` -> `whumpkit_*.gd`. In scene files (.tscn) replace `res://addons/wallop_lite/wallop_` with `res://addons/whumpkit_lite/whumpkit_`
  and the `WallopLite*` script class names with the new ones (a find-and-replace is enough).
- Demo, docs and checks from the unreleased notes below are included: a punching bag with impact sparks, a hit flash and live meters for trauma and time scale;
  taps and a second finger work on touch screens; `make web-check` drives the web export in real Chrome (heavy hit: time scale 0 then back to 1; two touches give two hits; 0 console errors) and records the preview GIF.

## 1.0.0 (2026-10-12)

- First release of the Lite edition (as Wallop Lite): WallopLiteShake2D, WallopLiteShake3D, WallopLiteHitStop, demo and tests.
