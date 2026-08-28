import bpy, math, sys
from mathutils import Vector, Matrix, Quaternion
_A=sys.argv[sys.argv.index("--")+1:] if "--" in sys.argv else []
def arg(i,d): return float(_A[i]) if len(_A)>i else d
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_rigged.blend")
sc=bpy.context.scene
AO=bpy.data.objects["BossRig"]
bpy.context.view_layer.objects.active=AO; bpy.ops.object.mode_set(mode='POSE')
PB=AO.pose.bones
for pb in PB: pb.rotation_mode='XYZ'

N=96; CYC=48.0                    # 两个爬行周期
FWD=-1.0                          # 实测: 躯干上段偏 y-0.104、藤群在 +y、三条腿聚在 -y
                                  # => 这个模型的正面是 **-Y**。往 +Y 推就是倒着走。
STRIDE=arg(0,0.24)*FWD            # 每周期前进的距离。上限由**腿的伸展率**定死:
                                  # 迈过头 IK 就把腿硬拉直 -> 撕(实测 2.76x)。
                                  # 拍脑袋没用, 底下有 REACH 量表, 卡在 0.92 以内。
LIFT=arg(1,0.075); DUTY=arg(2,0.55)   # 抬脚高度 / 站立相占比(追逐: 抬更高、撑地时间更短)
CROUCH=arg(3,0.075); INSET=arg(4,0.03)# 骨盆压低量 / 落脚点径向内收量
# 为什么要压低+内收才能迈大步: 这个模型静止时腿就快伸直了(伸展率 0.94/1.0)。
# 光加步幅 = 直接把腿抻成直棍, 膝盖没了、IK 够不着、脚开始蹭地。
# 压低骨盆和把脚往身下收都是在**买伸展余量**, 顺带也就是"压低身子扑过来"的样子。
INPLACE=True                       # 原地踏步: 根骨不位移, 位移交给 Unity。
                                   # 脚的曲线一个字都不用改 —— 站立相本来就是按
                                   # 「每帧后撤 STRIDE/CYC」写的, 正好抵消根骨前进。
                                   # 根骨不动之后, 这段后撤就变成跑步机, 速率照样对。
LEGS=sorted(n for n in PB.keys() if n.startswith("root_") and n.endswith("_ik"))
# 三足交替: 按脚在世界里的方位角排序, 相邻的分到不同组
ang=sorted(LEGS,key=lambda n: math.atan2(PB[n].head.y,PB[n].head.x))
PH={n:(0.0 if i%2==0 else 0.5) for i,n in enumerate(ang)}
print("腿相位:", {n.replace("_ik",""):PH[n] for n in ang})
# 落脚点径向内收: 世界里朝中轴收 INSET, 换算到 IK 目标骨自己的局部基里
# (目标骨挂在 root 下、root 不转, 所以 rest 基就够, 不用带父级增量)
IN={}
for n in LEGS:
    r=PB[n].bone.head_local.copy(); r.z=0.0
    r=r.normalized() if r.length>1e-6 else Vector((1.0,0.0,0.0))
    IN[n]=PB[n].bone.matrix_local.to_3x3().inverted()@(-r*INSET)
VINE_BONES={}
for pb in PB:
    if pb.name.startswith("vine_"):
        VINE_BONES.setdefault("Vine_"+pb.name.split("_")[1],[]).append(pb.name)
for k in VINE_BONES: VINE_BONES[k].sort()
# 藤的相位跟腿错开半拍: 腿在撑的时候藤在收, 看着像交替倒手
vang=sorted(VINE_BONES,key=lambda n: math.atan2(PB[VINE_BONES[n][0]].head.y,PB[VINE_BONES[n][0]].head.x))
PHV={n:((0.25 if i%2==0 else 0.75)+0.08*i)%1.0 for i,n in enumerate(vang)}
print("藤:", {n:len(VINE_BONES[n]) for n in vang})

def smooth(x):
    x=max(0.0,min(1.0,x)); return x*x*(3.0-2.0*x)
def whip(f):
    """第二个周期抡一记鞭: f44-56 向后蓄力 -> f56-62 抽出去 -> 之后余韵衰减。
    (原来写成 t=(f%N)/N 再乘一个 f>48 的淡入 —— 抽鞭发生在 f17-27, 正好被淡入抹掉了,
     等于这一鞭根本没打出来。)"""
    if f<44: return 0.0
    if f<56: return -0.45*((f-44)/12.0)
    if f<62: return -0.45+2.05*((f-56)/6.0)
    return 1.60*math.exp(-(f-62)*0.45)
