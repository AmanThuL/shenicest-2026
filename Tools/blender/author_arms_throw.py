"""
Author the right-arm `throw` Action on the arms rig, headless and re-runnably.

Provenance for a hand-authored clip: the pose table below is the source of
truth, so the Action can be rebuilt from scratch after any rig change instead
of being a one-off that only exists inside a .blend.

Contract: docs/architecture/contracts/手臂动画状态机.md
  - single-hand clip: keys exactly the channels `drop` keys (right arm only,
    no camera / root / left arm);
  - seam frames are value-exact: f1 == `hold` f1, f_last == `drop` f28;
  - the wrist is derived from the solved forearm every key, so the joint angle
    is authored rather than accidental (validate_wrist.py is the gate);
  - the stored (unkeyed) pose the file is saved with is left untouched.

Usage:

    /Applications/Blender.app/Contents/MacOS/Blender --background \
      SourceArt/Blender/ArmsRig/arms_rig_all.blend \
      --python Tools/blender/author_arms_throw.py -- --save
"""

import argparse
import math
import sys

import bpy
from mathutils import Matrix, Quaternion, Vector

ARMATURE = "ArmsRig"
ACTION = "throw"
CHANNEL_TEMPLATE = "drop"          # the right-arm-only channel set to mirror
START_FROM = ("hold", 1)           # forearm_raised, right hand up -- but a FLAT hand
END_AT = ("drop", 28)              # hang_low, right hand empty
GRIP_HAND = ("grab_ground", 31)    # the real closed grip around a picked-up object
OPEN_HAND = ("drop", 12)           # released, fingers open

# frame, wrist world position, elbow-pole world position,
# wrist slerp grip->hang, wrist snap (deg about hand X), finger pose, shoulder YXZ euler
KEYS = [
    (1,  (-0.307, -0.246, 1.524), (-0.641, 0.298, 1.390), 0.00, 0.0, "hold", (0.00, 0.0, 0.00)),
    (5,  (-0.315, -0.215, 1.470), (-0.680, 0.240, 1.430), 0.00, -4.0, "grip", (0.00, 0.0, -0.02)),
    (10, (-0.380, 0.010, 1.700), (-0.850, 0.100, 1.560), 0.02, -10.0, "grip", (0.05, 0.0, -0.10)),
    (18, (-0.397, 0.197, 1.794), (-0.850, 0.000, 1.600), 0.12, -20.0, "grip", (0.09, 0.0, -0.18)),
    (20, (-0.399, 0.203, 1.797), (-0.855, 0.000, 1.605), 0.12, -22.0, "grip", (0.09, 0.0, -0.19)),
    (22, (-0.390, 0.150, 1.830), (-0.800, -0.150, 1.600), 0.10, -22.0, "grip", (0.05, 0.0, -0.04)),
    (24, (-0.350, -0.030, 1.760), (-0.750, -0.250, 1.700), 0.14, -10.0, "grip", (0.02, 0.0, 0.14)),
    (26, (-0.300, -0.355, 1.945), (-0.720, -0.220, 1.720), 0.35, 15.0, "open", (-0.02, 0.0, 0.26)),
    (28, (-0.283, -0.445, 1.845), (-0.660, -0.180, 1.680), 0.55, 8.0, "open", (-0.03, 0.0, 0.24)),
    (31, (-0.255, -0.420, 1.520), (-0.580, 0.000, 1.520), 0.75, 0.0, "open", (-0.02, 0.0, 0.12)),
    (35, (-0.225, -0.240, 1.180), (-0.490, 0.200, 1.310), 0.90, 0.0, "hang", (0.00, 0.0, 0.03)),
    (40, (-0.220, 0.000, 1.050), (-0.450, 0.280, 1.200), 1.00, 0.0, "hang", (0.00, 0.0, 0.00)),
]

WRIST = "handIK.R"
POLE = "elbowIK.R"
SHOULDER = "shoulder.R"
SOLVED_PARENT = "forearm.R"        # IK-solved; the wrist orientation hangs off it


