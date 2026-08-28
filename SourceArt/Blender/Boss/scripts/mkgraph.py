#!/usr/bin/env python3
# 生成 Assets/RootsDance/Shaders/BossPulse.shadergraph
#
# 为什么用脚本生成而不是手搓 JSON: .shadergraph 是 MultiJson —— 每个节点/每个
# 插槽/每条连线都是一个带 32 位十六进制 m_ObjectId 的独立对象, 手写必错。
# 也不能用 ShaderGraph 的 C# API: GraphData / BlockNode / CustomFunctionNode
# 这些类型在 Unity.ShaderGraph.Editor 里全是 internal, 外部程序集碰不到。
# 所有对象的字段布局都是从 Unity 自带模板里原样抄的(Cross Pipeline/0_Lit Basic)。
import json, hashlib, os, sys

HLSL_GUID = sys.argv[1]
OUT = sys.argv[2]

objs = []
def oid(tag):
    return hashlib.md5(("bosspulse:" + tag).encode()).hexdigest()
def add(tag, typ, ver=0, **kw):
    o = {"m_SGVersion": ver, "m_Type": typ, "m_ObjectId": oid(tag)}
    o.update(kw)
    objs.append(o)
    return o["m_ObjectId"]
def ref(tag): return {"m_Id": oid(tag)}

def drawstate(x, y, w=200.0, h=120.0, expanded=True):
    return {"m_Expanded": expanded, "m_Position": {"serializedVersion": "2",
            "x": x, "y": y, "width": w, "height": h}}

NODE_COMMON = dict(m_Group={"m_Id": ""}, synonyms=[], m_Precision=0,
                   m_PreviewExpanded=True, m_DismissedVersion=0, m_PreviewMode=0,
                   m_CustomColors={"m_SerializableColors": []})

# ---------------- 插槽 ----------------
def slot_v1(tag, sid, name, out, stage=3, val=0.0):
    return add(tag, "UnityEditor.ShaderGraph.Vector1MaterialSlot", m_Id=sid,
               m_DisplayName=name, m_SlotType=(1 if out else 0), m_Hidden=False,
               m_ShaderOutputName=name, m_StageCapability=stage,
               m_Value=val, m_DefaultValue=val, m_Labels=[])
def slot_vn(tag, sid, name, out, n, stage=3, val=(0.0, 0.0, 0.0, 0.0)):
    typ = {2: "Vector2MaterialSlot", 3: "Vector3MaterialSlot", 4: "Vector4MaterialSlot"}[n]
    keys = "xyzw"[:n]
    v = {k: val[i] for i, k in enumerate(keys)}
    return add(tag, "UnityEditor.ShaderGraph." + typ, m_Id=sid, m_DisplayName=name,
               m_SlotType=(1 if out else 0), m_Hidden=False, m_ShaderOutputName=name,
               m_StageCapability=stage, m_Value=v, m_DefaultValue=dict(v), m_Labels=[])

# ================= 属性 =================
# 引用名沿用 URP/Lit 的惯例 (_BaseMap/_BumpMap/_Smoothness), 这样 Boss.mat
# 从 URP/Lit 换到这个 shader 时贴图槽能直接对上, 不用重新指派。
PROPS = []
def prop_float(name, refname, value, ftype=0, rng=(0.0, 1.0)):
    t = "p_" + refname
    add(t, "UnityEditor.ShaderGraph.Internal.Vector1ShaderProperty", ver=1,
        m_Guid={"m_GuidSerialized": oid("g_" + refname)[:8] + "-" + oid("g_" + refname)[8:12]
                + "-" + oid("g_" + refname)[12:16] + "-" + oid("g_" + refname)[16:20]
                + "-" + oid("g_" + refname)[20:32]},
        m_Name=name, m_DefaultRefNameVersion=1, m_RefNameGeneratedByDisplayName=name,
        m_DefaultReferenceName="_" + name.replace(" ", "_"), m_OverrideReferenceName=refname,
        m_GeneratePropertyBlock=True, m_UseCustomSlotLabel=False, m_CustomSlotLabel="",
        m_DismissedVersion=0, m_Precision=0, overrideHLSLDeclaration=False,
        hlslDeclarationOverride=0, m_Hidden=False, m_PerRendererData=False,
        m_customAttributes=[], m_Value=value, m_FloatType=ftype,
        m_RangeValues={"x": rng[0], "y": rng[1]}, m_SliderType=0, m_SliderPower=3.0,
        m_EnumType=0, m_CSharpEnumString="", m_EnumNames=["Default"], m_EnumValues=[0])
    PROPS.append(t)
    return t

