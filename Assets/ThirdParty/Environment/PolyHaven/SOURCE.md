# Poly Haven — source record

- **Vendor:** Poly Haven
- **URL:** <https://polyhaven.com/> (per-asset pages listed below and in `LICENSE.md`)
- **Licence:** CC0 1.0 Universal (see `LICENSE.md`)
- **Downloaded:** 2026-08-27 (1K resolution, FBX + textures, from the team candidate library)

## Copied files

Models (13, `<name>` = folder name; the `textures/` subfolder of each download was flattened next to the FBX):

- `Models/<name>/<name>_1k.fbx`
- `Models/<name>/<name>_diff_1k.jpg|png` — base colour
- `Models/<name>/<name>_nor_gl_1k.png` — OpenGL tangent-space normal (`.exr` → `.png`, see *Local edits*)
- `Models/<name>/<name>_rough_1k.png|jpg` — roughness (`.exr` → `.png` where the source was EXR)
- plus, where the asset ships them: `<name>_metal_1k.png`, `<name>_disp_1k.png`, `<name>_alpha_1k.png`
- `modular_chainlink_fence` uses two material sets (`_posts_*`, `_wire_*`); `pine_roots` uses two (`_a_*`, `_b_*`)

| Model | Polycount (`info.json`) | Author(s) | Page |
|---|---:|---|---|
| `dead_tree_trunk` | 101,802 | Rob Tuytel | <https://polyhaven.com/a/dead_tree_trunk> |
| `dead_tree_trunk_02` | 155,864 | Jenelle van Heerden (photography), Rico Cilliers (processing) | <https://polyhaven.com/a/dead_tree_trunk_02> |
| `dry_branches_medium_01` | 16,803 | Rico Cilliers | <https://polyhaven.com/a/dry_branches_medium_01> |
| `modular_chainlink_fence` | 89,232 | James Ray Cock; Amal Kumar (fence wire material) | <https://polyhaven.com/a/modular_chainlink_fence> |
| `concrete_road_barrier` | 80,776 | Amal Kumar | <https://polyhaven.com/a/concrete_road_barrier> |
| `clipboard` | 6,176 | ProgrammerOnCoffee | <https://polyhaven.com/a/clipboard> |
| `binder_notebook` | 18,077 | DaDrood | <https://polyhaven.com/a/binder_notebook> |
| `pine_roots` | 162,693 | Rob Tuytel | <https://polyhaven.com/a/pine_roots> |
| `root_cluster_01` | 225,261 | Jenelle van Heerden (photography), Rico Cilliers (photography, processing) | <https://polyhaven.com/a/root_cluster_01> |
| `root_cluster_02` | 339,641 | Jenelle van Heerden | <https://polyhaven.com/a/root_cluster_02> |
| `single_root` | 114,424 | Jenelle van Heerden | <https://polyhaven.com/a/single_root> |
| `rock_moss_set_01` | 63,127 | Kless Gyzen | <https://polyhaven.com/a/rock_moss_set_01> |
| `rock_moss_set_02` | 57,647 | Kless Gyzen | <https://polyhaven.com/a/rock_moss_set_02> |

Polycounts are the Poly Haven source-mesh figures — these are photogrammetry assets and several are heavy
(`root_cluster_02` ≈ 340 k tris); check guideline 05 before instancing them in bulk.

Terrain PBR sets (2, `<Id>` ∈ {brown_mud_02, aerial_ground_rock}, both by Rob Tuytel):

- `Textures/<Id>/<Id>_diff_1k.jpg`
- `Textures/<Id>/<Id>_nor_gl_1k.jpg`
- `Textures/<Id>/Source~/<Id>_ao_1k.jpg`
- `Textures/<Id>/Source~/<Id>_rough_1k.jpg`
- `Textures/<Id>/Source~/<Id>_disp_1k.jpg`

Pages: <https://polyhaven.com/a/brown_mud_02>, <https://polyhaven.com/a/aerial_ground_rock>. The `_arm` (packed
AO/rough/metal) and `_nor_dx` (DirectX normal) variants were not copied. As with the AmbientCG sets,
AO/Roughness/Displacement live in `Source~/` (ignored by the Unity importer) and are packed into
`Assets/RootsDance/Textures/Environment/Terrain<LayerName>_Mask.png` by RootsDance/Terrain/Pack Terrain Layer Masks.

Not copied: `info.json`, `files.json`, `SOURCE_PAGE.html` from each download, and every other asset in the candidate
library (`metal_detector`, `aerial_mud_1`, plants, …) — those were rejected during selection.

## Local edits

Everything is copied verbatim **except** the 22 `.exr` maps (normal, roughness, metal) of the models, which were
converted to 8-bit PNG with the same file name (`foo_nor_gl_1k.exr` → `foo_nor_gl_1k.png`). The EXRs are 16-bit
half-float, DWAA-compressed *linear data* maps; the PNGs are plain linear 8-bit (no gamma / sRGB curve applied), so
import them in Unity with **sRGB (Color Texture) off** (normal maps: Texture Type = Normal map). ImageMagick
7.1.2 from Homebrew has no OpenEXR coder and ffmpeg's swscale range-expands single-channel (Y) EXRs, so the
conversion is a three-step pipeline, run on 2026-08-27 for every `.exr`:

```bash
# 1. lossless re-wrap DWAA -> ZIP with the OpenEXR reference tools (ffmpeg cannot decode single-channel DWAA)
exrmetrics --convert -z zip in.exr -o tmp.exr
# 2. decode to 32-bit float PFM, linear (no transfer curve); Y files -> grayf32le, RGB(A) files -> gbrpf32le
ffmpeg -apply_trc linear -i tmp.exr -pix_fmt gbrpf32le -c:v pfm tmp.pfm       # or -pix_fmt grayf32le
# 3. quantise to 8-bit with ImageMagick (color-type 2 = RGB for normals, 0 = grayscale for rough/metal)
/opt/homebrew/bin/magick tmp.pfm -depth 8 -define png:color-type=2 out.png     # or color-type=0
```

Verification: an independent decode of the ZIP EXRs (Python, `zlib` + `struct`) gives per-channel means that every
PNG matches within ±0.03/255, e.g. `dead_tree_trunk_nor_gl_1k`: EXR R/G/B = 127.18 / 127.45 / 245.39 → PNG
127.23 / 127.42 / 245.30 (an sRGB curve would have produced ≈ 186 / 186 / 251). The alpha channel that
`concrete_road_barrier`, `rock_moss_set_01` and `rock_moss_set_02` carry in their normal EXR (constant 255) was
dropped; the two `rock_moss_set` normals average darker (≈ 101 / 102 / 183) because their unused UV space is black
in the source, not because of the conversion.

## Selection rationale

- **Dead trunks, dry branches, roots** (`dead_tree_trunk*`, `dry_branches_medium_01`, `pine_roots`,
  `root_cluster_*`, `single_root`): the dead outer ring of the map and the root-and-rock clutter that gives
  *Where the Roots Dance* its motif.
- **Moss rock sets** (`rock_moss_set_01/02`): ground clutter along the roots and at the treeline.
- **Chain-link fence + concrete road barrier**: the boundary of the abandoned zone.
- **Clipboard + binder notebook**: evidence props for the research camp.
- **`brown_mud_02`, `aerial_ground_rock`**: extra terrain layers (mud, rocky ground) next to the AmbientCG sets.