def hemisphere_breaks(action):
    """Neighbouring quaternion keys that sit on opposite hemispheres.

    Blender interpolates quaternion channels component-wise, so such a pair sends the
    bone the long way round between the keys -- invisible at the keys themselves.
    """
    curves = {}
    for fcurve in action.fcurves:
        if fcurve.data_path.endswith("rotation_quaternion"):
            curves.setdefault(fcurve.data_path, {})[fcurve.array_index] = fcurve
    breaks = []
    for path, axes in curves.items():
        if len(axes) != 4:
            continue
        ordered = [axes[i] for i in range(4)]
        for i in range(1, len(ordered[0].keyframe_points)):
            dot = sum(c.keyframe_points[i].co[1] * c.keyframe_points[i - 1].co[1] for c in ordered)
            if dot < 0.0:
                breaks.append((path, int(round(ordered[0].keyframe_points[i].co[0]))))
    return breaks


def align_hemisphere(pose, reference):
    """Flip pose quaternions that face away from the reference pose -- same rotation, no long way round."""
    for name, values in pose.items():
        if name.startswith("_") or len(values["rot"]) != 4:
            continue
        ref = reference[name]["rot"]
        if sum(a * b for a, b in zip(values["rot"], ref)) < 0.0:
            values["rot"] = [-v for v in values["rot"]]


def solved_quaternion(arm, bone):
    """Read a constraint/IK-solved bone off the evaluated depsgraph, not the stale original."""
    depsgraph = bpy.context.evaluated_depsgraph_get()
    depsgraph.update()
    return arm.evaluated_get(depsgraph).pose.bones[bone].matrix.to_quaternion()


def joint_angles(arm):
    """(twist, swing) of hand.R relative to forearm.R, the way validate_wrist.py measures it."""
    depsgraph = bpy.context.evaluated_depsgraph_get()
    depsgraph.update()
    evaluated = arm.evaluated_get(depsgraph)
    q_rel = (evaluated.pose.bones[SOLVED_PARENT].matrix.to_quaternion().inverted()
             @ evaluated.pose.bones["hand.R"].matrix.to_quaternion())
    twist_q = Quaternion((q_rel.w, 0.0, q_rel.y, 0.0))
    if twist_q.magnitude < 1e-8:
        return 180.0, 0.0
    twist_q.normalize()
    twist = math.degrees(2.0 * math.acos(min(1.0, abs(twist_q.w))))
    swing = math.degrees(2.0 * math.acos(min(1.0, abs((q_rel @ twist_q.inverted()).w))))
    return twist, swing


def hermite(keys, values, frame):
    """Catmull-Rom through (frame, value) pairs -- the key spacing IS the timing."""
    if frame <= keys[0]:
        return values[0]
    if frame >= keys[-1]:
        return values[-1]
    i = max(j for j in range(len(keys) - 1) if keys[j] <= frame)
    span = keys[i + 1] - keys[i]
    t = (frame - keys[i]) / span
    prev_i, next_i = max(0, i - 1), min(len(keys) - 1, i + 2)
    m0 = (values[i + 1] - values[prev_i]) / (keys[i + 1] - keys[prev_i]) * span
    m1 = (values[next_i] - values[i]) / (keys[next_i] - keys[i]) * span
    t2, t3 = t * t, t * t * t
    return ((2 * t3 - 3 * t2 + 1) * values[i] + (t3 - 2 * t2 + t) * m0
            + (-2 * t3 + 3 * t2) * values[i + 1] + (t3 - t2) * m1)


def blend_poses(a, b, weight):
    """Mix two sampled poses; quaternions slerp, everything else lerps."""
    out = {}
    for name, va in a.items():
        if name.startswith("_"):
            continue
        vb = b[name]
        if len(va["rot"]) == 4:
            rot = list(Quaternion(va["rot"]).slerp(Quaternion(vb["rot"]), weight))
        else:
            rot = [x + (y - x) * weight for x, y in zip(va["rot"], vb["rot"])]
        out[name] = {
            "loc": [x + (y - x) * weight for x, y in zip(va["loc"], vb["loc"])],
            "scale": [x + (y - x) * weight for x, y in zip(va["scale"], vb["scale"])],
            "rot": rot,
        }
    return out


