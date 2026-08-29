"""
Build the "pick-up-from-the-ground while holding a test tube" variant of `grab_ground`.

`grab_ground` is left untouched. The variant is a full two-handed copy of it -- same
camera, root, left arm and right-arm path -- with ONLY the right hand's shape replaced by
a cylindrical grip, plus a preview tube prop parented into that hand.

Contract: docs/architecture/contracts/手臂动画状态机.md
  - preview props (`knife_dummy`, `Helmet_Placeholder`, `GameScanner`, and now
    `tube_dummy`) never export with a clip; the in-game prop is attached by gameplay.
  - the stored (unkeyed) pose the file is saved with is left untouched.

Usage:

    /Applications/Blender.app/Contents/MacOS/Blender --background \
      SourceArt/Blender/ArmsRig/arms_rig_all.blend \
      --python Tools/blender/author_arms_grab_tube.py -- --save
"""

import argparse
import math
import sys

import bpy
from mathutils import Matrix, Quaternion, Vector

ARMATURE = "ArmsRig"
SOURCE_ACTION = "grab_ground"
ACTION = "grab_ground_tube"

TUBE_FBX = "/Users/yawen/Downloads/source/Tube.fbx"
TUBE_OBJECT = "tube_dummy"
TUBE_LENGTH = 0.16                 # metres, agreed with the artist
TUBE_MODEL_AXIS = "Y"              # the imported mesh runs along its own Y

# Where a cylinder sits in this hand, in hand.R space -- taken from the rig's own
# `knife_dummy`, which is an authored cylindrical grip in this exact hand: its origin sits
# at (-0.0205, 0.0975) with the blade running along +Z. The fingers curl toward -X, so a
# prop centred on +X ends up resting on the BACK of the hand. Z is pushed out so the tube
# is gripped by its lower third and stands proud of the fist -- centred, an 8 cm tube
# disappears inside a closed hand almost entirely.
GRIP_BOTTOM = -0.050                   # hand-space Z of the tube's lower end
GRIP_CENTRE = Vector((-0.0205, 0.0975, GRIP_BOTTOM + TUBE_LENGTH / 2.0))
GRIP_AXIS = Vector((0.0, 0.0, -1.0))

# The right hand's SHAPE -- everything the grip changes. shoulder/handIK/elbowIK are the
# arm's path and stay exactly as `grab_ground` authored them.
HAND_SHAPE_PREFIXES = ("palm.", "f_index.", "f_middle.", "f_ring.", "f_pinky.", "thumb.")
GRIP_SOURCE = ("knife_idle", 1)    # the rig's own authored cylindrical grip

# Keeping the tube's mouth up is OFF by default, and the measurement is why: uprightness is
# bought entirely with forearm pronation, which on this rig is the elbow pole, and the rolls
# that stand the tube up pull the elbow 15-20 cm inboard of where `grab_ground` carries it.
# Measured trade-off (elbow inboard allowance -> worst/mean tilt): 0mm 67/50, 40mm 58/40,
# 80mm 43/31, 120mm 38/22, 200mm 24/4. Turn this on and set ELBOW_SLACK to pick a point.
# This rotates the WRIST only: the IK
# constraint ignores its target's rotation, so `handIK.R` can be turned without moving the
# arm a millimetre. The correction is clamped to whatever the joint can actually do.
UPRIGHT_TUBE = False
TUBE_MOUTH = Vector((0.0, 0.0, 1.0))   # in hand.R space -- the end that stands out
WORLD_UP = Vector((0.0, 0.0, 1.0))

# Anatomical limits for hand.R relative to forearm.R, as YXZ euler in degrees.
# validate_wrist.py's project defaults (twist 90 / swing 85) are far looser than a wrist
# and will happily pass a snapped one, so this pass holds itself to real joint ranges.
# Keeping a held object vertical is mostly PRONATION -- that lives in the forearm's roll,
# not the wrist, which is why this pass turns the elbow pole first and only then asks the
# wrist for what is left.
MAX_FLEX = 55.0                        # X: flexion / extension
MAX_WRIST_TWIST = 15.0                 # Y: the wrist barely twists at all
MAX_DEVIATION = 22.0                   # Z: radial / ulnar deviation
POLE_STEPS = 72                        # roll resolution, 5 degrees
ELBOW_SLACK = 0.15                     # how far inboard of `grab_ground`'s OWN elbow this
                                       # clip may sit, in metres. A fixed threshold is not
                                       # enough: the source elbow swings out to x = -0.435,
                                       # so anything parked at a constant -0.26 reads as the
                                       # elbow tucking IN compared to the animation it is a
                                       # variant of. The source track is the floor.
