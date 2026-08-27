"""Stage: validate_final_asset  --  the gate before anything reaches Unity.

Runs on plain system Python 3 with no third-party packages and no Blender, so
it can run in CI or a pre-commit hook.  It reads the PNG headers itself rather
than pulling in Pillow.

What it checks, all from the filesystem and the file bytes -- never a screenshot:

  * every map the preset requires exists, for every texture set
  * file names parse under the project naming convention (guideline 02)
  * dimensions match the preset, are square and power-of-two
  * bit depth and colour type are what Unity expects
  * maps that must carry alpha actually have an alpha channel
    (HDRP Lit reads smoothness out of the mask map's alpha)
  * no stray files in the texture folder that look like a failed export
  * the mesh the textures belong to exists

Run:
    python3 Tools/pipeline/stages/validate_textures.py \
        --asset Helmet --texture-set HelmetShell --texture-set HelmetVisor \
        --preset psx_prop --textures Assets/RootsDance/Textures/Props \
        --mesh Assets/RootsDance/Meshes/Props/Helmet.fbx \
        --report Build/pipeline/Helmet/validate_final_asset.json
"""

import argparse
import os
import struct
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import naming

PNG_SIG = b"\x89PNG\r\n\x1a\n"

# PNG colour types -> (name, has_alpha)
COLOR_TYPES = {
    0: ("greyscale", False),
    2: ("truecolour", False),
    3: ("indexed", False),
    4: ("greyscale+alpha", True),
    6: ("truecolour+alpha", True),
}


def read_png_header(path):
    """Return dict of PNG facts, or raise ValueError. Pure stdlib."""
    with open(path, "rb") as fh:
        sig = fh.read(8)
        if sig != PNG_SIG:
            raise ValueError("not a PNG (bad signature)")
        length = struct.unpack(">I", fh.read(4))[0]
        ctype = fh.read(4)
        if ctype != b"IHDR":
            raise ValueError("first chunk is %r, not IHDR" % ctype)
        data = fh.read(length)
        w, h, bit_depth, color_type, _comp, _filt, interlace = struct.unpack(
            ">IIBBBBB", data[:13])
        fh.read(4)  # CRC

        chunks = []
        while True:
            head = fh.read(8)
            if len(head) < 8:
                break
            ln, ct = struct.unpack(">I", head[:4])[0], head[4:8]
            chunks.append(ct.decode("ascii", "replace"))
            if ct == b"IDAT" or ct == b"IEND":
                break
            fh.seek(ln + 4, os.SEEK_CUR)

    name, has_alpha = COLOR_TYPES.get(color_type, ("unknown", False))
    return {
        "width": w, "height": h, "bit_depth": bit_depth,
        "color_type": color_type, "color_type_name": name,
        "has_alpha": has_alpha, "interlace": interlace,
        "chunks": chunks,
        "has_srgb_chunk": "sRGB" in chunks,
        "bytes": os.path.getsize(path),
    }


def is_pot(n):
    return n > 0 and (n & (n - 1)) == 0


