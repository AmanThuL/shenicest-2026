# Retro PSX Nature Pack (Elegant Crow) — source record

- **Vendor:** Elegant Crow (elegantcrow)
- **URL:** <https://elegantcrow.itch.io/retro-psx-nature-pack> (download: "Retro Nature Pack", 5.8 MB, dated 2022-05-21)
- **Licence:** no explicit licence text found on the itch.io page as saved — see `LICENSE.md` (verify before release)
- **Downloaded:** 2026-08-27 (from the team candidate library,
  `室外场景候选素材/01_美术组点名/Itch/elegantcrow__retro-psx-nature-pack/`)
- **Source root:** `extracted/Retro Nature Pack/retro_nature_pack/` — paths below are relative to it.
- **Copied files** (14 models, 16 textures):
  - `Models/Trees/tree0N_winter.fbx` ← `models/FBX/trees/tree0N_winter.fbx`, N ∈ {1, 3, 4, 5, 6}
  - `Models/Trees/tree02_winter.obj` ← `models/OBJ/trees/tree02_winter.obj` — **substitute**: the vendor's
    `models/FBX/trees/tree02_winter.fbx` (4 KB) and `models/glTF/trees/tree02_winter.glb` (132 B) are empty
    exports with no geometry; only the OBJ carries the mesh (81 vertices, 110 faces, UVs present).
  - `Models/Bushes/bush0N_winter.fbx` ← `models/FBX/bushes/bush0N_winter.fbx`, N ∈ {1 … 6}
  - `Models/Bushes/bush07.fbx`, `bush08.fbx` ← `models/FBX/bushes/` (the two non-seasonal plain bushes)
  - `Textures/Trees/tree0N_winter.png` ← `textures/trees/`, N ∈ {1 … 6}
  - `Textures/Bushes/bushN_winter.png` ← `textures/bushes/`, N ∈ {1 … 6} (vendor names are not zero-padded)
  - `Textures/Bushes/bush7_fall.png`, `bush7_winter.png`, `bush8_fall.png`, `bush8_winter.png` ← `textures/bushes/`

Copied verbatim from the team candidate library; no local edits. OBJ/glTF duplicates, the grass models/textures
(another pack covers grass) and the spring/summer/fall variants of the seasonal models were not copied.

**Texture wiring:** none of the FBX files embeds a texture path (Blender export, materials only). Unity will create
materials named after the FBX material slots — `tree0N` + `tree0N_top` (trees), `bushN_winter` (winter bushes),
`bush7` / `bush8` — but cannot auto-assign textures; assign `tree0N_winter.png` / `bushN_winter.png` /
`bush7|8_fall|winter.png` by hand (or via the importer's "Search and Remap" on material name). `bush07`/`bush08`
reference no season, so the muted `_fall` and `_winter` textures were copied and `_summer` was left out.

**Selection rationale:** winter/dead variants for the dead-vegetation outer ring; `bush07`/`bush08` as sparse
ordinary bushes for the transition ring.
