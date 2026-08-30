import bpy, math
from mathutils import Vector
from mathutils.kdtree import KDTree

SRC = "/Users/tiantian/Downloads/奇幻植物怪兽+3D+模型.glb"
DST = "/tmp/rd-agent/tripo/boss_organized.blend"
THORN_CUT = 0.055
D0, D1 = 0.004, 0.085      # 间隙 <D0 完全钉死, >D1 完全自由 (模型总高 1.0)

bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=SRC)
sc = bpy.context.scene
bpy.ops.object.select_all(action='SELECT')
bpy.context.view_layer.objects.active = [o for o in sc.objects if o.type=='MESH'][0]
bpy.ops.object.parent_clear(type='CLEAR_KEEP_TRANSFORM')
bpy.ops.object.transform_apply(location=True, rotation=True, scale=True)
bpy.ops.object.select_all(action='DESELECT')

def measure(o):
    ws=[v.co.copy() for v in o.data.vertices]
    lo=Vector((min(p[i] for p in ws) for i in range(3)))
    hi=Vector((max(p[i] for p in ws) for i in range(3)))
    d=hi-lo
    return dict(d=d, c=sum(ws,Vector())/len(ws), mx=max(d), thin=min(d)/max(d), lo=lo, hi=hi, ws=ws)

meshes=[o for o in sc.objects if o.type=='MESH']
M={o.name:measure(o) for o in meshes}
MLO=Vector((min(M[n]['lo'][i] for n in M) for i in range(3)))
MHI=Vector((max(M[n]['hi'][i] for n in M) for i in range(3)))
MSZ=MHI-MLO

struct=[o for o in meshes if M[o.name]['mx']>=THORN_CUT]
thorns=[o for o in meshes if M[o.name]['mx']< THORN_CUT]
def ntri(o):
    o.data.calc_loop_triangles(); return len(o.data.loop_triangles)
trunk=max(struct,key=ntri)
roots,vines,petals,misc=[],[],[],[]
for o in struct:
    if o is trunk: continue
    m=M[o.name]
    # 腿 = **触地**的粗部件。不能按重心高度判 —— 拱形的藤重心也低,
    # 会被误判成腿然后锁死不动。
    if   m['lo'].z<0.12 and m['hi'].z<0.45:    roots.append(o)
    elif m['mx']>=0.22:                        vines.append(o)
    elif m['c'].z>=0.60 and m['thin']<0.60:    petals.append(o)
    else:                                      misc.append(o)
KIND={}
for o in roots:  KIND[o]=('Root',True)      # True = 静止(走骨骼)
for o in vines:  KIND[o]=('Vine',False)
for o in petals: KIND[o]=('Petal',False)
for o in misc:   KIND[o]=('Leaf',False)
for o in thorns: KIND[o]=('Thorn',False)
KIND[trunk]=('Trunk',True)

# ===== 补掉 Tripo 原模型自带的悬空 =====
# 实测有部件静止状态就离宿主 0.0088(7 米时 6 厘米)。不是动画造成的, 是生成时就没接上。
# 沿"最近点"方向把整个部件推进去, 留 0.004 的嵌入量保证穿插。
# 宿主 = 躯干/腿/藤。花瓣不能往旁边那片花瓣上推 —— 推完离躯干照样悬空。
# 宿主分两套: 花瓣/叶只能往躯干/腿/藤上推(往旁边那片花瓣推等于没推);
# 刺可以长在任何结构件上, 包括花瓣。
def build(lst):
    t=KDTree(sum(len(M[o.name]['ws']) for o in lst)); ow=[]; k=0
    for o in lst:
        for w in M[o.name]['ws']: t.insert(w,k); ow.append(o); k+=1
    t.balance(); return t,ow
GK,GO=build([trunk]+roots+vines)          # 给花瓣/叶
TK,TO=build(struct)                       # 给刺
moved=0; worst=0.0; far=[]
for o in meshes:
    if o is trunk or o in roots: continue
    gkd,gown=(TK,TO) if o in thorns else (GK,GO)
    best=(9e9,None,None)
    for w in M[o.name]['ws']:
        hit=[(p,ii,d) for p,ii,d in gkd.find_n(w,40) if gown[ii] is not o]
        if hit and hit[0][2]<best[0]: best=(hit[0][2],w,hit[0][0])
    d,vp,hp=best
    if d>=0.030:            # 真的离宿主很远 = 本来就是独立悬浮件, 别乱搬
        far.append((o.name,d)); continue
    if d>0.0015 and vp is not None:
        dirv=(hp-vp);
        if dirv.length>1e-9:
            # 嵌入量按部件尺寸给, 留出旋转开合的余量
            sh=dirv.normalized()*(d+max(0.004,0.075*M[o.name]['mx']))
            for v in o.data.vertices: v.co+=sh
            M[o.name]=measure(o); moved+=1; worst=max(worst,d)
