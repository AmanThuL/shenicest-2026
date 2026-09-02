"""Build the compact Chapter House laboratory connection.

The module is authored in Unity metres. Its origin is the centre of the south
wall at the Chapter House finished-floor height. Blender +Z is up, and the
laboratory connection extends along -Y (exported as Unity -Z).

Only a first-storey arch and a local patch for the retired offset door belong
to this module. The Chapter House upper galleries remain owned by the original
building mesh.
"""

import math
from pathlib import Path

import bpy


OPENING_HALF_WIDTH = 1.875
OPENING_SPRING_HEIGHT = 1.15
OPENING_ARCH_RISE = 1.63
FRAME_THICKNESS = 0.20
FRAME_DEPTH = 0.32
SURROUND_HALF_WIDTH = 2.50
SURROUND_TOP = 3.14
SURROUND_BACK = -0.06
SURROUND_FRONT = 0.12
TUNNEL_LENGTH = 6.2
FLOOR_THICKNESS = 0.13
FLOOR_LAB_END = -6.44
FLOOR_CHAPTER_END = -0.34
LEGACY_PATCH_CENTER_X = -4.80
LEGACY_PATCH_WIDTH = 2.50
LEGACY_PATCH_BOTTOM = -0.065
LEGACY_PATCH_TOP = 2.985
LEGACY_PATCH_DEPTH = 0.14
ARCH_SEGMENTS = 24
DOOR_DEPTH = 0.12
DOOR_WALL_OFFSET = -0.22


def clear_scene():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for datablocks in (bpy.data.meshes, bpy.data.curves, bpy.data.materials):
        for datablock in list(datablocks):
            if datablock.users == 0:
                datablocks.remove(datablock)


def ensure_material(name, colour, metallic=0.0, roughness=0.7):
    material = bpy.data.materials.get(name)
    if material is None:
        material = bpy.data.materials.new(name)
    material.diffuse_color = (*colour, 1.0)
    material.metallic = metallic
    material.roughness = roughness
    return material


def move_to_collection(obj, collection):
    for target in list(obj.users_collection):
        target.objects.unlink(obj)
    collection.objects.link(obj)


def add_box(name, location, dimensions, material, collection):
    bpy.ops.mesh.primitive_cube_add(size=1.0, location=location)
    obj = bpy.context.active_object
    obj.name = name
    obj.dimensions = dimensions
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(material)
    move_to_collection(obj, collection)
    return obj


def arch_profile(half_width, spring_height, rise, bottom):
    points = [(-half_width, bottom), (-half_width, spring_height)]
    for index in range(1, ARCH_SEGMENTS + 1):
        angle = math.pi - math.pi * index / ARCH_SEGMENTS
        points.append((half_width * math.cos(angle), spring_height + rise * math.sin(angle)))
    points.append((half_width, bottom))
    return points


