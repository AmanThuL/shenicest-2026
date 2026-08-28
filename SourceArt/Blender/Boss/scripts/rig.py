import bpy, math, os
from mathutils import Vector
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_organized.blend")
sc=bpy.context.scene
MESH=[o for o in sc.objects if o.type=='MESH']
W={o.name:[o.matrix_world@v.co for v in o.data.vertices] for o in MESH}
T=bpy.data.objects["Trunk"]

def chain(name, nseg, from_low=True, anchor=None):
    """沿最长轴切片取重心 = 中轴。anchor 给定时, 把离 anchor 近的那端当根端。"""
    ws=W[name]
    lo=Vector((min(w[i] for w in ws) for i in range(3)))
    hi=Vector((max(w[i] for w in ws) for i in range(3)))
    d=hi-lo; ax=list(d).index(max(d)); L=max(d)
    seg=[[] for _ in range(nseg+1)]
    for w in ws: seg[min(nseg,int((w[ax]-lo[ax])/L*(nseg+1)))].append(w)
    cs=[sum(s,Vector())/len(s) for s in seg if s]
    if anchor is not None:
        if min((cs[-1]-a).length for a in anchor) < min((cs[0]-a).length for a in anchor):
            cs=cs[::-1]
    elif from_low and cs[-1].z<cs[0].z: cs=cs[::-1]
    return cs

TW=W["Trunk"]
CH={}
CH["spine"]=chain("Trunk",2,from_low=True)
LEGS=[n for n in W if n.startswith("Root_")]
VINES=[n for n in W if n.startswith("Vine_")]
LEGSEG=int(os.environ.get("LEGSEG","9"))
for n in LEGS:  CH[n]=chain(n,LEGSEG,anchor=TW)     # 根端在躯干侧, 梢端触地
# 分段数直接决定膝盖能弯多狠: 剪切 ≈ 每节转角 × 力臂 / 过渡带。
# 同样的弯曲总角度, 节数翻倍 -> 每节转角减半 -> 撕裂减半。要迈大步就得加节。
for n in VINES: CH[n]=chain(n,5 if len(W[n])>150 else 3, anchor=TW)

arm=bpy.data.armatures.new("BossRig"); AO=bpy.data.objects.new("BossRig",arm)
sc.collection.objects.link(AO)
bpy.context.view_layer.objects.active=AO; bpy.ops.object.mode_set(mode='EDIT')
EB=arm.edit_bones
def mkchain(prefix, cs, parent, connect_first=False):
    out=[]; prev=parent
    for i in range(len(cs)-1):
        b=EB.new("%s_%02d"%(prefix,i)); b.head=cs[i]; b.tail=cs[i+1]
        if prev is not None:
            b.parent=prev
            b.use_connect = connect_first if i==0 else True
        prev=b; out.append(b.name)
    return out

cx=sum(w.x for w in TW)/len(TW); cy=sum(w.y for w in TW)/len(TW)
# root / pelvis / 脚的 IK 目标一律**沿 +Y 建**。姿态骨的 location 是骨骼局部空间,
# +Y 骨在 roll=0 时局部轴恰好等于世界轴, 写 location=(x,y,z) 就是世界的 x,y,z。
# 竖着建(tail 在 +Z)的话局部 Y 指向世界 +Z —— "往前爬"会变成"往天上爬"。
FWD=Vector((0,1,0))
root=EB.new("root"); root.head=Vector((cx,cy,0.0)); root.tail=root.head+FWD*0.14
pelvis=EB.new("pelvis"); pelvis.head=CH["spine"][0]; pelvis.tail=CH["spine"][0]+FWD*0.10
pelvis.parent=root
SP=mkchain("spine",CH["spine"],EB["pelvis"])
crown=EB.new("crown"); crown.head=CH["spine"][-1]; crown.tail=CH["spine"][-1]+Vector((0,0,0.10))
crown.parent=EB[SP[-1]]; crown.use_connect=True