def smoothstep(t):
    return t * t * (3.0 - 2.0 * t)


def pose_channels(pose):
    """{(data_path, index): value} for a sampled pose, in fcurve terms."""
    out = {}
    for name, v in pose.items():
        if name.startswith("_"):
            continue
        prefix = 'pose.bones["%s"].' % name
        for i, value in enumerate(v["loc"]):
            out[(prefix + "location", i)] = value
        for i, value in enumerate(v["scale"]):
            out[(prefix + "scale", i)] = value
        path = "rotation_quaternion" if len(v["rot"]) == 4 else "rotation_euler"
        for i, value in enumerate(v["rot"]):
            out[(prefix + path, i)] = value
    return out


def blend_into_seam(action, pose, frames_weights):
    """Ease the baked curves onto an exact seam pose over the given frames.

    Value-exact seams are a contract requirement, but a baked arm that merely *ends near*
    the seam still snaps on the last frame. Blending the tail in makes the last key both
    exact and smooth. Quaternions are slerped so the hand does not unwind on the way.
    """
    target = pose_channels(pose)
    curves = {(fc.data_path, fc.array_index): fc for fc in action.fcurves}
    quats = {}
    for (path, index), fcurve in curves.items():
        if path.endswith("rotation_quaternion"):
            quats.setdefault(path, {})[index] = fcurve
    for frame, weight in frames_weights:
        for path, axes in quats.items():
            if len(axes) != 4:
                continue
            keys = [next(kp for kp in axes[i].keyframe_points if abs(kp.co[0] - frame) < 0.5)
                    for i in range(4)]
            baked = Quaternion([kp.co[1] for kp in keys])
            goal = Quaternion([target[(path, i)] for i in range(4)])
            if baked.dot(goal) < 0.0:
                goal.negate()
            mixed = baked.slerp(goal, weight)
            for i, kp in enumerate(keys):
                kp.co[1] = mixed[i]
        for (path, index), fcurve in curves.items():
            if path.endswith("rotation_quaternion"):
                continue
            kp = next(k for k in fcurve.keyframe_points if abs(k.co[0] - frame) < 0.5)
            kp.co[1] = kp.co[1] + (target[(path, index)] - kp.co[1]) * weight
    for fcurve in curves.values():
        fcurve.update()


def parse_args():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    p = argparse.ArgumentParser(description="Rebuild the right-arm throw Action.")
    p.add_argument("--save", action="store_true", help="write the .blend back in place")
    return p.parse_args(argv)


def read_pose(arm, bones):
    pose = {}
    for name in bones:
        pb = arm.pose.bones[name]
        pose[name] = {
            "loc": list(pb.location),
            "scale": list(pb.scale),
            "rot": list(pb.rotation_quaternion if pb.rotation_mode == "QUATERNION"
                        else pb.rotation_euler),
        }
    return pose


def write_pose(arm, pose):
    for name, v in pose.items():
        if name.startswith("_"):
            continue
        pb = arm.pose.bones[name]
        pb.location = v["loc"]
        pb.scale = v["scale"]
        if pb.rotation_mode == "QUATERNION":
            pb.rotation_quaternion = v["rot"]
        else:
            pb.rotation_euler = v["rot"]


def key_pose(arm, bones, frame):
    for name in bones:
        pb = arm.pose.bones[name]
        pb.keyframe_insert("location", frame=frame, group=name)
        pb.keyframe_insert("scale", frame=frame, group=name)
        pb.keyframe_insert(
            "rotation_quaternion" if pb.rotation_mode == "QUATERNION" else "rotation_euler",
            frame=frame, group=name)


def sample(arm, scene, action_name, frame, bones):
    arm.animation_data.action = bpy.data.actions[action_name]
    scene.frame_set(frame)
    bpy.context.view_layer.update()
    pose = read_pose(arm, bones)
    q_parent = solved_quaternion(arm, SOLVED_PARENT)
    q_wrist = arm.pose.bones[WRIST].matrix.to_quaternion()
    q_rel = q_parent.inverted() @ q_wrist
    q_rel.normalize()
    if q_rel.w < 0.0:
        q_rel.negate()
    pose["_wrist_rel"] = q_rel
    return pose