def prop_tex(name, refname, default_type, is_main=False):
    t = "p_" + refname
    add(t, "UnityEditor.ShaderGraph.Internal.Texture2DShaderProperty",
        m_Guid={"m_GuidSerialized": oid("g_" + refname)[:8] + "-" + oid("g_" + refname)[8:12]
                + "-" + oid("g_" + refname)[12:16] + "-" + oid("g_" + refname)[16:20]
                + "-" + oid("g_" + refname)[20:32]},
        m_Name=name, m_DefaultRefNameVersion=1, m_RefNameGeneratedByDisplayName=name,
        m_DefaultReferenceName="_" + name.replace(" ", "_"), m_OverrideReferenceName=refname,
        m_GeneratePropertyBlock=True, m_UseCustomSlotLabel=False, m_CustomSlotLabel="",
        m_DismissedVersion=0, m_Precision=0, overrideHLSLDeclaration=False,
        hlslDeclarationOverride=0, m_Hidden=False, m_PerRendererData=False,
        m_customAttributes=[], m_Value={"m_SerializedTexture": "", "m_Guid": ""},
        isMainTexture=is_main, useTilingAndOffset=False, useTexelSize=False,
        m_Modifiable=True, m_DefaultType=default_type)
    PROPS.append(t)
    return t

prop_tex("Base Map", "_BaseMap", 0, is_main=True)      # 0 = White
prop_tex("Normal Map", "_BumpMap", 3)                  # 3 = Bump
prop_float("Smoothness", "_Smoothness", 0.25, ftype=1, rng=(0.0, 1.0))
# 幅度是**绝对位移**(标定空间, 模型高 1.0), 不是刺长的百分比。
# 0.0158 = 0.30 x 最大刺尺寸 0.0528, 跟 Blender 预览里鼓起来一样多。
prop_float("Bulge Amp", "_BulgeAmp", 0.0158)
prop_float("Bulge Freq", "_BulgeFreq", 0.53)
prop_float("Sway Amp", "_SwayAmp", 0.024)
prop_float("Sway Freq", "_SwayFreq", 0.19)
# 模型在 Unity 里高 7 米, 而上面的常数是按高 1.0 标定的。
prop_float("Model Scale", "_ModelScale", 7.0)

# ================= 节点 =================
NODES, EDGES = [], []
def node(tag, typ, name, slots, x, y, ver=0, **extra):
    add(tag, typ, ver=ver, m_Name=name, m_DrawState=drawstate(x, y),
        m_Slots=[ref(s) for s in slots], **dict(NODE_COMMON, **extra))
    NODES.append(tag)
    return tag
def edge(src, sslot, dst, dslot):
    EDGES.append({"m_OutputSlot": {"m_Node": ref(src), "m_SlotId": sslot},
                  "m_InputSlot": {"m_Node": ref(dst), "m_SlotId": dslot}})

def propnode(tag, ptag, x, y, tex=False):
    s = tag + "_out"
    if tex:
        add(s, "UnityEditor.ShaderGraph.Texture2DMaterialSlot", m_Id=0, m_DisplayName="Out",
            m_SlotType=1, m_Hidden=False, m_ShaderOutputName="Out", m_StageCapability=3,
            m_BareResource=False)
    else:
        slot_v1(s, 0, "Out", True)
    return node(tag, "UnityEditor.ShaderGraph.PropertyNode", "Property", [s], x, y,
                m_Property=ref(ptag))

# --- 顶点阶段输入 ---
slot_vn("n_pos_out", 0, "Out", True, 3)
node("n_pos", "UnityEditor.ShaderGraph.PositionNode", "Position", ["n_pos_out"], -1000, -700,
     m_Space=0)                                   # 0 = Object