BONES={}
for n in LEGS:  BONES[n]=mkchain(n.lower(),CH[n],EB["pelvis"])
IKB=[]
for n in LEGS:                              # 脚的目标点挂在 root 上 -> 身体前移时脚不滑
    tip=CH[n][-1]
    b=EB.new(n.lower()+"_ik"); b.head=tip; b.tail=tip+FWD*0.08; b.parent=root
    IKB.append((n,b.name))
for n in VINES:                             # 藤按根端离脊柱哪一节近来挂
    base=CH[n][0]
    par=min(SP+["crown"], key=lambda bn: (base-EB[bn].head).length)
    BONES[n]=mkchain(n.lower(),CH[n],EB[par])
# 让每根骨的局部 X 轴对齐世界 X: 骨 Z 朝世界 -Y 时, X = Y x Z 恰好是世界 +X。
# 这样 rotation_euler[0] 对每根骨都是"前后俯仰", 不用逐根猜轴。
# 竖直骨用 GLOBAL_POS_Z 是退化的(骨向和目标轴平行), 之前脊柱的俯仰方向就是乱的。
# roll 要按组给, 不能一刀切:
#   腿/藤 —— 放射状朝各个方向。GLOBAL_POS_Z 让骨 Z 朝世界上方, 局部 X 就成了
#            "垂直于自己、且水平"的轴, 绕它转 = 在自己所在的竖直面里俯仰/下卷。
#            这个约定跟方位角无关, 两侧对称的骨给同样的角度会同向卷。
#            一刀切成 GLOBAL_NEG_Y 会逼所有腿在世界 YZ 面里弯 -> 横着掰 -> 畸变 2.76x。
#   脊柱  —— 近乎竖直, GLOBAL_POS_Z 退化, 改用 GLOBAL_NEG_Y (局部 X = 世界 X = 前后俯仰)。
#   root/pelvis/IK —— 沿 +Y 建, roll=0 时局部轴就等于世界轴。
bpy.ops.armature.select_all(action='DESELECT')
for bn in sum(BONES.values(),[]): EB[bn].select=True
bpy.ops.armature.calculate_roll(type='GLOBAL_POS_Z')
bpy.ops.armature.select_all(action='DESELECT')
for bn in SP: EB[bn].select=True
EB["crown"].select=True
bpy.ops.armature.calculate_roll(type='GLOBAL_NEG_Y')
for bn in ["root","pelvis"]+[x[1] for x in IKB]: EB[bn].roll=0.0
bpy.ops.object.mode_set(mode='OBJECT')

# IK 链故意**不包含腿根那一节**(6 节里解后 5 节)。腿根一转, 埋在躯干里的
# 腿根表面就会从躯干表面上撕开(实测掀开 0.1165)。让腿根保持相对 pelvis 刚性,
# 而躯干下段的权重也是 pelvis 系的 -> 两边同步, 接口纹丝不动。
# 但只留 3 节给 IK 会绷坏(畸变 3.57x), 所以腿要**加节**: 腿根照样钉死, 能动的部分分摊到更多关节。
for n,ikn in IKB:
    pb=AO.pose.bones[BONES[n][-1]]
    # 解后 (LEGSEG-1) 节, **腿根那一节永远不动**。
    # 这个数必须跟 LEGSEG 一起变: 写死 5 的话, 加节反而让可达半径缩水
    # (5 根变短的骨 < 5 根原长的骨), 伸展率直接飙到 1.22, IK 够不着 -> 畸变 3.50x。
    c=pb.constraints.new('IK'); c.target=AO; c.subtarget=ikn; c.chain_count=LEGSEG-1

# ===== 权重 =====
# 沿中轴弧长做线性过渡, 过渡带 = 骨段长的 85%。**不能开 use_deform_preserve_volume**
# (双四元数蒙皮): Unity 只有线性混合蒙皮, 在 Blender 里靠它掩盖的挤压到引擎里会原样暴露。自动热扩散在这种合并出来的
# 脏网格上容易炸, 而且过渡带宽度不可控 —— 过渡越窄剪切越大, 跟顶点着色器一个道理。
def seg_t(p,a,b):
    ab=b-a; l2=ab.length_squared
    return max(0.0,min(1.0,(p-a).dot(ab)/l2)) if l2>1e-12 else 0.0
