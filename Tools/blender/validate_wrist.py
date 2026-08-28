"""
Wrist-break validator for rigged animation files.

Sweeps every frame of the named Actions and measures the anatomical rotation
of each child joint relative to its parent (swing-twist decomposition of the
evaluated pose quaternions). A frame whose twist or swing exceeds the limits
is reported as a violation; any violation makes the script exit non-zero, so
this can run in CI or as a pre-export gate.

Knows no asset names. Joint pairs, actions and limits are arguments.

The file is evaluated exactly AS SAVED -- the stored (unkeyed) pose is part of
what an exporter would bake, so pollution of unkeyed channels (the classic
"scrubbed another action, then saved" mistake) is caught here too.

Usage:

    /Applications/Blender.app/Contents/MacOS/Blender --background \
      /path/to/source.blend \
      --python Tools/blender/validate_wrist.py -- \
      --armature ArmsRig \
      --joints forearm.R:hand.R,forearm.L:hand.L \
      --actions helmet_off,keypad_poke \
      --max-twist 90 --max-swing 85

Omitting --actions checks every Action in the file that animates the armature.
Exit codes: 0 = clean, 2 = violations found, 1 = usage/data error.
"""

import argparse
import math
import sys

import bpy
from mathutils import Quaternion


def parse_args():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    p = argparse.ArgumentParser(description="Detect broken wrists (or any over-rotated joint) per frame.")
    p.add_argument("--armature", help="armature object name; inferred when the file holds exactly one")
    p.add_argument("--joints", required=True,
                   help="comma-separated parent:child pose-bone pairs, e.g. forearm.R:hand.R,forearm.L:hand.L")
    p.add_argument("--actions", help="comma-separated Action names; default: every Action that targets the armature")
    p.add_argument("--max-twist", type=float, default=90.0,
                   help="max rotation about the parent bone's long (Y) axis, degrees (pronation/supination)")
    p.add_argument("--max-swing", type=float, default=85.0,
                   help="max remaining swing rotation, degrees (flexion/extension + deviation)")
    p.add_argument("--frame-step", type=int, default=1)
    return p.parse_args(argv)


def swing_twist_deg(q_parent, q_child):
    """Return (twist, swing) in degrees of child relative to parent, twist about local Y."""
    q_rel = q_parent.inverted() @ q_child
    twist_q = Quaternion((q_rel.w, 0.0, q_rel.y, 0.0))
    if twist_q.magnitude < 1e-8:
        return 180.0, 0.0
    twist_q.normalize()
    twist = math.degrees(2.0 * math.acos(max(-1.0, min(1.0, abs(twist_q.w)))))
    swing_q = q_rel @ twist_q.inverted()
    swing = math.degrees(2.0 * math.acos(max(-1.0, min(1.0, abs(swing_q.w)))))
    return twist, swing


def main():
    args = parse_args()

    armatures = [o for o in bpy.data.objects if o.type == "ARMATURE"]
    if args.armature:
        arm = bpy.data.objects.get(args.armature)
        if arm is None or arm.type != "ARMATURE":
            print("error: armature object not found: %s" % args.armature)
            sys.exit(1)
    elif len(armatures) == 1:
        arm = armatures[0]
    else:
        print("error: pass --armature (file holds %d armatures)" % len(armatures))
        sys.exit(1)

    pairs = []
    for chunk in args.joints.split(","):
        parent, _, child = chunk.partition(":")
        if not child or parent not in arm.pose.bones or child not in arm.pose.bones:
            print("error: bad joint pair %r (bones must exist on %s)" % (chunk, arm.name))
            sys.exit(1)
        pairs.append((parent, child))

    if args.actions:
        actions = []
        for name in args.actions.split(","):
            act = bpy.data.actions.get(name)
            if act is None:
                print("error: Action not found: %s" % name)
                sys.exit(1)
            actions.append(act)
    else:
        actions = [a for a in bpy.data.actions
                   if any(fc.data_path.startswith("pose.bones") for fc in a.fcurves)]

    if arm.animation_data is None:
        arm.animation_data_create()

    scene = bpy.context.scene
    dg = bpy.context.evaluated_depsgraph_get()
    violations = []
    for act in actions:
        arm.animation_data.action = act
        start, end = int(act.frame_range[0]), int(act.frame_range[1])
        for f in range(start, end + 1, args.frame_step):
            scene.frame_set(f)
            dg.update()
            ae = arm.evaluated_get(dg)
            for parent, child in pairs:
                twist, swing = swing_twist_deg(
                    ae.pose.bones[parent].matrix.to_quaternion(),
                    ae.pose.bones[child].matrix.to_quaternion())
                if twist > args.max_twist or swing > args.max_swing:
                    violations.append((act.name, f, child, twist, swing))

    if violations:
        print("WRIST VALIDATION FAILED: %d frame(s) over limits (twist > %.0f or swing > %.0f)"
              % (len(violations), args.max_twist, args.max_swing))
        by_action = {}
        for act_name, f, child, twist, swing in violations:
            by_action.setdefault((act_name, child), []).append((f, twist, swing))
        for (act_name, child), rows in sorted(by_action.items()):
            frames = [r[0] for r in rows]
            worst = max(rows, key=lambda r: max(r[1] / args.max_twist, r[2] / args.max_swing))
            print("  %s / %s: frames %d-%d (%d frames), worst f%d twist %.1f swing %.1f"
                  % (act_name, child, min(frames), max(frames), len(frames), *worst))
        sys.exit(2)

    print("wrist validation clean: %d action(s), %d joint pair(s), limits twist %.0f / swing %.0f"
          % (len(actions), len(pairs), args.max_twist, args.max_swing))


if __name__ == "__main__":
    main()
