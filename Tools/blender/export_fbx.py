"""
Generic Blender -> Unity FBX exporter.

Works with arbitrary Blender files and arbitrary rigged assets.

Design:
    Generic exporter
        +
    command-line asset selection
        +
    optional JSON export profile
        +
    optional provenance manifest

No asset-specific object names are hardcoded. Nothing in this file names
ArmsRig, Helmet_Placeholder or helmet_off; those are command-line arguments.
Animation policy lives in a profile, so an FPS-arms asset can bake every frame
while another asset uses a different policy, without editing this script.

Path resolution
---------------
With --project-root, relative --output / --manifest / --profile paths resolve
against the project root, and the manifest records paths relative to it. This is
the mode Unity projects want: the manifest stays free of machine-specific paths
and the Editor can still resolve every path it reads.

Without --project-root, relative paths resolve against the .blend's directory
(or the process working directory when the .blend has not been saved).

Absolute paths are always accepted as supplied. This script contains no
absolute path of its own.

Examples
--------

1. Export current Blender selection:

    blender --background source.blend --python export_fbx.py -- \
        --output Assets/Characters/Character.fbx \
        --selection

2. Export named objects:

    blender --background source.blend --python export_fbx.py -- \
        --output Assets/Characters/Arms.fbx \
        --objects ArmsMesh,ArmsRig,Helmet_Placeholder

3. Export one animation from an armature:

    blender --background source.blend --python export_fbx.py -- \
        --output Assets/Characters/Arms.fbx \
        --objects ArmsMesh,ArmsRig,Helmet_Placeholder \
        --armature ArmsRig \
        --action helmet_off

4. Export multiple actions as separate FBX files:

    blender --background source.blend --python export_fbx.py -- \
        --output Assets/Characters/Character.fbx \
        --objects CharacterMesh,CharacterRig \
        --armature CharacterRig \
        --actions idle,walk,run

    Produces:

        Character_idle.fbx
        Character_walk.fbx
        Character_run.fbx

5. Use a custom animation/export profile:

    blender --background source.blend --python export_fbx.py -- \
        --output Assets/Characters/Arms.fbx \
        --objects ArmsMesh,ArmsRig,Helmet_Placeholder \
        --armature ArmsRig \
        --action helmet_off \
        --profile Tools/blender/profiles/fps_arms.json

6. Write provenance manifest, with project-root-relative paths:

    blender --background source.blend --python export_fbx.py -- \
        --project-root /path/to/UnityProject \
        --output Assets/Characters/Arms.fbx \
        --objects ArmsMesh,ArmsRig,Helmet_Placeholder \
        --armature ArmsRig \
        --action helmet_off \
        --manifest SourceArt/Export/Arms.export.json

Important:
- The exporter does NOT assume an armature exists.
- The exporter does NOT assume an animation exists.
- The exporter does NOT assume any particular object names.
- The exporter NEVER exports every Action in the .blend. A .blend commonly
  holds dozens of Actions; which ones ship is always stated explicitly with
  --action / --actions.
- Animation settings live in the profile, so FPS arms can use bake-every-frame
  while another asset can use a different animation policy.
"""

import argparse
import datetime
import json
import os
import sys

import bpy


# ---------------------------------------------------------------------------
# Default export profile
# ---------------------------------------------------------------------------
#
# These are intentionally generic Unity-friendly defaults.
#
# Asset-specific animation policies should normally live in a JSON profile,
# rather than being hardcoded here.
#