slot_vn("n_nrm_out", 0, "Out", True, 3)
node("n_nrm", "UnityEditor.ShaderGraph.NormalVectorNode", "Normal Vector", ["n_nrm_out"],
     -1000, -600, m_Space=0)
slot_vn("n_uv2_out", 0, "Out", True, 4)
node("n_uv2", "UnityEditor.ShaderGraph.UVNode", "UV", ["n_uv2_out"], -1000, -500,
     m_OutputChannel=2)                           # 2 = UV2 (AnimData)
slot_vn("n_col_out", 0, "Out", True, 4)
node("n_col", "UnityEditor.ShaderGraph.VertexColorNode", "Vertex Color", ["n_col_out"],
     -1000, -400)
for i, nm in enumerate(["Time", "Sine Time", "Cosine Time", "Delta Time", "Smooth Delta"]):
    slot_v1("n_time_%d" % i, i, nm, True)
node("n_time", "UnityEditor.ShaderGraph.TimeNode", "Time",
     ["n_time_%d" % i for i in range(5)], -1000, -300)

for i, (rn, y) in enumerate([("_BulgeAmp", -200), ("_BulgeFreq", -130), ("_SwayAmp", -60),
                             ("_SwayFreq", 10), ("_ModelScale", 80)]):
    propnode("n_" + rn, "p_" + rn, -1000, y)

# --- Custom Function: 全部数学都在 BossPulse.hlsl 里 ---
# 用外部 .hlsl 文件而不是内联字符串, 这样代码能被正常 review 和 diff。
CF_IN = [(0, "PositionOS", 3), (1, "NormalOS", 3), (2, "AnimData", 4), (3, "VertexColor", 4),
         (4, "TimeSec", 1), (5, "BulgeAmp", 1), (6, "BulgeFreq", 1), (7, "SwayAmp", 1),
         (8, "SwayFreq", 1), (9, "ModelScale", 1)]
cf_slots = []
for sid, nm, n in CF_IN:
    t = "cf_in_%d" % sid
    (slot_v1 if n == 1 else (lambda a, b, c, d: slot_vn(a, b, c, d, n)))(t, sid, nm, False)
    cf_slots.append(t)
slot_vn("cf_out", 10, "OutPositionOS", True, 3)
cf_slots.append("cf_out")
node("n_cf", "UnityEditor.ShaderGraph.CustomFunctionNode", "BossPulse (Custom Function)",
     cf_slots, -600, -500, ver=1,
     m_SourceType=0, m_FunctionName="BossPulse", m_FunctionSource=HLSL_GUID,
     m_FunctionSourceUsePragmas=True, m_FunctionBody="")
objs[-1]["synonyms"] = ["code", "HLSL"]

for sid, src in [(0, "n_pos"), (1, "n_nrm"), (2, "n_uv2"), (3, "n_col")]:
    edge(src, 0, "n_cf", sid)
edge("n_time", 0, "n_cf", 4)
for sid, rn in [(5, "_BulgeAmp"), (6, "_BulgeFreq"), (7, "_SwayAmp"), (8, "_SwayFreq"),
                (9, "_ModelScale")]:
    edge("n_" + rn, 0, "n_cf", sid)

# --- 片元阶段 ---
propnode("n_basemap", "p__BaseMap", -1000, 300, tex=True)
propnode("n_bumpmap", "p__BumpMap", -1000, 500, tex=True)
propnode("n_smooth", "p__Smoothness", -1000, 700)