def gape(f):
    """嘴: 跟着抽鞭的节奏。蓄力时越张越大 -> 鞭子抽出去的同一拍咬合, 咬过头再回弹。"""
    if f<42: return 0.0
    if f<56: return smooth((f-42)/14.0)
    if f<60: return 1.0-1.28*((f-56)/4.0)
    if f<74: return -0.28*math.exp(-(f-60)*0.35)
    return 0.0

for f in range(1,N+1):
    sc.frame_set(f)
    t=(f-1)/CYC
    PB["root"].location=Vector((0.0, 0.0 if INPLACE else STRIDE*t, 0.0))
    PB["root"].keyframe_insert("location")     # 照样打关键帧(值恒为 0), 免得 Unity 那边继承到别的动作的残留位移
    # 身体压低贴地 + 随步频起伏
    bob=0.012*math.sin(2*math.pi*(t*2))
    PB["pelvis"].location=Vector((0.0,0.0,-CROUCH+bob))
    PB["pelvis"].rotation_euler=(FWD*math.radians(8+3*math.sin(2*math.pi*t*2)),0,0)
    PB["pelvis"].keyframe_insert("location"); PB["pelvis"].keyframe_insert("rotation_euler")
    # spine_00 **保持不动**: 躯干下段的权重在它身上, 而腿根跟的是 pelvis。
    # 一转 spine_00, 躯干下段就从腿根上滑开(实测 0.0399)。身体起伏放到 spine_01 和 pelvis。
    for i,bn in enumerate(("spine_01","crown")):
        PB[bn].rotation_euler=(FWD*math.radians(-7+5*math.sin(2*math.pi*(t*2+0.25*i))),
                               0, math.radians(4*math.sin(2*math.pi*(t+0.15*i))))
        PB[bn].keyframe_insert("rotation_euler")
    for n in LEGS:
        p=(t+PH[n])%1.0
        if p<DUTY:
            # 站立相: 世界里钉住 => 局部回撤速率必须**恰好**等于根骨前进速率。
            # 一个周期根骨走 STRIDE, 站立相只占 DUTY, 所以这段只回撤 STRIDE*DUTY。
            # 写成回撤整个 STRIDE 的话每帧差 STRIDE*(1/DUTY-1)/CYC, 脚就一直在蹭地。
            y=STRIDE*(DUTY*0.5-p); z=0.0
        else:                            # 摆动相: 抬起来送到前面
            q=(p-DUTY)/(1.0-DUTY)
            y=STRIDE*(DUTY*0.5)*(-1.0+2.0*q); z=LIFT*math.sin(math.pi*q)
        PB[n].location=Vector((0.0,y,z))+IN[n]; PB[n].keyframe_insert("location")
    # ===== 六根藤全部参与爬行 =====
    # 上面的枝条不是装饰, 它们跟腿一样在"抓地往后拖"。同样的占空比:
    # 前 DUTY 段是撑地拖拽(整条往后压), 后段抬起来卷回前方。
    # 每节骨多一点相位滞后 -> 卷曲是从根部传到梢端的行波, 不是整条硬转。
    for vn in VINE_BONES:
        pv=(t+PHV[vn])%1.0
        nb=len(VINE_BONES[vn])
        for j,bn in enumerate(VINE_BONES[vn]):
            if j==0:            # 藤根那一节不转, 理由同腿根: 转了就从躯干上掀开
                PB[bn].rotation_euler=(0,0,0); PB[bn].keyframe_insert("rotation_euler"); continue
            q=(pv-0.055*j)%1.0
            if q<DUTY: k=1.0-2.0*(q/DUTY)          # 撑地拖拽
            else:      k=-1.0+2.0*((q-DUTY)/(1.0-DUTY))
            tipw=0.45+0.55*(j/max(1,nb-1))         # 越靠梢端卷得越狠
            rx=-k*math.radians(19)*tipw      # 负 = 往下卷去撑地(局部 X 是水平且垂直于骨的轴)
            rz=math.sin(2*math.pi*q)*math.radians(6)*tipw
            if vn=="Vine_01":                      # 第二个周期叠一记抽鞭
                w=whip(f)
                rx+=-w*math.radians(26); rz+=w*math.radians(9)
            PB[bn].rotation_euler=(rx,0,rz); PB[bn].keyframe_insert("rotation_euler")

