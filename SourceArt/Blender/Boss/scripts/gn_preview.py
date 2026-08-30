import bpy, math
from mathutils import Vector
SRC="/tmp/rd-agent/tripo/boss_organized.blend"
DST="/tmp/rd-agent/tripo/boss_anim_preview.blend"
bpy.ops.wm.open_mainfile(filepath=SRC)
sc=bpy.context.scene
ms=[o for o in sc.objects if o.type=='MESH']

# 模型包围盒常数（顶点色里存的是归一化中心点，这里还原回局部坐标）
lo=Vector((min(min((o.matrix_world@v.co)[i] for v in o.data.vertices) for o in ms) for i in range(3)))
hi=Vector((max(max((o.matrix_world@v.co)[i] for v in o.data.vertices) for o in ms) for i in range(3)))
sz=hi-lo
print("bbox lo",tuple(round(x,4) for x in lo)," size",tuple(round(x,4) for x in sz))

ng=bpy.data.node_groups.new("PulseAnim",'GeometryNodeTree')
IF=ng.interface
IF.new_socket("Geometry",in_out='INPUT', socket_type='NodeSocketGeometry')
# BulgeAmp 现在是**绝对位移**(局部单位, 模型高 1.0), 不再是"刺长的百分比"。
# 取 0.30 x 最大刺尺寸, 跟旧的等比缩放版鼓起来一样多。
# MouthAmp/MouthFreq 已删: 嘴的开合改由 jaw 骨 + att_* 骨做。
for nm,dv in (("BulgeAmp",0.0158),("BulgeFreq",0.53),("SwayAmp",0.024),("SwayFreq",0.19)):
    s=IF.new_socket(nm,in_out='INPUT', socket_type='NodeSocketFloat'); s.default_value=dv
IF.new_socket("Geometry",in_out='OUTPUT', socket_type='NodeSocketGeometry')
N=ng.nodes; L=ng.links
def n(t,**kw):
    x=N.new(t)
    for k,v in kw.items(): setattr(x,k,v)
    return x
gi=n('NodeGroupInput'); go=n('NodeGroupOutput')

pv=n('GeometryNodeInputNamedAttribute', data_type='FLOAT_COLOR'); pv.inputs["Name"].default_value="Pivot"
sep=n('FunctionNodeSeparateColor', mode='RGB'); L.new(pv.outputs["Attribute"], sep.inputs[0])
# 现在只用得上 Alpha(相位)。RGB(部件根部)是给旧的"绕根部缩放/旋转"用的,
# 换成法线膨胀 + 骨骼之后没人读了 —— 数据照旧烘着, 以后要做别的再捡起来。
phase=sep.outputs["Alpha"]

ad=n('GeometryNodeInputNamedAttribute', data_type='FLOAT_VECTOR'); ad.inputs["Name"].default_value="AnimData"
sxyz=n('ShaderNodeSeparateXYZ'); L.new(ad.outputs["Attribute"], sxyz.inputs[0])
sway, bulge = sxyz.outputs["X"], sxyz.outputs["Y"]

tm=n('GeometryNodeInputSceneTime'); t=tm.outputs["Seconds"]
pos=n('GeometryNodeInputPosition')

def sinwave(freq_sock, phase_sock):
    m=n('ShaderNodeMath', operation='MULTIPLY'); L.new(t,m.inputs[0]); L.new(freq_sock,m.inputs[1])
    a=n('ShaderNodeMath', operation='ADD'); L.new(m.outputs[0],a.inputs[0]); L.new(phase_sock,a.inputs[1])
    tau=n('ShaderNodeMath', operation='MULTIPLY'); tau.inputs[1].default_value=math.tau
    L.new(a.outputs[0],tau.inputs[0])
    s=n('ShaderNodeMath', operation='SINE'); L.new(tau.outputs[0],s.inputs[0])
    return s.outputs[0]

# ============ 摆动: 两组固定方向的长波行波(植被风场那套) ============
# 上一版用「绕中轴的切向」当方向, 中轴附近方向会翻转 -> 撕。
# 空间相位也太密(波长 0.33), 一根藤上摆 1.5 个整波, 两头反向拉 -> 撕。
# 固定方向 + 长波长 = 处处连续、处处近似同向, 只由权重决定摆多少。
sw2=n('ShaderNodeMath', operation='MULTIPLY'); L.new(sway,sw2.inputs[0]); L.new(sway,sw2.inputs[1])
amp=n('ShaderNodeMath', operation='MULTIPLY'); L.new(gi.outputs["SwayAmp"],amp.inputs[0]); L.new(sw2.outputs[0],amp.inputs[1])

def gust(kvec, dvec, fmul):
    sp=n('ShaderNodeVectorMath', operation='DOT_PRODUCT'); sp.inputs[1].default_value=kvec
    L.new(pos.outputs[0],sp.inputs[0])
    fq=n('ShaderNodeMath', operation='MULTIPLY'); fq.inputs[1].default_value=fmul
    L.new(gi.outputs["SwayFreq"],fq.inputs[0])
    w=sinwave(fq.outputs[0], sp.outputs["Value"])
    a=n('ShaderNodeMath', operation='MULTIPLY'); L.new(amp.outputs[0],a.inputs[0]); L.new(w,a.inputs[1])
    v=n('ShaderNodeVectorMath', operation='SCALE'); v.inputs[0].default_value=dvec
    L.new(a.outputs[0],v.inputs["Scale"])
    return v.outputs[0]