def paint(obj, cs, names):
    """返回 (每顶点的骨权重字典, 每顶点沿中轴的弧长, 总弧长)。先不写进顶点组,
    因为附着件还要拿宿主的权重来嫁接。"""
    tot=[(cs[i+1]-cs[i]).length for i in range(len(cs)-1)]
    cum=[0.0]
    for l in tot: cum.append(cum[-1]+l)
    Wv=[]; S=[]
    for w in W[obj.name]:
        best=(9e9,0,0.0)
        for i in range(len(cs)-1):
            t=seg_t(w,cs[i],cs[i+1]); dd=(w-(cs[i]+(cs[i+1]-cs[i])*t)).length
            if dd<best[0]: best=(dd,i,t)
        _,i,t=best; s=cum[i]+tot[i]*t; S.append(s)
        acc={}
        for j in range(len(names)):
            c=(cum[j]+cum[j+1])*0.5; half=tot[j]*0.5+tot[j]*0.85
            g=max(0.0,1.0-abs(s-c)/max(1e-9,half))
            if g>1e-4: acc[names[j]]=g
        tw=sum(acc.values()) or 1.0
        Wv.append({k:v/tw for k,v in acc.items()})
    return Wv,S,cum[-1]

WV={}; SS={}; ARC={}
WV["Trunk"],SS["Trunk"],ARC["Trunk"]=paint(T,CH["spine"],SP)
for n in LEGS+VINES:
    WV[n],SS[n],ARC[n]=paint(bpy.data.objects[n],CH[n],BONES[n])

# ===== 把附着件嫁接到宿主表面 =====
# 这是"一动就分家"的根因: 之前花瓣/叶是整片刚性挂在**某一根**骨上, 但它贴着的
# 躯干表面是在两根脊柱骨之间**混合**变形的。一边刚性一边混合, 一动必然错开。
# 正确做法是让附着件采样它接触点处宿主表面的**混合权重** —— 跟顶点动画层里
# "被携带的部件必须继承携带者" 是同一个道理, 只不过这里携带者是一片蒙皮表面。
from mathutils.kdtree import KDTree
def hostkd(names):
    n=sum(len(W[x]) for x in names); kd=KDTree(n); ref=[]; k=0
    for x in names:
        for i,w in enumerate(W[x]): kd.insert(w,k); ref.append((x,i)); k+=1
    kd.balance(); return kd,ref
def sample(kd,ref,p,skip=None):
    acc={}; tw=0.0
    for _,j,d in kd.find_n(p,8):
        x,i=ref[j]
        if x==skip: continue
        g=1.0/max(1e-4,d)
        for bn,v in WV[x][i].items(): acc[bn]=acc.get(bn,0.0)+v*g
        tw+=g
    if not acc: return None
    return {k:v/tw for k,v in acc.items()}

TK,TR=hostkd(["Trunk"])
# 过渡带**不能写死**。有的藤前 26% 是贴着躯干长的(Vine_05), 写死 28% 的话
# 过渡刚好在接触区边缘断掉, 贴着躯干那一整段全归藤骨管 -> 一卷就整块掀起来(0.0929)。
# 正确做法: 过渡带一直延伸到"这条藤不再碰到宿主"的位置, 再往外留一段余量。
# 接触区内 **完全**交给宿主权重(b=0), 出了接触区才开始过渡到自己的骨链。
# 只把过渡带的终点往后挪没用: 接触区里 b 已经涨到 0.68, 还是藤骨说了算 -> 照样掀 0.0657。
def blend_span(n, kd, arc, S):
    ws=W[n]; ext=0.0
    for i,w in enumerate(ws):
        if kd.find(w)[2]<0.012: ext=max(ext,S[i])
    ext=min(ext,0.60*arc)          # 封顶: 别让整条藤都被躯干锁死
    return ext, max(0.12*arc, 0.15*arc)