DEFAULT_PROFILE = {
    "fbx": {
        "apply_unit_scale": True,
        "global_scale": 1.0,
        "apply_scale_options": "FBX_SCALE_NONE",

        # Blender documents this as problematic for armatures/animations.
        "bake_space_transform": False,

        # Unity-compatible coordinate convention.
        "axis_forward": "-Z",
        "axis_up": "Y",

        "mesh_smooth_type": "FACE",
        "use_mesh_modifiers": True,

        # Prevent Blender from creating *_end bones.
        "add_leaf_bones": False,

        "primary_bone_axis": "Y",
        "secondary_bone_axis": "X",
        "armature_nodetype": "NULL",

        "path_mode": "AUTO",
    },

    "animation": {
        "bake_anim": True,

        # Preserve the complete armature animation when baking.
        "bake_anim_use_all_bones": True,

        # Do not rely on Blender NLA strips unless the profile explicitly
        # enables them.
        "bake_anim_use_nla_strips": False,

        # Never automatically export every Action in the .blend.
        "bake_anim_use_all_actions": False,

        # Make sure the beginning and end of the requested range are keyed.
        "bake_anim_force_startend_keying": True,

        # Bake every frame by default.
        #
        # This is conservative and particularly appropriate for constraints,
        # IK, Child Of, procedural motion, etc.
        #
        # A different profile can use another value.
        "bake_anim_step": 1.0,

        # Do not simplify baked curves by default.
        #
        # This preserves constraint-generated motion accurately.
        #
        # Other assets can use a non-zero value through their profile.
        "bake_anim_simplify_factor": 0.0,
    },
}


# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------

def parse_args():
    """
    Parse arguments after Blender's '--'.

    Example:

        blender file.blend --python export_fbx.py -- \
            --output Assets/Test.fbx \
            --selection
    """

    argv = sys.argv

    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []

    parser = argparse.ArgumentParser(
        description="Generic Blender -> Unity FBX exporter"
    )

    parser.add_argument(
        "--output",
        required=True,
        help=(
            "FBX output path. Relative paths are resolved relative to "
            "--project-root when given, otherwise relative to the "
            "Blender source file."
        ),
    )

    parser.add_argument(
        "--project-root",
        help=(
            "Optional project root. When given, relative paths resolve "
            "against it and the manifest records paths relative to it."
        ),
    )

    parser.add_argument(
        "--objects",
        help=(
            "Comma-separated Blender object names to export."
        ),
    )

    parser.add_argument(
        "--selection",
        action="store_true",
        help="Export the current Blender selection.",
    )

    parser.add_argument(
        "--collection",
        help=(
            "Blender collection name. Exports every MESH object linked "
            "under it (child collections included) that carries at "
            "least one polygon; edge-only helper meshes are skipped."
        ),
    )

    parser.add_argument(
        "--armature",
        help=(
            "Optional armature object name. Required when using "
            "--action or --actions."
        ),
    )

    parser.add_argument(
        "--action",
        help=(
            "Optional Blender Action to assign to the armature "
            "before export."
        ),
    )

    parser.add_argument(
        "--actions",
        help=(
            "Comma-separated Blender Actions. Each Action is exported "
            "as a separate FBX."
        ),
    )

    parser.add_argument(
        "--profile",
        help=(
            "Optional JSON export profile."
        ),
    )

    parser.add_argument(
        "--manifest",
        help=(
            "Optional provenance manifest path."
        ),
    )

    parser.add_argument(
        "--frame-start",
        type=int,
        help="Override animation frame start.",
    )

    parser.add_argument(
        "--frame-end",
        type=int,
        help="Override animation frame end.",
    )

    # argv, not sys.argv: everything before Blender's '--' belongs to Blender.
    args = parser.parse_args(argv)

    selectors = [
        bool(args.objects),
        bool(args.selection),
        bool(args.collection),
    ]

    if sum(selectors) > 1:
        parser.error(
            "--objects, --selection and --collection are mutually "
            "exclusive"
        )

    if sum(selectors) == 0:
        parser.error(
            "one of --objects, --selection or --collection is required"
        )

    if args.actions and args.action:
        parser.error(
            "--action and --actions are mutually exclusive"
        )

    return args


# ---------------------------------------------------------------------------
# Path handling
# ---------------------------------------------------------------------------