# 三组行波, 方向各不相同(含一组带垂直分量), 波长压到跟模型同量级(1.2~1.4)。
# 上一版只有两组、波长 1.9 —— 全身几乎处处同相, 看着像整棵树一起被推。
# 波长缩短 = 不同高度/不同侧的枝条落在波的不同段上, 方向和时机自然错开。
# 三项都只是**位置**的连续函数, 焊缝两侧取值相同, 照样不会裂。
gA=gust(( 0.52, 0.33, 0.40),( 0.96, 0.29, 0.00), 1.000)
gB=gust((-0.40, 0.49, 0.31),(-0.31, 0.94, 0.14), 0.618)  # 无理频率比, 永不重复
gC=gust(( 0.26,-0.55, 0.47),( 0.42,-0.55, 0.72), 0.379)  # 带 Z -> 有的枝条是上下颠
d1=n('ShaderNodeVectorMath', operation='ADD'); L.new(gA,d1.inputs[0]); L.new(gB,d1.inputs[1])
dsw=n('ShaderNodeVectorMath', operation='ADD'); L.new(d1.outputs[0],dsw.inputs[0]); L.new(gC,dsw.inputs[1])

# ============ 刺鼓胀: 沿**顶点法线**外推 ============
# 为什么不再"绕根部等比缩放": 那种做法要用烘死的根部坐标 piv 算 rel=pos-piv。
# 上了骨骼蒙皮之后, 刺跟着腿一起跑, 但 piv 还钉在静止姿态的位置 ——
# 腿一抬, rel 就变成"刺指向空中某点"的向量, 鼓胀方向乱指, 刺会朝地面甩。
# 法线是随蒙皮一起旋转的局部量, 蒙皮怎么动它都对。
# 代价: 法线膨胀不是仿射变换(凸起处鼓得多), 但幅度只有刺尺寸的三成, 看不出来,
# 而且"肿瘤鼓包"本来就不该是仿射的。
wb=sinwave(gi.outputs["BulgeFreq"], phase)
fr=n('ShaderNodeMath', operation='MULTIPLY'); fr.inputs[1].default_value=7.3; L.new(phase,fr.inputs[0])
fr2=n('ShaderNodeMath', operation='FRACT'); L.new(fr.outputs[0],fr2.inputs[0])
av=n('ShaderNodeMath', operation='MULTIPLY_ADD'); av.inputs[1].default_value=0.85; av.inputs[2].default_value=0.15
L.new(fr2.outputs[0],av.inputs[0])
ba=n('ShaderNodeMath', operation='MULTIPLY'); L.new(gi.outputs["BulgeAmp"],ba.inputs[0]); L.new(av.outputs[0],ba.inputs[1])
# 这里**不再**乘 bulge(=V 原始值), 尺寸增益全交给下面的 mS —— 乘两遍会把小刺压没。
# 只鼓不缩: sin 映射到 [0,1]。双向缩放时"缩"会把埋进宿主的根部拽出来露馅,
# 而且单向膨胀本来就更像肿瘤。
wb1=n('ShaderNodeMath', operation='MULTIPLY_ADD'); wb1.inputs[1].default_value=0.5; wb1.inputs[2].default_value=0.5
L.new(wb,wb1.inputs[0])
bs=n('ShaderNodeMath', operation='MULTIPLY'); L.new(ba.outputs[0],bs.inputs[0]); L.new(wb1.outputs[0],bs.inputs[1])

# 掩码: V>0.5 -> 刺, 增益 = 2V-1 = 这根刺相对最大刺的尺寸 x 根部淡出(逐顶点烘好的)。
# 花瓣叶烘的是 V<=0.5 -> 增益 0 -> 完全不鼓(它们的摆动现在由 att_* 骨骼做,
# 着色器里原来那层"花瓣绕根部刚体旋转"已经整个删掉了)。
mm=n('ShaderNodeMath', operation='MULTIPLY_ADD'); mm.inputs[1].default_value=2.0; mm.inputs[2].default_value=-1.0
L.new(bulge,mm.inputs[0])
mc=n('ShaderNodeClamp'); L.new(mm.outputs[0],mc.inputs["Value"])
mS=mc.outputs[0]

nrm=n('GeometryNodeInputNormal')
gs=n('ShaderNodeMath', operation='MULTIPLY'); L.new(bs.outputs[0],gs.inputs[0]); L.new(mS,gs.inputs[1])
dbu=n('ShaderNodeVectorMath', operation='SCALE'); L.new(nrm.outputs[0],dbu.inputs[0]); L.new(gs.outputs[0],dbu.inputs["Scale"])

off=n('ShaderNodeVectorMath', operation='ADD'); L.new(dsw.outputs[0],off.inputs[0]); L.new(dbu.outputs[0],off.inputs[1])

sp=n('GeometryNodeSetPosition')
L.new(gi.outputs["Geometry"],sp.inputs["Geometry"]); L.new(off.outputs[0],sp.inputs["Offset"])
L.new(sp.outputs["Geometry"],go.inputs["Geometry"])

for o in ms:
    m=o.modifiers.new("PulseAnim",'NODES'); m.node_group=ng
print("### 几何节点已挂到 %d 个对象 ###" % len(ms))
sc.frame_start=1; sc.frame_end=96; sc.render.fps=24
bpy.ops.wm.save_as_mainfile(filepath=DST)
print("SAVED",DST)
