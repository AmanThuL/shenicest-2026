# Tools/blender

Generic Blender → Unity FBX exporter.

**Read [docs/architecture/tooling/Blender到Unity导出管线.md](../../docs/architecture/tooling/Blender到Unity导出管线.md)
first.** That document is the specification: why this exists rather than Unity's native `.blend`
import (with the measurements), the constraint-baking findings, the socket decision, the acceptance
checklist. This file only says how to run the code.

## Layout

```
export_fbx.py              the exporter; knows no asset names
generate_static_lod.py     deterministic FBX decimation for static-mesh LODs
generate_spider_silk.py    parameterised procedural spider silk (swept-tube geometry)
generate_mycelium.py       parameterised procedural mycelium; fills a volume, breathes
validate_wrist.py          per-frame joint-rotation validator; knows no asset names
profiles/fps_arms.json     skinned + animated: bake every frame, no decimation
profiles/static_prop.json  static prop: no animation baked
profiles/shapekey_loop.json  no armature: bakes shape-key (blend shape) animation
```

The Unity half lives in `Tools/unity/model_import_profiles.json` and
`Assets/RootsDance/Scripts/Editor/Pipeline/`.

## Generate procedural spider silk

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  --python Tools/blender/generate_spider_silk.py -- --preset web --seed 11
```

`--preset web | study | all`; every numeric key of the script's `PARAMS` dict is also a
flag (`--cone-depth`, `--droplet-dropout`, `--loose-ends`, …). The defaults produce a
derelict web; the script header lists the numbers for a web still in service. Inside a
running Blender, `exec(open(...).read())` then call `generate("web")`.

## Generate procedural mycelium

Grows into a measured volume, lands on whatever mesh is already there (raycast; the existing
model is only read), branches, fuses, and breathes via two shape keys. Parameters are in
**Unity world metres**; the layout knobs are documented in the script header.

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  SourceArt/Corridor/RootsDance_Corridor_Blockout.blend \
  --python-expr "g={'__name__':'gen','__file__':'Tools/blender/generate_mycelium.py'}; exec(compile(open(g['__file__']).read(), g['__file__'], 'exec'), g); g['generate']()"
```

`--emit-cords 1` draws the rhizomorph scaffold as well; `--clip 0` lifts the containment that
keeps growth out of the floor slab and out of `avoid_boxes` (the metal bridge, by default).

## Export one asset

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  /path/to/source.blend \
  --python Tools/blender/export_fbx.py -- \
  --project-root . \
  --output Assets/RootsDance/Meshes/Characters/Arms.fbx \
  --objects ArmsMesh,ArmsRig,Helmet_Placeholder \
  --armature ArmsRig \
  --action helmet_off \
  --profile Tools/blender/profiles/fps_arms.json \
  --manifest SourceArt/Export/Arms.export.json
```

Run it from the Unity project root, which is what `--project-root .` refers to.

## Arguments

| | |
|---|---|
| `--output` | required; the FBX to write |
| `--objects` *or* `--selection` | exactly one is required |
| `--armature` | required only with `--action` / `--actions`; inferred when the export contains exactly one armature |
| `--action` / `--actions` | mutually exclusive; `--actions a,b` writes `Name_a.fbx`, `Name_b.fbx` |
| `--profile` | JSON merged over the built-in defaults |
| `--manifest` | provenance sidecar the Unity Editor reads |
| `--project-root` | see below |
| `--frame-start` / `--frame-end` | override the Action's own range |

## Path semantics

* **With `--project-root`** relative paths resolve against the project root, and the manifest
  records paths relative to it. This is how the pipeline runs, and it is why the manifest contains
  no machine-specific paths.
* **Without it** relative paths resolve against the `.blend`'s own directory. `--output Assets/…`
  then writes next to the `.blend`, which is almost never intended.
* Absolute paths are always taken as given. The script itself contains no absolute path.

## Two things it will not do

* **It will never export every Action.** A `.blend` commonly holds dozens; the arms file holds 20.
  Name what ships with `--action` / `--actions`.
* **It will not export Empties.** `object_types` is fixed to `ARMATURE` + `MESH`, and
  `use_selection` is forced on, so only what you named is written.

## Validate joint rotations (broken wrists)

Recurring failure mode: an Action poses a hand far beyond what a wrist can do
(the hand copies its IK target's orientation and nothing stops it), and the break
is only noticed while scrubbing. `validate_wrist.py` sweeps every frame of the
named Actions, decomposes each child joint's rotation relative to its parent into
twist + swing, and exits non-zero when a frame exceeds the limits — run it before
delivering animation changes:

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  SourceArt/Blender/ArmsRig/arms_rig_all.blend \
  --python Tools/blender/validate_wrist.py -- \
  --armature ArmsRig \
  --joints forearm.R:hand.R,forearm.L:hand.L \
  --max-twist 92 --max-swing 85
```

Omit `--actions` to check every Action in the file. Exit codes: 0 clean,
2 violations, 1 usage error. The file is evaluated as saved, so stored-pose
pollution (scrubbing one Action, then saving while another is active) is caught
too. The arms rig additionally carries `WristLimit` (Limit Rotation) constraints
on `hand.R`/`hand.L` (±80° flex, ±90° pronation, ±40° deviation) that clamp
every Action at evaluation time; the validator thresholds sit just above those
limits, so a regression means someone removed or muted the constraints.

## Notes

* Action names go into filenames verbatim: `--actions jab.L` produces `Arms_jab.L.fbx`, whose dot
  breaks the asset naming rule in guidelines/02. Rename such Actions in Blender before delivery.
* The source `.blend` is opened read-only; the exporter never writes back to it.
* Requires Blender 4.5.3 LTS. No third-party Python packages.

## Generate a static-mesh LOD

`generate_static_lod.py` imports an FBX, applies the same proportional Decimate ratio to every mesh,
triangulates the result and exports only the mesh objects. Object and material names remain intact so
Unity-side material remapping continues to work.

```bash
blender --background --factory-startup --python Tools/blender/generate_static_lod.py -- \
  --project-root . \
  --source Assets/ThirdParty/Environment/PolyHaven/Models/root_cluster_01/root_cluster_01_1k.fbx \
  --output Assets/RootsDance/Meshes/Environment/Roots/RootCluster01_LOD1.fbx \
  --target-triangles 25000
```

The script fails when the result differs from the target by more than 10%. Inspect silhouette, UVs,
normals and thin disconnected pieces in Blender or Unity before accepting an automatically generated LOD.