def set_world(pb, position, quat=None):
    matrix = quat.to_matrix().to_4x4() if quat is not None else pb.matrix.copy()
    matrix.translation = Vector(position)
    pb.matrix = matrix


def main():
    args = parse_args()
    arm = bpy.data.objects.get(ARMATURE)
    if arm is None or arm.type != "ARMATURE":
        print("error: armature not found: %s" % ARMATURE)
        sys.exit(1)
    if arm.animation_data is None:
        arm.animation_data_create()

    template = bpy.data.actions.get(CHANNEL_TEMPLATE)
    if template is None:
        print("error: channel template Action not found: %s" % CHANNEL_TEMPLATE)
        sys.exit(1)
    bones = sorted({fc.data_path.split('"')[1] for fc in template.fcurves})

    scene = bpy.context.scene
    stored_pose = read_pose(arm, [pb.name for pb in arm.pose.bones])
    stored_action = arm.animation_data.action
    stored_frame = scene.frame_current

    bases = {
        "hold": sample(arm, scene, START_FROM[0], START_FROM[1], bones),
        "grip": sample(arm, scene, GRIP_HAND[0], GRIP_HAND[1], bones),
        "hang": sample(arm, scene, END_AT[0], END_AT[1], bones),
        "open": sample(arm, scene, OPEN_HAND[0], OPEN_HAND[1], bones),
    }
    align_hemisphere(bases["grip"], bases["hold"])
    align_hemisphere(bases["open"], bases["hold"])
    q_grip = bases["hold"]["_wrist_rel"]
    q_hang = bases["hang"]["_wrist_rel"]

    # Author against the pose the file is stored with: `root`, the left arm and the
    # camera bone are NOT part of a single-arm clip, so they stay at their stored values
    # both here and wherever this clip is played back. Leaving them wherever sampling
    # happened to park them moves the shoulder, and every IK solve below drifts with it.
    write_pose(arm, stored_pose)

    existing = bpy.data.actions.get(ACTION)
    if existing is not None:
        bpy.data.actions.remove(existing)
    action = bpy.data.actions.new(ACTION)
    action.use_fake_user = True
    arm.animation_data.action = action

    wrist = arm.pose.bones[WRIST]
    pole = arm.pose.bones[POLE]
    key_frames = [k[0] for k in KEYS]
    tracks = {
        "wx": [k[1][0] for k in KEYS], "wy": [k[1][1] for k in KEYS], "wz": [k[1][2] for k in KEYS],
        "px": [k[2][0] for k in KEYS], "py": [k[2][1] for k in KEYS], "pz": [k[2][2] for k in KEYS],
        "blend": [k[3] for k in KEYS], "snap": [k[4] for k in KEYS],
        "sx": [k[6][0] for k in KEYS], "sy": [k[6][1] for k in KEYS], "sz": [k[6][2] for k in KEYS],
    }

    def finger_pose(frame):
        """Hand poses are swapped, not curved: cross-fade between the two bracketing bases."""
        i = max(j for j in range(len(KEYS)) if KEYS[j][0] <= frame)
        here = KEYS[i][5]
        if i + 1 >= len(KEYS) or KEYS[i + 1][5] == here:
            return bases[here]
        span = KEYS[i + 1][0] - KEYS[i][0]
        return blend_poses(bases[here], bases[KEYS[i + 1][5]],
                           smoothstep((frame - KEYS[i][0]) / span))

    # Solve and key EVERY frame. The forearm is IK-solved through a wide arc, so a hand
    # orientation keyed only at the poses gets interpolated as raw quaternion channels
    # between them -- which is what threw the wrist through 180 degrees mid-throw. Deriving
    # it from the freshly solved forearm each frame removes the interpolation entirely.
    previous_wrist = None
    for frame in range(key_frames[0], key_frames[-1] + 1):
        scene.frame_set(frame)
        write_pose(arm, finger_pose(frame))
        arm.pose.bones[SHOULDER].rotation_euler = (
            hermite(key_frames, tracks["sx"], frame),
            hermite(key_frames, tracks["sy"], frame),
            hermite(key_frames, tracks["sz"], frame))
        set_world(pole, [hermite(key_frames, tracks[k], frame) for k in ("px", "py", "pz")])
        wrist_pos = [hermite(key_frames, tracks[k], frame) for k in ("wx", "wy", "wz")]
        set_world(wrist, wrist_pos)
        bpy.context.view_layer.update()
        q_parent = solved_quaternion(arm, SOLVED_PARENT)
        # A Catmull-Rom tangent can overshoot; slerp will not take a factor outside [0, 1].
        q_rel = q_grip.slerp(q_hang, min(1.0, max(0.0, hermite(key_frames, tracks["blend"], frame))))
        snap = hermite(key_frames, tracks["snap"], frame)
        if abs(snap) > 1e-6:
            q_rel = q_rel @ Quaternion((1.0, 0.0, 0.0), math.radians(snap))
        set_world(wrist, wrist_pos, q_parent @ q_rel)
        # Blender picks the sign when it decomposes the matrix; the stored basis is what a
        # later edit interpolates, so settle the hemisphere on the basis, not on the world.
        if previous_wrist is not None and wrist.rotation_quaternion.dot(previous_wrist) < 0.0:
            wrist.rotation_quaternion.negate()
        previous_wrist = wrist.rotation_quaternion.copy()
        bpy.context.view_layer.update()
        key_pose(arm, bones, frame)

    # Seams must be value-exact AND smooth: a baked arm that merely ends near the seam
    # still snaps on the final frame. Ease the last/first frames onto the exact pose.
    tail = [(KEYS[-1][0] - 4, 0.10), (KEYS[-1][0] - 3, 0.35), (KEYS[-1][0] - 2, 0.65),
            (KEYS[-1][0] - 1, 0.90), (KEYS[-1][0], 1.0)]
    blend_into_seam(action, bases["hang"], tail)
    head = [(KEYS[0][0] + 2, 0.20), (KEYS[0][0] + 1, 0.55), (KEYS[0][0], 1.0)]
    blend_into_seam(action, bases["hold"], head)

    for fcurve in action.fcurves:
        for kp in fcurve.keyframe_points:
            kp.interpolation = "LINEAR"
        fcurve.update()

    arm.animation_data.action = stored_action
    scene.frame_set(stored_frame)
    write_pose(arm, stored_pose)

    print("%s: %d fcurves, frames %d-%d, bones %d"
          % (ACTION, len(action.fcurves), KEYS[0][0], KEYS[-1][0], len(bones)))
    same_channels = ({(fc.data_path, fc.array_index) for fc in action.fcurves}
                     == {(fc.data_path, fc.array_index) for fc in template.fcurves})
    print("channel set matches %s: %s" % (CHANNEL_TEMPLATE, same_channels))
    breaks = hemisphere_breaks(action)
    print("quaternion hemisphere breaks: %d%s"
          % (len(breaks), "" if not breaks else " -- %s" % breaks[:4]))
    for label, (src_action, src_frame), frame in (
            ("start", START_FROM, KEYS[0][0]), ("end", END_AT, KEYS[-1][0])):
        src = {(fc.data_path, fc.array_index): fc.evaluate(src_frame)
               for fc in bpy.data.actions[src_action].fcurves}
        mine = {(fc.data_path, fc.array_index): fc.evaluate(frame) for fc in action.fcurves}
        worst = max(abs(mine[k] - src[k]) for k in mine) if set(mine) <= set(src) else float("nan")
        print("seam %s f%d vs %s f%d: max delta %g" % (label, frame, src_action, src_frame, worst))

    if args.save:
        bpy.ops.wm.save_mainfile()
        print("saved %s" % bpy.data.filepath)


if __name__ == "__main__":
    main()
