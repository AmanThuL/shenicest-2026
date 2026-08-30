# Greenhouse interior props — source and attribution

Imported 2026-08-29 from the team's licensed Sketchfab candidate archive for the chapter 03 greenhouse interior.
All 11 included works were downloaded through Sketchfab's official download flow and are licensed under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). The original ZIP hashes remain recorded in the two
art-team intake reports named below; ZIP archives themselves are not copied into `Assets/`.

| Unity folder | Work | Author | Source |
|---|---|---|---|
| `TropicalPlantsM02P/` | Tropical Plants Pack M02P | MozzarellaARC | <https://sketchfab.com/3d-models/tropical-plants-pack-m02p-2f093afb792742438f0f7ba7eaab90f0> |
| `RealisticBeechFern/` | Realistic Beech Fern Plant | 3D Environment Artist Shop | <https://sketchfab.com/3d-models/realistic-beech-fern-plant-games-film-adf1e8832cf74a8a94c98792fa1d9088> |
| `Fern01/` | 3D Fern - 01 | SanForge Studio | <https://sketchfab.com/3d-models/3d-fern-01-165f3870237f488885faf406d9deddc0> |
| `FernGrass01/` | fern grass 01 | POLYSCAN | <https://sketchfab.com/3d-models/fern-grass-01-b0a96490483a48d2877d2ed8abc9e436> |
| `FernGrass02/` | fern grass 02 | POLYSCAN | <https://sketchfab.com/3d-models/fern-grass-02-93d1f6a261e24b8394d0ea41cf985ef9> |
| `FernsLowpoly/` | Ferns lowpoly model | adam127 | <https://sketchfab.com/3d-models/ferns-lowpoly-model-34fffcb1f90d4bb2a3bd362f38abbe80> |
| `BrackenFern/` | Bracken Fern Low Poly | Marcin.Kwiatkowski | <https://sketchfab.com/3d-models/bracken-fern-low-poly-b64381d3ea9547b88581f98178800627> |
| `MaleFern/` | Realistic HD Male fern (3/50) | PlantCatalog | <https://sketchfab.com/3d-models/realistic-hd-male-fern-350-5186272e16e3414e9240e093f37c3bf3> |
| `CommonPolypody/` | Realistic HD Common polypody fern (43/55) | PlantCatalog | <https://sketchfab.com/3d-models/realistic-hd-common-polypody-fern-4355-891b474098c54e8db9d5fb07b372e2c9> |
| `SwampFern/` | Swamp Fern (Green) | gavinpgamer1 | <https://sketchfab.com/3d-models/swamp-fern-green-2470736b312844e8bab5b080565d3e7e> |
| `FernBush/` | Fern Bush | Anatomy by Doctor Jana | <https://sketchfab.com/3d-models/fern-bush-c6195b907d11468192f6fde8ec948f08> |

## Imported subset and derived assets

- Source models and textures in this folder are unedited vendor files. The package background disc from M02P is not
  exposed as a prop; its 15 plant meshes become individual prefabs.
- The PlantCatalog male fern uses the provided LOD2 and LOD4 meshes; its 126,070-triangle LOD0 is intentionally not
  imported. The common polypody uses the provided LOD0, LOD2 and LOD4 meshes. Both become `LODGroup` prefabs.
- Separate albedo/opacity maps are packed into RGBA PNGs under
  `Assets/RootsDance/Textures/Environment/GreenhouseInteriorProps/`. This is a technical channel-pack only; source
  pixels are not repainted.
- `GreenhouseInteriorPropsBuilder` generates TVE materials and 25 placement prefabs under the project-owned
  `Assets/RootsDance/Materials/Environment/GreenhouseInteriorProps/` and
  `Assets/RootsDance/Prefabs/Environment/GreenhouseInteriorProps/` folders.
- The Prefab World Builder palette is `GreenhouseInteriorProps`, one brush per prefab.

## Intake records

- `美术组/素材下载/2026-08-29_素材库核对_第五轮/README.md`
- `美术组/素材下载/2026-08-29_蕨类搜索筛选_第六轮/README.md`

`Tree Fern 2` by b_nealie and `Tropical Vegetation` by alint are not present here: both authors disabled downloads.
Only their metadata remains in the candidate-library manifest; no download restriction was bypassed.
