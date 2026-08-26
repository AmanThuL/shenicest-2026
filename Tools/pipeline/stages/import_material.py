"""Stage: import_blender_material  --  reconnect exported textures in Blender.

Given a directory of textures named by the project convention
(<Set>_BaseMap.png, <Set>_Normal.png, ...), find the matching material on the
object, build the node graph, and wire it into Principled BSDF with the right
colour spaces.  No GUI, no manual node dragging.

The colour-space rules are the ones that actually break renders:

  * BaseMap and Emission are sRGB.
  * Normal, Metallic, Occlusion, Height are Non-Color.  A data map left on
    sRGB is gamma-decoded and shades wrong.
  * The metallic map's ALPHA is smoothness (URP Lit convention), so Blender's
    Roughness input gets 1 - alpha.  Wiring alpha straight to Roughness would
    invert the material.
  * Normal maps go through a Normal Map node, never straight into the shader.

Run:
    blender -b SourceArt/Blender/Helmet/Helmet.blend \
        --python Tools/pipeline/stages/import_material.py -- \
        --object Helmet --textures Assets/RootsDance/Textures/Props \
        --preset psx_prop --out SourceArt/Blender/Helmet/Helmet.blend \
        --report Build/pipeline/Helmet/import_material.json
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import bpy

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import naming
from rdpipe import blendutil as bu

# Node layout, so a human opening the file sees something readable.
COL_TEX = -900
COL_HELP = -450
ROW = {"BaseMap": 400, "Metallic": 100, "Occlusion": -150,
       "Normal": -400, "Emission": 650, "Height": -700, "Specular": -950}


def parse_args():
    p = argparse.ArgumentParser(prog="import_material")
    p.add_argument("--object", required=True)
    p.add_argument("--textures", required=True)
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--asset", default=None)
    p.add_argument("--out", required=True)
    p.add_argument("--report", default=None)
    p.add_argument("--allow-missing", action="store_true",
                   help="warn instead of failing when a map the preset lists "
                        "has no file on disk")
    return p.parse_args(bu.stage_argv())


def find_bsdf(mat, report):
    nt = mat.node_tree
    for n in nt.nodes:
        if n.type == "BSDF_PRINCIPLED":
            return n
    out = None
    for n in nt.nodes:
        if n.type == "OUTPUT_MATERIAL":
            out = n
    bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
    bsdf.location = (0, 300)
    if out is None:
        out = nt.nodes.new("ShaderNodeOutputMaterial")
        out.location = (400, 300)
    nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
    report.info("material.bsdf_created", mat.name,
                "material had no Principled BSDF; created one and linked it to "
                "the Material Output")
    return bsdf


def clear_pipeline_nodes(nt):
    """Remove nodes this stage created on a previous run, so re-running is
    idempotent instead of stacking duplicate graphs."""
    doomed = [n for n in nt.nodes if n.get("rd_pipeline")]
    for n in doomed:
        nt.nodes.remove(n)
    # Drop image datablocks nothing references any more, so a re-run against a
    # different texture directory does not leave "Foo_BaseMap.png.001" behind.
    for img in list(bpy.data.images):
        if img.users == 0 and not img.use_fake_user:
            bpy.data.images.remove(img)
    return len(doomed)


def tag(node):
    node["rd_pipeline"] = True
    return node


def load_image(path, srgb, report):
    img = bpy.data.images.load(path, check_existing=True)
    img.colorspace_settings.name = "sRGB" if srgb else "Non-Color"
    if img.colorspace_settings.name != ("sRGB" if srgb else "Non-Color"):
        report.error("texture.colorspace", os.path.basename(path),
                     "could not set colour space to %s"
                     % ("sRGB" if srgb else "Non-Color"))
    return img


def wire(obj, tex_dir, preset, args, report):
    maps = preset["texture"]["maps"]
    asset = args.asset or obj.name

    if not obj.material_slots:
        report.error("material.no_slots", obj.name,
                     "object has no material slots; nothing to wire textures into")
        return

    for slot in obj.material_slots:
        mat = slot.material
        if mat is None:
            report.error("material.empty_slot", obj.name,
                         "material slot is empty")
            continue
        try:
            ts = naming.texture_set_for_material(asset, mat.name)
        except naming.NameError_ as e:
            report.error("material.bad_name", mat.name, str(e))
            continue

        mat.use_nodes = True
        nt = mat.node_tree
        removed = clear_pipeline_nodes(nt)
        if removed:
            report.info("material.reset", mat.name,
                        "removed %d node(s) from a previous pipeline run "
                        "(re-running is idempotent)" % removed)

        bsdf = find_bsdf(mat, report)
        wired = []

        for m in maps:
            fname = naming.texture_filename(ts, m)
            path = os.path.join(tex_dir, fname)
            if not os.path.isfile(path):
                sev = report.warn if args.allow_missing else report.error
                sev("texture.missing", fname,
                    "preset %s lists map %s but %s is not on disk"
                    % (preset["_name"], m, path))
                continue

            img = load_image(path, naming.is_srgb(m), report)
            tex = tag(nt.nodes.new("ShaderNodeTexImage"))
            tex.image = img
            tex.label = "%s %s" % (ts, m)
            tex.location = (COL_TEX, ROW.get(m, 0))

            if m == "BaseMap":
                nt.links.new(tex.outputs["Color"], bsdf.inputs["Base Color"])
                wired.append("BaseMap -> Base Color (sRGB)")

            elif m == "Normal":
                nm = tag(nt.nodes.new("ShaderNodeNormalMap"))
                nm.location = (COL_HELP, ROW["Normal"])
                nt.links.new(tex.outputs["Color"], nm.inputs["Color"])
                nt.links.new(nm.outputs["Normal"], bsdf.inputs["Normal"])
                wired.append("Normal -> Normal Map node -> Normal (Non-Color)")

            elif m == "Metallic":
                nt.links.new(tex.outputs["Color"], bsdf.inputs["Metallic"])
                # URP packs SMOOTHNESS in alpha; Blender wants ROUGHNESS.
                inv = tag(nt.nodes.new("ShaderNodeInvert"))
                inv.label = "smoothness -> roughness"
                inv.location = (COL_HELP, ROW["Metallic"])
                nt.links.new(tex.outputs["Alpha"], inv.inputs["Color"])
                nt.links.new(inv.outputs["Color"], bsdf.inputs["Roughness"])
                wired.append("Metallic -> Metallic, alpha(smoothness) "
                             "-> Invert -> Roughness")

            elif m == "Occlusion":
                # Principled has no AO input. Multiply it into Base Color when
                # a BaseMap is present, otherwise leave it unconnected rather
                # than pretending it does something.
                base = bsdf.inputs["Base Color"]
                if base.is_linked:
                    src = base.links[0].from_socket
                    mix = tag(nt.nodes.new("ShaderNodeMix"))
                    mix.data_type = "RGBA"
                    mix.blend_type = "MULTIPLY"
                    mix.label = "AO x BaseMap"
                    mix.location = (COL_HELP, ROW["Occlusion"])
                    mix.inputs["Factor"].default_value = 1.0
                    nt.links.new(src, mix.inputs[6])
                    nt.links.new(tex.outputs["Color"], mix.inputs[7])
                    nt.links.new(mix.outputs[2], base)
                    wired.append("Occlusion -> multiplied into Base Color "
                                 "(Blender preview only; Unity uses the "
                                 "Occlusion slot directly)")
                else:
                    report.warn("material.ao_unconnected", mat.name,
                                "Occlusion map loaded but Base Color is not "
                                "linked, so there is nothing to multiply it "
                                "into; node left unconnected")

            elif m == "Emission":
                nt.links.new(tex.outputs["Color"], bsdf.inputs["Emission Color"])
                bsdf.inputs["Emission Strength"].default_value = 1.0
                wired.append("Emission -> Emission Color (sRGB)")

            elif m == "Height":
                disp = tag(nt.nodes.new("ShaderNodeDisplacement"))
                disp.location = (COL_HELP, ROW["Height"])
                nt.links.new(tex.outputs["Color"], disp.inputs["Height"])
                for n in nt.nodes:
                    if n.type == "OUTPUT_MATERIAL":
                        nt.links.new(disp.outputs["Displacement"],
                                     n.inputs["Displacement"])
                wired.append("Height -> Displacement (Non-Color)")

            elif m == "Specular":
                nt.links.new(tex.outputs["Color"],
                             bsdf.inputs["Specular IOR Level"])
                wired.append("Specular -> Specular IOR Level")

        if wired:
            report.info("material.wired", mat.name,
                        "texture set %s: %s" % (ts, "; ".join(wired)),
                        texture_set=ts, connections=wired)


def verify(obj, preset, report):
    """Confirm the graph is actually connected, not just that nodes exist."""
    maps = preset["texture"]["maps"]
    for slot in obj.material_slots:
        mat = slot.material
        if mat is None or not mat.use_nodes:
            continue
        bsdf = next((n for n in mat.node_tree.nodes
                     if n.type == "BSDF_PRINCIPLED"), None)
        if bsdf is None:
            report.error("material.no_bsdf", mat.name,
                         "no Principled BSDF after wiring")
            continue
        checks = {
            "BaseMap": "Base Color",
            "Normal": "Normal",
            "Metallic": "Metallic",
            "Emission": "Emission Color",
        }
        for m, socket in checks.items():
            if m not in maps:
                continue
            if not bsdf.inputs[socket].is_linked:
                report.error("material.not_connected", mat.name,
                             "%s is in the preset but the BSDF's %r input is "
                             "not linked" % (m, socket))
            else:
                report.info("material.connected", mat.name,
                            "%r <- linked" % socket)
        # Colour-space audit over every image the material references.
        for n in mat.node_tree.nodes:
            if n.type != "TEX_IMAGE" or n.image is None:
                continue
            # Parse the file path, not the datablock name: Blender renames a
            # second datablock for the same file to "x.png.001", which would
            # not parse and would silently skip this check.
            src_name = os.path.basename(
                bpy.path.abspath(n.image.filepath) or n.image.name)
            try:
                _ts, m, _ = naming.parse_texture_filename(src_name)
            except naming.NameError_:
                report.warn("material.unparseable_image", src_name,
                            "image %r in material %r does not follow the naming "
                            "convention, so its colour space could not be "
                            "audited" % (src_name, mat.name))
                continue
            want = "sRGB" if naming.is_srgb(m) else "Non-Color"
            got = n.image.colorspace_settings.name
            if got != want:
                report.error("material.colorspace", src_name,
                             "colour space is %r, must be %r" % (got, want))


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    tex_dir = os.path.abspath(args.textures)
    out = os.path.abspath(args.out)

    r = rep.Report("import_blender_material", asset=args.asset or args.object,
                   inputs={"blend": bpy.data.filepath, "object": args.object,
                           "textures": tex_dir, "preset": preset["_name"]})

    objs = bu.resolve_objects([args.object], r)
    if not objs:
        r.emit(args.report, exit_on_error=True)
        return
    obj = objs[0]

    wire(obj, tex_dir, preset, args, r)
    verify(obj, preset, r)

    if r.errors:
        r.warn("output.skipped", out, "errors raised; not saving the .blend")
        r.emit(args.report, exit_on_error=True)
        return

    d = os.path.dirname(out)
    if d and not os.path.isdir(d):
        os.makedirs(d)
    bpy.ops.wm.save_as_mainfile(filepath=out, copy=True, compress=True)
    r.output("blend", out)
    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()
