"""
Build `SourceArt/Blender/Tube/Tube.blend` from a raw test-tube FBX.

The delivered file is a metre-scale, upright, single-mesh prop that satisfies the asset
contract: root transform 0 / 0 / 1, pivot on the contact point, long axis up. Everything
here is mechanical, so keeping it as a script means the source can be rebuilt if the raw
model is ever replaced.

Usage:

    /Applications/Blender.app/Contents/MacOS/Blender --background \
      --python Tools/blender/build_tube_source.py -- \
      --source ~/Downloads/source/Tube.fbx \
      --output SourceArt/Blender/Tube/Tube.blend
"""

import argparse
import math
import os
import sys

import bpy
from mathutils import Vector

NAME = "Tube"
LENGTH = 0.16                      # metres, agreed with the artist
MODEL_AXIS = 1                     # the raw mesh runs along its own Y


def parse_args():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    p = argparse.ArgumentParser(description="Build the tube prop source .blend.")
    p.add_argument("--source", required=True)
    p.add_argument("--output", required=True)
    return p.parse_args(argv)


def main():
    args = parse_args()
    source = os.path.expanduser(args.source)
    if not os.path.isfile(source):
        print("error: source not found: %s" % source)
        sys.exit(1)

    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.fbx(filepath=source)
    meshes = [o for o in bpy.data.objects if o.type == "MESH"]
    if len(meshes) != 1:
        print("error: expected one mesh, got %d" % len(meshes))
        sys.exit(1)
    tube = meshes[0]
    for stray in [o for o in bpy.data.objects if o is not tube]:
        bpy.data.objects.remove(stray, do_unlink=True)

    tube.name = NAME
    tube.data.name = NAME
    for slot in tube.material_slots:
        if slot.material:
            slot.material.name = NAME

    # Long axis to +Z (a tube stands up), then scale to the delivered length.
    tube.rotation_euler = (math.radians(90.0), 0.0, 0.0)
    bpy.context.view_layer.objects.active = tube
    tube.select_set(True)
    bpy.ops.object.transform_apply(location=False, rotation=True, scale=False)
    bpy.context.view_layer.update()
    tube.scale = [s * (LENGTH / tube.dimensions.z) for s in tube.scale]
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    bpy.context.view_layer.update()

    # Pivot on the contact point: origin at the base, object at the world origin.
    lowest = min((tube.matrix_world @ v.co).z for v in tube.data.vertices)
    centre = sum(((tube.matrix_world @ v.co) for v in tube.data.vertices), Vector()) / len(tube.data.vertices)
    bpy.context.scene.cursor.location = Vector((centre.x, centre.y, lowest))
    bpy.ops.object.origin_set(type="ORIGIN_CURSOR")
    tube.location = (0.0, 0.0, 0.0)
    bpy.context.scene.cursor.location = Vector((0.0, 0.0, 0.0))
    bpy.context.view_layer.update()

    output = os.path.abspath(args.output)
    os.makedirs(os.path.dirname(output), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=output)
    print("%s: %.4f x %.4f x %.4f m, %d verts, %d faces, material %s"
          % (NAME, tube.dimensions.x, tube.dimensions.y, tube.dimensions.z,
             len(tube.data.vertices), len(tube.data.polygons),
             [s.material.name for s in tube.material_slots]))
    print("root transform: loc %s rot %s scale %s"
          % ([round(v, 4) for v in tube.location],
             [round(math.degrees(a), 1) for a in tube.rotation_euler],
             [round(v, 4) for v in tube.scale]))
    print("saved %s" % output)


if __name__ == "__main__":
    main()
