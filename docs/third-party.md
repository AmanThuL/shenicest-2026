# Third-party plugin records

> **Scope:** Exceptions and unavoidable deviations for content under `Assets/ThirdParty/` and `Assets/Plugins/`, as required by [docs/guidelines/02-project-structure.md](guidelines/02-project-structure.md) §5. One entry per package; when adding one, record the exact version, path, *why* it's an exception, and every file you had to touch (so the edit can be re-applied after a vendor update).
>
> Third-party **art** assets are recorded here too (licence and provenance), even though their source files live outside `Assets/` under `SourceArt/`.

## Odin Inspector and Serializer (Sirenix) — `Assets/Plugins/Sirenix/`

- **Version:** 4.0.2.3. Imported 2026-08-24 as a team decision (each teammate holds a seat licence).
- **Vendor-required path.** Odin installs to and locates itself from `Assets/Plugins/Sirenix/` (`Odin Inspector/Assets/Editor/OdinPathLookup.asset`, the `Config/Editor/*.asset` files and the per-platform `Assemblies/` sub-folders are resolved relative to it), so it stays there instead of `Assets/ThirdParty/`.
- **No local edits.**
- Odin writes `ODIN_INSPECTOR*` scripting defines into `ProjectSettings/ProjectSettings.asset` per active build target group. The Odin serializer is deliberately unused — see [12 Odin Inspector](guidelines/12-odin-inspector.md), the owner guideline.

## DOTween (Demigiant) — `Assets/Plugins/Demigiant/DOTween/`