print("### 补合: 推回 %d 个悬空部件, 最大原始缝隙 %.4f ###"%(moved,worst))
for nm,d in sorted(far,key=lambda x:-x[1]): print("    跳过(离宿主 %.3f, 本来就是悬浮件): %s"%(d,nm))

# ===== 第二遍: 网格**内部**的悬空小块 =====
# 上面那一遍是对象级的, 看不见这个 —— Tripo 的腿根本不是一个壳:
# Root_01 一个对象里有 48 个互相重叠的小块(最大的才 42 顶点), 整个对象离宿主
# 早就是负的(埋进去了), 可里面某几颗刺自己飘在外面。必须按**连通分量**逐块量。
#
# 而且要量到**表面**(BVH)、不能量最近顶点: 顶点对顶点的距离受网格疏密影响,
# 埋得很深的块也能量出 0.006~0.011(上一版就是这么误报了 37 个)。
from mathutils.bvhtree import BVHTree
def islands(o):
    adj={i:set() for i in range(len(o.data.vertices))}
    for e in o.data.edges:
        a,b=e.vertices; adj[a].add(b); adj[b].add(a)
    seen=set(); out=[]
    for s in adj:
        if s in seen: continue
        st=[s]; seen.add(s); c=[]
        while st:
            x=st.pop(); c.append(x)
            for y in adj[x]:
                if y not in seen: seen.add(y); st.append(y)
        out.append(c)
    return out
ISL=[]; VK={}
for o in meshes:
    for c in islands(o):
        for i in c: VK[(o.name,i)]=len(ISL)
        ISL.append((o,c))
def gbvh():
    vs=[]; ps=[]; pk=[]
    for o in meshes:
        off=len(vs); vs.extend(M[o.name]['ws'])
        for p in o.data.polygons:
            ps.append([off+i for i in p.vertices]); pk.append(VK[(o.name,p.vertices[0])])
    return BVHTree.FromPolygons(vs,ps), pk
SMALL=24
fixed=0; wg=0.0
for _it in range(3):
    BV,PK=gbvh(); todo=[]
    for k,(o,c) in enumerate(ISL):
        if len(c)>SMALL: continue          # 大块是结构本身, 不许搬
        ws=M[o.name]['ws']; best=(9e9,None)
        for i in c:
            w=ws[i]; hit=None
            for R in (0.02,0.05,0.12):     # 半径逐级放大, 找到别的块就停
                h=[x for x in BV.find_nearest_range(w,R) if PK[x[2]]!=k]
                if h: hit=h; break
            if not hit: continue
            loc,nor,idx,d=min(hit,key=lambda x:x[3])
            sd=d if (w-loc).dot(nor)>=0 else -d     # 负 = 已经嵌进去了
            if sd<best[0]: best=(sd,nor)
        sd,nor=best
        # 只管"整块所有顶点都在别人外面"的; 一旦有一个顶点是负的, 说明已经接上了
        if nor is not None and 0.001<sd<0.030: todo.append((k,sd,nor))
    if not todo: break
    for k,sd,nor in todo:
        o,c=ISL[k]; ws=M[o.name]['ws']
        sz=max(max(ws[i][ax] for i in c)-min(ws[i][ax] for i in c) for ax in range(3))
        emb=max(0.0015,min(0.004,0.15*sz))          # 嵌入量按小块自己的尺寸给, 别把刺整根吞了
        sh=-nor*(sd+emb)
        for i in c: o.data.vertices[i].co+=sh
        wg=max(wg,sd)
    for o in set(ISL[k][0] for k,_,_ in todo): M[o.name]=measure(o)
    fixed+=len(todo)
print("### 补合2(块级): 推回 %d 个网格内部的悬空小块, 最大悬空 %.4f ###"%(fixed,wg))

# ===== 摆动权重: 一个覆盖全身的连续场 =====
# 定义: 离「躯干 + 腿」这些静止部件有多远。
#
# 为什么不按部件各算各的 —— 剪切量 ≈ 2 x 幅度 / 权重过渡距离。
# 过渡距离压在单个部件的尺寸上(几厘米), 幅度稍微一给就把网格剪碎(实测 6.17x)。
# 换成全身尺度的场, 过渡距离 0.30, 同样幅度下剪切降一个数量级。
#
# 另一个好处: 同一个位置的顶点必然拿到同一个权重, 跟它属于哪个部件无关
# -> 焊缝在数学上不可能裂开, 刺也不需要"继承宿主"这种补丁。
SWAY_D = 0.30
static=[trunk]+roots
skd=KDTree(sum(len(M[o.name]['ws']) for o in static)); k=0
for o in static:
    for w in M[o.name]['ws']: skd.insert(w,k); k+=1
