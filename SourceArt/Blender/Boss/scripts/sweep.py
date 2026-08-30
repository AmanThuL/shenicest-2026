import bpy
bpy.ops.wm.open_mainfile(filepath="/tmp/rd-agent/tripo/boss_anim_preview.blend")
sc=bpy.context.scene
ms=[o for o in sc.objects if o.type=='MESH']
rest={}
for o in ms:
    me=o.data; me.calc_loop_triangles()
    rest[o.name]=([tuple(t.vertices) for t in me.loop_triangles],
                  [v.co.copy() for v in me.vertices])
def ident(m):                      # 找 BulgeAmp / SwayAmp 的 socket 标识
    g=m.node_group; out={}
    for s in g.interface.items_tree:
        if getattr(s,'identifier',None) and s.item_type=='SOCKET' and s.in_out=='INPUT':
            out[s.name]=s.identifier
    return out
IDS=ident(ms[0].modifiers["PulseAnim"])
def run(bulge,sway):
    for o in ms:
        m=o.modifiers["PulseAnim"]
        m[IDS["BulgeAmp"]]=bulge; m[IDS["SwayAmp"]]=sway
        o.update_tag()
    worst=0.0; who=""
    for f in (1,13,25,37,49,61,73,85):
        sc.frame_set(f); dg=bpy.context.evaluated_depsgraph_get()
        for o in ms:
            ev=o.evaluated_get(dg).data
            tris,co=rest[o.name]
            for a,b,c in tris:
                r=[]
                for i,j in ((a,b),(b,c),(c,a)):
                    d0=(co[i]-co[j]).length
                    if d0<1e-7: r=[]; break
                    r.append((ev.vertices[i].co-ev.vertices[j].co).length/d0)
                if not r: continue
                q=max(r)/max(1e-7,min(r))
                if q>worst: worst,who=q,"%s@f%d"%(o.name,f)
    return worst,who
for bl,sw in ((0.0,0.024),(0.0158,0.0),(0.0158,0.024),(0.008,0.024),(0.004,0.024),(0.002,0.024)):
    w,who=run(bl,sw)
    print("### BulgeAmp %.4f  SwayAmp %.3f -> 畸变 %.2fx (%s) ###"%(bl,sw,w,who))