# 腿**不嫁接**。腿骨 0 的父级本来就是 pelvis, 根部埋在躯干里看不见;
# 硬把腿根 28% 弧长焊到脊柱的混合权重上, 等于在髋部塞进一段极短的过渡带,
# 而髋恰恰是转角最大的地方 —— 又是"剪切 = 转角/过渡距离", 实测畸变 1.57 -> 2.77x。
for n in VINES:
    ws=W[n]
    ai=min(range(len(ws)), key=lambda i: TK.find(ws[i])[2])
    hw=sample(TK,TR,ws[ai])
    if hw is None: continue
    ext,mar=blend_span(n,TK,ARC[n],SS[n])
    for i in range(len(ws)):
        b=max(0.0,min(1.0,(SS[n][i]-ext)/max(1e-9,mar)))
        acc={k:v*b for k,v in WV[n][i].items()}
        for k,v in hw.items(): acc[k]=acc.get(k,0.0)+v*(1.0-b)
        tw=sum(acc.values()) or 1.0
        WV[n][i]={k:v/tw for k,v in acc.items()}

# ===== 附着件: 每片给一根自己的骨 =====
# 之前花瓣/叶是**整片**照抄宿主接触点的混合权重 —— 焊得死死的(分家 0.0001),
# 但也彻底不会动: 身体一甩它们像贴纸一样整片跟着平移, 没有任何滞后。
# 现在改成: **接触区仍然 100% 交给宿主表面**(所以照样不分家), 出了接触区才过渡到
# 自己的骨。甩多大不是拍脑袋定的, 还是那条剪切律:
#   剪切 ≈ 转角 x 力臂 / 过渡带宽   =>   转角上限 = 剪切预算 x 过渡带宽 / 部件长度
# 侧躺贴在躯干上的叶(接触区占了大半)自动只剩几度, 悬空的花瓣能甩二十几度。
HK,HR=hostkd(["Trunk"]+LEGS+VINES)
ATT=[o for o in MESH if o.name not in (["Trunk"]+LEGS+VINES)]
SHEAR=0.40; CONTACT=0.012   # 0.45 时冠部实测 1.42x, 压过了 1.4x 的撕裂线
GEO={}
for o in ATT:
    ws=W[o.name]; dh=[HK.find(w)[2] for w in ws]
    order=sorted(range(len(ws)), key=lambda i: dh[i])
    k=max(1,int(0.20*len(ws)))
    B=sum((ws[i] for i in order[:k]),Vector())/k       # 根部 = 最贴宿主那 20% 顶点的重心
    C=sum(ws,Vector())/len(ws)
    d=C-B; d=d.normalized() if d.length>1e-6 else Vector((0,0,1))
    # 过渡带按**离根部的球面距离**算, 不能按"沿部件朝向的长度"算。
    # 花瓣是又宽又薄的板: Petal_13 顺着朝向只有 0.055 长, 横着却有 0.104 宽。
    # 按长度定带宽 -> 横向那些顶点的力臂是带宽的两倍, 剪切翻倍(实测畸变 3.06x)。
    S=[(w-B).length for w in ws]
    L=max(max(S),0.02)
    ext=max([S[i] for i in range(len(ws)) if dh[i]<CONTACT], default=0.0)
    ext=max(0.0,min(ext,0.75*L))
    mar=max(0.5*(L-ext),0.15*L)
    hw=sample(HK,HR,ws[order[0]]) or {"crown":1.0}
    GEO[o.name]=dict(B=B,d=d,S=S,L=L,ext=ext,mar=mar,hw=hw,
                     # 过渡带末端的力臂 = ext+mar, 剪切 ≈ 转角 x 力臂 / 带宽
                     tmax=min(math.radians(28.0),SHEAR*mar/max(1e-4,ext+mar)),
                     par=max(hw,key=lambda x:hw[x]), dh=dh)