skd.balance()
def sway_field(o):
    if o in static: return [0.0]*len(o.data.vertices)
    out=[]
    for w in M[o.name]['ws']:
        _,_,d=skd.find(w)
        t=max(0.0,min(1.0,d/SWAY_D))
        out.append(t*t*(3-2*t))
    return out

print("### 分类 ###")
for tag,lst in (('Trunk',[trunk]),('Root',roots),('Vine',vines),('Petal',petals),('Leaf',misc),('Thorn',thorns)):
    print("  %-6s %3d 个 / %5d 面" % (tag,len(lst),sum(ntri(o) for o in lst)))

# ================== 通道设计 ==================
#   顶点色 Pivot: RGB = 部件根部(归一化, 现在只有花瓣的旧路径还在用), A = 相位
#   UV2 AnimData: U = 摆动权重(全身连续场), V = 鼓胀增益, 见下
# 两项都是加法叠加:
#   摆动 —— 位移只由**位置**决定, 焊缝处两边位移相同, 必然合得上
#   鼓胀 —— 沿**顶点法线**外推, 不再是"绕根部等比缩放"
#
# 为什么从"绕根部缩放"换成"法线膨胀": 骨骼蒙皮之后, 刺跟着腿一起动,
# 而烘死的根部坐标 piv 是**静止姿态**下的绝对位置。腿一抬, rel=pos-piv
# 就变成"刺到空气中某点"的向量, 缩放方向乱指 -> 刺会朝地面甩。
# 法线是跟着蒙皮一起转的局部量, 所以法线膨胀天然免疫这个问题。
# 代价: 法线膨胀不是仿射变换, 形状会变(凸起处鼓得多), 但只要幅度小于
# 刺自身尺寸的量级就看不出来 —— 而且"肿瘤鼓包"本来就该是非仿射的。
#
#   V > 0.5 = 刺, 鼓胀增益 mS = clamp(2V-1) = 这根刺相对最大刺的尺寸
#   0 < V <= 0.5 = 花瓣叶, mS = 0 -> 不鼓(它们的摆动现在由 att_* 骨骼做)
#   V = 0 = 只跟着摆动场
def part_base(o):
    """部件根部 = 离其它结构件最近的那 20% 顶点的重心。
    同时返回"接触点摊开的程度": 贴着宿主侧躺的部件(比如顺着躯干长的叶),
    接触点遍布全身, 算出来的"根部"落在中段 —— 绕中段一转两头全甩起来,
    看着就是悬空。这种部件不能给旋转, 交给摆动场就行。"""
    ws=M[o.name]['ws']
    dd=[skd0.find(w)[2] for w in ws]
    order=sorted(range(len(ws)), key=lambda i: dd[i])
    k=max(1,int(0.20*len(ws)))
    b=sum((ws[i] for i in order[:k]), Vector())/k
    spread=max((ws[i]-b).length for i in order[:k])/max(1e-6,M[o.name]['mx'])
    return b, spread

skd0=KDTree(sum(len(M[o.name]['ws']) for o in struct)); k=0
for o in struct:
    for w in M[o.name]['ws']: skd0.insert(w,k); k+=1
skd0.balance()

# ===== 刺并入谁 (提前算, 携带关系直接复用, 保证和合并结果一致) =====
kd2=KDTree(sum(len(M[o.name]['ws']) for o in struct)); own2=[]; k=0
for o in struct:
    for w in M[o.name]['ws']: kd2.insert(w,k); own2.append(o); k+=1
kd2.balance()
buckets={o:[] for o in struct}
for t in thorns:
    _,i,_=kd2.find(M[t.name]['c']); buckets[own2[i]].append(t)

# ===== 谁被谁"携带" =====
# 花瓣是绕自己根部**刚体旋转**的。插在花瓣上的牙齿/刺如果绕自己的根部转,
# 转法跟花瓣不一样, 接缝就开 —— 用户看到的"牙齿和某些刺悬空"就是这个。
# 摆动场不会有这问题(它只由位置决定), 但刚体旋转是部件级的,
# 所以被携带的部件必须**继承携带者的旋转中心和相位**, 变成同一个刚体。
#
# 判据不能用"最近" —— 冠部花瓣互相挨着, 会被串成一整块一起转。
# 用"明显更大 + 互相穿插": 携带者尺寸 > 2.5 倍, 且几乎贴合。
carrier={}
for h,kids in buckets.items():                     # 刺: 直接用合并宿主, 不再另判贴合距离
    if KIND[h][0] in ('Petal','Leaf'):
        for t in kids: carrier[t]=h