def sampler(tag, x, y, textype, ver=0):
    slot_vn(tag + "_rgba", 0, "RGBA", True, 4, stage=2)
    for sid, nm in [(4, "R"), (5, "G"), (6, "B"), (7, "A")]:
        slot_v1(tag + "_%d" % sid, sid, nm, True, stage=2)
    add(tag + "_tex", "UnityEditor.ShaderGraph.Texture2DInputMaterialSlot", m_Id=1,
        m_DisplayName="Texture", m_SlotType=0, m_Hidden=False, m_ShaderOutputName="Texture",
        m_StageCapability=3, m_BareResource=False,
        m_Texture={"m_SerializedTexture": "", "m_Guid": ""}, m_DefaultType=textype)
    add(tag + "_uv", "UnityEditor.ShaderGraph.UVMaterialSlot", m_Id=2, m_DisplayName="UV",
        m_SlotType=0, m_Hidden=False, m_ShaderOutputName="UV", m_StageCapability=3,
        m_Value={"x": 0.0, "y": 0.0}, m_DefaultValue={"x": 0.0, "y": 0.0}, m_Labels=[],
        m_Channel=0)
    add(tag + "_smp", "UnityEditor.ShaderGraph.SamplerStateMaterialSlot", m_Id=3,
        m_DisplayName="Sampler", m_SlotType=0, m_Hidden=False, m_ShaderOutputName="Sampler",
        m_StageCapability=3, m_BareResource=False)
    return node(tag, "UnityEditor.ShaderGraph.SampleTexture2DNode", "Sample Texture 2D",
                [tag + "_rgba"] + [tag + "_%d" % s for s in (4, 5, 6, 7)]
                + [tag + "_tex", tag + "_uv", tag + "_smp"], x, y,
                m_TextureType=(1 if textype == 3 else 0),
                m_NormalMapSpace=0, m_EnableGlobalMipBias=True, m_MipSamplingMode=0)

sampler("n_sbase", -600, 300, 0)
sampler("n_snorm", -600, 500, 3)
edge("n_basemap", 0, "n_sbase", 1)
edge("n_bumpmap", 0, "n_snorm", 1)

# ================= Block(输出) =================
VERT = [("VertexDescription.Position", "PositionMaterialSlot", "Position", dict(
            m_Value={"x": 0.0, "y": 0.0, "z": 0.0},
            m_DefaultValue={"x": 0.0, "y": 0.0, "z": 0.0}, m_Labels=[], m_Space=0), 1),
        ("VertexDescription.Normal", "NormalMaterialSlot", "Normal", dict(
            m_Value={"x": 0.0, "y": 0.0, "z": 0.0},
            m_DefaultValue={"x": 0.0, "y": 0.0, "z": 0.0}, m_Labels=[], m_Space=0), 1),
        ("VertexDescription.Tangent", "TangentMaterialSlot", "Tangent", dict(
            m_Value={"x": 0.0, "y": 0.0, "z": 0.0},
            m_DefaultValue={"x": 0.0, "y": 0.0, "z": 0.0}, m_Labels=[], m_Space=0), 1)]
FRAG = [("SurfaceDescription.BaseColor", "ColorRGBMaterialSlot", "Base Color", dict(
            m_Value={"x": 0.5, "y": 0.5, "z": 0.5},
            m_DefaultValue={"x": 0.5, "y": 0.5, "z": 0.5}, m_Labels=[], m_ColorMode=0,
            m_DefaultColor={"r": 0.5, "g": 0.5, "b": 0.5, "a": 1.0}), 2),
        ("SurfaceDescription.NormalTS", "NormalMaterialSlot", "Normal (Tangent Space)", dict(
            m_Value={"x": 0.0, "y": 0.0, "z": 0.0},
            m_DefaultValue={"x": 0.0, "y": 0.0, "z": 0.0}, m_Labels=[], m_Space=3), 2),
        ("SurfaceDescription.Metallic", "Vector1MaterialSlot", "Metallic", dict(
            m_Value=0.0, m_DefaultValue=0.0, m_Labels=[]), 2),
        ("SurfaceDescription.Smoothness", "Vector1MaterialSlot", "Smoothness", dict(
            m_Value=0.5, m_DefaultValue=0.5, m_Labels=[]), 2),
        ("SurfaceDescription.Emission", "ColorRGBMaterialSlot", "Emission", dict(
            m_Value={"x": 0.0, "y": 0.0, "z": 0.0},
            m_DefaultValue={"x": 0.0, "y": 0.0, "z": 0.0}, m_Labels=[], m_ColorMode=1,
            m_DefaultColor={"r": 0.0, "g": 0.0, "b": 0.0, "a": 1.0}), 2),
        ("SurfaceDescription.Occlusion", "Vector1MaterialSlot", "Ambient Occlusion", dict(
            m_Value=1.0, m_DefaultValue=1.0, m_Labels=[]), 2)]

