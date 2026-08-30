import bpy
from collections import defaultdict

SRC="/tmp/rd-agent/tripo/boss_crawl.blend"
DST="/tmp/rd-agent/tripo/boss_crawl_2x.blend"

# 目标: 幅度翻倍(0.0158 -> 0.0316)但**刺根不能被推出宿主**。
# 现在烘进 UV2.V 的是  V = 0.5 + 0.5*g*S(u)
#   g = 这根刺相对最大刺的尺寸(每根刺一个常数)
#   S = 沿刺轴的根部淡出 smoothstep, 0.15~0.55 段从 0 升到 1
# 位移 = BulgeAmp * (2V-1) = BulgeAmp * g * S。
#
# 做法: 把归一化后的淡出曲线**平方** —— S -> S²。
#   两端不变(0->0, 1->1), 每根刺的尺寸增益 g 原封不动;
#   中段被压低: S=0.5 处变 0.25。
# 配合 BulgeAmp 翻倍, 净效果是: 位移比 = 2S。
#   刺尖(S=1) 拿到满的 2 倍 —— 这是想要的;
#   S<=0.5 的根部区域位移**不高于**现在的出厂版 —— 根就不会被拔出来。
# 好处: 只碰一个顶点通道, 骨骼/蒙皮/动画一根手指都没动。

bpy.ops.wm.open_mainfile(filepath=SRC)
meshes=[o for o in bpy.context.scene.objects if o.type=='MESH']
print("### 打开 %s: %d 个网格对象 ###"%(SRC.split('/')[-1],len(meshes)))

tot_isl=0; tot_thorn=0; changed=0
for o in meshes:
    me=o.data
    uv=me.uv_layers.get("AnimData")
    if uv is None: continue
    # 顶点 -> V (逐顶点烘的, 取任一 loop 即可)
    vy={}
    v2loops=defaultdict(list)
    for poly in me.polygons:
        for li in poly.loop_indices:
            vi=me.loops[li].vertex_index
            vy[vi]=uv.data[li].uv[1]
            v2loops[vi].append(li)
    # 连通分量 = 一根刺。合并过的对象里装着好几根刺, 尺寸增益 g 各不相同,
    # 按整个对象取 max 会把小刺算错, 必须逐个连通分量来。
    adj=defaultdict(set)
    for e in me.edges:
        a,b=e.vertices; adj[a].add(b); adj[b].add(a)
    seen=set()
    for start in range(len(me.vertices)):
        if start in seen: continue
        comp=[]; stack=[start]; seen.add(start)
        while stack:
            x=stack.pop(); comp.append(x)
            for y in adj[x]:
                if y not in seen: seen.add(y); stack.append(y)
        tot_isl+=1
        ss=[2.0*vy.get(i,0.0)-1.0 for i in comp]
        g=max(ss)
        if g<=0.001: continue          # 不是刺(花瓣/藤/躯干 V<=0.5)
        tot_thorn+=1
        for i,s in zip(comp,ss):
            S=max(0.0,min(1.0,s/g))
            v_new=0.5+0.5*g*(S*S)
            for li in v2loops[i]:
                u_old=uv.data[li].uv[0]
                uv.data[li].uv=(u_old,v_new)   # U(摆动权重)原样不动
            changed+=1

print("### 连通分量 %d 个, 其中刺 %d 个; 重烘顶点 %d 个 ###"%(tot_isl,tot_thorn,changed))
bpy.ops.wm.save_as_mainfile(filepath=DST)
print("SAVED",DST)
