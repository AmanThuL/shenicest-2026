"""Join the broken glazing into one mesh and export it for Unity.

One object, four material slots -- Intact, Cracked, Shattered, Stained --
so the Unity side maps four materials and nothing more. Export settings
mirror export_mesh.py: no space-transform baking, -Z forward, Y up.
"""
import bpy

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
OUT = ROOT + "/Assets/RootsDance/Meshes/Environment/GreenHouse1Glass.fbx"

bpy.ops.wm.open_mainfile(filepath=ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend")
col = bpy.data.collections["GlassRecovered"]
objs = [o for o in col.objects if o.type == "MESH"]

# every object needs the same 4-slot layout before joining, or join reshuffles
names = ["GreenHouse1GlassIntact", "GreenHouse1GlassCracked",
         "GreenHouse1GlassShattered", "GreenHouse1GlassStained"]
mats = [bpy.data.materials.get(n) or bpy.data.materials.new(n) for n in names]
for o in objs:
    for i, m in enumerate(mats):
        if i < len(o.data.materials):
            o.data.materials[i] = m
        else:
            o.data.materials.append(m)

bpy.ops.object.select_all(action='DESELECT')
for o in objs:
    o.select_set(True)
bpy.context.view_layer.objects.active = objs[0]
bpy.ops.object.join()
joined = bpy.context.view_layer.objects.active
joined.name = joined.data.name = "GreenHouse1Glass"
bpy.ops.object.transform_apply(location=False, rotation=True, scale=True)

bpy.ops.export_scene.fbx(
    filepath=OUT, use_selection=True, object_types={"MESH"},
    global_scale=1.0, apply_unit_scale=True, apply_scale_options="FBX_SCALE_NONE",
    use_space_transform=True, bake_space_transform=False,
    axis_forward="-Z", axis_up="Y",
    use_mesh_modifiers=True, mesh_smooth_type="OFF",
    use_triangles=False, use_custom_props=False,
    add_leaf_bones=False, bake_anim=False,
)
print("### exported %s: %d faces, slots=%s"
      % (OUT.rsplit("/", 1)[-1], len(joined.data.polygons),
         [m.name for m in joined.data.materials]))