def source_root():
    """
    Return the directory containing the current .blend.

    No user-specific absolute path is stored in this script.
    """

    blend_path = bpy.data.filepath

    if blend_path:
        return os.path.dirname(
            os.path.abspath(blend_path)
        )

    # If the .blend has not been saved yet, use the process cwd.
    return os.getcwd()


def path_root(project_root):
    """
    Return the base directory for resolving relative paths.
    """

    if project_root:
        return os.path.abspath(project_root)

    return source_root()


def resolve_path(path, project_root=None):
    """
    Resolve a command-line path.

    Relative:
        resolved relative to --project-root when given, otherwise
        relative to the .blend directory.

    Absolute:
        accepted as supplied.

    The script itself never contains an absolute project/user path.
    """

    if not path:
        return None

    if os.path.isabs(path):
        return os.path.normpath(path)

    return os.path.normpath(
        os.path.join(
            path_root(project_root),
            path,
        )
    )


def display_path(path, project_root=None):
    """
    Return a root-relative path where possible.

    This keeps logs/manifests portable and avoids recording unnecessary
    machine-specific absolute paths. Paths that cannot be expressed
    relative to the root (a different volume, or a source file kept
    outside the project) are returned absolute, because a manifest that
    Unity cannot resolve is worse than one that is machine-specific.
    """

    if not path:
        return ""

    base = path_root(project_root)

    try:
        relative = os.path.relpath(path, base)
    except ValueError:
        return path

    if relative.startswith(os.pardir) and not project_root:
        # Without an explicit root, escaping the .blend directory produces
        # a path nothing downstream can anchor. Keep it absolute instead.
        return path

    return relative


# ---------------------------------------------------------------------------
# Profile handling
# ---------------------------------------------------------------------------

def deep_copy_default_profile():
    """
    Return an independent copy of DEFAULT_PROFILE.
    """

    return json.loads(
        json.dumps(DEFAULT_PROFILE)
    )


def load_profile(path, project_root=None):
    """
    Load a JSON profile and merge it over the generic defaults.

    Example profile:

        {
          "fbx": {
            "add_leaf_bones": false
          },
          "animation": {
            "bake_anim_step": 1.0,
            "bake_anim_simplify_factor": 0.0
          }
        }
    """

    profile = deep_copy_default_profile()

    if not path:
        return profile

    profile_path = resolve_path(path, project_root)

    with open(
        profile_path,
        "r",
        encoding="utf-8",
    ) as handle:
        user_profile = json.load(handle)

    if not isinstance(user_profile, dict):
        raise RuntimeError(
            "profile root must be a JSON object"
        )

    for section in ("fbx", "animation"):
        values = user_profile.get(section, {})

        if not isinstance(values, dict):
            raise RuntimeError(
                "profile section must be an object: "
                + section
            )

        profile[section].update(values)

    return profile


# ---------------------------------------------------------------------------
# Blender object handling
# ---------------------------------------------------------------------------

def get_objects_from_names(names):
    """
    Resolve Blender object names.
    """

    objects = []

    for raw_name in names:
        name = raw_name.strip()

        if not name:
            continue

        obj = bpy.data.objects.get(name)

        if obj is None:
            raise RuntimeError(
                "object not found in this .blend: "
                + name
            )

        objects.append(obj)

    if not objects:
        raise RuntimeError(
            "no objects were specified"
        )

    return objects