# ===== 附着件: 张嘴 + 跟随抖动 =====
# 花瓣/叶不再是贴纸。每片有自己的骨(接触区仍归宿主表面, 所以不会分家),
# 这里给它两层旋转:
#   ① 张嘴 —— 冠部那圈花瓣绕"自身朝向 x 向外径向"转, 梢端往外翻, 根部不动。
#   ② 跟随抖动 —— 不是叠一个正弦, 是拿**宿主接触点的实际加速度**当激励, 跑一个
#      二阶弹簧。所以身体一顿, 花瓣才滞后一拍甩过去, 还会来回颤两下再停。
#      每片的固有频率按名字散开(周期 8~14 帧), 否则整圈花瓣会齐刷刷同时抖。
# 幅度上限 tmax 是建骨时按剪切预算逐片算好的, 存在骨头上。
ATTB=[b.name for b in AO.data.bones if "tmax" in b.keys()]   # att_* 和 jaw
for bn in ATTB: PB[bn].rotation_mode='QUATERNION'
assert (AO.matrix_world.to_3x3()-Matrix.Identity(3)).median_scale<1e-6, "骨架有变换, 世界/骨架空间不重合"

HEAD={bn:[] for bn in ATTB}; BASIS={bn:[] for bn in ATTB}
for f in range(1,N+1):
    sc.frame_set(f)
    dg=bpy.context.evaluated_depsgraph_get(); AE=AO.evaluated_get(dg)
    for bn in ATTB:
        pb=AE.pose.bones[bn]; par=pb.parent
        # 父级链实际转了多少 -> 姿态下这根骨的"静置基"
        pd=par.matrix.to_3x3()@par.bone.matrix_local.to_3x3().inverted()
        HEAD[bn].append(pb.head.copy()); BASIS[bn].append(pd@pb.bone.matrix_local.to_3x3())

RHO={}
for bn in ATTB:
    P=HEAD[bn]; Mb=BASIS[bn]
    h=sum(ord(c) for c in bn)
    w0=0.45+0.30*((h*37)%97)/96.0            # 固有角频率 rad/帧 -> 周期 8~14 帧
    k=w0*w0; c=2.0*0.24*w0                   # 阻尼比 0.24: 甩过去还会颤两下
    rho=Vector(); om=Vector(); out=[]
    for rep in range(4):                     # 跑 4 遍取最后一遍 -> 周期解, 首尾接得上
        out=[]
        for f in range(N):
            a=P[(f+1)%N]-2.0*P[f]+P[(f-1)%N]     # 根部加速度
            d=Mb[f].col[1]                        # 骨轴(局部 Y)在姿态下的世界朝向
            drive=d.cross(-a)*220.0
            for _ in range(4):                    # 半隐式欧拉, 4 个子步保稳
                om+= (drive-k*rho-c*om)*0.25; rho+= om*0.25
            out.append(rho.copy())
    RHO[bn]=out

for f in range(1,N+1):
    sc.frame_set(f)
    br=0.5-0.5*math.cos(2*math.pi*((f-1)/CYC))       # 呼吸: 两个周期两次
    for bn in ATTB:
        bo=AO.data.bones[bn]; tmax=bo["tmax"]
        Mi=BASIS[bn][f-1].inverted()
        r=RHO[bn][f-1]; mx=max(v.length for v in RHO[bn]) or 1.0
        share=0.55 if bo["mouth"] else 0.9
        q=Quaternion()
        if r.length>1e-9:
            q=Quaternion(Mi@r.normalized(), tmax*share*min(1.0,r.length/mx))
        if bo["mouth"]:
            m=max(-0.30,min(1.0,0.22*br+gape(f)))
            ax=bo.matrix_local.to_3x3().inverted()@Vector(bo["open"])
            q=Quaternion(ax,tmax*m)@q
        PB[bn].rotation_quaternion=q
        PB[bn].keyframe_insert("rotation_quaternion")