for o in petals+misc:                              # 牙齿这种够大、没被归成刺的, 按"明显更小+贴合"判
    sz=M[o.name]['mx']; best=(9e9,None)
    for w in M[o.name]['ws']:
        hit=[(ii,d) for _,ii,d in TK.find_n(w,40) if TO[ii] is not o]
        if hit and hit[0][1]<best[0]: best=(hit[0][1],TO[hit[0][0]])
    d,h=best
    if h is not None and d<0.5*sz and M[h.name]['mx']>2.5*sz and KIND[h][0] in ('Petal','Leaf'):
        carrier[o]=h
for _ in range(4):                       # 传递闭包: 刺 -> 牙 -> 花瓣
    for o in list(carrier):
        h=carrier[o]
        if h in carrier: carrier[o]=carrier[h]
print("### 携带关系: %d 个部件跟着携带者一起转 ###"%len(carrier))

# ===== 旋转增益: 让"贴着宿主的那一点"无论怎么转都基本不动 =====
# 张开量 ~= 转角 x (接触点到旋转中心的距离)。侧躺贴在躯干上的叶, 根部锚在别处,
# 接触点离旋转中心 0.18 -> 0.14 弧度就掀开 0.025。所以按每个部件实测的
# "最远接触点半径"反算它能转多少, 保证接触点位移不超过 TOL。
# 增益直接烘进 V (V = 0.5 x 增益): 着色器里 mR = clamp(2V) - clamp(2V-1) 恰好等于增益,
# 一个节点都不用改。V=1.0 的刺不受影响。
TOL=0.004; MOUTH=0.14
BASE={}; GAIN={}
for o in petals+misc:
    b,sp=part_base(o); BASE[o]=b
    r=0.0
    for w in M[o.name]['ws']:
        hit=[d for _,ii,d in kd2.find_n(w,40) if own2[ii] is not o]
        # 0.015 而不是 0.006: 顶点对顶点的距离受网格疏密影响很大, 真嵌进躯干的
        # 部件量出来照样有 0.006~0.011。门槛卡太紧, 这些部件会被当成自由件放开转。
        if hit and hit[0]<0.015: r=max(r,(w-b).length)
    GAIN[o]=1.0 if r<1e-6 else max(0.0,min(1.0,TOL/(MOUTH*r)))
damp=sorted(((GAIN[o],o.name) for o in GAIN if GAIN[o]<0.85))
print("### 旋转被压住的部件 %d 个: %s ###"%(len(damp),
      ", ".join("%s %.2f"%(n,g) for g,n in damp[:8]) or "无"))

# 最大的那根刺当基准, 其余刺按自己的尺寸拿到 0~1 的增益。
TREF=max(M[t.name]['mx'] for t in thorns)
print("### 鼓胀基准: 最大刺 %.4f, 最小刺 %.4f (增益 %.2f) ###"
      %(TREF,min(M[t.name]['mx'] for t in thorns),min(M[t.name]['mx'] for t in thorns)/TREF))