def get_objects_from_collection(name):
    """
    Resolve every exportable MESH object under a collection.

    Child collections are included. Meshes without polygons (edge-only
    wireframe duplicates that CAD exports leave behind) are skipped
    because Unity imports them as empty meshes. Hidden objects cannot be
    selected and would be dropped silently by the FBX exporter, so they
    fail loudly here instead.
    """

    collection = bpy.data.collections.get(name)

    if collection is None:
        raise RuntimeError(
            "collection not found in this .blend: " + name
        )

    view_layer_objects = bpy.context.view_layer.objects

    objects = []
    hidden = []
    excluded = []
    skipped_faceless = 0

    for obj in collection.all_objects:
        if obj.type != "MESH":
            continue

        if len(obj.data.polygons) == 0:
            skipped_faceless += 1
            continue

        # A collection unchecked in the outliner is excluded from the
        # view layer: the artist removed it from the model on purpose.
        if obj.name not in view_layer_objects:
            excluded.append(obj.name)
            continue

        if obj.hide_get() or obj.hide_viewport:
            hidden.append(obj.name)
            continue

        objects.append(obj)

    if hidden:
        raise RuntimeError(
            "hidden objects in collection '" + name + "' cannot be "
            "exported; unhide them or move them out: "
            + ", ".join(hidden)
        )

    if not objects:
        raise RuntimeError(
            "collection has no exportable mesh objects: " + name
        )

    print(
        "collection '" + name + "': "
        + str(len(objects)) + " mesh objects, "
        + str(skipped_faceless) + " faceless meshes skipped, "
        + str(len(excluded)) + " objects in excluded collections skipped"
    )

    if excluded:
        print(
            "excluded from the view layer (not exported): "
            + ", ".join(excluded)
        )

    return objects, excluded


def get_selected_objects():
    """
    Return currently selected Blender objects.
    """

    objects = list(
        bpy.context.selected_objects
    )

    if not objects:
        raise RuntimeError(
            "no Blender objects are currently selected"
        )

    return objects


def select_only(objects):
    """
    Replace the current selection with exactly these objects.

    Objects that exist in the .blend but are not linked into the active
    view layer cannot be selected, and Blender's FBX exporter would skip
    them silently. Fail loudly instead.
    """

    view_layer_objects = bpy.context.view_layer.objects

    missing = [
        obj.name
        for obj in objects
        if obj.name not in view_layer_objects
    ]

    if missing:
        raise RuntimeError(
            "object is not in the active view layer, so it cannot be "
            "exported: " + ", ".join(missing)
        )

    if (
        bpy.context.object is not None
        and bpy.context.object.mode != "OBJECT"
    ):
        bpy.ops.object.mode_set(
            mode="OBJECT"
        )

    bpy.ops.object.select_all(
        action="DESELECT"
    )

    for obj in objects:
        obj.select_set(True)

    bpy.context.view_layer.objects.active = objects[0]


def get_armature(args, exported_objects):
    """
    Resolve the armature.

    Explicit --armature wins.

    If --armature is omitted and exactly one exported armature exists,
    automatically use it.

    If there is no unique armature, return None.
    """

    if args.armature:
        armature = bpy.data.objects.get(
            args.armature
        )

        if armature is None:
            raise RuntimeError(
                "armature object not found: "
                + args.armature
            )

        if armature.type != "ARMATURE":
            raise RuntimeError(
                "object is not an armature: "
                + args.armature
            )

        return armature

    armatures = [
        obj
        for obj in exported_objects
        if obj.type == "ARMATURE"
    ]

    if len(armatures) == 1:
        return armatures[0]

    return None


# ---------------------------------------------------------------------------
# Animation handling
# ---------------------------------------------------------------------------

def get_action(name):
    """
    Resolve a Blender Action by name.
    """

    action = bpy.data.actions.get(name)

    if action is None:
        raise RuntimeError(
            "action not found: "
            + name
        )

    return action


def get_actions(args):
    """
    Resolve explicitly requested Actions.

    No action means:
        export the armature's current animation state.
    """

    if args.action:
        return [
            get_action(args.action)
        ]

    if args.actions:
        return [
            get_action(name.strip())
            for name in args.actions.split(",")
            if name.strip()
        ]

    return []


def assign_action(armature, action):
    """
    Assign an Action to an armature.
    """

    if armature is None:
        raise RuntimeError(
            "an armature is required when using "
            "--action or --actions"
        )

    if armature.animation_data is None:
        armature.animation_data_create()

    armature.animation_data.action = action


