"""Generate one deterministic static-mesh LOD from an FBX source.

The source file is opened read-only. Every mesh receives the same proportional
Decimate ratio so multi-part assets keep their relative detail distribution.
The result is triangulated before export and keeps object/material names for
Unity-side material remapping.
"""

import argparse
import os
import sys

import bpy


def parse_args():
    argv = sys.argv
    argv = argv[argv.index("--") + 1:] if "--" in argv else []
    parser = argparse.ArgumentParser(description="Generate a static FBX LOD")
    parser.add_argument("--project-root", required=True)
    parser.add_argument("--source", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--target-triangles", required=True, type=int)
    return parser.parse_args(argv)


def absolute_path(project_root, path):
    if os.path.isabs(path):
        return os.path.normpath(path)
    return os.path.normpath(os.path.join(project_root, path))


def triangle_count(mesh):
    mesh.calc_loop_triangles()
    return len(mesh.loop_triangles)


def apply_modifier(obj, modifier_name):
    bpy.ops.object.select_all(action="DESELECT")
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.modifier_apply(modifier=modifier_name)


def simplify(mesh_objects, target_triangles):
    source_triangles = sum(triangle_count(obj.data) for obj in mesh_objects)
    if source_triangles <= 0:
        raise RuntimeError("source contains no triangles")
    if target_triangles >= source_triangles:
        raise RuntimeError(
            f"target {target_triangles} must be below source {source_triangles}"
        )

    ratio = target_triangles / source_triangles
    for obj in mesh_objects:
        modifier = obj.modifiers.new(name="LOD Decimate", type="DECIMATE")
        modifier.decimate_type = "COLLAPSE"
        modifier.ratio = ratio
        modifier.use_collapse_triangulate = True
        apply_modifier(obj, modifier.name)

        triangulate = obj.modifiers.new(name="LOD Triangulate", type="TRIANGULATE")
        apply_modifier(obj, triangulate.name)

    result_triangles = sum(triangle_count(obj.data) for obj in mesh_objects)
    error_ratio = abs(result_triangles - target_triangles) / target_triangles
    if error_ratio > 0.10:
        raise RuntimeError(
            f"generated {result_triangles} triangles for target {target_triangles} "
            f"({error_ratio:.1%} error)"
        )

    return source_triangles, result_triangles


def export_fbx(mesh_objects, output_path):
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bpy.ops.object.select_all(action="DESELECT")
    for obj in mesh_objects:
        obj.select_set(True)
    bpy.context.view_layer.objects.active = mesh_objects[0]

    bpy.ops.export_scene.fbx(
        filepath=output_path,
        use_selection=True,
        object_types={"MESH"},
        apply_unit_scale=True,
        global_scale=1.0,
        apply_scale_options="FBX_SCALE_NONE",
        bake_space_transform=False,
        axis_forward="-Z",
        axis_up="Y",
        mesh_smooth_type="FACE",
        use_mesh_modifiers=True,
        add_leaf_bones=False,
        bake_anim=False,
        path_mode="AUTO",
    )


def main():
    args = parse_args()
    project_root = os.path.abspath(args.project_root)
    source_path = absolute_path(project_root, args.source)
    output_path = absolute_path(project_root, args.output)

    if not os.path.isfile(source_path):
        raise RuntimeError(f"source FBX does not exist: {source_path}")
    if args.target_triangles <= 0:
        raise RuntimeError("--target-triangles must be positive")

    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.fbx(filepath=source_path, use_anim=False)
    mesh_objects = sorted(
        (obj for obj in bpy.context.scene.objects if obj.type == "MESH"),
        key=lambda obj: obj.name,
    )
    if not mesh_objects:
        raise RuntimeError(f"source FBX contains no mesh objects: {source_path}")

    source_triangles, result_triangles = simplify(
        mesh_objects, args.target_triangles
    )
    export_fbx(mesh_objects, output_path)
    print(
        f"LOD generated: {args.source} {source_triangles} -> "
        f"{result_triangles} triangles at {args.output}"
    )


if __name__ == "__main__":
    main()
