import bpy
from mathutils.kdtree import KDTree
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_anim_preview.blend")
sc=bpy.context.scene
objs=[o for o in sc.objects if o.type=='MESH']
# 每个对象内部的连通块(刺/牙合并进来后各自是独立岛)
comp={}
for o in objs:
    me=o.data; n=len(me.vertices)
    par=list(range(n))
    def find(x):
        while par[x]!=x: par[x]=par[par[x]]; x=par[x]
        return x
    for e in me.edges:
        a,b=find(e.vertices[0]),find(e.vertices[1])
        if a!=b: par[a]=b
    comp[o.name]=[find(i) for i in range(n)]
# 基准必须取**没上修改器的原网格**, 不能用 snap(0)。
# 帧 0 的 sin(2pi*phase) 不为零, 拿帧 0 当静止 = 拿一个随机姿势当基准,
# 连配对都会跟着变, 两个版本之间根本没法比。gap.py 里早写了这条, 这里当初漏了。
REST={o.name:[v.co.copy() for v in o.data.vertices] for o in objs}
def snap(fr):
    sc.frame_set(fr); dg=bpy.context.evaluated_depsgraph_get(); out={}
    for o in objs:
        ev=o.evaluated_get(dg); me=ev.to_mesh()
        out[o.name]=[v.co.copy() for v in me.vertices]; ev.to_mesh_clear()
    return out
pairs={}
for o in objs:
    vs=REST[o.name]; c=comp[o.name]
    if len(set(c))<2: continue
    kd=KDTree(len(vs))
    for i,w in enumerate(vs): kd.insert(w,i)
    kd.balance()
    best={}
    for i,w in enumerate(vs):
        for _,j,d in kd.find_n(w,24):
            if c[j]!=c[i]:
                k=(min(c[i],c[j]),max(c[i],c[j]))
                if d<best.get(k,(9e9,))[0]: best[k]=(d,i,j)
                break
    pairs[o.name]=best
worst={}
for fr in (4,10,16,22,28,34,40,46):
    S=snap(fr)
    for nm,bp in pairs.items():
        vs=S[nm]
        for k,(d0,i,j) in bp.items():
            g=(vs[i]-vs[j]).length-d0
            if g>worst.get(nm,(0,))[0]: worst[nm]=(g,d0)
print("%-10s %10s %10s   %s"%("对象","静止贴合","动起来张开","(网格内部, 刺/牙 vs 宿主)"))
for nm in sorted(worst,key=lambda x:-worst[x][0])[:10]:
    g,d0=worst[nm]
    print("%-10s %10.4f %10.4f%s"%(nm,d0,g,"  <<< 焊缝裂开" if g>0.003 else ""))
print("\n网格内部最大张开 %.4f (模型高 1.0)"%max(v[0] for v in worst.values()))