ELBOW_MIN_Y = -0.20                    # how far forward of the shoulder the elbow may go.
                                       # `grab_ground` itself carries the elbow FORWARD as
                                       # the character crouches (y = -0.080 at f14, -0.145 at
                                       # f28) and only holds it back while standing, so a
                                       # blanket "never forward" rule is wrong and was what
                                       # pushed the tube to 84 degrees off vertical.
OUTWARD_WEIGHT = 60.0                  # tie-break only; the hard limit above does the work
SMOOTH_RADIUS = 3                      # frames each side of the low-pass on the roll track
CONTINUITY_WEIGHT = 450.0              # degrees of tilt traded per metre the ELBOW moves.
                                       # Costing the roll angle instead looks equivalent but
                                       # is not: near full extension the elbow sits close to
                                       # the shoulder-wrist axis, so the same angle buys a
                                       # very different amount of elbow travel.
POLE_WEIGHT = 90.0                     # and per metre the POLE itself moves: near full
                                       # extension the pole is ill-conditioned and will
                                       # swing half a metre to buy a centimetre of elbow.


def joint_angles(q_parent, q_child):
    """(twist, swing) in degrees, the way validate_wrist.py measures a joint."""
    q_rel = q_parent.inverted() @ q_child
    twist_q = Quaternion((q_rel.w, 0.0, q_rel.y, 0.0))
    if twist_q.magnitude < 1e-8:
        return 180.0, 0.0
    twist_q.normalize()
    twist = math.degrees(2.0 * math.acos(min(1.0, abs(twist_q.w))))
    swing = math.degrees(2.0 * math.acos(min(1.0, abs((q_rel @ twist_q.inverted()).w))))
    return twist, swing


def evaluated(arm):
    depsgraph = bpy.context.evaluated_depsgraph_get()
    depsgraph.update()
    return arm.evaluated_get(depsgraph)


def clamp_wrist(q_forearm, q_want):
    """Nearest hand orientation to q_want that a real wrist can reach from q_forearm."""
    euler = (q_forearm.inverted() @ q_want).to_euler("YXZ")
    euler.x = math.radians(max(-MAX_FLEX, min(MAX_FLEX, math.degrees(euler.x))))
    euler.y = math.radians(max(-MAX_WRIST_TWIST, min(MAX_WRIST_TWIST, math.degrees(euler.y))))
    euler.z = math.radians(max(-MAX_DEVIATION, min(MAX_DEVIATION, math.degrees(euler.z))))
    return q_forearm @ euler.to_quaternion()


def upright_hand(q_hand):
    """Turn a hand orientation so the tube's mouth points up, changing nothing else."""
    return (q_hand @ TUBE_MOUTH).rotation_difference(WORLD_UP) @ q_hand


def source_elbow(arm, action, scene):
    """Where `grab_ground` puts the elbow on each frame -- the floor this variant must match."""
    arm.animation_data.action = action
    out = []
    for frame in range(int(action.frame_range[0]), int(action.frame_range[1]) + 1):
        scene.frame_set(frame)
        bpy.context.view_layer.update()
        out.append(evaluated(arm).pose.bones["forearm.R"].matrix.translation.copy())
    return out


