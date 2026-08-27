# Lab Assets (OpenGameArt) — source record

- **Vendor / author:** MilkAndBanana (creator; pack dated 2022-01-31), uploaded to OpenGameArt by user `kooow`
- **URL:** <https://opengameart.org/content/lab-assets> (download: `https://opengameart.org/sites/default/files/lab_assets.zip`,
  SHA-256 `5202bc6759e19c43f513b848e5cf2e28136f71a0eb9355f50b0c0ac4873dd515`)
- **Licence:** CC0 1.0 Universal (see `LICENSE.md`)
- **Downloaded:** 2026-08-27 (copied from the team candidate library `02_风格补充/OpenGameArt/LabAssets_CC0/`)
- **Copied files** (19 of the pack's 140 `FBX/All/*.fbx`, vendor file names kept, flat in `Models/`):
  - `Models/bottle_test_tube_rack.fbx`
  - `Models/bottle_glassware_test_tube_medium.fbx`
  - `Models/bottle_glassware_test_tube_small.fbx`
  - `Models/bottle_glassware_vial_medium.fbx`
  - `Models/bottle_glassware_reagent_bottle_medium.fbx`
  - `Models/bottle_glassware_reagent_bottle_small.fbx`
  - `Models/bottle_glassware_centrifuge_tube.fbx`
  - `Models/bottle_dropper.fbx`
  - `Models/bottle_plastic_bottle_medium.fbx`
  - `Models/dish_petridish.fbx`
  - `Models/dish_watch_glass.fbx`
  - `Models/misc_wash_bottle.fbx`
  - `Models/misc_scale.fbx`
  - `Models/misc_magnifying_glass.fbx`
  - `Models/heating_equipment_thermometer.fbx`
  - `Models/heating_equipment_forceps.fbx`
  - `Models/clamp_tube_clamp.fbx`
  - `Models/ppe_rubber_gloves.fbx`
  - `Models/ppe_safety_glasses.fbx`

Copied verbatim from the team candidate library; no local edits. The pack's `GLB/` variants, `Preview.png`,
`desktop.ini` and the social `*.url` shortcuts were not copied.

## Textures / vertex colours

- The FBX files (binary FBX 7.4) carry **no vertex colours** (no `LayerElementColor`) and reference **no external
  texture files**.
- Every FBX **embeds the same 256×1 RGB palette PNG** (`PastedImage220104-201001.png`, 731 bytes, identical in all
  19 files); the meshes are UV-mapped onto that palette strip through a single Phong material with a
  base-colour texture slot. The pack's only loose PNG (`Preview.png`, 1280×720) is a preview image, not a texture.
- In Unity: import with *Materials > Extract Textures…* (or leave the texture embedded) and build one shared HDRP/Lit
  material from the extracted palette; the candidate-library note recommends darkening/desaturating it so the props do
  not read as a bright cartoon lab.

## Selection rationale

Small hand-held sampling and recording tools that an evacuated field-survey camp would leave behind: test tubes, vials,
reagent and plastic bottles, a dropper, petri dish and watch glass, wash bottle, scale, magnifying glass, thermometer,
forceps, a tube clamp, rubber gloves and safety glasses. Large furniture and machines (counters, cabinets, centrifuge,
microscope, hot plate, desiccator, burners, stands) were deliberately excluded.
