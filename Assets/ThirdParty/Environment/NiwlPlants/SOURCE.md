# Niwl-Games plants — source record

- **Vendor:** Niwl-Games (Khaleer) — <https://niwl.games/>
- **URL:** <https://niwl-games.itch.io/plants> (pack name: `Niwl-Plant-AssetPack-01`)
- **Licence:** CC0 1.0 Universal (see `LICENSE.md`)
- **Downloaded:** 2026-08-27
- **Copied files** (18 FBX + 2 textures; source paths are relative to the pack's `Standard/` folder):
  - `3D/FBX/M3D_grass_patch_1.fbx` … `3D/FBX/M3D_grass_patch_8.fbx` → `Models/Grass/` (8)
  - `3D/FBX/M3D_fern-1.fbx`, `3D/FBX/M3D_fern-2.fbx` → `Models/Ferns/` (2)
  - `3D/FBX/M3D_bush-1.fbx` … `3D/FBX/M3D_bush-4.fbx` → `Models/Bushes/` (4)
  - `3D/FBX/M3D_ivy_1.fbx` … `3D/FBX/M3D_ivy_4.fbx` → `Models/Ivy/` (4)
  - `TXT/T_Plants_General.png` → `Textures/` (referenced by all grass patches, ferns and bush 1–3)
  - `TXT/T_Plants_General_Bunch.png` → `Textures/` (referenced by bush 4 and ivy 1–4)
  - `License.txt` → `LICENSE.md`

Copied verbatim from the team candidate library; no local edits, vendor file names kept as-is. The FBX files embed
absolute texture paths from the author's machine; Unity resolves them by file name against `Textures/`. The pack's
roughness maps (`T_Plants_Roughness*.png`) are not referenced by any copied FBX and were not copied.

**Not copied** (art direction rejects healthy/colourful plants; trees come from another pack): poppy, sunflower,
pine, meadow, alder, birch, leaves, water-overgrowth, ivy 6/7/8, the `3D/GLB/` duplicates and the bark/branch
textures.

## Selection rationale

Grass patches, ferns, bushes and ivy dress the **transition-growth ring** between the dead outer ring and the
stable inner ecology: low, sparse, muted ground cover that reads as life creeping back in rather than a lush meadow.