def stand_tube_up(arm, action, scene, floor):
    """Roll the forearm with the elbow pole, then let the wrist take the remainder.

    The hand's POSITION is never touched -- `handIK.R` keeps the location `grab_ground`
    authored, so the reach is identical. What moves is the elbow, around the shoulder-wrist
    axis (the only thing a pole target can do), and the wrist inside its real range.

    Two things the naive per-frame search gets wrong, both fixed here:
      - it picks whichever roll is a degree better, so the elbow flickers between two
        near-equivalent solutions frame to frame;
      - it has no opinion about WHERE the elbow should be, so it happily tucks it against
        the ribs. An elbow carries outboard. Both are scored, then the chosen roll track is
        smoothed over time before anything is keyed.
    """
    wrist = arm.pose.bones["handIK.R"]
    pole = arm.pose.bones["elbowIK.R"]
    shoulder_head = arm.data.bones["upper_arm.R"].head_local
    start, end = int(action.frame_range[0]), int(action.frame_range[1])
    frames = list(range(start, end + 1))

    def apply_roll(frame_state, roll):
        """Place the pole at `roll` and return (forearm quat, elbow position)."""
        base_pole, wrist_pos, axis = frame_state
        matrix = pole.matrix.copy()
        matrix.translation = shoulder_head + (Quaternion(axis, roll) @ (base_pole - shoulder_head))
        pole.matrix = matrix
        bpy.context.view_layer.update()
        ev = evaluated(arm)
        return ev.pose.bones["forearm.R"].matrix.to_quaternion(), ev.pose.bones["forearm.R"].matrix.translation.copy()

    def set_wrist(wrist_pos, q_forearm):
        q_hand = clamp_wrist(q_forearm, upright_hand(q_forearm))
        matrix = q_hand.to_matrix().to_4x4()
        matrix.translation = wrist_pos
        wrist.matrix = matrix
        bpy.context.view_layer.update()
        reached = evaluated(arm).pose.bones["hand.R"].matrix.to_quaternion()
        return math.degrees((reached @ TUBE_MOUTH).angle(WORLD_UP))

    rolls = [2.0 * math.pi * i / POLE_STEPS for i in range(POLE_STEPS)]

    def angular(a, b):
        return abs((a - b + math.pi) % (2.0 * math.pi) - math.pi)

    # Pass 1 -- tabulate what every roll costs on every frame.
    states, table = [], []
    for frame in frames:
        scene.frame_set(frame)
        bpy.context.view_layer.update()
        wrist_pos = wrist.matrix.translation.copy()
        axis = wrist_pos - shoulder_head
        axis = axis.normalized() if axis.length > 1e-6 else Vector((0.0, 0.0, 1.0))
        state = (pole.matrix.translation.copy(), wrist_pos, axis)
        states.append(state)
        row = []
        for roll in rolls:
            q_forearm, elbow = apply_roll(state, roll)
            pole_at = shoulder_head + (Quaternion(state[2], roll) @ (state[0] - shoulder_head))
            row.append((set_wrist(wrist_pos, q_forearm), elbow.copy(), pole_at))
        limit = floor[len(states) - 1].x + ELBOW_SLACK
        legal = [i for i, entry in enumerate(row)
                 if entry[1].x <= limit and entry[1].y >= ELBOW_MIN_Y]
        if not legal:                                  # unreachable: take the most outboard
            legal = sorted(range(len(row)), key=lambda i: row[i][1].x)[:6]
        table.append((row, set(legal)))

    # Pass 2 -- cheapest path through the table. Choosing each frame's roll on its own is
    # what produced both failures seen so far: greedy-per-frame flickers between two
    # near-equal minima, and greedy-along-time walks into a corner it cannot back out of.
    # A single shortest-path pass has neither problem, and the transition cost IS the
    # smoothness, so nothing has to be filtered afterwards.
    INF = float("inf")
    def emission(f, i):
        tilt, elbow, _ = table[f][0][i]
        return (tilt + OUTWARD_WEIGHT * elbow.x) if i in table[f][1] else INF

    cost = [emission(0, i) for i in range(POLE_STEPS)]
    back = []
    for f in range(1, len(frames)):
        step_cost, step_back = [], []
        for i in range(POLE_STEPS):
            here = emission(f, i)
            if here == INF:
                step_cost.append(INF); step_back.append(0); continue
            best_j, best_v = 0, INF
            for j in range(POLE_STEPS):
                if cost[j] == INF:
                    continue
                v = (cost[j]
                     + CONTINUITY_WEIGHT * (table[f][0][i][1] - table[f - 1][0][j][1]).length
                     + POLE_WEIGHT * (table[f][0][i][2] - table[f - 1][0][j][2]).length)
                if v < best_v:
                    best_j, best_v = j, v
            step_cost.append(best_v + here); step_back.append(best_j)
        cost, _ = step_cost, None
        back.append(step_back)

    index = min(range(POLE_STEPS), key=lambda i: cost[i])
    path = [index]
    for step_back in reversed(back):
        index = step_back[index]
        path.append(index)
    path.reverse()
    solved = [rolls[i] for i in path]

    # Pass 2b -- the transition cost is linear in |delta roll|, which prices a zigzag exactly
    # the same as a straight move, so the path can still buzz between neighbouring rolls.
    # Low-pass it, then pull any frame that left the legal region back along the segment
    # towards its solved value. Continuous pullback, not a snap to the nearest legal sample:
    # snapping is what made this jitter worse the last time.
    smoothed = []
    for i, state in enumerate(states):
        lo, hi = max(0, i - SMOOTH_RADIUS), min(len(solved), i + SMOOTH_RADIUS + 1)
        target = sum(solved[lo:hi]) / (hi - lo)
        scene.frame_set(frames[i])
        bpy.context.view_layer.update()
        limit = floor[i].x + ELBOW_SLACK

        def outside(roll):
            elbow = apply_roll(state, roll)[1]
            return elbow.x > limit or elbow.y < ELBOW_MIN_Y

        if outside(target):
            low, high = 0.0, 1.0                       # 0 = solved (legal), 1 = smoothed
            for _ in range(8):
                mid = (low + high) / 2.0
                if not outside(solved[i] + (target - solved[i]) * mid):
                    low = mid
                else:
                    high = mid
            target = solved[i] + (target - solved[i]) * low
        smoothed.append(target)

    # Pass 3 -- apply the chosen track and key it.
    previous_wrist = None
    worst = 0.0
    elbow_x = []
    for frame, state, roll in zip(frames, states, smoothed):
        scene.frame_set(frame)
        bpy.context.view_layer.update()
        q_forearm, elbow = apply_roll(state, roll)
        worst = max(worst, set_wrist(state[1], q_forearm))
        elbow_x.append(elbow.x)
        if previous_wrist is not None and wrist.rotation_quaternion.dot(previous_wrist) < 0.0:
            wrist.rotation_quaternion.negate()
        previous_wrist = wrist.rotation_quaternion.copy()
        wrist.keyframe_insert("rotation_quaternion", frame=frame, group="handIK.R")
        pole.keyframe_insert("location", frame=frame, group="elbowIK.R")
    inboard = max(x - floor[i].x for i, x in enumerate(elbow_x))
    print("tube upright: worst mouth tilt %.0f deg | elbow x %.3f..%.3f, at worst %.0f mm inboard of %s"
          % (worst, min(elbow_x), max(elbow_x), inboard * 1000.0, SOURCE_ACTION))