act=AO.animation_data.action          # Blender 5 的 Action 改成了 layer/slot 结构
fcs=list(getattr(act,"fcurves",[]))
for lay in getattr(act,"layers",[]):
    for st in lay.strips:
        for cb in getattr(st,"channelbags",[]): fcs.extend(cb.fcurves)
for fc in fcs:
    for kp in fc.keyframe_points: kp.interpolation='BEZIER'
bpy.ops.object.mode_set(mode='OBJECT')

# ===== 验方向和落地: 局部空间搞错的话这里立刻现形 =====
def centroid(f):
    sc.frame_set(f); dg=bpy.context.evaluated_depsgraph_get()
    tot=Vector(); n=0
    for o in sc.objects:
        if o.type!='MESH': continue
        ev=o.evaluated_get(dg); me=ev.to_mesh()
        for v in me.vertices: tot+=o.matrix_world@v.co; n+=1
        ev.to_mesh_clear()
    return tot/n
d=centroid(N)-centroid(1)
print("### 96 帧质心位移: 前 %+.3f / 侧 %+.3f / 上 %+.3f ###"%(d.y,d.x,d.z))
# 量**骨尾**而不是网格最低点: IK 钉的是最后一节骨的骨尾, 网格顶点离它还有几厘米,
# 脚绕着钉住的尖端转时那个顶点当然在动 —— 那是"脚掌绕趾尖转", 不是打滑。
TIPB=[max((b for b in PB.keys() if b.startswith(n.lower()+"_") and not b.endswith("_ik")))
      for n in sorted(x for x in bpy.data.objects.keys() if x.startswith("Root_"))]
trk={b:[] for b in TIPB}
# 腿伸展率 = 髋到落脚点的直线距离 / 这条腿能伸直的最大长度。
# 步子能迈多大**只由这个数说了算**: 逼近 1.0 = IK 把整条腿抻成一根直棍, 膝盖没了、网格开撕。
# 卡 0.92 —— 留 8% 给膝弯, 既不撕又能看出是在"够"。
# IK 只解链条上的后 5 节(_01.._05), _00 不在链里 -> 可达半径是这 5 节之和 0.293,
# 不是整条腿的弧长 0.38。髋要取**姿态下**的位置, 骨盆起伏会带着它动。
CH={}
for n in LEGS:
    pre=n[:-3]                                     # root_01_ik -> root_01_
    seg=sorted(b for b in PB.keys() if b.startswith(pre) and not b.endswith("_ik"))
    ik=[c for c in PB[seg[-1]].constraints if c.type=='IK'][0]
    seg=seg[-ik.chain_count:]
    CH[n]=(seg[0], sum(PB[b].bone.length for b in seg))
reach=0.0; rleg=""
for f in range(1,N+1):
    sc.frame_set(f)
    for b in TIPB: trk[b].append((AO.matrix_world@PB[b].tail).copy())
    for n in LEGS:
        hb,L=CH[n]
        r=(PB[n].head-PB[hb].head).length/L
        if r>reach: reach,rleg=r,"%s@f%d"%(n,f)
print("### 腿最大伸展率 %.2f (%s)  —— >0.92 就要开始拉直撕裂 ###"%(reach,rleg))
# 原地踏步下"钉住"的定义变了: 落地脚不是不动, 而是**匀速往后跑跑步机**。
# 只要所有落地脚的后撤速度**彼此一致**, Unity 那边按这个速度一推就完美钉地。
# 所以不能拿"世界 Y"当理想方向 —— 根骨的局部轴是斜的, 跑步机方向得**实测**:
# 取所有落地帧位移的平均, 再量每一帧偏离这个平均多少。
# 落地帧要用**动画自己的相位**判, 不能拿"离地高度低于某阈值"猜:
# 抬脚头几帧离地还很低, 会被算成落地, 于是把摆动相的速度(Y-0.0054/Z+0.0094)
# 混进来 -> 离散度虚高到 0.0124, 而真正的落地脚其实一致得很。
V=[]
for k,nm in enumerate(TIPB):
    ps=trk[nm]; ph=PH[LEGS[k]]
    for i in range(len(ps)-1):
        p0=((i  )/CYC+ph)%1.0; p1=((i+1)/CYC+ph)%1.0
        if p0<DUTY and p1<DUTY and p1>p0: V.append(ps[i+1]-ps[i])
