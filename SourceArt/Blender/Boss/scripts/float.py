import bpy, sys
from mathutils import Vector
from mathutils.bvhtree import BVHTree
F=sys.argv[sys.argv.index("--")+1]
bpy.ops.wm.open_mainfile(filepath=F)
sc=bpy.context.scene
MESH=[o for o in sc.objects if o.type=='MESH']
def comps(me):
    adj={i:set() for i in range(len(me.vertices))}
    for e in me.edges:
        a,b=e.vertices; adj[a].add(b); adj[b].add(a)
    seen=set(); out=[]
    for i in range(len(me.vertices)):
        if i in seen: continue
        st=[i]; seen.add(i); c=[]
        while st:
            x=st.pop(); c.append(x)
            for y in adj[x]:
                if y not in seen: seen.add(y); st.append(y)
        out.append(c)
    return out
CO={o.name:comps(o.data) for o in MESH}
W={o.name:[o.matrix_world@v.co for v in o.data.vertices] for o in MESH}
ISL=[]                                  # (objname, [vidx...])
vs=[]; ps=[]; pisl=[]
for o in MESH:
    vid={}
    for ci,c in enumerate(CO[o.name]):
        vid.update({i:len(ISL) for i in c}); ISL.append((o.name,c))
    off=len(vs); vs.extend(W[o.name])
    for p in o.data.polygons:
        ps.append([off+i for i in p.vertices]); pisl.append(vid[p.vertices[0]])
BV=BVHTree.FromPolygons(vs,ps)
def probe(k):
    """这一块离**别的**块的表面多远。负 = 已经嵌进去了。"""
    nm,c=ISL[k]; best=(9e9,None)
    for i in c:
        w=W[nm][i]
        for R in (0.02,0.05,0.12):
            hit=[h for h in BV.find_nearest_range(w,R) if pisl[h[2]]!=k]
            if hit: break
        if not hit: continue
        loc,nor,idx,d=min(hit,key=lambda h:h[3])
        sd=d if (w-loc).dot(nor)>=0 else -d
        if sd<best[0]: best=(sd,nor)
    return best
res=[]
for k,(nm,c) in enumerate(ISL):
    ws=[W[nm][i] for i in c]
    sz=max((a-b).length for a in ws for b in ws)
    sd,nor=probe(k)
    res.append((sd,nm,k,len(c),sz))
res.sort(reverse=True)
sm=[r for r in res if r[4]<0.07]
bad=[r for r in sm if 0.001<r[0]<0.10]
print("### 小块 %d 个, 其中真·悬空(离一切别的表面 >0.001) %d 个 ###"%(len(sm),len(bad)))
for g in bad[:14]:
    print("   %-10s 块#%-3d v%-3d 尺寸%.3f  悬空 %+.4f"%(g[1],g[2],g[3],g[4],g[0]))
