import bpy
from mathutils.kdtree import KDTree
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_anim_preview.blend")
sc=bpy.context.scene
objs=[o for o in sc.objects if o.type=='MESH']
def snap(fr):
    sc.frame_set(fr); dg=bpy.context.evaluated_depsgraph_get(); out={}
    for o in objs:
        ev=o.evaluated_get(dg); me=ev.to_mesh()
        out[o.name]=[v.co.copy() for v in me.vertices]; ev.to_mesh_clear()
    return out
# 基准必须是**没上动画**的原网格。帧 0 的 sin(2pi*phase) 并不为零,
# 拿帧 0 当"静止"等于拿一个随机姿势当基准, 数出来的张开量没有意义。
S0={o.name:[v.co.copy() for v in o.data.vertices] for o in objs}
tot=sum(len(v) for v in S0.values())
kd=KDTree(tot); own=[]; loc=[]; k=0
for nm,vs in S0.items():
    for i,w in enumerate(vs): kd.insert(w,k); own.append(nm); loc.append(i); k+=1
kd.balance()
pair={}
for nm,vs in S0.items():
    best=(9e9,None,None,None)
    for i,w in enumerate(vs):
        for _,j,d in kd.find_n(w,40):
            if own[j]!=nm:
                if d<best[0]: best=(d,i,own[j],loc[j])
                break
    pair[nm]=best
worst={}
for fr in range(0,48,2):
    S=snap(fr)
    for nm,(d0,i,hn,hi) in pair.items():
        if i is None: continue
        d=(S[nm][i]-S[hn][hi]).length
        worst[nm]=max(worst.get(nm,0.0), d-d0)
print("%-10s %9s %11s  %s"%("对象","静止缝隙","动起来张开","接触对象"))
HOST=("Trunk","Root","Vine")
real={k:v for k,v in worst.items() if pair[k][2].split("_")[0] in HOST}
for nm in sorted(real,key=lambda x:-real[x])[:8]:
    print("%-10s %9.4f %11.4f  %s%s"%(nm,pair[nm][0],worst[nm],pair[nm][2],"  <<< 悬空" if worst[nm]>0.004 else ""))
print("\n真正脱离宿主的最大张开 %.4f (模型高 1.0, 花瓣互相拉开不算)"%max(real.values()))
