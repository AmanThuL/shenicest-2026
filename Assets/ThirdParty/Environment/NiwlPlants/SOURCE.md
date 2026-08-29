# Niwl-Games plants — source record

- **Vendor:** Niwl-Games (Khaleer) — <https://niwl.games/>
- **URL:** <https://niwl-games.itch.io/plants> (pack name: `Niwl-Plant-AssetPack-01`)
- **Licence:** CC0 1.0 Universal (see `LICENSE.md`)
- **Downloaded:** 2026-08-27
- **Copied files** (32 FBX + 5 textures; source paths are relative to the pack's `Standard/` folder):
  - `3D/FBX/M3D_grass_patch_1.fbx` … `3D/FBX/M3D_grass_patch_8.fbx` → `Models/Grass/` (8)
  - `3D/FBX/M3D_fern-1.fbx`, `3D/FBX/M3D_fern-2.fbx` → `Models/Ferns/` (2)
  - `3D/FBX/M3D_bush-1.fbx` … `3D/FBX/M3D_bush-4.fbx` → `Models/Bushes/` (4)
  - `3D/FBX/M3D_ivy_1.fbx` … `3D/FBX/M3D_ivy_4.fbx` → `Models/Ivy/` (4)
  - `3D/FBX/M3D_ivy_6.fbx` … `3D/FBX/M3D_ivy_8.fbx` → `Models/Ivy/` (3)
  - `3D/FBX/M3D_meadown.fbx` → `Models/Meadow/` (vendor spelling retained)
  - `3D/FBX/M3D_poppy-1.fbx`, `M3D_poppy2.fbx`, `M3D_sunflower.fbx` → `Models/Flowers/` (3)
  - `3D/FBX/M3D_alder_1.fbx` … `M3D_alder_3.fbx`, `M3D_birch-tree-1.fbx` …
    `M3D_birch-tree-3.fbx`, `M3D_pine.fbx` → `Models/Trees/` (7)
  - `TXT/T_Plants_General.png` → `Textures/` (referenced by all grass patches, ferns and bush 1–3)
  - `TXT/T_Plants_General_Bunch.png` → `Textures/` (referenced by bush 4 and ivy 1–4)
  - `TXT/T_Plants-TreeBranches.png`, `T_birch_bark.png`, `T_willow_bark.png` → `Textures/`
  - `License.txt` → `LICENSE.md`

Copied verbatim from the team candidate library; no local edits, vendor file names kept as-is. The FBX files embed
absolute texture paths from the author's machine; Unity resolves them by file name against `Textures/`. The pack's
roughness maps (`T_Plants_Roughness*.png`) are not referenced by any copied FBX and were not copied.

**Not copied:** the loose leaf-only meshes, water-overgrowth, the `3D/GLB/` duplicates and the two roughness maps.
The latter are not referenced by the FBX exports and the project material palette deliberately controls roughness.

## Selection rationale

Grass patches, ferns, bushes and ivy dress the transition and anomalous-growth rings. The 2026-08-29 increment adds
the pack's meadow and flowers for colour/species variation, plus low-complexity alder, birch and pine whose trunk
capsules can form the E-ring natural boundary while their crowns keep the greenhouse dome visible above them.