def parse_args():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    p = argparse.ArgumentParser(description="Build the tube variant of grab_ground.")
    p.add_argument("--save", action="store_true", help="write the .blend back in place")
    p.add_argument("--skip-prop", action="store_true", help="only rebuild the Action")
    return p.parse_args(argv)


def hand_shape_bones(arm):
    return [pb.name for pb in arm.pose.bones
            if pb.name.endswith(".R") and pb.name.startswith(HAND_SHAPE_PREFIXES)]


def read_pose(arm, bones):
    out = {}
    for name in bones:
        pb = arm.pose.bones[name]
        out[name] = {
            "loc": list(pb.location),
            "scale": list(pb.scale),
            "rot": list(pb.rotation_quaternion if pb.rotation_mode == "QUATERNION"
                        else pb.rotation_euler),
        }
    return out


def write_pose(arm, pose):
    for name, v in pose.items():
        pb = arm.pose.bones[name]
        pb.location = v["loc"]
        pb.scale = v["scale"]
        if pb.rotation_mode == "QUATERNION":
            pb.rotation_quaternion = v["rot"]
        else:
            pb.rotation_euler = v["rot"]


def import_tube(arm):
    """(Re)import the preview tube and lock it into the right hand."""
    existing = bpy.data.objects.get(TUBE_OBJECT)
    if existing is not None:
        bpy.data.objects.remove(existing, do_unlink=True)

    before = set(bpy.data.objects)
    bpy.ops.import_scene.fbx(filepath=TUBE_FBX)
    imported = [o for o in set(bpy.data.objects) - before if o.type == "MESH"]
    if len(imported) != 1:
        print("error: expected one mesh in %s, got %d" % (TUBE_FBX, len(imported)))
        sys.exit(1)
    tube = imported[0]
    for stray in set(bpy.data.objects) - before:
        if stray is not tube:
            bpy.data.objects.remove(stray, do_unlink=True)
    tube.name = TUBE_OBJECT
    tube.data.name = TUBE_OBJECT

    axis = "XYZ".index(TUBE_MODEL_AXIS)
    tube.scale = [s * (TUBE_LENGTH / tube.dimensions[axis]) for s in tube.scale]
    bpy.context.view_layer.update()

    # Park it beside the reference props so it can never be picked up by an export.
    for collection in list(tube.users_collection):
        collection.objects.unlink(tube)
    knife = bpy.data.objects.get("knife_dummy")
    home = knife.users_collection[0] if knife and knife.users_collection else bpy.context.scene.collection
    home.objects.link(tube)

    tube.parent = arm
    tube.parent_type = "BONE"
    tube.parent_bone = "hand.R"
    bpy.context.view_layer.update()
    return tube


