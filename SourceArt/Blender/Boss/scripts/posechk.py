import bpy
def bbox(tag,path,mult):
    bpy.ops.wm.open_mainfile(filepath=path)
    sc=bpy.context.scene
    ms=[o for o in sc.objects if o.type=='MESH']
    print("### %s ###"%tag)
    for f in (1,25,49,73):
        sc.frame_set(f)
        dg=bpy.context.evaluated_depsgraph_get()
        pts=[o.matrix_world@v.co for o in ms for v in o.evaluated_get(dg).data.vertices]
        xs=[p.x for p in pts]; ys=[p.y for p in pts]; zs=[p.z for p in pts]
        print("  f%-3d 宽X %.3f 厚Y %.3f 高Z %.3f 底z %.3f   (x%s 期望 宽%.3f 高%.3f)"
              %(f,max(xs)-min(xs),max(ys)-min(ys),max(zs)-min(zs),min(zs),mult,0.875*mult,1.0*mult))
bbox("boss_crawl.blend (1.0 尺度)","/tmp/rd-agent/tripo/boss_crawl.blend",1)
bbox("boss_export.blend (7.0 尺度)","/tmp/rd-agent/tripo/boss_export.blend",7)