def parse_args():
    p = argparse.ArgumentParser(prog="validate_textures")
    p.add_argument("--asset", required=True)
    p.add_argument("--texture-set", action="append", required=True, dest="sets")
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--textures", required=True, help="texture directory")
    p.add_argument("--mesh", default=None, help="the .fbx these textures belong to")
    p.add_argument("--report", default=None)
    p.add_argument("--strict-extra", action="store_true",
                   help="treat unrecognised files in the texture dir as errors")
    return p.parse_args()


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    res = preset["texture"]["resolution"]
    maps = preset["texture"]["maps"]
    tex_dir = os.path.abspath(args.textures)

    r = rep.Report("validate_final_asset", asset=args.asset, inputs={
        "preset": preset["_name"], "expected_resolution": res,
        "expected_maps": maps, "texture_sets": args.sets,
        "textures": tex_dir, "mesh": args.mesh,
    })

    # --- mesh ------------------------------------------------------------
    if args.mesh:
        if os.path.isfile(args.mesh):
            r.info("mesh.present", os.path.basename(args.mesh),
                   "%s exists (%d bytes)"
                   % (args.mesh, os.path.getsize(args.mesh)))
        else:
            r.error("mesh.missing", args.mesh,
                    "the mesh these textures belong to does not exist")

    if not os.path.isdir(tex_dir):
        r.error("textures.dir_missing", tex_dir, "texture directory does not exist")
        r.emit(args.report, exit_on_error=True)
        return

    expected = set()
    for ts in args.sets:
        for m in maps:
            expected.add(naming.texture_filename(ts, m))

    # --- required files --------------------------------------------------
    for fname in sorted(expected):
        path = os.path.join(tex_dir, fname)
        if not os.path.isfile(path):
            r.error("texture.missing", fname,
                    "required map is not in %s" % tex_dir)
            continue
        try:
            hdr = read_png_header(path)
        except ValueError as e:
            r.error("texture.unreadable", fname, "cannot read PNG header: %s" % e)
            continue

        ts, m, _ext = naming.parse_texture_filename(fname)

        if hdr["width"] != res or hdr["height"] != res:
            r.error("texture.resolution", fname,
                    "is %dx%d, preset %s requires %dx%d"
                    % (hdr["width"], hdr["height"], preset["_name"], res, res),
                    got=[hdr["width"], hdr["height"]], expected=[res, res])
        if hdr["width"] != hdr["height"]:
            r.error("texture.not_square", fname,
                    "%dx%d is not square" % (hdr["width"], hdr["height"]))
        if not is_pot(hdr["width"]) or not is_pot(hdr["height"]):
            r.error("texture.not_pot", fname,
                    "%dx%d is not power-of-two; guideline 05 section 7.1 requires "
                    "POT for GPU compression"
                    % (hdr["width"], hdr["height"]))
        if hdr["bit_depth"] not in (8, 16):
            r.error("texture.bit_depth", fname,
                    "bit depth %d; expected 8 (or 16 for height/normal)"
                    % hdr["bit_depth"])
        if hdr["interlace"]:
            r.error("texture.interlaced", fname,
                    "PNG is interlaced; Unity does not want interlaced textures")
        if m in naming.ALPHA_REQUIRED_MAPS and not hdr["has_alpha"]:
            r.error("texture.alpha_missing", fname,
                    "%s has no alpha channel (colour type %d, %s), but HDRP Lit "
                    "reads smoothness from the mask map's alpha "
                    "(Mask = R metallic, G AO, B detail, A smoothness)"
                    % (m, hdr["color_type"], hdr["color_type_name"]))
        if hdr["color_type"] == 3:
            r.error("texture.indexed", fname,
                    "indexed-colour PNG; Unity import is unreliable, export "
                    "truecolour")

        r.info("texture.header", fname,
               "%dx%d, %d-bit %s, alpha %s, %s, %d bytes"
               % (hdr["width"], hdr["height"], hdr["bit_depth"],
                  hdr["color_type_name"], hdr["has_alpha"],
                  "sRGB in Unity" if naming.is_srgb(m) else "linear in Unity",
                  hdr["bytes"]),
               texture_set=ts, map=m, srgb=naming.is_srgb(m), **{
                   k: hdr[k] for k in ("width", "height", "bit_depth",
                                       "color_type_name", "has_alpha")})

    # --- stray files -----------------------------------------------------
    present = {f for f in os.listdir(tex_dir)
               if not f.startswith(".") and not f.endswith(".meta")}
    extra = sorted(present - expected)
    for f in extra:
        try:
            ts, m, _ = naming.parse_texture_filename(f)
            if ts in args.sets and m not in maps:
                r.warn("texture.unexpected_map", f,
                       "%s is a valid name but preset %s does not list map %s"
                       % (f, preset["_name"], m))
            else:
                r.info("texture.other_asset", f,
                       "belongs to another asset (texture set %s)" % ts)
        except naming.NameError_ as e:
            sev = r.error if args.strict_extra else r.warn
            sev("texture.bad_name", f,
                "file in the texture folder does not follow "
                "<Asset>_<Map>.png: %s" % e)

    # --- summary ---------------------------------------------------------
    r.info("summary", args.asset,
           "%d texture set(s) x %d map(s) = %d required file(s), preset %s at %dpx"
           % (len(args.sets), len(maps), len(expected), preset["_name"], res))

    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()
