# Tools/blender

Generic Blender → Unity FBX exporter.

**Read [docs/architecture/tooling/Blender到Unity导出管线.md](../../docs/architecture/tooling/Blender到Unity导出管线.md)
first.** That document is the specification: why this exists rather than Unity's native `.blend`
import (with the measurements), the constraint-baking findings, the socket decision, the acceptance
checklist. This file only says how to run the code.

## Layout

```
export_fbx.py              the exporter; knows no asset names
validate_wrist.py          per-frame joint-rotation validator; knows no asset names
profiles/fps_arms.json     skinned + animated: bake every frame, no decimation
profiles/static_prop.json  static prop: no animation baked
```

The Unity half lives in `Tools/unity/model_import_profiles.json` and
`Assets/RootsDance/Scripts/Editor/Pipeline/`.

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