TM=sum(V,Vector())/max(1,len(V))
slip=max(((v-TM).length for v in V), default=0.0)
print("### 落地脚每帧最大滑移 %.4f (跑步机一帧走 %.4f, 越小越钉得住) ###"%(slip,TM.length))
print("### 交给 Unity: 角色每帧前进 %.4f 单位, 方向 (%+.2f,%+.2f,%+.2f) = %.3f 单位/秒(24fps) ###"
      %(TM.length,-TM.normalized().x,-TM.normalized().y,-TM.normalized().z,TM.length*24))

# ===== 验一遍: 甩到最狠那几帧的形状畸变 =====
REST={o.name:[v.co.copy() for v in o.data.vertices] for o in sc.objects if o.type=='MESH'}
worst=(1.0,""); wpart={}
for f in (1,20,28,34,48,56,60,64,76,90):
    sc.frame_set(f); dg=bpy.context.evaluated_depsgraph_get()
    for o in sc.objects:
        if o.type!='MESH': continue
        ev=o.evaluated_get(dg); me=ev.to_mesh(); vs=[v.co for v in me.vertices]; rv=REST[o.name]
        for p in o.data.polygons:
            a,b,c=p.vertices[:3]; r=[]
            for x,y in ((a,b),(b,c),(c,a)):
                l0=(rv[x]-rv[y]).length
                if l0>1e-6: r.append((vs[x]-vs[y]).length/l0)
            if len(r)==3 and min(r)>1e-6:
                m=max(r)/min(r)
                if m>worst[0]: worst=(m,"%s @f%d"%(o.name,f))
                if m>wpart.get(o.name,(0,0))[0]: wpart[o.name]=(m,f)
        ev.to_mesh_clear()
print("### 爬行+挥鞭 最大形状畸变 %.2fx (%s) ###"%worst)
pw=max(((v,k) for k,v in wpart.items() if k.startswith("Petal_") or k.startswith("Leaf_")))
print("   其中冠部花瓣/叶最大 %.2fx (%s @f%d)"%(pw[0][0],pw[1],pw[0][1]))

# ===== 附着件有没有跟宿主分家 =====
from mathutils.kdtree import KDTree
MS=[o for o in sc.objects if o.type=='MESH']
def snap(f):
    sc.frame_set(f); dg=bpy.context.evaluated_depsgraph_get(); out={}
    for o in MS:
        ev=o.evaluated_get(dg); me=ev.to_mesh()
        out[o.name]=[o.matrix_world@v.co for v in me.vertices]; ev.to_mesh_clear()
    return out
R={o.name:[o.matrix_world@v.co for v in o.data.vertices] for o in MS}   # 未变形 = 真基准
tot=sum(len(v) for v in R.values()); kd=KDTree(tot); own=[]; loc=[]; k=0
for nm,vs in R.items():
    for i,w in enumerate(vs): kd.insert(w,k); own.append(nm); loc.append(i); k+=1
kd.balance()
# 只跟**宿主**(躯干/腿/藤)配对。花瓣跟隔壁花瓣的距离不能算"分家" ——
# 嘴张开时相邻花瓣本来就该互相拉开, 那是效果不是缺陷。
HOSTS=set(["Trunk"]+[n for n in R if n.startswith("Root_") or n.startswith("Vine_")])
pair={}
for nm,vs in R.items():
    ok=(lambda x: x!=nm) if nm in HOSTS else (lambda x: x in HOSTS)
    best=(9e9,None,None,None)
    for i,w in enumerate(vs):
        for _,j,d in kd.find_n(w,60):
            if ok(own[j]):
                if d<best[0]: best=(d,i,own[j],loc[j])
                break
    pair[nm]=best
op={}
for f in range(1,N+1,3):
    S=snap(f)
    for nm,(d0,i,hn,hi) in pair.items():
        if i is None: continue
        op[nm]=max(op.get(nm,0.0),(S[nm][i]-S[hn][hi]).length-d0)
top=sorted(op,key=lambda x:-op[x])[:5]
for nm in top: print("   %-10s 张开 %.4f  (贴着 %s)"%(nm,op[nm],pair[nm][2]))
print("### 骨骼变形下最大分家 %.4f (模型高 1.0) ###"%max(op.values()))
sc.frame_start=1; sc.frame_end=N; sc.render.fps=24
bpy.ops.wm.save_as_mainfile(filepath="/tmp/rd-agent/tripo/boss_crawl.blend")
