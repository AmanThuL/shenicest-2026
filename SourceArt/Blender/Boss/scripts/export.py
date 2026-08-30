import bpy, os
SCALE=7.0
OUT="/tmp/rd-agent/out"; os.makedirs(OUT,exist_ok=True)
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_crawl.blend")
sc=bpy.context.scene
ms=[o for o in sc.objects if o.type=='MESH']
ar=[o for o in sc.objects if o.type=='ARMATURE'][0]

# ---------- 1. 贴图: 中文名 -> ASCII, 2048 -> 512 ----------
# 512 是项目基准(跟第一人称手臂那套 PSX 素材对齐), 不是按 Boss 体量定的。
REN={'basecolor':'Boss_BaseMap','normal':'Boss_Normal'}
for im in list(bpy.data.images):
    tgt=next((v for k,v in REN.items() if k in im.name.lower()),None)
    if not tgt: continue
    im.scale(512,512)
    im.filepath_raw=os.path.join(OUT,tgt+".png"); im.file_format='PNG'
    if 'normal' in im.name.lower(): im.colorspace_settings.name='Non-Color'
    im.save()
    im.name=tgt
    print("### 贴图 %s -> 512, %s ###"%(tgt,im.filepath_raw))

# ---------- 2. 合并成一个蒙皮网格 ----------
for o in bpy.data.objects: o.select_set(False)
for o in ms: o.select_set(True)
bpy.context.view_layer.objects.active=ms[0]
ms[0].name="Boss"; ms[0].data.name="Boss"
bpy.ops.object.join()
M=bpy.context.view_layer.objects.active
me=M.data
print("### 合并后: %s, 顶点 %d, 面 %d, UV %s, 颜色属性 %s, 顶点组 %d, 材质 %d ###"
      %(M.name,len(me.vertices),len(me.polygons),[l.name for l in me.uv_layers],
        [c.name for c in me.color_attributes],len(M.vertex_groups),len(me.materials)))
assert 'AnimData' in [l.name for l in me.uv_layers], "AnimData UV 丢了"
assert 'Pivot'   in [c.name for c in me.color_attributes], "Pivot 顶点色丢了"
me.uv_layers['UVMap'].active_render=True

# ---------- 3. 放大到 7 米 ----------
# **不要手工改数据来放大。** 上一版是逐项缩放: 网格顶点 x7 / 编辑骨 head,tail x7 /
# 动作里 location 曲线 x7。三样单独看都对, 合起来是坏的 —— 姿态过了 IK 和约束
# 那一层就不再是相似变换了, 实测第 1 帧宽度从该有的 6.37 变成 19.001 (2.98 倍),
# 而且高/厚各错各的(不是均匀错), 一眼就知道不是尺度问题是姿态被解坏了。
# 正确做法: 数据全留在 1.0, 把 7 倍交给 FBX 导出器的 global_scale。
# 它在写文件那一刻对整棵层级 + 所有动画曲线做**一次**统一相似变换, 碰不到 IK。
zs=[(M.matrix_world@v.co).z for v in me.vertices]
xs=[(M.matrix_world@v.co).x for v in me.vertices]
ys=[(M.matrix_world@v.co).y for v in me.vertices]
print("### 静止尺寸(1.0 尺度): 高 %.3f 宽 %.3f 厚 %.3f -> x%.1f = 高 %.3f m 宽 %.3f m ###"
      %(max(zs)-min(zs),max(xs)-min(xs),max(ys)-min(ys),SCALE,
        (max(zs)-min(zs))*SCALE,(max(xs)-min(xs))*SCALE))

# ---------- 4. 导 FBX ----------
# D14: 带骨骼**禁止**用选项 1(Apply Transform / bake_space_transform),
# Blender 官方说明它对 armature/animation 是坏的。走「选项 4」:
# Blender 保持默认轴向不烘, Unity 侧开 Bake Axis Conversion。
FBX=os.path.join(OUT,"Boss.fbx")
bpy.ops.export_scene.fbx(filepath=FBX, use_selection=False,
    global_scale=SCALE, apply_scale_options='FBX_SCALE_ALL', bake_space_transform=False,
    object_types={'ARMATURE','MESH'}, use_mesh_modifiers=False,
    mesh_smooth_type='FACE', colors_type='LINEAR',
    add_leaf_bones=False, primary_bone_axis='Y', secondary_bone_axis='X',
    bake_anim=True, bake_anim_use_all_bones=True, bake_anim_use_nla_strips=False,
    bake_anim_use_all_actions=False, bake_anim_force_startend_keying=True,
    bake_anim_step=1.0, bake_anim_simplify_factor=0.0,
    path_mode='STRIP', axis_forward='-Z', axis_up='Y')
print("### FBX 已导出 %s (%.1f MB) ###"%(FBX,os.path.getsize(FBX)/1e6))
bpy.ops.wm.save_as_mainfile(filepath="/tmp/rd-agent/tripo/boss_export.blend")
print("SAVED")
