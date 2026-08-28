import bpy, math
from mathutils import Vector
SRC="/tmp/rd-agent/tripo/boss_crawl.blend"
bpy.ops.wm.open_mainfile(filepath=SRC)
sc=bpy.context.scene
# 从预览文件里把节点组拿过来
with bpy.data.libraries.load("/tmp/rd-agent/tripo/boss_anim_preview.blend") as (df,dt):
    dt.node_groups=[n for n in df.node_groups if n=="PulseAnim"]
ng=bpy.data.node_groups["PulseAnim"]
ms=[o for o in sc.objects if o.type=='MESH']
for o in ms:
    m=o.modifiers.new("PulseAnim",'NODES'); m.node_group=ng   # 加在 Armature **之后**
    assert [x.type for x in o.modifiers]==['ARMATURE','NODES'], [x.type for x in o.modifiers]
IDS={s.name:s.identifier for s in ng.interface.items_tree
     if getattr(s,'identifier',None) and s.item_type=='SOCKET' and s.in_out=='INPUT'}
print("### 修改器顺序 Armature -> PulseAnim, 已挂 %d 个对象 ###"%len(ms))

# 核心验证: 鼓胀位移必须**始终沿着刺自己往外**, 不能因为腿抬起来就朝地面甩。
# 量法: 同一帧关掉/打开鼓胀, 取位移向量, 看它跟该顶点(蒙皮后)法线的夹角。
def snap(amp):
    for o in ms:
        m=o.modifiers["PulseAnim"]; m[IDS["BulgeAmp"]]=amp; m[IDS["SwayAmp"]]=0.0
        o.update_tag()
    dg=bpy.context.evaluated_depsgraph_get()
    return {o.name:[(o.matrix_world@v.co).copy() for v in o.evaluated_get(dg).data.vertices] for o in ms}
def nrm():
    dg=bpy.context.evaluated_depsgraph_get()
    return {o.name:[(o.matrix_world.to_3x3()@v.normal).normalized() for v in o.evaluated_get(dg).data.vertices] for o in ms}
worst=0.0; who=""; mx=0.0
for f in (1,17,33,49,64,80,96):
    sc.frame_set(f)
    A=snap(0.0); NN=nrm(); B=snap(0.0158)
    for o in ms:
        for i,(a,b) in enumerate(zip(A[o.name],B[o.name])):
            d=b-a
            if d.length<1e-5: continue
            mx=max(mx,d.length)
            ang=math.degrees(d.normalized().angle(NN[o.name][i]))
            if ang>worst: worst,who=ang,"%s v%d @f%d"%(o.name,i,f)
print("### 鼓胀方向 vs 蒙皮后法线: 最大夹角 %.2f 度 (%s), 最大位移 %.4f ###"%(worst,who,mx))
bpy.ops.wm.save_as_mainfile(filepath="/tmp/rd-agent/tripo/boss_crawl_pulse.blend")
print("SAVED")