stats={}
for idx,o in enumerate(meshes):
    me=o.data; m=M[o.name]; tag=KIND[o][0]
    phase=(idx*0.6180339887498949)%1.0
    sway=sway_field(o)
    # V: >0.5 = 刺(沿法线鼓胀, 增益 2V-1) / <=0.5 = 花瓣叶(不鼓, 交给骨骼) / 0 = 只跟摆动场
    if o in carrier:
        # 被花瓣携带 -> 完全复制携带者的旋转中心和相位, 变成同一个刚体。
        # 代价是它自己不再脉动, 换接缝绝不开裂 —— 牙齿本来也不该鼓。
        h=carrier[o]; base=BASE.get(h) or part_base(h)[0]; bul=0.5*GAIN.get(h,1.0)
        piv=Vector(((base[i]-MLO[i])/MSZ[i] for i in range(3)))
        if base.z>0.62: phase=0.0
        else: phase=(meshes.index(h)*0.6180339887498949)%1.0
    elif tag in ('Thorn','Petal','Leaf'):
        base=BASE[o] if o in BASE else part_base(o)[0]
        # 刺改走**法线膨胀**, V 就腾出来当鼓胀增益用: mS = clamp(2V-1)。
        # 增益里乘两样东西, 都是逐顶点的, 着色器一个节点都不用加:
        #  ① 这根刺的相对尺寸 —— 原来"绕根部等比缩放"时顶点位移天然 ∝ 刺长,
        #     大刺鼓得多小刺鼓得少。法线膨胀是绝对位移, 不按尺寸缩就会
        #     小刺爆掉、大刺纹丝不动。
        #  ② 根部淡出 —— 等比缩放时根部是不动点, 接缝天然不裂; 法线膨胀
        #     会把埋进宿主的那截往外推。嵌入量才 0.0015~0.004, 而幅度 0.016,
        #     不淡出的话每根刺都会当着镜头把根拔出来。
        if tag=='Thorn':
            g=min(1.0,M[o.name]['mx']/TREF)
            ws=M[o.name]['ws']; L0=max(1e-6,M[o.name]['mx'])
            bul=[]
            for w in ws:
                u=(w-base).length/L0
                u=max(0.0,min(1.0,(u-0.15)/0.40))
                bul.append(0.5+0.5*g*(u*u*(3.0-2.0*u)))    # smoothstep: 根部 0, 中段往上满增益
        else:
            bul=0.5*GAIN[o]
        piv=Vector(((base[i]-MLO[i])/MSZ[i] for i in range(3)))
        # 冠部花瓣相位全部归零 -> 它们同步开合, 读作"嘴在呼吸";
        # 低处的叶保留各自相位 -> 各飘各的。同一套公式, 靠相位区分。
        if tag!='Thorn' and base.z>0.62: phase=0.0
    else:
        bul=0.0; piv=Vector((0.0,0.0,0.0))
    s=stats.setdefault(tag,[0,0.0,0])
    s[0]+=len(sway); s[1]+=sum(sway); s[2]+=sum(1 for x in sway if x<0.05)
    col=me.color_attributes.get("Pivot") or me.color_attributes.new(name="Pivot",type='FLOAT_COLOR',domain='POINT')
    for i in range(len(me.vertices)): col.data[i].color=(piv.x,piv.y,piv.z,phase)
    uv=me.uv_layers.get("AnimData") or me.uv_layers.new(name="AnimData")
    bl=bul if isinstance(bul,list) else None
    for poly in me.polygons:
        for li in poly.loop_indices:
            vi=me.loops[li].vertex_index
            uv.data[li].uv=(sway[vi], bl[vi] if bl else bul)

print("### 摆动权重 (0=静止/贴身, 1=离躯干远, 可摆) ###")
for tag,(n_,ssum,pinned) in stats.items():
    if n_: print("  %-6s 平均 %.2f   不动的顶点 %d/%d (%.0f%%)" % (tag,ssum/n_,pinned,n_,100.0*pinned/n_))

# ===== 刺并入宿主 =====
bpy.ops.object.select_all(action='DESELECT')
for host,kids in buckets.items():
    if not kids: continue
    for kk in kids: kk.select_set(True)
    host.select_set(True); bpy.context.view_layer.objects.active=host
    bpy.ops.object.join(); bpy.ops.object.select_all(action='DESELECT')

for c in list(bpy.data.collections): bpy.data.collections.remove(c)
cols={}
def coll(t):
    if t not in cols:
        c=bpy.data.collections.new(t); sc.collection.children.link(c); cols[t]=c
    return cols[t]
for tag,lst in (('Trunk',[trunk]),
                ('Root',sorted(roots,key=lambda o:math.atan2(M[o.name]['c'].y,M[o.name]['c'].x))),
                ('Vine',sorted(vines,key=lambda o:-M[o.name]['c'].z)),
                ('Petal',sorted(petals,key=lambda o:-M[o.name]['c'].z)),
                ('Leaf',sorted(misc,key=lambda o:-M[o.name]['c'].z))):
    c=coll(tag)
    for i,o in enumerate(lst):
        o.name=tag if tag=='Trunk' else "%s_%02d"%(tag,i+1); o.data.name=o.name
        for old in list(o.users_collection): old.objects.unlink(o)
        c.objects.link(o)
for o in sc.objects:
    if o.type=='EMPTY': o.name="BossRoot"
print("### 合计 %d 个对象 / %d 面 / %d 材质 ###" %
      (len([o for o in sc.objects if o.type=='MESH']),
       sum(ntri(o) for o in sc.objects if o.type=='MESH'), len(bpy.data.materials)))
bpy.ops.wm.save_as_mainfile(filepath=DST)
print("SAVED",DST)