def set_frame_range(
    action,
    frame_start,
    frame_end,
):
    """
    Determine and apply the animation frame range.

    Priority:

        explicit CLI override
        >
        Action frame range
        >
        current Blender scene range
    """

    if frame_start is not None:
        start = frame_start

    elif action is not None:
        start = int(
            action.frame_range[0]
        )

    else:
        start = bpy.context.scene.frame_start

    if frame_end is not None:
        end = frame_end

    elif action is not None:
        end = int(
            action.frame_range[1]
        )

    else:
        end = bpy.context.scene.frame_end

    if end < start:
        raise RuntimeError(
            "frame end must be >= frame start"
        )

    bpy.context.scene.frame_start = start
    bpy.context.scene.frame_end = end

    return start, end


# ---------------------------------------------------------------------------
# FBX export
# ---------------------------------------------------------------------------

def export_fbx(
    output_path,
    profile,
):
    """
    Execute Blender's FBX exporter.

    The generic exporter combines:
        profile["fbx"]
        profile["animation"]

    with the runtime-required:
        filepath
        use_selection
        object_types
    """

    output_dir = os.path.dirname(
        output_path
    )

    if output_dir:
        os.makedirs(
            output_dir,
            exist_ok=True,
        )

    settings = {}

    settings.update(
        profile["fbx"]
    )

    settings.update(
        profile["animation"]
    )

    settings["filepath"] = output_path

    # Export exactly the objects selected by this script.
    settings["use_selection"] = True

    # This exporter is intended for meshes + armatures.
    settings["object_types"] = {
        "ARMATURE",
        "MESH",
    }

    bpy.ops.export_scene.fbx(
        **settings
    )


# ---------------------------------------------------------------------------
# Provenance manifest
# ---------------------------------------------------------------------------

def write_manifest(
    manifest_path,
    output_path,
    armature,
    action,
    frame_start,
    frame_end,
    exported_objects,
    profile_path,
    project_root=None,
    collection_name=None,
    excluded_objects=None,
):
    """
    Write portable provenance information.

    The manifest intentionally stores root-relative paths where possible.
    """

    blend_path = bpy.data.filepath

    manifest = {
        "m_fbx": display_path(
            output_path,
            project_root,
        ),

        "m_blend": (
            display_path(blend_path, project_root)
            if blend_path
            else ""
        ),

        "m_blendModifiedUtc": file_mtime(
            blend_path
        ),

        "m_action": (
            action.name
            if action
            else ""
        ),

        "m_armature": (
            armature.name
            if armature
            else ""
        ),

        "m_frameStart": frame_start,
        "m_frameEnd": frame_end,

        "m_fps": (
            bpy.context.scene.render.fps
        ),

        "m_exportedCollection": (
            collection_name
            if collection_name
            else ""
        ),

        "m_exportedObjects": [
            obj.name
            for obj in exported_objects
        ],

        "m_excludedObjects": list(
            excluded_objects or []
        ),

        "m_blenderVersion": (
            bpy.app.version_string
        ),

        "m_profile": (
            display_path(profile_path, project_root)
            if profile_path
            else "built-in-default"
        ),

        "m_exportedUtc": (
            datetime.datetime.now(
                datetime.timezone.utc
            )
            .replace(microsecond=0)
            .isoformat()
        ),
    }

    manifest_dir = os.path.dirname(
        manifest_path
    )

    if manifest_dir:
        os.makedirs(
            manifest_dir,
            exist_ok=True,
        )

    with open(
        manifest_path,
        "w",
        encoding="utf-8",
    ) as handle:
        json.dump(
            manifest,
            handle,
            indent=2,
            ensure_ascii=False,
        )
        handle.write("\n")

    print(
        "manifest -> "
        + display_path(manifest_path, project_root)
    )


def file_mtime(path):
    """
    Return a UTC modification timestamp.
    """

    if (
        not path
        or not os.path.exists(path)
    ):
        return ""

    stamp = datetime.datetime.fromtimestamp(
        os.path.getmtime(path),
        datetime.timezone.utc,
    )

    return stamp.replace(
        microsecond=0
    ).isoformat()