# 嘴 = 冠部那圈玫瑰状花瓣。中心取它们根部的重心, 轴取它们伸出方向的平均。
# "张开" = 每片绕 (自身朝向 x 向外的径向) 转 -> 梢端往外翻, 根部不动。
CR=[n for n in GEO if GEO[n]["B"].z>0.60]
MC=sum((GEO[n]["B"] for n in CR),Vector())/len(CR)
MA=sum((GEO[n]["d"] for n in CR),Vector()).normalized()
print("### 嘴: 中心 (%.3f,%.3f,%.3f) 朝向 (%+.2f,%+.2f,%+.2f) 花瓣 %d 片 ###"%(
    MC.x,MC.y,MC.z,MA.x,MA.y,MA.z,len(CR)))
for n in GEO:
    g=GEO[n]; T=g["B"]+g["d"]*g["L"]
    rad=(T-MC)-MA*((T-MC).dot(MA))
    if rad.length<1e-4: rad=g["d"].cross(MA)
    ax=g["d"].cross(rad.normalized())
    g["open"]=ax.normalized() if ax.length>1e-6 else Vector((1,0,0))
    g["mouth"]=1 if (n in CR and (g["B"]-MC).length<0.17) else 0

# ===== 冠心那个喙: 拆上下颌 =====
# Petal_09 不是一片花瓣, 是嘴本身: 里面有 69 个松散块 —— 上壳 40 顶点、下壳 36 顶点,
# 外加 65 颗牙。Tripo 拆件时它们是分开的, organize2 合并后还留在同一个网格里,
# 所以能按**连通分量**重新分成上下颌, 给下颌单独一根铰链骨。
BEAK="Petal_09"
_bo=bpy.data.objects[BEAK]; _me=_bo.data; WB=W[BEAK]
_adj={i:set() for i in range(len(_me.vertices))}
for _e in _me.edges:
    _a,_b=_e.vertices; _adj[_a].add(_b); _adj[_b].add(_a)
_seen=set(); COMP=[]
for _i in range(len(_me.vertices)):
    if _i in _seen: continue
    _st=[_i]; _seen.add(_i); _c=[]
    while _st:
        _x=_st.pop(); _c.append(_x)
        for _y in _adj[_x]:
            if _y not in _seen: _seen.add(_y); _st.append(_y)
    COMP.append(_c)
COMP.sort(key=len,reverse=True)
UPS,LOS=COMP[0],COMP[1]
if sum(WB[i].z for i in UPS)/len(UPS) < sum(WB[i].z for i in LOS)/len(LOS): UPS,LOS=LOS,UPS
def _kd(idx):
    t=KDTree(len(idx))
    for j,i in enumerate(idx): t.insert(WB[i],j)
    t.balance(); return t
_ku,_kl=_kd(UPS),_kd(LOS)
LOW=set(LOS)
for _c in COMP[2:]:              # 牙: 拿**最近顶点**判归属, 用重心会把上颌垂下来的牙判给下颌
    if min(_kl.find(WB[i])[2] for i in _c) < min(_ku.find(WB[i])[2] for i in _c): LOW|=set(_c)
_g=GEO[BEAK]
_sl=sorted(LOW,key=lambda i:_g["S"][i]); _k=max(1,int(0.15*len(_sl)))
HINGE=sum((WB[i] for i in _sl[:_k]),Vector())/_k       # 铰链 = 下颌最靠后那 15% 的重心
JAX=_g["d"].cross(Vector((0,0,1)))
JAX=JAX.normalized() if JAX.length>1e-6 else Vector((1,0,0))
RL=max((WB[i]-HINGE).length for i in LOW)
JMAR=max(0.45*RL,0.008)
# 铰链骨的过渡带是从**铰链**量的, 所以过渡带末端的力臂就等于带宽 -> 剪切 ≈ 转角本身,
# 转角能直接吃满剪切预算(20°), 比按部件根部量的 6° 大得多。
TJAW=SHEAR
_jt=sum((WB[i] for i in _sl[-_k:]),Vector())/_k
print("### 喙: 上颌 %d 顶点 / 下颌 %d 顶点(含牙) 铰链 (%.3f,%.3f,%.3f) 开合 %.1f° ###"%(
    len(WB)-len(LOW),len(LOW),HINGE.x,HINGE.y,HINGE.z,math.degrees(TJAW)))

