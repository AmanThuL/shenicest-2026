# Tools/pipeline

Blender → Substance Painter → Unity texture pipeline.

**Read [docs/architecture/tooling/贴图管线.md](../../docs/architecture/tooling/贴图管线.md) first.**
That document is the specification: environment findings, directory layout, naming
convention, presets, the Painter contract, Unity import rules, version-control policy
and the vertical-slice results. This file only says how to run the code.

## Run the whole pipeline for one asset

```bash
python3 Tools/pipeline/run_asset.py Tools/pipeline/assets/Helmet.json
```

The Painter stage talks to Substance 3D Painter's remote-scripting server, so Painter has
to be running with it enabled first:

```bash
"/Applications/Adobe Substance 3D Painter/Adobe Substance 3D Painter.app/Contents/MacOS/Adobe Substance 3D Painter" --enable-remote-scripting
```

Check the connection and record the API surface of that build before trusting it:

```bash
python3 Tools/pipeline/painter/painter_probe.py --out Build/pipeline/painter_probe.json
```

Run one stage only:

```bash
python3 Tools/pipeline/run_asset.py Tools/pipeline/assets/Helmet.json --only asset_inspect
```

Reports land in `Build/pipeline/<Asset>/*.json` (gitignored). Any stage exiting non-zero
stops the run.

## Layout

```
rdpipe/          shared core, stdlib only (naming, report, presets, blender helpers)
stages/          one file per stage
painter/         painter_remote.py (remote-scripting client) + painter_probe.py
presets/         psx_prop, psx_character, realistic_prop (JSON, not YAML -- Blender
                 bundles no PyYAML)
assets/          one JSON per asset describing source, repairs and texture sets
run_asset.py     the runner
```

## Adding an asset

Copy `assets/Helmet.json`, point `source.blend` and `source.object` at the mesh, list the
material slots, pick a preset. Then run `--only asset_inspect` first and read the report:
it tells you what `asset_prepare` needs to be allowed to repair. Every repair is opt-in by
flag; nothing is fixed silently.

## Requirements

* Blender 4.5.3 LTS at `/Applications/Blender.app` (override with `RD_BLENDER`)
* Python 3 for `validate_textures.py` and the runner
* No third-party Python packages

## Safety

* The artist's source `.blend` is opened read-only and never written back.
  `asset_prepare` refuses when `--out` equals the input path.
* `asset_inspect` never modifies anything.
* `export_mesh` re-imports the FBX it just wrote and diffs it against what was meant to go
  out. Keep this on; it is what caught the animated-transform bug documented in section 6
  of the specification.
