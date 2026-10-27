# Whumpkit Lite: Godot Asset Library listing

Status 2026-10-27: the asset is LIVE as asset 5526 (https://godotengine.org/asset-library/asset/5526) under its old title "Wallop Lite – Camera Shake and Hit-Stop" at v1.0.0. The name WALLOP is a registered trade mark, so the asset is renamed to Whumpkit Lite (release v2.0.0). The GitHub repository was renamed to `pnscripts/godot-whumpkit-lite`; the old URL redirects, so the current download keeps working until the asset is edited.

## Owner step: edit asset 5526 (sign in as pnscripts)

Sign in at https://godotengine.org/asset-library/asset, open asset 5526, choose Edit, and set exactly:

- Asset Name: Whumpkit Lite – Camera Shake and Hit-Stop
- Category: Scripts (unchanged)
- Godot version: 4.7 (unchanged; tested on 4.7.1)
- Version: 2.0.0
- Licence: MIT (matches LICENSE.md, which has the copyright line)
- Repository host: GitHub
- Repository URL: https://github.com/pnscripts/godot-whumpkit-lite
- Issues URL: https://github.com/pnscripts/godot-whumpkit-lite/issues
- Download commit: b3dedb52558904d055d74c685660c7a92592d45d (the commit that the tag v2.0.0 points to)
- Icon URL: https://raw.githubusercontent.com/pnscripts/godot-whumpkit-lite/v2.0.0/listing/icon-256.png
- Previews (type Image; image URL and thumbnail URL are the same link; the old preview 6634 must be switched to the new tag, because the old Wallop Lite images no longer match):
  1. https://raw.githubusercontent.com/pnscripts/godot-whumpkit-lite/v2.0.0/listing/preview-code-1280x720.png
  2. https://raw.githubusercontent.com/pnscripts/godot-whumpkit-lite/v2.0.0/listing/preview-demo-frame-1280x720.png
  3. https://raw.githubusercontent.com/pnscripts/godot-whumpkit-lite/v2.0.0/listing/banner-1280x640.png
- Description (plain text, paste as is):

```
Free game feel helpers for Godot 4 (MIT): trauma-based camera shake for 2D and 3D and hit-stop (freeze frames). Each is a node you drop into a scene. Whumpkit Lite was called Wallop Lite before version 2.0.0; it was renamed so that its name is clearly its own (old node names are listed in the changelog).

- WhumpkitLiteShake2D / WhumpkitLiteShake3D: trauma model (0 to 1, shake = trauma ^ power, linear decay), seeded FastNoiseLite offsets and roll, so the same seed always gives the same motion. Applied on top of the camera's own offset and rotation and removed afterwards, so your camera code keeps control. 3D uses h_offset / v_offset plus pitch, yaw and roll. Signal settled; stop() clears at once.
- WhumpkitLiteHitStop: freezes or slows Engine.time_scale for a real-time duration, then restores whatever scale was there before (your own slow motion survives). Overlapping freezes extend to the longest one and use the lowest scale; max_duration caps stacking. Signals started, finished.
- Every node has step(delta). By default they run themselves each frame on real time (so the shake keeps moving during hit-stop); switch off auto_process to drive them yourself. In Movie Maker mode they follow the recording clock.
- WhumpkitLite.Shake2D, WhumpkitLite.Shake3D and WhumpkitLite.HitStop are typed script handles for code.

Upgrading from 1.0.0: the addon folder is now addons/whumpkit_lite and the nodes are WhumpkitLiteShake2D, WhumpkitLiteShake3D and WhumpkitLiteHitStop (formerly WallopLite...). Behaviour is unchanged.

Tested on Godot 4.7.1 with automated tests. Made by PN Scripts (https://pnscripts.com).
```

## Rules read on 2026-10-27

Source: https://docs.godotengine.org/en/stable/community/asset_library/submitting_to_assetlib.html (re-read this session). What matters here:

- The licence on the asset must match the repository licence; the repository must have LICENSE or LICENSE.md with the licence text and a copyright line (year and holder). This repo has LICENSE.md in the root and inside `addons/whumpkit_lite/`.
- The icon link must be direct and start with `raw.githubusercontent.com`, square, at least 128 px (icon-256.png is 256 px).
- The Download commit field takes a commit hash; the site builds the ZIP link from it, and the internal version number is raised every time the download URL changes. Editing the asset to the new commit is therefore how users get 2.0.0.
- The page says nothing special about renaming or editing a published asset; it only describes the form and that review is manual and may take up to a few days. In practice a change to a live asset can go back to review, so expect the old entry to stay visible until it is approved.
- Name and description must be proper English with correct capitalisation and full sentences; up to three image or YouTube previews (PNG or JPG, not GIF; the animated preview stays in the README).
- `.gitignore` required, `.gitattributes` export-ignore recommended (both present), screenshots in a folder with an empty `.gdignore` (listing/ and tools/ have one).

Note: the `.gitattributes` export-ignore keeps demo, tests, tools and listing out of the downloaded ZIP; the `listing/` images stay reachable through raw.githubusercontent.com because they are in the repository.