bpy.ops.object.mode_set(mode='EDIT'); EB=AO.data.edit_bones
for n in sorted(GEO):
    g=GEO[n]
    b=EB.new("att_"+n.lower()); b.head=g["B"]; b.tail=g["B"]+g["d"]*max(g["L"],0.02)
    b.parent=EB[g["par"]]; b.use_connect=False
    g["bone"]=b.name
jb=EB.new("jaw"); jb.head=HINGE; jb.tail=HINGE+(_jt-HINGE).normalized()*max(RL,0.02)
jb.parent=EB[GEO[BEAK]["bone"]]; jb.use_connect=False
bpy.ops.object.mode_set(mode='OBJECT')
GEO[BEAK]["open"]=JAX            # 喙整体也绕铰链轴仰头, 跟下颌反向 -> 张得更开
AO.data.bones["jaw"]["tmax"]=TJAW
AO.data.bones["jaw"]["mouth"]=1
AO.data.bones["jaw"]["open"]=list(-JAX)
for n in GEO:                    # 甩动上限/张嘴轴存在骨头上, 动画脚本直接读
    g=GEO[n]; bo=AO.data.bones[g["bone"]]
    bo["tmax"]=g["tmax"]; bo["mouth"]=g["mouth"]; bo["open"]=list(g["open"])
print("   %-10s %5s %6s %6s %6s  %s"%("部件","长","接触","过渡","上限°","嘴"))
for n in sorted(GEO,key=lambda x:-GEO[x]["tmax"]):
    g=GEO[n]
    print("   %-10s %5.3f %6.3f %6.3f %6.1f  %s"%(
        n,g["L"],g["ext"],g["mar"],math.degrees(g["tmax"]),"嘴" if g["mouth"] else ""))

for o in ATT:
    n=o.name; g=GEO[n]; ws=W[n]; bn=g["bone"]
    WV[n]=[]
    for i in range(len(ws)):
        b=max(0.0,min(1.0,(g["S"][i]-g["ext"])/max(1e-9,g["mar"])))
        acc={k2:v*(1.0-b) for k2,v in g["hw"].items()}
        acc[bn]=acc.get(bn,0.0)+b
        tw=sum(acc.values()) or 1.0
        WV[n].append({k2:v/tw for k2,v in acc.items()})

for i in LOW:                    # 下颌: 在喙自己的权重之上, 按离铰链的距离过渡到铰链骨
    b=max(0.0,min(1.0,(WB[i]-HINGE).length/JMAR))
    acc={k2:v*(1.0-b) for k2,v in WV[BEAK][i].items()}
    acc["jaw"]=acc.get("jaw",0.0)+b
    tw=sum(acc.values()) or 1.0
    WV[BEAK][i]={k2:v/tw for k2,v in acc.items()}

for o in MESH:                   # 落笔
    got=set()
    for d in WV[o.name]: got|=set(d.keys())
    for bn in got: o.vertex_groups.new(name=bn)
    for i,d in enumerate(WV[o.name]):
        for bn,v in d.items():
            if v>1e-4: o.vertex_groups[bn].add([i],v,'REPLACE')

for o in MESH:
    m=o.modifiers.new("Rig",'ARMATURE'); m.object=AO; m.use_deform_preserve_volume=False
    o.parent=AO
print("### 骨架: %d 根骨 (腿 %d 条 / 藤 %d 条), %d 个网格已蒙皮 ###"%(
    len(AO.data.bones),len(LEGS),len(VINES),len(MESH)))
bpy.ops.wm.save_as_mainfile(filepath="/tmp/rd-agent/tripo/boss_rigged.blend")
