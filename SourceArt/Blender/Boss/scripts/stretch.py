import bpy, statistics
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_anim_preview.blend")
sc=bpy.context.scene
rest={}
for o in sc.objects:
    if o.type!='MESH': continue
    me=o.data; me.calc_loop_triangles()
    tris=[tuple(t.vertices) for t in me.loop_triangles]
    rest[o.name]=([v.co.copy() for v in me.vertices],tris)
res={}
def shape(vs,rv,tris):
    """三角形形状畸变: 三条边各自的伸长比里, 最大/最小。
    整体等比放大(刺鼓起来)三条边同比 -> 1.00; 被剪切才 >1。"""
    m=1.0
    for a,b,c in tris:
        r=[]
        for x,y in ((a,b),(b,c),(c,a)):
            l0=(rv[x]-rv[y]).length
            if l0>1e-6: r.append((vs[x]-vs[y]).length/l0)
        if len(r)==3 and min(r)>1e-6: m=max(m,max(r)/min(r))
    return m
for fr in range(0,49,2):
    sc.frame_set(fr); dg=bpy.context.evaluated_depsgraph_get()
    for o in sc.objects:
        if o.type!='MESH': continue
        ev=o.evaluated_get(dg); me=ev.to_mesh()
        vs=[v.co.copy() for v in me.vertices]; ev.to_mesh_clear()
        rv,tris=rest[o.name]
        res[o.name]=max(res.get(o.name,1.0), shape(vs,rv,tris))
print("%-10s %s" % ("对象","形状畸变 (1.00 = 只平移/等比缩放, 完全不剪切)"))
for k in sorted(res,key=lambda x:-res[x])[:12]:
    d=res[k]; flag="  <<< 撕裂" if d>1.5 else ("  << 明显" if d>1.2 else "")
    print("%-10s %7.2fx%s" % (k,d,flag))
print("\n全模型最大形状畸变 %.2fx" % max(res.values()))