# ---------------------------------------------------------------------------
# Export orchestration
# ---------------------------------------------------------------------------

def output_for_action(
    output_path,
    action,
    multiple_actions,
):
    """
    When exporting multiple Actions, generate:

        Character_idle.fbx
        Character_walk.fbx
        Character_run.fbx
    """

    if not multiple_actions:
        return output_path

    base, extension = os.path.splitext(
        output_path
    )

    return (
        base
        + "_"
        + action.name
        + extension
    )


def manifest_for_action(
    manifest_path,
    action,
    multiple_actions,
):
    """
    Generate separate manifests when exporting multiple Actions.
    """

    if not manifest_path:
        return None

    if not multiple_actions:
        return manifest_path

    base, extension = os.path.splitext(
        manifest_path
    )

    return (
        base
        + "_"
        + action.name
        + extension
    )


def export_one(
    output_path,
    exported_objects,
    armature,
    action,
    args,
    profile,
    manifest_path=None,
    profile_path=None,
):
    """
    Export one FBX.
    """

    if action is not None:
        assign_action(
            armature,
            action
        )

    frame_start, frame_end = (
        set_frame_range(
            action,
            args.frame_start,
            args.frame_end,
        )
    )

    select_only(
        exported_objects
    )

    export_fbx(
        output_path,
        profile,
    )

    if manifest_path:
        write_manifest(
            manifest_path=manifest_path,
            output_path=output_path,
            armature=armature,
            action=action,
            frame_start=frame_start,
            frame_end=frame_end,
            exported_objects=exported_objects,
            profile_path=profile_path,
            project_root=args.project_root,
            collection_name=args.collection,
            excluded_objects=args.excluded_objects,
        )

    size = os.path.getsize(
        output_path
    )

    print(
        "exported {} frames {}-{} -> {} ({} bytes)".format(
            action.name
            if action
            else "current animation",
            frame_start,
            frame_end,
            display_path(output_path, args.project_root),
            size,
        )
    )


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    args = parse_args()

    project_root = args.project_root

    output_path = resolve_path(
        args.output,
        project_root,
    )

    profile_path = (
        resolve_path(args.profile, project_root)
        if args.profile
        else None
    )

    manifest_path = (
        resolve_path(args.manifest, project_root)
        if args.manifest
        else None
    )

    profile = load_profile(
        args.profile,
        project_root,
    )

    excluded_objects = []

    if args.objects:
        exported_objects = (
            get_objects_from_names(
                args.objects.split(",")
            )
        )
    elif args.collection:
        exported_objects, excluded_objects = (
            get_objects_from_collection(
                args.collection
            )
        )
    else:
        exported_objects = (
            get_selected_objects()
        )

    args.excluded_objects = excluded_objects

    armature = get_armature(
        args,
        exported_objects,
    )

    actions = get_actions(args)

    # ---------------------------------------------------------------
    # Multiple explicit Actions
    # ---------------------------------------------------------------

    if actions:
        multiple_actions = (
            len(actions) > 1
        )

        for action in actions:
            output = output_for_action(
                output_path,
                action,
                multiple_actions,
            )

            action_manifest = (
                manifest_for_action(
                    manifest_path,
                    action,
                    multiple_actions,
                )
            )

            export_one(
                output_path=output,
                exported_objects=exported_objects,
                armature=armature,
                action=action,
                args=args,
                profile=profile,
                manifest_path=action_manifest,
                profile_path=profile_path,
            )

    # ---------------------------------------------------------------
    # No explicit Action
    # ---------------------------------------------------------------

    else:
        export_one(
            output_path=output_path,
            exported_objects=exported_objects,
            armature=armature,
            action=None,
            args=args,
            profile=profile,
            manifest_path=manifest_path,
            profile_path=profile_path,
        )


if __name__ == "__main__":
    main()
