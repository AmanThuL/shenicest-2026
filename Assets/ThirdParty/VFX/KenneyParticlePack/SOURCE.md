# Kenney Particle Pack — source record

- **Vendor:** Kenney (Kenney Vleugels), <https://kenney.nl>
- **URL:** <https://kenney.nl/assets/particle-pack> (download: `kenney_particle-pack.zip`, 14.3 MB, pack version 1.1)
- **Licence:** Creative Commons Zero (CC0 1.0) — see `LICENSE.txt` (copied verbatim from the zip's `License.txt`).
  Credit is optional; the pack may be used in commercial projects.
- **Downloaded:** 2026-08-27, directly from the vendor URL above.
- **Source root:** the zip's `PNG (Transparent)/` folder (512 × 512 sprites with alpha) — paths below are relative to it.
- **Copied files** (2 of 80):
  - `circle_05.png` — soft round blob; the 污染光点 (contamination motes) sprite.
  - `light_01.png` — soft glow with faint concentric rings; the 孢子 (spores) sprite.

Copied verbatim; no local edits. The `PNG (Black background)`, `Rotated` and `Unity samples` folders were not copied.

**Usage:** `RootsDance.Editor.Environment.OpeningVfxPrefabBuilder` assigns each sprite as the colour and emissive map
of the generated `Assets/RootsDance/VFX/VFX_*.mat` particle materials. Import settings are Unity's defaults for a
sprite-like texture (sRGB, alpha is transparency). Add further sprites from the same pack by copying them here and
extending this list.
