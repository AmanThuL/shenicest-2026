# ambientCG — source record

- **Vendor:** ambientCG
- **URL:** <https://ambientcg.com/> (per-asset pages listed in `LICENSE.md`)
- **Licence:** CC0 1.0 Universal (see `LICENSE.md`)
- **Downloaded:** 2026-08-26 (Ground068/Ground086/Concrete032 added 2026-08-27)
- **Copied files** (9 materials, `<Id>` ∈ {Ground103, Ground106, Grass003, Ground037, Concrete044D, Gravel043, Ground068, Ground086, Concrete032}):
  - `<Id>/<Id>_1K-JPG_Color.jpg`
  - `<Id>/<Id>_1K-JPG_NormalGL.jpg`
  - `<Id>/Source~/<Id>_1K-JPG_AmbientOcclusion.jpg`
  - `<Id>/Source~/<Id>_1K-JPG_Roughness.jpg`
  - `<Id>/Source~/<Id>_1K-JPG_Displacement.jpg`

Copied verbatim from the team candidate library; no local edits. AO/Roughness/Displacement live in `Source~/`
(ignored by the Unity importer) and are packed into `Assets/RootsDance/Textures/Environment/Terrain<LayerName>_Mask.png` by
RootsDance/Terrain/Pack Terrain Layer Masks.

- **Helmet HUD dressing** (added 2026-08-27, downloaded from ambientcg.com, `<Id>` ∈ {Rubber004, Metal032, Fingerprints002}):
  - `<Id>/<Id>_1K-JPG_Color.jpg` — colour map only; consumed by `RootsDance/UI/HelmetVisor`
    (shell rubber, rim metal, glass smudges), wired by `HelmetHudBuilder.EnsureVisorMaterial`.