def block(desc, slottype, disp, extra, stage):
    st = "b_" + desc + "_slot"
    out = desc.split(".")[-1]
    add(st, "UnityEditor.ShaderGraph." + slottype, m_Id=0, m_DisplayName=disp,
        m_SlotType=0, m_Hidden=False, m_ShaderOutputName=out, m_StageCapability=stage, **extra)
    tag = "b_" + desc
    add(tag, "UnityEditor.ShaderGraph.BlockNode", m_Name=desc,
        m_DrawState=drawstate(0.0, 0.0, 0.0, 0.0), m_Slots=[ref(st)],
        m_SerializedDescriptor=desc, **NODE_COMMON)
    NODES.append(tag)
    return tag

vblocks = [block(*b) for b in VERT]
fblocks = [block(*b) for b in FRAG]

edge("n_cf", 10, "b_VertexDescription.Position", 0)
edge("n_sbase", 0, "b_SurfaceDescription.BaseColor", 0)
edge("n_snorm", 0, "b_SurfaceDescription.NormalTS", 0)
edge("n_smooth", 0, "b_SurfaceDescription.Smoothness", 0)

# ================= Target =================
add("subtarget", "UnityEditor.Rendering.Universal.ShaderGraph.UniversalLitSubTarget", ver=2,
    m_WorkflowMode=1, m_NormalDropOffSpace=0, m_ClearCoat=False,
    m_BlendModePreserveSpecular=True)
add("target", "UnityEditor.Rendering.Universal.ShaderGraph.UniversalTarget", ver=1,
    m_Datas=[], m_ActiveSubTarget=ref("subtarget"), m_AllowMaterialOverride=False,
    m_SurfaceType=0, m_ZTestMode=4, m_ZWriteControl=0, m_AlphaMode=0, m_RenderFace=2,
    m_AlphaClip=False, m_CastShadows=True, m_ReceiveShadows=True, m_DisableTint=False,
    m_AdditionalMotionVectorMode=0, m_AlembicMotionVectors=False,
    m_SupportsLODCrossFade=False, m_CustomEditorGUI="", m_SupportVFX=False)

add("category", "UnityEditor.ShaderGraph.CategoryData", m_Name="",
    m_ChildObjectList=[ref(p) for p in PROPS])

graph = {"m_SGVersion": 3, "m_Type": "UnityEditor.ShaderGraph.GraphData",
         "m_ObjectId": oid("graph"),
         "m_Properties": [ref(p) for p in PROPS], "m_Keywords": [], "m_Dropdowns": [],
         "m_CategoryData": [ref("category")],
         "m_Nodes": [ref(n) for n in NODES], "m_GroupDatas": [], "m_StickyNoteDatas": [],
         "m_Edges": EDGES,
         "m_VertexContext": {"m_Position": {"x": 0.0, "y": -300.0},
                             "m_Blocks": [ref(b) for b in vblocks]},
         "m_FragmentContext": {"m_Position": {"x": 0.0, "y": 200.0},
                               "m_Blocks": [ref(b) for b in fblocks]},
         "m_PreviewData": {"serializedMesh": {"m_SerializedMesh": "{\"mesh\":{\"instanceID\":0}}",
                                              "m_Guid": ""}, "preventRotation": False},
         "m_Path": "Shader Graphs", "m_GraphPrecision": 1, "m_PreviewMode": 2,
         "m_OutputNode": {"m_Id": ""}, "m_SubDatas": [],
         "m_ActiveTargets": [ref("target")]}

out = [json.dumps(graph, indent=4)] + [json.dumps(o, indent=4) for o in objs]
open(OUT, "w").write("\n\n".join(out) + "\n")
ids = [o["m_ObjectId"] for o in objs] + [graph["m_ObjectId"]]
assert len(ids) == len(set(ids)), "m_ObjectId 撞了"
print("### 写出 %s: %d 个对象, %d 个节点, %d 条连线, %d 个属性 ###"
      % (OUT, len(objs) + 1, len(NODES), len(EDGES), len(PROPS)))
