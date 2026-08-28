import bpy
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.fbx(filepath="/tmp/rd-agent/out/Boss.fbx")
sc=bpy.context.scene
ms=[o for o in sc.objects if o.type=='MESH']
ar=[o for o in sc.objects if o.type=='ARMATURE']
print("### 回读: 网格 %d 骨架 %d 骨头 %d ###"%(len(ms),len(ar),len(ar[0].data.bones) if ar else 0))
for o in ar+ms:
    print("   %-10s loc %s rot %s scale %s"%(o.type,
        tuple(round(x,3) for x in o.location),
        tuple(round(x,3) for x in o.rotation_euler),
        tuple(round(x,4) for x in o.scale)))
# 静止姿态
if ar:
    for pb in ar[0].pose.bones: pb.matrix_basis.identity()
    bpy.context.view_layer.update()
    pts=[o.matrix_world@v.co for o in ms for v in o.data.vertices]
    xs=[p.x for p in pts]; ys=[p.y for p in pts]; zs=[p.z for p in pts]
    print("### 静止(清空姿态): X %.3f Y %.3f Z %.3f  期望 6.125 / 3.689 / 7.000 ###"
          %(max(xs)-min(xs),max(ys)-min(ys),max(zs)-min(zs)))
for f in (1,25,49):
    sc.frame_set(f)
    dg=bpy.context.evaluated_depsgraph_get()
    pts=[o.matrix_world@v.co for o in ms for v in o.evaluated_get(dg).data.vertices]
    xs=[p.x for p in pts]; ys=[p.y for p in pts]; zs=[p.z for p in pts]
    print("  f%-3d X %.3f Y %.3f Z %.3f   (源 x7 应为 f1: 6.370/3.773/5.803  f25: 6.475/3.738/7.217)"
          %(f,max(xs)-min(xs),max(ys)-min(ys),max(zs)-min(zs)))
