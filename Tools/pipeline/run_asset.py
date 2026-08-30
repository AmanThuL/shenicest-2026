#!/usr/bin/env python3
"""Run the pipeline for one asset, described by a JSON config.

Each stage is a separate process with explicit inputs and outputs.  The runner
does not do any work of its own; it wires stages together and stops at the
first failure, so a red stage cannot be papered over by a later green one.

The Painter stage drives Substance 3D Painter over its remote-scripting
server, so Painter must already be running with --enable-remote-scripting
(see docs/architecture/tooling/贴图管线.md section 7).  Nothing here automates
a GUI.

    python3 Tools/pipeline/run_asset.py Tools/pipeline/assets/Helmet.json
    python3 Tools/pipeline/run_asset.py Tools/pipeline/assets/Helmet.json --only asset_inspect
"""

import argparse
import json
import os
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PIPE = os.path.join(ROOT, "Tools", "pipeline")

BLENDER = os.environ.get(
    "RD_BLENDER", "/Applications/Blender.app/Contents/MacOS/Blender")


def rel(*parts):
    return os.path.join(ROOT, *parts)


def run(cmd, label, allow_fail=False):
    print("\n" + "-" * 72)
    print(">>> %s" % label)
    print("-" * 72)
    proc = subprocess.run(cmd)
    if proc.returncode != 0:
        if allow_fail:
            print("\n(diagnostic stage %r reported problems -- continuing, "
                  "because repairing them is the next stage's job)" % label)
            return proc.returncode
        print("\n!!! stage %r failed with exit code %d -- stopping."
              % (label, proc.returncode))
        sys.exit(proc.returncode)
    return 0


def main():
    ap = argparse.ArgumentParser(prog="run_asset")
    ap.add_argument("config")
    ap.add_argument("--only", action="append", default=[],
                    help="run only these stages; repeatable")
    ap.add_argument("--overwrite", action="store_true", default=True)
    args = ap.parse_args()

    with open(args.config) as fh:
        cfg = json.load(fh)

    asset = cfg["asset"]
    category = cfg["category"]
    preset = cfg["preset"]
    src_blend = os.path.normpath(os.path.join(ROOT, cfg["source"]["blend"]))
    src_object = cfg["source"]["object"]
    sets = cfg["texture_sets"]

    work_blend = rel("SourceArt", "Blender", asset, "%s.blend" % asset)
    fbx = rel("Assets", "RootsDance", "Meshes", category, "%s.fbx" % asset)
    tex_dir = rel("Assets", "RootsDance", "Textures", category)
    reports = rel("Build", "pipeline", asset)

    def want(name):
        return not args.only or name in args.only

    def rep(name):
        return os.path.join(reports, "%s.json" % name)

    if not os.path.isfile(src_blend):
        print("source .blend not found: %s" % src_blend)
        sys.exit(2)

    # 1. inspect the source, read only
    if want("asset_inspect"):
        run([BLENDER, "-b", src_blend, "--python",
             os.path.join(PIPE, "stages", "asset_inspect.py"), "--",
             "--object", src_object, "--asset", asset, "--preset", preset,
             "--report", rep("asset_inspect_source")],
            "asset_inspect (source, read-only -- errors here are expected on "
            "raw art and tell asset_prepare what to repair)",
            allow_fail=True)

    # 2. explicit repair into a derived file
    if want("asset_prepare"):
        p = cfg.get("prepare", {})
        cmd = [BLENDER, "-b", src_blend, "--python",
               os.path.join(PIPE, "stages", "asset_prepare.py"), "--",
               "--object", src_object, "--asset", asset, "--preset", preset,
               "--out", work_blend, "--report", rep("asset_prepare")]
        for flag, key in (("--apply-rotation", "apply_rotation"),
                          ("--apply-scale", "apply_scale"),
                          ("--to-origin", "to_origin"),
                          ("--strip-animation", "strip_animation")):
            if p.get(key):
                cmd.append(flag)
        if p.get("merge_doubles"):
            cmd += ["--merge-doubles", str(p["merge_doubles"])]
        if p.get("delete_duplicate_faces"):
            cmd.append("--delete-duplicate-faces")
        if p.get("delete_degenerate"):
            cmd.append("--delete-degenerate")
        if p.get("drop_empty_slots"):
            cmd.append("--drop-empty-slots")
        for old_new in p.get("rename_slots", []):
            cmd += ["--rename-slot", old_new]
        for slot in p.get("material_slots", []):
            cmd += ["--slot", slot]
        if args.overwrite:
            cmd.append("--overwrite")
        run(cmd, "asset_prepare")

    # 3. UV
    if want("uv_prepare"):
        run([BLENDER, "-b", work_blend, "--python",
             os.path.join(PIPE, "stages", "uv_prepare.py"), "--",
             "--object", asset, "--preset", preset,
             "--mode", cfg.get("uv", {}).get("mode", "preserve"),
             "--out", work_blend, "--report", rep("uv_prepare")],
            "uv_prepare")

    # 4. re-inspect the prepared asset; this one must be clean
    if want("asset_inspect_prepared"):
        run([BLENDER, "-b", work_blend, "--python",
             os.path.join(PIPE, "stages", "asset_inspect.py"), "--",
             "--object", asset, "--asset", asset, "--preset", preset,
             "--report", rep("asset_inspect_prepared")],
            "asset_inspect (prepared -- must be clean)")

    # 5. FBX out, with round-trip verification
    if want("export_mesh"):
        run([BLENDER, "-b", work_blend, "--python",
             os.path.join(PIPE, "stages", "export_mesh.py"), "--",
             "--object", asset, "--asset", asset, "--preset", preset,
             "--out", fbx, "--report", rep("export_mesh")],
            "export_mesh (+ FBX round-trip verification)")

    # 6. Substance Painter: create project, bake mesh maps, export PBR.
    #    Painter must already be running with --enable-remote-scripting; the
    #    stage talks to its JSON server, never to its GUI.
    if want("painter"):
        cmd = [sys.executable,
               os.path.join(PIPE, "stages", "painter_texture.py"),
               "--asset", asset, "--preset", preset,
               "--mesh", fbx, "--out", tex_dir,
               "--project", rel("SourceArt", "Painter", asset + ".spp"),
               "--report", rep("painter_texture")]
        for layer in cfg.get("painter", {}).get("layers", []):
            cmd += ["--layer", layer]
        for fill in cfg.get("painter", {}).get("fills", []):
            cmd += ["--fill", fill]
        run(cmd, "painter_texture (create + bake + author + export over remote "
                 "scripting)")

    # 7. back into Blender
    if want("import_material"):
        run([BLENDER, "-b", work_blend, "--python",
             os.path.join(PIPE, "stages", "import_material.py"), "--",
             "--object", asset, "--asset", asset, "--textures", tex_dir,
             "--preset", preset, "--out", work_blend,
             "--report", rep("import_material")],
            "import_blender_material")

    # 8. final gate
    if want("validate"):
        cmd = [sys.executable,
               os.path.join(PIPE, "stages", "validate_textures.py"),
               "--asset", asset, "--preset", preset, "--textures", tex_dir,
               "--mesh", fbx, "--report", rep("validate_final_asset")]
        for ts in sets:
            cmd += ["--texture-set", ts]
        run(cmd, "validate_final_asset")

    print("\n" + "=" * 72)
    print("pipeline complete for %s -- reports in %s"
          % (asset, os.path.relpath(reports, ROOT)))
    print("=" * 72)


if __name__ == "__main__":
    main()