- **Placement exception.** Imported via the vendor's `.unitypackage`, which installs to `Assets/Plugins/Demigiant/DOTween/` by convention. Left there rather than moved to `Assets/ThirdParty/Demigiant/` because `DOTween.dll` is a compiled managed binary — the folder it belongs in per [02](guidelines/02-project-structure.md) §2 ("`Assets/Plugins/` — native and managed plug-in binaries only"). Its `Modules/` and `Editor/` companion source files ride along in the same tree rather than being split out, to keep the vendor's internal layout intact for future updates.
- **Assembly definitions added** (the one tolerated edit inside a vendor folder, per [02](guidelines/02-project-structure.md) §5): `DOTween.Modules.asmdef` at the DOTween root (covers `DOTween.dll` + `Modules/`) and `Editor/DOTween.Editor.asmdef` (editor-only, references `DOTween.Modules`, covers `DOTweenEditor.dll`). Neither shipped with the Asset Store package. `RootsDance.Runtime.asmdef` references `DOTween.Modules`.
- **No `Resources/` folder.** DOTween's Utility Panel (*Tools > Demigiant > DOTween Utility Panel > Setup DOTween...*) normally writes `Assets/Resources/DOTweenSettings.asset`, which conflicts with the project's non-negotiable "never create a `Resources/` folder" rule ([AGENTS.md](../AGENTS.md) #19, [02](guidelines/02-project-structure.md) §4). That asset only carries *default* tween settings (ease, safe mode, log behaviour, recycle) that DOTween otherwise falls back to hardcoded defaults for if the asset is absent — it is not required for `DG.Tweening` extension methods to compile or run. All module files under `Modules/` are compiled unconditionally by default (each is guarded by an opt-out define, e.g. `#if !DOTWEEN_NOPHYSICS`, that nothing in this project sets), so they work without ever running Setup.
  - Instead, the same defaults are set from code once, in [`GameBootstrap.Awake()`](../Assets/RootsDance/Scripts/Runtime/App/GameBootstrap.cs): `DOTween.Init(recycleAllByDefault: false, useSafeMode: true, logBehaviour: LogBehaviour.ErrorsOnly)`.
  - **Do not** run "Setup DOTween..." in a way that leaves `Assets/Resources/DOTweenSettings.asset` behind. If a teammate needs to disable a specific module (e.g. `DOTWEEN_NOPHYSICS2D` because a feature genuinely never needs it), open the Utility Panel, apply the module change, then delete the generated `Resources/DOTweenSettings.asset` + folder afterward — the module toggle itself is a scripting-define change, not a dependency on the settings asset.
  - **Unverified:** this repo currently has no Unity Editor access to confirm in-Editor that DOTween runs cleanly (zero console errors/warnings) with no settings asset present. A teammate should open the project once and confirm before relying on this pattern further.
- **Usage:** `using DG.Tweening;` in any `RootsDance.Runtime` file that needs it.

## The Visual Engine (BOXOPHOBIC) — `Assets/BOXOPHOBIC/` + `Assets/BOXOPHOBIC+/`

- **Version:** 22.0.0 (`Version.asset` data `2200`), HDRP support package "High Definition 6000.0+". Imported 2026-08-27.
- **Vendor-required paths.** The editor tooling hard-codes the user folder `Assets/BOXOPHOBIC+` (`BoxoUtils.GetUserFolder()`, `TVEShaderManager`, `TVEMaterialManager`, `TVEAssetManager`, `TVEMaterialUpgrader`, `TVESceneDebugger`), and the installer/upgrader locates the core folder next to it — so both trees stay at the `Assets/` root instead of `Assets/ThirdParty/`.
- **Removed after import** (re-import the Asset Store package if any of it is ever needed): `The Visual Engine/Demo/` (412 MB — nine demo scenes, demo vegetation prefabs, terrain and textures), `The Visual Engine/Learn/` (tutorial scene) and `The Visual Engine/Core/Pipelines/` (the three per-pipeline `.unitypackage` archives; the HDRP one was already applied by the installer, and [02](guidelines/02-project-structure.md) §5 forbids `.unitypackage` files under `Assets/`). Two `Core/Resources/Internal *TexRT.mat` materials keep stale Amplify property slots pointing at a deleted demo texture; their shader (`CustomRT Drops`) only samples `_DropsTex`, so this is harmless.
- **No local edits.** `Assets/BOXOPHOBIC+/User/The Visual Engine/{Version,Pipeline}.asset` are written by the vendor installer and are committed so the installer does not re-run on other machines.
- The installer writes `THE_VISUAL_ENGINE_V22;THE_VISUAL_ENGINE_HD` into `ProjectSettings/ProjectSettings.asset` (Standalone group) and sets vertex compression / script execution order for its own scripts. Its `Core/Resources/` folder is vendor-internal (the `Resources/` ban in [02](guidelines/02-project-structure.md) §4 is about project-owned content).
- **Usage:** vegetation/wind/interaction shaders and the `TVE Manager` scene component; rendering rules in [07](guidelines/07-rendering-hdrp.md). Manual: `Assets/BOXOPHOBIC/The Visual Engine/The Visual Engine.pdf`.

## Prefab World Builder (PluginMaster) — `Assets/PluginMaster/`

- **Version:** 4.12.2. Imported 2026-08-27. Editor-only (everything is under `DesignTools/Editor/`), no runtime code, no samples shipped.
- **Vendor-required path.** `PWBData.RELATIVE_TOOL_DIR = "PluginMaster/DesignTools/Editor/PrefabWorldBuilder"` and `Resources/Data/PWBData.txt` (`_rootDirectory`) pin the tool to `Assets/PluginMaster/…`, so it stays at the `Assets/` root instead of `Assets/ThirdParty/`.
- **No local edits.**
- PWB stores its palettes under `Resources/Data/` inside its own tree and its shortcut profiles + data-dir pointer in `ProjectSettings/PWBSettings.txt` (both committed — palettes are shared team content). It adds `PWB_HDRP` to the Standalone scripting defines.
- **Usage:** prefab painting / placement for level dressing ([11](guidelines/11-scenes-prefabs-workflow.md)). Manual: `Assets/PluginMaster/DesignTools/Editor/PrefabWorldBuilder/Documentation/Prefab World Builder Documentation.pdf`.

## Curved UI Utility (Caeden117) — `Assets/ThirdParty/CurvedUIUtility/`

- **Version:** 0.2.6 (`package.json`), vendored 2026-08-27 from the GitHub repo `Caeden117/Curved-UI-Utility`
  (`Assets/com.caeden117.curved-ui-utility/` subtree, with the upstream `.meta` files so GUID references hold).
- **Licence: MIT** — `CurvedUIUtility/LICENSE.md`. Attribution requested, not required.
- **Why vendored, not UPM:** upstream publishes no registry package; vendoring under `Assets/ThirdParty/` follows
  [02](guidelines/02-project-structure.md) and keeps `Packages/manifest.json` untouched.
- **What it does:** Halo-style curved HUD for overlay canvases — a `CurvedUIController` on the canvas plus
  `CurvedTextMeshPro`/`CurvedImage` graphics that bend their vertices in canvas space (crisp SDF text, no render
  texture, no extra camera). Assemblies `CurvedUIUtility` + `CurvedUIUtility.Editor` ride along; `RootsDance.Editor`
  references the runtime assembly.
- **Local edits** (re-apply after a vendor update):
  - `Editor/Internal/UIHelper.cs` — `FindObjectOfType<EventSystem>` → `FindFirstObjectByType` (obsolete in Unity 6);
    dropped `using UnityEditor.Experimental.SceneManagement` (namespace removed in Unity 6 — a compile error that
    took every script assembly down with it; `PrefabStageUtility` resolves via `UnityEditor.SceneManagement`).
  - `Runtime/Internal/CurvedTextMeshProUnderline.cs` — did not compile against Unity 6's bundled TMP:
    the `TMP_MANUALLY_GET_UNDERLINE` block (`GetUnderlineSpecialCharacter` + `m_Underline.character`) now runs
    unconditionally (the define's version check can never match the uGUI-bundled TMP), `uvs0` is typed `Vector4[]`
    carrying the SDF scale in `w` (quad UVs built as `(u, v, 0, xScale)`, `Vector4.Lerp` for the interpolated
    corners), matching this TMP's own `DrawUnderlineMesh`.
- **Known quirks:** the vendor's own *GameObject > UI > Curved …* creation menu still adds a legacy
  `StandaloneInputModule` EventSystem — don't use that menu; build HUDs through `RootsDance > Build Helmet HUD (Test)`
  or by hand. Its `versionDefines` target the standalone TMP package, so `TMP_MANUALLY_GET_UNDERLINE` stays off with
  Unity 6's uGUI-bundled TMP (the modern underline path is the one that runs). Pointer raycasts hit the un-curved
  rects — fine for the non-interactive helmet HUD.

## IngameDebugConsole (yasirkula) — UPM package

Installed as a normal UPM package (`com.yasirkula.ingamedebugconsole`, via the OpenUPM scoped registry added to `Packages/manifest.json`), not vendored under `Assets/`. No exception needed — this is the preferred path per [09-packages-systems.md](guidelines/09-packages-systems.md); no entry required here.

## PSX First Person Arms (drillimpact) — art asset, `SourceArt/Blender/`

- **Licence: CC0** (public domain). Source: drillimpact, "PSX First Person Arms" on itch.io.
- **What is used:** `arms_rig_helmat.blend` — the rigged first-person arms, its 20 actions, and the
  512px `arms_01.png` sheet. `Arms.fbx`, `Arms_HelmetOff` and `Assets/RootsDance/Textures/Characters/Arms_BaseMap.png`
  all derive from it.
- **Local additions:** a non-deforming `helmet_socket` bone under `root`, driven by a Child Of
  constraint, added so the helmet hand-off is pure skeletal animation
  ([Blender → Unity 导出管线](architecture/tooling/Blender到Unity导出管线.md) §7).
- **Placeholder status:** the helmet in this file is a placeholder sphere, and its `Visor` material
  slot has no faces assigned. It is a stand-in until the real helmet model arrives.
- CC0 imposes no attribution requirement; this entry exists for provenance, not obligation.

## An Abandoned Garage (dasy444) — art asset, `SourceArt/Blender/Garage/`

- **Licence:** Sketchfab Free Standard. Source: dasy444, [An Abandoned Garage](https://sketchfab.com/3d-models/an-abandoned-garage-cae82b98d3654226a67ed05f2c927c99), model UID `cae82b98d3654226a67ed05f2c927c99`.
- **What is used:** `Assets/Garage_Shell.blend` supplies the laboratory walls, floor, broken ceiling, beams, trim, windows and door panel; `Assets/Ivy_Hanging.blend` supplies the eleven hanging-ivy meshes aligned to the ceiling openings.
- **Derived assets:** `Assets/RootsDance/Meshes/Environment/Garage/` contains the Unity FBX exports, `Assets/RootsDance/Textures/Environment/Garage/` contains the packed Blender images extracted for HDRP materials, and `SourceArt/Export/Garage/` contains reproducible export manifests.
- **Import note:** the source files were already present in project `SourceArt` and were used in preference to the separately downloaded Sketchfab archive. The export was regenerated with Blender 5.2.1; the manifests record the exact source and export settings.

## Chapter house (chapel) — art asset, `SourceArt/Blender/siii-lab-abstracted-cloth-landscape/`

- **Licence: UNVERIFIED — resolve before the asset ships in a build.** The download carries no
  licence file, and neither the archive nor the commit that added it (`1fbea22d`) records where it
  came from. What the files themselves say: the folder name is a Sketchfab model slug, the source
  blend is `alpha60CHAPEL_zzRENDERASKETCHFAB3spotlighttrimmerFINnolilghts.blend`, exported from
  Blender 2.83 on 2020-06-18, and the MTL's texture paths are the author's own machine
  (`C:\Users\onegr\...`). Whoever downloaded it should add the model URL, the author and the
  licence here, the way the Garage entry above does.
- **What is used:** `source/chapterhouseblue5/chapterhouseblue6.obj` — a chapel interior, 21
  material groups, 106,400 vertices — plus the 27 baked PNGs in `textures/`.
- **Derived assets:** `Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouse.obj` (the
  same mesh; the accompanying `ChapterHouse.mtl` is the authored one with its unresolvable absolute
  texture paths stripped, so the import logs no missing-texture warnings) and
  `Assets/RootsDance/Textures/Environment/ChapterHouse/`. Materials and both level scenes are
  generated by `RootsDance > Build Chapter House Interior`.
- **No local edits** to the source files.

## ambientCG — `Assets/ThirdParty/Environment/AmbientCG/`

- **Version/date:** downloaded 2026-08-26 from the ambientCG library.
- **Path:** `Assets/ThirdParty/Environment/AmbientCG/<Id>/` for `<Id>` ∈ {Ground103, Ground106, Grass003, Ground037, Concrete044D, Gravel043, Ground068, Ground086, Concrete032} (the last three added 2026-08-27 for the mud/humus terrain layers and the lab blockout normal map).
- **Licence:** CC0 1.0 Universal — see `AmbientCG/LICENSE.md` and `AmbientCG/SOURCE.md` (one record covering all nine ids).
- **No local edits.**
- **What's imported:** the `_Color` and `_NormalGL` 1K JPGs (imported by the Editor as sRGB colour / linear normal map respectively via `EnvironmentAssetPostprocessor`); the `_AmbientOcclusion`, `_Roughness` and `_Displacement` JPGs live in each `<Id>/Source~/` folder, which Unity's importer ignores (folder name ends in `~`) — they are read directly off disk by `RootsDance/Terrain/Pack Terrain Layer Masks` to bake `Assets/RootsDance/Textures/Environment/Terrain<LayerName>_Mask.png` (packed AO/Roughness/Displacement; the file is named after the terrain layer the id feeds, e.g. `Ground103` → `TerrainAshDry_Mask.png`), then never imported as their own textures.
- **Left out (spec decision 12):** the `.blend`/`.mtlx`/`.tres`/`.usdc` source files, the `_NormalDX` and `_Metalness` variants (Unity/HDRP samples OpenGL-convention normal maps and the terrain layers are non-metallic), and the preview `.png` thumbnail — none of these are consumed by the terrain layer pipeline. `` was imported for the trail layer in the first pass and removed in the Task 8 tuning pass when `Gravel043` took over that layer.

## Outdoor dressing packs (2026-08-27) — `Assets/ThirdParty/Environment/<Vendor>/`

Curated subsets of the team candidate library (`室外场景候选素材/素材总索引.md`), imported for the six Prefab World Builder
pools (DeadTree_Sparse, RootRock_Clutter, DryLowGrowth, Transition_Growth, BrokenBoundary, CampEvidence). Each vendor
folder carries its own `SOURCE.md` (exact file list, selection rationale) and `LICENSE.md`. Vendor files are verbatim;
the only derived data lives under `Assets/RootsDance/`.

| Folder | Vendor | Licence | What |
|---|---|---|---|
| `RetroPSXNature/` | elegantcrow, *Retro PSX Nature Pack* (itch.io) | **No licence text on the saved page** — index lists CC0; confirm on the live page before the submission build | Existing winter trees/bushes plus 12 grass meshes, 8 ordinary summer trees, 6 ordinary summer bushes and selected summer/winter alpha sheets |
| `NiwlPlants/` | Niwl-Games / Khaleer, *Plants* (itch.io) | CC0 1.0 | 8 grass patches, 2 ferns, 4 bushes, ivy 1–4/6–8, meadow, poppies, sunflower, 3 alder, 3 birch, pine and five shared atlases/bark maps |
| `PolyHaven/` | Poly Haven | CC0 1.0 | `Models/`: dead_tree_trunk(_02), dry_branches_medium_01, pine_roots, root_cluster_01/02, single_root, rock_moss_set_01/02, modular_chainlink_fence, concrete_road_barrier, clipboard, binder_notebook (1K). `Textures/`: brown_mud_02, aerial_ground_rock (AO/rough/disp in `Source~/`, same convention as ambientCG) |
| `LabAssetsCC0/` | MilkAndBanana via OpenGameArt *Lab Assets* | CC0 1.0 | 19 hand-held sampling/recording props (centimetre scale — the prefab table scales them by 0.01) |

- **Local edits (PolyHaven only):** the 22 `.exr` normal/roughness/metal maps were converted to 8-bit linear PNG
  (`exrmetrics` → `ffmpeg -apply_trc linear` → `magick -depth 8`; mean values verified against the float source, no
  gamma applied). Command and evidence in `PolyHaven/SOURCE.md`.
- **Derived textures** in `Assets/RootsDance/Textures/Environment/`: `ChainlinkFenceWire_BaseMap.png` (Poly Haven wire
  `_diff` + `_alpha` packed into RGBA with `magick … -compose CopyOpacity`) and `LabPalette_BaseMap.png` (the 256×1 palette
  strip every Lab Assets FBX embeds, extracted verbatim and tiled to 256×256 so the texture pipeline accepts it).
- **Import rules:** `EnvironmentAssetPostprocessor` — Retro PSX textures point-filtered/uncompressed, `_nor_` maps as
  normal maps, `_alpha_/_metal_/_rough` linear, Niwl models with calculated normals and no tangents.
- **Materials and prefabs:** `RootsDance > Environment > Build Environment Prefabs` (`EnvironmentPalette` +
  `EnvironmentPrefabTable` + `EnvironmentPrefabBuilder`) writes one **The Visual Engine** material per vendor texture set
  to `Assets/RootsDance/Materials/Environment/` (`General Standard Lit` for trees/props/scans, `General Subsurface Lit`
  for bush/plant cards; `TVEUtils.SetMaterialSettings` + the "The Visual Engine" label) and 133 prefabs to
  `Assets/RootsDance/Prefabs/Environment/{Vegetation,Heroes,Rocks,Facility,Props}/`. The 2026-08-29 increment keeps
  grass/flower meshes walk-through, gives ordinary trees a trunk capsule, and reuses the two Retro patch meshes for
  several palette-tint variants rather than duplicating source geometry. TVE's own Asset Converter is not
  used: it needs the separately sold *TVE Conversion Presets* package and, without a preset, replaces materials with
  blank ones. `RootsDance > Environment > Create TVE Manager Prefab` builds `Prefabs/Systems/TVEManager.prefab`; every
  Environment scene that uses these prefabs needs one instance (materials read wind/tint/wetness from it).
- **Prefab World Builder palettes** (2026-08-27): six palettes in PWB's data folder
  (`Assets/PluginMaster/DesignTools/Editor/PrefabWorldBuilder/Resources/Data/Palettes/PWB_*.txt` + thumbnail PNGs),
  one brush per prefab — `DeadTree_Sparse` (winter trees upright + embedded, winter bushes, dry branches),
  `RootRock_Clutter` (roots, moss rocks, dead trunks; surface-aligned, scale 0.7–1.3), `DryLowGrowth` (bush07/08,
  small grass patches), `Transition_Growth` (Niwl grass/fern/bush/ivy; surface-aligned, orient up), `BrokenBoundary`
  (fence, barrier; no random rotation/scale), `CampEvidence` (clipboard, binder, lab props). Generated once through the
  public `PluginMaster.PaletteManager`/`MultibrushSettings` API from an Editor eval (PWB has no asmdef, so
  `RootsDance.Editor` cannot reference it); edit them in *Tools > Plugin Master > Prefab World Builder > Palette* from
  now on.
- **Not imported because of licence vs. public repo:** *Barriers Retro PSX* (gataki) and *PSX Large Terrain Rock Pack 2*
  (Caliber Creations) both forbid redistributing their files, and `AmanThuL/shenicest-2026` is public — committing the
  FBX would be redistribution. Poly Haven's `concrete_road_barrier` and `modular_chainlink_fence` cover the boundary pool;
  rocks come from the two `rock_moss_set` scans until the repo goes private or the authors OK it. This remains true
  if the original rock materials/textures are discarded: the licence also protects the raw and modified meshes.

## Briggs interior artist picks (Sketchfab, 2026-08-29)

- **Path:** `Assets/ThirdParty/Environment/BriggsArtistPicks/`; per-model source and conversion notes are in `SOURCE.md`.
- **Licence:** CC BY 4.0. Original Sketchfab metadata is preserved in `Attribution/`.
- **Kitchen and Lab desk:** the Briggs central island uses only the `Kitchen_DeskBig_2` mesh from
  [Kitchen And Lab by Amogusstrikesback2](https://sketchfab.com/3d-models/kitchen-and-lab-by-amogusstrikesback2-e9fdbbfb929e4bf796fa81d250fe6d64),
  uploaded by @sanyabeast and crediting original creator amogusstrikesback2. The project retains both credits and the
  original-model URL from the supplied description. The included base map is a brighter, desaturated derivative of the
  downloaded baked texture.
- **Excluded references:** *Chemical Lab Fallout 4* and *Black Mesa Lab Props* remain out of the repository because of
  explicit third-party IP provenance. *Abandoned Lab Equipment*, *Mad Scientist Lab* and *Conspiracy Papers X-Lab*
  had no downloadable source mesh in the local archive.

## Greenhouse interior props (Sketchfab, 2026-08-29)

- **Path:** `Assets/ThirdParty/Environment/GreenhouseInteriorProps/`; complete work/author/source attribution and the
  local selection notes are in `SOURCE.md`, with the shared CC BY 4.0 terms in `LICENSE.md`.
- **Included:** 11 officially downloadable CC BY 4.0 works — Tropical Plants Pack M02P plus ten complementary fern
  assets. The M02P kit is split into 15 individual plants; the other works contribute one placement prefab each, for
  25 prefabs total.
- **Optimisation:** the PlantCatalog male fern imports the supplied LOD2/LOD4 meshes instead of the 126,070-triangle
  LOD0; common polypody imports LOD0/LOD2/LOD4. `GreenhouseInteriorPropsBuilder` creates both `LODGroup` prefabs,
  normalises the remaining models to useful interior heights, keeps all foliage walk-through, disables foliage shadow
  casting, and maps every renderer to project-owned The Visual Engine materials.
- **Derived data:** channel-packed albedo/opacity PNGs live under
  `Assets/RootsDance/Textures/Environment/GreenhouseInteriorProps/`; generated materials and prefabs live in the
  matching `Materials/Environment/GreenhouseInteriorProps/` and `Prefabs/Environment/GreenhouseInteriorProps/`
  folders. PWB's shared `GreenhouseInteriorProps` palette contains one preconfigured brush per prefab (embedded,
  upright, random 360-degree yaw, uniform scale 0.85–1.15).
- **Not imported:** *Tree Fern 2* and *Tropical Vegetation* have author-disabled downloads. Their candidate metadata
  was retained, but no model data is present and no download restriction was bypassed.

## Kenney Particle Pack (Kenney) — `Assets/ThirdParty/VFX/KenneyParticlePack/`

- **Version:** 1.1. Downloaded 2026-08-27 from <https://kenney.nl/assets/particle-pack>; record in the folder's `SOURCE.md`.
- **Licence:** CC0 1.0 (`LICENSE.txt` in the folder) — public-domain dedication, commercial use allowed, credit optional.
- **Copied:** only `circle_05.png` and `light_01.png` (the soft-blob and soft-glow sprites) out of 80; the rest can be
  copied from the same zip when a VFX needs them.
- **No local edits.**
- **Usage:** colour + emissive maps of the generated opening-atmosphere particle materials
  (`Assets/RootsDance/VFX/VFX_ContaminationMotes.mat`, `VFX_AnomalousSpores.mat`, written by
  `OpeningVfxPrefabBuilder`); see [07](guidelines/07-rendering-hdrp.md) §6 for the opening volumes.

## ambientCG — Paper001（旧档案纸张扫描）

- **路径**：`Assets/ThirdParty/Textures/AmbientCG/`（`Color` / `NormalGL` / `Roughness`，2048²，可平铺）
- **来源**：<https://ambientcg.com/view?id=Paper001>，取自 `Paper001_2K-JPG.zip`，2026-08-29 下载
- **授权**：**CC0 1.0（公有领域）** —— 可商用，无需署名
- **用途**：作为**源素材**被 `ArchivePaperTextureBaker` 读取，合成进
  `Assets/RootsDance/Textures/Props/ArchivePaper_*`。按 AGENTS.md 规定**不在原地修改**。
- **为什么引入**：纸面原本整张是 Perlin 噪声，无论频率怎么调都读成一团棕雾 ——
  真实纸纤维是各个尺度都有结构的照片纹理，带限噪声没有。做旧（污渍、霉斑、撕边）仍然是程序生成的，
  只是现在叠在一张真实扫描上，而不是替代它。