def add_arch_frame(name, material, collection):
    inner = arch_profile(
        OPENING_HALF_WIDTH,
        OPENING_SPRING_HEIGHT,
        OPENING_ARCH_RISE,
        0.0,
    )
    outer = arch_profile(
        OPENING_HALF_WIDTH + FRAME_THICKNESS,
        OPENING_SPRING_HEIGHT,
        OPENING_ARCH_RISE + FRAME_THICKNESS,
        -0.065,
    )
    vertices = []
    y_values = (-FRAME_DEPTH * 0.5, FRAME_DEPTH * 0.5)
    for y_value in y_values:
        for profile in (inner, outer):
            for x_value, z_value in profile:
                vertices.append((x_value, y_value, z_value))

    count = len(inner)

    def vertex(layer, profile, index):
        return layer * count * 2 + profile * count + index

    faces = []
    for index in range(count - 1):
        next_index = index + 1
        faces.append((
            vertex(1, 0, index), vertex(1, 0, next_index),
            vertex(1, 1, next_index), vertex(1, 1, index),
        ))
        faces.append((
            vertex(0, 1, index), vertex(0, 1, next_index),
            vertex(0, 0, next_index), vertex(0, 0, index),
        ))
        faces.append((
            vertex(0, 0, index), vertex(0, 0, next_index),
            vertex(1, 0, next_index), vertex(1, 0, index),
        ))
        faces.append((
            vertex(1, 1, index), vertex(1, 1, next_index),
            vertex(0, 1, next_index), vertex(0, 1, index),
        ))

    mesh = bpy.data.meshes.new(name + "Mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    obj = bpy.data.objects.new(name, mesh)
    collection.objects.link(obj)
    return obj


def add_arch_door_leaf(name, side, material, collection):
    """Build one half of a closed arch-shaped sliding door."""
    half_segments = ARCH_SEGMENTS // 2
    top = OPENING_SPRING_HEIGHT + OPENING_ARCH_RISE

    if side == "LEFT":
        profile = [
            (-OPENING_HALF_WIDTH, 0.0),
            (0.0, 0.0),
            (0.0, top),
        ]
        for index in range(1, half_segments + 1):
            angle = math.pi * 0.5 + math.pi * 0.5 * index / half_segments
            profile.append((
                OPENING_HALF_WIDTH * math.cos(angle),
                OPENING_SPRING_HEIGHT + OPENING_ARCH_RISE * math.sin(angle),
            ))
    elif side == "RIGHT":
        profile = [
            (0.0, 0.0),
            (OPENING_HALF_WIDTH, 0.0),
            (OPENING_HALF_WIDTH, OPENING_SPRING_HEIGHT),
        ]
        for index in range(1, half_segments + 1):
            angle = math.pi * 0.5 * index / half_segments
            profile.append((
                OPENING_HALF_WIDTH * math.cos(angle),
                OPENING_SPRING_HEIGHT + OPENING_ARCH_RISE * math.sin(angle),
            ))
    else:
        raise ValueError("side must be LEFT or RIGHT")

    vertices = []
    for y_value in (-DOOR_DEPTH * 0.5, DOOR_DEPTH * 0.5):
        for x_value, z_value in profile:
            vertices.append((x_value, y_value + DOOR_WALL_OFFSET, z_value))

    count = len(profile)
    faces = []
    faces.append(tuple(range(count - 1, -1, -1)))
    faces.append(tuple(range(count, count * 2)))

    for index in range(count):
        next_index = (index + 1) % count
        faces.append((index, next_index, count + next_index, count + index))

    mesh = bpy.data.meshes.new(name + "Mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    obj = bpy.data.objects.new(name, mesh)
    collection.objects.link(obj)

    bevel = obj.modifiers.new("DoorEdgeBevel", "BEVEL")
    bevel.width = 0.025
    bevel.segments = 2
    return obj


def add_tunnel(name, material, collection):
    profile = arch_profile(
        OPENING_HALF_WIDTH,
        OPENING_SPRING_HEIGHT,
        OPENING_ARCH_RISE,
        0.0,
    )
    vertices = []
    for y_value in (-TUNNEL_LENGTH, 0.0):
        for x_value, z_value in profile:
            vertices.append((x_value, y_value, z_value))

    count = len(profile)
    faces = []
    for index in range(count - 1):
        faces.append((index, index + 1, count + index + 1, count + index))

    mesh = bpy.data.meshes.new(name + "Mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    obj = bpy.data.objects.new(name, mesh)
    collection.objects.link(obj)
    return obj


def add_arch_surround(material, collection):
    side_width = SURROUND_HALF_WIDTH - OPENING_HALF_WIDTH
    side_center = OPENING_HALF_WIDTH + side_width * 0.5
    surround_height = SURROUND_TOP + 0.065
    add_box(
        "RoundEntrance_FirstStoreySurround_Left",
        (-side_center, (SURROUND_BACK + SURROUND_FRONT) * 0.5,
         -0.065 + surround_height * 0.5),
        (side_width, SURROUND_FRONT - SURROUND_BACK, surround_height),
        material,
        collection,
    )
    add_box(
        "RoundEntrance_FirstStoreySurround_Right",
        (side_center, (SURROUND_BACK + SURROUND_FRONT) * 0.5,
         -0.065 + surround_height * 0.5),
        (side_width, SURROUND_FRONT - SURROUND_BACK, surround_height),
        material,
        collection,
    )

    profile = arch_profile(
        OPENING_HALF_WIDTH,
        OPENING_SPRING_HEIGHT,
        OPENING_ARCH_RISE,
        0.0,
    )
    vertices = []
    faces = []
    for index in range(1, len(profile) - 2):
        start_x, start_z = profile[index]
        end_x, end_z = profile[index + 1]
        base = len(vertices)
        vertices.extend((
            (start_x, SURROUND_BACK, start_z),
            (end_x, SURROUND_BACK, end_z),
            (end_x, SURROUND_BACK, SURROUND_TOP),
            (start_x, SURROUND_BACK, SURROUND_TOP),
            (start_x, SURROUND_FRONT, start_z),
            (end_x, SURROUND_FRONT, end_z),
            (end_x, SURROUND_FRONT, SURROUND_TOP),
            (start_x, SURROUND_FRONT, SURROUND_TOP),
        ))
        faces.extend((
            (base, base + 3, base + 2, base + 1),
            (base + 4, base + 5, base + 6, base + 7),
            (base, base + 1, base + 5, base + 4),
            (base + 3, base + 7, base + 6, base + 2),
            (base, base + 4, base + 7, base + 3),
            (base + 1, base + 2, base + 6, base + 5),
        ))

    mesh = bpy.data.meshes.new("RoundEntrance_FirstStoreySurround_UpperMesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.materials.append(material)
    obj = bpy.data.objects.new("RoundEntrance_FirstStoreySurround_Upper", mesh)
    collection.objects.link(obj)
    return obj


def build(output_path):
    clear_scene()
    scene = bpy.context.scene
    scene.unit_settings.system = "METRIC"
    scene.unit_settings.scale_length = 1.0

    collection = bpy.data.collections.new("ChapterHouseRoundEntrance_Export")
    scene.collection.children.link(collection)

    wall = ensure_material("RoundEntrance_Wall", (0.10, 0.16, 0.24), roughness=0.86)
    stone = ensure_material("RoundEntrance_Stone", (0.12, 0.22, 0.33), roughness=0.78)
    floor = ensure_material("RoundEntrance_Floor", (0.14, 0.17, 0.20), roughness=0.88)

    patch_height = LEGACY_PATCH_TOP - LEGACY_PATCH_BOTTOM
    add_box(
        "RoundEntrance_LegacyDoorPatch",
        (LEGACY_PATCH_CENTER_X, 0.0, LEGACY_PATCH_BOTTOM + patch_height * 0.5),
        (LEGACY_PATCH_WIDTH, LEGACY_PATCH_DEPTH, patch_height),
        wall,
        collection,
    )
    for index, x_value in enumerate((-5.62, -4.80, -3.98), start=1):
        add_box(
            "RoundEntrance_LegacyDoorPatchPanel_%02d" % index,
            (x_value, 0.09, 1.30),
            (0.68, 0.04, 2.20),
            stone,
            collection,
        )
    add_arch_surround(wall, collection)
    add_arch_frame("RoundEntrance_ArchFrame", stone, collection)
    add_tunnel("RoundEntrance_TunnelShell", stone, collection)
    add_arch_door_leaf("RoundEntrance_Door_Left", "LEFT", wall, collection)
    add_arch_door_leaf("RoundEntrance_Door_Right", "RIGHT", wall, collection)
    floor_length = FLOOR_CHAPTER_END - FLOOR_LAB_END
    add_box(
        "RoundEntrance_Floor",
        (0.0, (FLOOR_LAB_END + FLOOR_CHAPTER_END) * 0.5, -FLOOR_THICKNESS * 0.5 - 0.002),
        (OPENING_HALF_WIDTH * 2.0, floor_length, FLOOR_THICKNESS),
        floor,
        collection,
    )

    for obj in collection.objects:
        if obj.type == "MESH":
            obj["RootsDanceRole"] = "ChapterHouseRoundEntrance"

    output = Path(output_path).resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(output))
    return {
        "output": str(output),
        "objects": sorted(obj.name for obj in collection.objects),
        "opening_width": OPENING_HALF_WIDTH * 2.0,
        "opening_height": OPENING_SPRING_HEIGHT + OPENING_ARCH_RISE,
        "tunnel_length": TUNNEL_LENGTH,
    }


if __name__ == "__main__":
    build("SourceArt/Blender/ChapterHouseRoundEntrance/ChapterHouseRoundEntrance.blend")