def place_in_hand(arm, tube):
    """Seat the tube on the measured grip axis of hand.R."""
    hand = arm.pose.bones["hand.R"].matrix
    # model Y -> grip axis, with an arbitrary but stable roll
    forward = GRIP_AXIS
    up = Vector((1.0, 0.0, 0.0))
    if abs(forward.dot(up)) > 0.9:
        up = Vector((0.0, 1.0, 0.0))
    right = forward.cross(up).normalized()
    up = right.cross(forward).normalized()
    basis = Matrix((right, forward, up)).transposed().to_4x4()
    local = Matrix.Translation(GRIP_CENTRE) @ basis
    scale = tube.matrix_world.to_scale()
    world = hand @ local
    tube.matrix_world = world @ Matrix.Diagonal(scale.to_4d())
    bpy.context.view_layer.update()


def main():
    args = parse_args()
    arm = bpy.data.objects.get(ARMATURE)
    if arm is None or arm.type != "ARMATURE":
        print("error: armature not found: %s" % ARMATURE)
        sys.exit(1)
    source = bpy.data.actions.get(SOURCE_ACTION)
    if source is None:
        print("error: source Action not found: %s" % SOURCE_ACTION)
        sys.exit(1)

    scene = bpy.context.scene
    all_bones = [pb.name for pb in arm.pose.bones]
    stored_pose = read_pose(arm, all_bones)
    stored_action = arm.animation_data.action if arm.animation_data else None
    stored_frame = scene.frame_current
    if arm.animation_data is None:
        arm.animation_data_create()

    shape_bones = hand_shape_bones(arm)
    arm.animation_data.action = bpy.data.actions[GRIP_SOURCE[0]]
    scene.frame_set(GRIP_SOURCE[1])
    bpy.context.view_layer.update()
    grip = read_pose(arm, shape_bones)

    existing = bpy.data.actions.get(ACTION)
    if existing is not None:
        bpy.data.actions.remove(existing)
    action = source.copy()
    action.name = ACTION
    action.use_fake_user = True
    arm.animation_data.action = action

    # Overwrite only the hand-shape channels, leaving every other curve byte-identical
    # to `grab_ground` -- that is what "only the right hand changes" has to mean.
    targets = {}
    for name, values in grip.items():
        prefix = 'pose.bones["%s"].' % name
        for i, v in enumerate(values["loc"]):
            targets[(prefix + "location", i)] = v
        for i, v in enumerate(values["scale"]):
            targets[(prefix + "scale", i)] = v
        path = "rotation_quaternion" if len(values["rot"]) == 4 else "rotation_euler"
        for i, v in enumerate(values["rot"]):
            targets[(prefix + path, i)] = v

    touched = 0
    for fcurve in action.fcurves:
        key = (fcurve.data_path, fcurve.array_index)
        if key not in targets:
            continue
        touched += 1
        for kp in fcurve.keyframe_points:
            kp.co[1] = targets[key]
            kp.handle_left[1] = targets[key]
            kp.handle_right[1] = targets[key]
        fcurve.update()

    print("%s: copied from %s, %d fcurves, frames %d-%d"
          % (ACTION, SOURCE_ACTION, len(action.fcurves),
             int(action.frame_range[0]), int(action.frame_range[1])))
    print("hand-shape channels rewritten: %d over %d bones" % (touched, len(shape_bones)))
    untouched = sum(1 for fc in action.fcurves if (fc.data_path, fc.array_index) not in targets)
    print("channels left identical to %s: %d" % (SOURCE_ACTION, untouched))

    if UPRIGHT_TUBE:
        floor = source_elbow(arm, source, scene)
        arm.animation_data.action = action
        stand_tube_up(arm, action, scene, floor)

    if not args.skip_prop:
        tube = import_tube(arm)
        scene.frame_set(int(action.frame_range[1]))
        bpy.context.view_layer.update()
        place_in_hand(arm, tube)
        print("%s: %.3f x %.3f x %.3f m, parented to hand.R"
              % (TUBE_OBJECT, tube.dimensions.x, tube.dimensions.y, tube.dimensions.z))

    arm.animation_data.action = stored_action
    scene.frame_set(stored_frame)
    write_pose(arm, stored_pose)

    if args.save:
        bpy.ops.wm.save_mainfile()
        print("saved %s" % bpy.data.filepath)


if __name__ == "__main__":
    main()
