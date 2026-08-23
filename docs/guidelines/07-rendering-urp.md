# 07. Rendering and URP conventions

> **Scope:** How this project configures and uses the Universal Render Pipeline (URP 17.3) in Unity 6.3: pipeline assets and quality tiers, the Forward+ rendering path, Render Graph custom passes, lighting (APV, lightmaps, shadows, probes), post-processing Volumes, cameras and Cinemachine, materials and Shader Graph, anti-aliasing/HDR/colour space, rendering-relevant texture import settings, and what to check when something renders pink or black.
> **Applies to:** every URP asset, renderer, Volume profile, lighting setting, material, shader, Shader Graph and camera under `Assets/SheNicest/`, and any C# under `Assets/SheNicest/Scripts/Runtime/Rendering` (folder and namespace `SheNicest.Rendering` are created only with the first custom render pass, per [02](./02-project-structure.md)). Generic profiling and CPU/GPU budgets are owned by [05 Performance](./05-performance.md); Unity 6.3 facts and deprecations by [10 Unity 6.3 facts](./10-unity6-facts.md).
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

## TL;DR — rules at a glance

1. **MUST** render with URP 17.3 with **Rendering Path = Forward+** on the renderer of the desktop tier (and on any other renderer that stays in use). Verify in the text-serialized renderer `.asset`: `m_RenderingMode: 2` (`ForwardPlus`); set it in the Inspector if the template shipped `0` (Forward).
2. **MUST** keep exactly the quality levels, URP assets and renderers the Universal 3D template created (expected for Unity 6: levels `PC` and `Mobile`, `PC_RPAsset`/`Mobile_RPAsset`, `PC_Renderer`/`Mobile_Renderer`, moved into `Assets/SheNicest/Settings/`). On day one the rendering owner opens the project, records the actual level names, asset names, renderer names and per-platform defaults in §1, and nobody adds, renames or reorders them.
3. **MUST** write every custom pass with the **Render Graph** API (`ScriptableRenderPass.RecordRenderGraph` + `ScriptableRendererFeature.AddRenderPasses`). URP Compatibility Mode is removed in 6.3. **NEVER** call `CommandBuffer.Blit`, `Graphics.Blit` or `RenderingUtils.Blit` — use `AddBlitPass` / `AddCopyPass` / `Blitter`.
4. **MUST** keep **Color Space = Linear** (Player settings). Never switch to Gamma.
5. **MUST** light each level from its `<Level>_Environment.unity` (or `_Lighting`) scene — never from a `_Gameplay` part — with one **Mixed** Directional main light, **Baked Global Illumination** on, Lighting Mode **Baked Indirect**, and **Adaptive Probe Volumes** as the Light Probe System. Lightmaps are opt-in for large static surfaces only.
6. **MUST** apply post-processing only through **Volume** components and Volume Profile assets named `<Context>Profile` in `Assets/SheNicest/Settings/VolumeProfiles/`; one global Volume per level, in its `_Environment` (or `_Lighting`) scene; post-processing enabled only on the Base Camera (the last camera of a stack).
7. **MUST** keep the `MainCamera` from [09](./09-packages-systems.md) as the only Base Camera (Post Processing on, Anti-aliasing None, Dithering on); Overlay cameras and stacking only for the §7 cases.
8. **MUST** use URP shaders only: **Lit** by default, **Unlit** for unlit effects, **Shader Graph (URP targets)** for anything custom. Built-in/Standard and HDRP shaders render pink.
9. **MUST** keep materials SRP-Batcher compatible: no `MaterialPropertyBlock`, **Material Variants** for colour/texture variations, and unused Lit features switched off (details in [05](./05-performance.md)).
10. **SHOULD** use anti-aliasing = **MSAA from the URP asset** (2x on the desktop tier, off on the low tier) with the camera's post-process Anti-aliasing set to **None**; **NEVER** TAA or STP (incompatible with MSAA and camera stacking).
11. **SHOULD** import textures so that only colour textures are **sRGB** and normal maps use Texture Type **Normal map** (size, Read/Write and mipmap rules in [05](./05-performance.md)).
12. **SHOULD** stay inside the per-scene render budgets in §11 (lights, shadow casters, cameras, renderer features, post effects).
13. **NEVER** change URP assets, the renderer, Quality or Graphics settings in a feature commit — settings changes are their own commit, announced in the team channel, and made only by the rendering owner.
14. **NEVER** enable the GPU Resident Drawer, GPU occlusion culling, Depth Priming, Depth/Opaque Texture, SSAO or the Decal feature "just in case" — each adds passes, variants or build time; enable only with a measured reason (see [05](./05-performance.md)).
15. **NEVER** embed the URP Config package to change `MAX_VISIBLE_LIGHT_COUNT`, and never create Volume Profiles at runtime (with **Strip Unused Post Processing Variants** on in Graphics > URP, the build strips the variants they would need).

## 1. Pipeline assets and where they live

**MUST** keep whatever quality levels, URP assets and Universal Renderers the Universal 3D template generated, with their template names, and move them, in the Editor, from the template's `Assets/Settings` into `Assets/SheNicest/Settings/` (see [02 Project structure](./02-project-structure.md) for the move and the `.meta` rule). Rules in this document are phrased per tier **role**: the **desktop tier** (the URP asset Standalone uses) and the **low tier** (the URP asset Web would use). Do not assume the `UniversalRP-Low/Medium/HighQuality` names some older material shows.
- *Why:* "When you create a project using the URP template, Unity creates the URP assets in the Settings project folder and assigns them in Project Settings." For Unity 6 the manual and e-book name them `PC_RPAsset` / `Mobile_RPAsset` with `PC_Renderer` (renderers under `Assets > Settings > Renderers`); the `UniversalRP-*` / `UniversalRenderer` names come from the legacy GitHub template. Keeping the shipped names keeps Unity's docs, [02](./02-project-structure.md) and this document in agreement.
- *Source:* [manual-urp-asset-and-renderer](../reference/rendering-urp/manual-urp-asset-and-renderer.md), [manual-how-to-custom-effect-render-objects](../reference/rendering-urp/manual-how-to-custom-effect-render-objects.md) ("select the URP Renderer asset your project uses, for example **Settings** > **PC_Renderer**"), [manual-post-processing-custom-effect-low-code](../reference/rendering-urp/manual-post-processing-custom-effect-low-code.md) (Universal Renderers in **Assets > Settings > Renderers**), [URP e-book (Unity 6)](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.15 ("PC_RPAsset is the default URP Asset selected on a desktop, but you can switch to Mobile_RPAsset"); legacy GitHub template assets (indicative values only; names differ in the 6000.3 Hub template) [UniversalRP-HighQuality](../reference/rendering-urp/github-graphics-universalrp-highquality-asset.md), [-MediumQuality](../reference/rendering-urp/github-graphics-universalrp-mediumquality-asset.md), [-LowQuality](../reference/rendering-urp/github-graphics-universalrp-lowquality-asset.md), [UniversalRenderer](../reference/rendering-urp/github-graphics-universalrenderer-asset.md).

**MUST** use this layout inside `Assets/SheNicest/Settings/` (file names as verified on day one) **[project decision]**:

```text
Assets/SheNicest/Settings/                 # moved in-Editor from the template's Assets/Settings/ (02)
  PC_RPAsset.asset                         # desktop tier URP asset  (verify name on day one)
  Mobile_RPAsset.asset                     # low tier URP asset      (verify name on day one)
  PC_Renderer.asset                        # desktop-tier Universal Renderer → Forward+ (may sit in Renderers/)
  Mobile_Renderer.asset                    # low-tier Universal Renderer (may sit in Renderers/)
  UniversalRenderPipelineGlobalSettings.asset
  DefaultVolumeProfile.asset, SampleSceneProfile.asset   # template profiles keep their names (02)
  VolumeProfiles/<Context>Profile.asset    # new profiles, e.g. ForestProfile, MainMenuProfile (02)
  Lighting/SheNicest.lighting              # shared Lighting Settings Asset (§5.2)
```

**MUST** fill in the day-one record below the first time the project is opened in 6000.3.22f1 (rendering owner, same commit as the settings move) and keep it current; it — not the expected names above — is what reviewers check. **[project decision]**

Day-one record (rendering owner fills in):
- Quality levels (Project Settings > Quality, in row order): `…`
- URP assets (`t:universalrenderpipelineasset`): `…`
- Renderer assets and their folder: `…`
- Standalone default level: `…` · Web default level: `…`
- Rendering Path after setup: desktop-tier renderer `m_RenderingMode: 2`; low-tier renderer `m_RenderingMode: …`

**MUST** assign the desktop-tier asset as **Edit > Project Settings > Graphics > Default Render Pipeline** and give **every** quality level an explicit **Render Pipeline Asset** override in **Edit > Project Settings > Quality** (the template does both; verify rather than redo).
- *Why:* Unity uses the per-quality-level asset when set and falls back to the Graphics default otherwise; a level without an override silently renders with the wrong tier. "If both aren't set, Unity uses the Built-In Render Pipeline."
- *Source:* [manual-srp-setting-render-pipeline-asset](../reference/rendering-urp/manual-srp-setting-render-pipeline-asset.md), [manual-installurpintoaproject](../reference/rendering-urp/manual-installurpintoaproject.md) (`t:universalrenderpipelineasset` finds all URP assets).

**NEVER** rename a renderer asset to the name of any Renderer Feature it owns.
- *Why:* Known URP issue — the renderer and the feature swap places and the renderer misbehaves.
- *Source:* [manual-known-issues](../reference/rendering-urp/manual-known-issues.md).

**NEVER** install the Post Processing Stack v2 package or HDRP; URP is not compatible with either.
- *Source:* [manual-integration-with-post-processing](../reference/rendering-urp/manual-integration-with-post-processing.md), [manual-requirements](../reference/rendering-urp/manual-requirements.md).

## 2. Rendering path and renderer settings

**MUST** set **Rendering Path = Forward+** on the desktop-tier renderer asset, and on every other renderer that stays in use (Project Settings > Graphics or Quality > double-click the Render Pipeline Asset > double-click the renderer in **Renderer List** > **Rendering Path**), then confirm each text-serialized renderer asset contains `m_RenderingMode: 2`.
- *Why:* Forward+ removes the per-object light limit (Forward: 1 main + 8 additional per object), blends more than 2 reflection probes and is required by the GPU Resident Drawer. The legacy template renderer serializes `m_RenderingMode: 0`, which is `RenderingMode.Forward` (`Forward = 0, Deferred = 1, ForwardPlus = 2, DeferredPlus = 3` in the URP 17.3 source), so check the value instead of trusting the template. Deferred/Deferred+ disable MSAA and have shadowmask caveats; we do not use them. **[project decision]**
- *Source:* [manual-rendering-paths-set](../reference/rendering-urp/manual-rendering-paths-set.md), [manual-rendering-paths-comparison](../reference/rendering-urp/manual-rendering-paths-comparison.md), [manual-forward-rendering-paths](../reference/rendering-urp/manual-forward-rendering-paths.md), [manual-light-limits-in-urp](../reference/rendering-urp/manual-light-limits-in-urp.md), legacy template [UniversalRenderer](../reference/rendering-urp/github-graphics-universalrenderer-asset.md); enum values verified against `UniversalRenderer.cs` on the `6000.3/staging` branch of the Unity Graphics repository.

**MUST** leave these renderer settings at the template values unless §11 budgets are blown and the Profiler proves the change helps:

| Renderer / URP asset setting | Value | Why |
|:--|:--|:--|
| Depth Priming Mode | **Disabled** | Unity recommends Auto/Forced on PC, but priming is unsupported with MSAA, which the desktop tier uses; stays Disabled while MSAA is on. Custom shaders without `DepthOnly`/`DepthNormals` passes render invisible when priming is on. **[project decision]** |
| Depth Texture, Opaque Texture | **Off** in the URP asset | Each adds a copy pass and memory; enable per camera (**Depth Texture / Opaque Texture = On**) only for the camera whose shader samples scene depth/colour. |
| Native RenderPass | template value | Unity recommends it on Vulkan/Metal/DX12 (macOS Metal is a target); we keep the template value until a Frame Debugger/Profiler capture shows a bandwidth cost — revisit. **[project decision]** |
| SRP Batcher | **On** (all tiers) | Cuts CPU time for materials sharing a shader variant. |
| Dynamic Batching | **Off** | Target hardware supports instancing; SRP Batcher takes precedence anyway. |
| GPU Resident Drawer / GPU Occlusion Culling | **Disabled** | Longer builds (all BRG variants compiled), needs compute shaders (no OpenGL ES; compute-shader platforms only), and pays off only in large scenes with many identical meshes. **[project decision]** |
| Store Actions | Auto | Default; discards unused targets. |
| Transparent Receive Shadows | On (template) | Keep. |

- *Source:* [manual-urp-universal-renderer](../reference/rendering-urp/manual-urp-universal-renderer.md), [manual-configure-for-better-performance](../reference/rendering-urp/manual-configure-for-better-performance.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md), [manual-gpu-resident-drawer](../reference/rendering-urp/manual-gpu-resident-drawer.md), [manual-gpu-culling](../reference/rendering-urp/manual-gpu-culling.md), [manual-srpbatcher](../reference/rendering-urp/manual-srpbatcher.md), [manual-optimizing-draw-calls-choose-method](../reference/performance/manual-optimizing-draw-calls-choose-method.md).

**MAY** enable the GPU Resident Drawer on the desktop tier later if the Frame Debugger shows thousands of SetPass calls from repeated meshes: Project Settings > Graphics > Shader Stripping > **BatchRendererGroup Variants = Keep All**, URP asset **SRP Batcher** on, **GPU Resident Drawer = Instanced Drawing**, renderer on Forward+. Objects using `MaterialPropertyBlock`, `OnRenderObject` or Light Probe Proxy Volumes are excluded automatically.
- *Source:* [manual-gpu-resident-drawer](../reference/rendering-urp/manual-gpu-resident-drawer.md), [manual-make-object-compatible-gpu-rendering](../reference/rendering-urp/manual-make-object-compatible-gpu-rendering.md).

**NEVER** embed `com.unity.render-pipelines.universal-config` to lower `MAX_VISIBLE_LIGHT_COUNT`.
- *Why:* It embeds package source that must be re-applied on every Editor upgrade; the known long-build-time issue of Forward+ (desktop per-camera limit 256) is acceptable for a hackathon project with few lights.
- *Source:* [manual-forward-plus-rendering-path-limitations](../reference/rendering-urp/manual-forward-plus-rendering-path-limitations.md), [manual-known-issues](../reference/rendering-urp/manual-known-issues.md).

## 3. Quality tiers

**MUST** keep the template's quality levels and their URP asset values as the baseline. Values to record from the actual assets on day one; the numbers below are from the legacy GitHub template and are indicative only:

| Setting (URP asset) | low tier (`Mobile_RPAsset`) | desktop tier (`PC_RPAsset`) |
|:--|:--|:--|
| HDR | Off | **On** (32-bit precision) |
| Anti Aliasing (MSAA) | Disabled | **2x** |
| Render Scale | 1.0 | 1.0 |
| Main Light shadows | Off | On, 2048 |
| Additional Lights (mode is ignored under Forward+: always per pixel) | Disabled, no shadows | Per Pixel, Cast Shadows may stay on (atlas 2048) — budget in §11 |
| Shadow Max Distance | 50 m | 50 m |
| Cascade Count | 1 | 2 |
| Soft Shadows | Off | On |
| Reflection Probe Blending | Off | On (always on under Forward+) |
| Grading Mode / LUT size | LDR / 16 | LDR / 32 |
| SRP Batcher / Dynamic Batching | On / Off | On / Off |

Quality level defaults: **Standalone → desktop tier**, **Web → low tier** (record the actual level names and indices in the §1 day-one record).
- *Why:* These are the values the template ships; they already follow Unity's "adjust settings to improve performance" table (additional-light shadows and soft shadows only at the top tier, LDR grading, low LUT on the low tier). Under Forward+ the **Main Light** and **Additional Lights** mode fields and **Per Object Limit** are ignored (every light renders per pixel), so the low tier's "Disabled" has no effect — the light budget in §11 is the real limiter; only the **Cast Shadows** sub-settings differ in practice.
- *Source:* legacy template [QualitySettings.asset](../reference/rendering-urp/github-graphics-qualitysettings-asset.md) and the legacy URP assets in §1 (indicative values); [manual-optimize-for-better-performance](../reference/rendering-urp/manual-optimize-for-better-performance.md); [manual-forward-rendering-paths](../reference/rendering-urp/manual-forward-rendering-paths.md); [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md).

**MUST** switch quality only from menus or loading screens, via `QualitySettings.SetQualityLevel`; read the active asset with `GraphicsSettings.currentRenderPipeline as UniversalRenderPipelineAsset`.
- *Why:* Changing the quality level or URP asset "causes a temporary but significant performance impact". Quality index = position in the Quality list, counting only levels enabled for the platform.
- *Source:* [manual-quality-settings-through-code](../reference/rendering-urp/manual-quality-settings-through-code.md), [manual-change-urp-asset-settings](../reference/rendering-urp/manual-change-urp-asset-settings.md), [manual-srp-setting-render-pipeline-asset](../reference/rendering-urp/manual-srp-setting-render-pipeline-asset.md); `UniversalRenderPipelineAsset.supportsHDR` / `renderScale` / `shadowDistance` / `msaaSampleCount` are `get; set;` properties in the URP 17.3 scripting API.

Lives in `Scripts/Runtime/UI/` (options menu); `UniversalRenderPipelineAsset` needs the `Unity.RenderPipelines.Universal.Runtime` asmdef reference from §4.

```csharp
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace SheNicest.UI
{
    /// <summary>Row index in Project Settings > Quality (only levels enabled for the platform count). Own file per 01.</summary>
    public enum QualityTier
    {
        // values = row index in Project Settings > Quality — verify on day one (§1 record)
        Mobile = 0,
        PC = 1
    }

    /// <summary>Quality switching for the options menu.</summary>
    public class QualityMenu : MonoBehaviour
    {
        public void ApplyTier(QualityTier tier)
        {
            // Only call from a menu or loading screen: switching the URP asset is expensive.
            QualitySettings.SetQualityLevel((int)tier, true);
        }

        public bool IsHdrActive()
        {
            UniversalRenderPipelineAsset urpAsset = GraphicsSettings.currentRenderPipeline as UniversalRenderPipelineAsset;
            return urpAsset != null && urpAsset.supportsHDR;
        }
    }
}
```

## 4. Custom rendering: Render Graph only

**MUST** reach for the no-code options first, in this order: a **Volume Override** (post effect), the **Render Objects** Renderer Feature (draw a layer at another event with material/stencil overrides), the **Full Screen Pass** Renderer Feature with a **Fullscreen Shader Graph** (custom post effect). Write C# only when these cannot express the effect.
- *Why:* Renderer Features are added on the renderer asset and need no pipeline code; the low-code post effect is Shader Graph (`Create > Shader Graph > URP > Fullscreen Shader Graph`, **URP Sample Buffer** node with **Blit Source**) + Full Screen Pass feature with **Injection Point = After Rendering Post Processing**, **Requirements = Color**.
- *Source:* [manual-urp-renderer-feature](../reference/rendering-urp/manual-urp-renderer-feature.md), [manual-post-processing-custom-effect-low-code](../reference/rendering-urp/manual-post-processing-custom-effect-low-code.md), [manual-custom-post-processing](../reference/rendering-urp/manual-custom-post-processing.md).

**MUST** implement any C# pass as a `ScriptableRenderPass` overriding `RecordRenderGraph(RenderGraph, ContextContainer)` and inject it from a `ScriptableRendererFeature` (`Create` runs on first load, on enable/disable and on Inspector changes — build the pass and materials there; `AddRenderPasses` runs every frame per camera and must only enqueue, never allocate).
- *Why:* Render Graph is the only execution model in 6.3: Compatibility Mode is removed, `RenderGraphSettings.enableRenderCompatibilityMode` is read-only `false`, and the `URP_COMPATIBILITY_MODE` define exists only to migrate and dies in 6.4.
- *Source:* [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [manual-render-graph-write-render-pass](../reference/rendering-urp/manual-render-graph-write-render-pass.md), [manual-inject-a-pass-using-a-scriptable-renderer-feature](../reference/rendering-urp/manual-inject-a-pass-using-a-scriptable-renderer-feature.md), [manual-custom-rendering-pass-workflow-in-urp](../reference/rendering-urp/manual-custom-rendering-pass-workflow-in-urp.md).

Render Graph rules (all **MUST**):
- Declare inputs/outputs with the `builder` in `RecordRenderGraph`; put GPU commands only in the static render function passed to `SetRenderFunc`. Prefer `AddRasterRenderPass`; use `AddUnsafePass` only when a `CommandBuffer` API such as `SetRenderTarget` is unavoidable (it blocks pass merging). *Source:* [manual-render-graph-write-render-pass](../reference/rendering-urp/manual-render-graph-write-render-pass.md), [manual-render-graph-optimize](../reference/rendering-urp/manual-render-graph-optimize.md).
- Blit with `RenderGraphUtils.AddBlitPass` / `AddCopyPass` (`using UnityEngine.Rendering.RenderGraphModule.Util`) or the SRP Core `Blitter` (hand-written shader only — Shader Graph shaders are not `Blitter`-compatible). **NEVER** `CommandBuffer.Blit`, `Graphics.Blit`, `RenderingUtils.Blit`. *Source:* [manual-blit-overview](../reference/rendering-urp/manual-blit-overview.md), [manual-render-graph-blit](../reference/rendering-urp/manual-render-graph-blit.md).
- Reading the camera colour requires `requiresIntermediateTexture = true` on the pass (the back buffer cannot be an input); after a full-screen blit, set `resourceData.cameraColor = destination` instead of blitting back. *Source:* [BlitAndSwapColorRendererFeature.cs](../reference/rendering-urp/github-graphics-blitandswapcolorrendererfeature-cs.md), [CopyRenderFeature.cs](../reference/rendering-urp/github-graphics-copyrenderfeature-cs.md).
- Need scene depth/colour? Call `ConfigureInput` so URP produces `cameraDepthTexture` / `cameraOpaqueTexture` instead of copying them yourself. *Source:* [manual-render-graph-optimize](../reference/rendering-urp/manual-render-graph-optimize.md).
- A pass whose output nothing reads is removed by the graph, and resources are allocated only between their first write and last read — so write the result into `resourceData.cameraColor` or a texture a later pass consumes, and never keep internal `TextureHandle`s across frames. *Source:* [manual-render-graph-introduction](../reference/rendering-urp/manual-render-graph-introduction.md), [CopyRenderFeature.cs](../reference/rendering-urp/github-graphics-copyrenderfeature-cs.md).
- Pick the injection point from the reference table (`RenderPassEvent.AfterRenderingOpaques`, `AfterRenderingPostProcessing`, …); camera matrices are not set up before `BeforeRenderingPrePasses`. *Source:* [manual-custom-pass-injection-points](../reference/rendering-urp/manual-custom-pass-injection-points.md).
- Verify with **Window > Analysis > Render Graph Viewer** (pass merging, resource lifetimes) and the Frame Debugger. *Source:* [manual-render-graph-view](../reference/rendering-urp/manual-render-graph-view.md).
- Create `Scripts/Runtime/Rendering/` (namespace `SheNicest.Rendering`) together with the first pass, and in the same commit add `"Unity.RenderPipelines.Universal.Runtime"` and `"Unity.RenderPipelines.Core.Runtime"` to the `references` array of `SheNicest.Runtime.asmdef` shown in [02 §8](./02-project-structure.md) (names verified in the URP 17.3 package). **[project decision]**

Minimal full-screen material pass, in project style:

```csharp
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.RenderGraphModule;
using UnityEngine.Rendering.RenderGraphModule.Util;
using UnityEngine.Rendering.Universal;

namespace SheNicest.Rendering
{
    /// <summary>Runs a full-screen material over the camera colour. Add it to the desktop-tier renderer asset.</summary>
    public class FullScreenMaterialFeature : ScriptableRendererFeature
    {
        [SerializeField] private Material m_material;
        [SerializeField] private RenderPassEvent m_renderPassEvent = RenderPassEvent.AfterRenderingPostProcessing;

        private FullScreenMaterialPass m_pass;

        public override void Create()
        {
            m_pass = new FullScreenMaterialPass();
            m_pass.renderPassEvent = m_renderPassEvent;
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            if (m_material == null)
            {
                return; // called every frame per camera: no allocation, no logging spam
            }

            m_pass.Setup(m_material);
            renderer.EnqueuePass(m_pass);
        }

        private class FullScreenMaterialPass : ScriptableRenderPass
        {
            private const string k_PassName = "SheNicest FullScreenMaterial";

            private Material m_material;

            public void Setup(Material material)
            {
                m_material = material;
                requiresIntermediateTexture = true; // the back buffer cannot be read as an input
            }

            public override void RecordRenderGraph(RenderGraph renderGraph, ContextContainer frameData)
            {
                UniversalResourceData resourceData = frameData.Get<UniversalResourceData>();
                if (resourceData.isActiveTargetBackBuffer)
                {
                    return; // e.g. injected at AfterRendering, where only the back buffer exists
                }

                TextureHandle source = resourceData.activeColorTexture;
                TextureDesc destinationDesc = renderGraph.GetTextureDesc(source);
                destinationDesc.name = "SheNicest_FullScreenMaterial";
                destinationDesc.clearBuffer = false;
                TextureHandle destination = renderGraph.CreateTexture(destinationDesc);

                var blitParameters = new RenderGraphUtils.BlitMaterialParameters(source, destination, m_material, 0);
                renderGraph.AddBlitPass(blitParameters, passName: k_PassName);

                resourceData.cameraColor = destination; // later passes read the result; no blit back
            }
        }
    }
}
```

## 5. Lighting workflow

### 5.1 Colour space and environment

**MUST** keep **Edit > Project Settings > Player > Other Settings > Rendering > Color Space = Linear** (the template sets it).
- *Why:* Linear is required for correct lighting; textures authored in sRGB are converted by the sRGB sampler. URP supports Linear on all our targets.
- *Source:* [manual-linearrendering-linearorgammaworkflow](../reference/rendering-urp/manual-linearrendering-linearorgammaworkflow.md), [URP e-book (Unity 6)](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.14, [manual-render-pipelines-feature-comparison](../reference/rendering-urp/manual-render-pipelines-feature-comparison.md) (Color space).

**MUST** set skybox, ambient light and fog in **Window > Rendering > Lighting > Environment** per level, in `<Level>_Environment.unity` (or `<Level>_Lighting.unity` when split out; `MainMenu.unity` for the menu) — never in a `_Gameplay` part (see [11](./11-scenes-prefabs-workflow.md)): **Skybox Material**, **Environment Lighting > Source = Skybox** (or Gradient/Color for stylised looks), **Other Settings > Fog** (Linear / Exponential / Exponential Squared — URP has no volumetric fog). Re-run **Generate Lighting** after changing the skybox.
- *Why:* Skybox-sourced ambient light and the default reflection probe only update when lighting is generated; Gradient and Color update live. These settings are per scene and, with additive loading, Unity uses the **active** scene's rendering settings — so the level's environment/lighting part must be the active scene (see [11 Scenes](./11-scenes-prefabs-workflow.md)).
- *Source:* [manual-lighting-ambient-light](../reference/rendering-urp/manual-lighting-ambient-light.md), [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.41, [manual-reflectionprobes](../reference/rendering-urp/manual-reflectionprobes.md), [manual-render-pipelines-feature-comparison](../reference/rendering-urp/manual-render-pipelines-feature-comparison.md) (Volumetrics), [manual-setupmultiplescenes](../reference/project-structure/manual-setupmultiplescenes.md); fog location confirmed on the 6000.3 Lighting-window manual page.

### 5.2 Light modes and Lighting Mode

**MUST** use one Directional light per level — in `<Level>_Environment.unity` (or `<Level>_Lighting.unity` when split out; `MainMenu.unity` for the menu), never in a `_Gameplay` part (see [11](./11-scenes-prefabs-workflow.md)) — as the main light, **Mode = Mixed**, assigned as **Sun Source** in the Lighting window; static decoration lights **Baked**; only lights that move, flicker or are spawned at runtime **Realtime**.
- *Why:* Mixed gives real-time direct light + shadows on dynamic objects with baked indirect; Baked lights cost nothing at runtime but "dynamic GameObjects do not receive light or shadow from Baked Lights"; Realtime lights have no bounce, so their shadows are fully black. Without a Sun Source, URP picks the brightest directional light.
- *Source:* [manual-lightmodes-choose](../reference/rendering-urp/manual-lightmodes-choose.md), [manual-lightmodes-introduction](../reference/rendering-urp/manual-lightmodes-introduction.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md) (Main Light).

**MUST** enable **Baked Global Illumination** (Lighting > Scene > Mixed Lighting) with **Lighting Mode = Baked Indirect** in the shared Lighting Settings Asset. **[project decision]**
- *Why:* If Baked GI is off, every Baked/Mixed light silently behaves as Realtime. Baked Indirect keeps all shadows real-time, so a stale bake only shows as slightly wrong bounce light instead of wrong shadows — the forgiving choice while levels change daily. Switch to **Shadowmask** (max 4 overlapping mixed lights per texel) only if real-time shadow cost becomes the measured bottleneck. **NEVER** enable Enlighten Realtime Global Illumination next to baked GI: Unity calls running both "rarely recommended".
- *Source:* [manual-lightmodes-introduction](../reference/rendering-urp/manual-lightmodes-introduction.md), [manual-lighting-mode](../reference/rendering-urp/manual-lighting-mode.md), [manual-shadows-optimization](../reference/rendering-urp/manual-shadows-optimization.md), [manual-lighting-configuration-workflow](../reference/rendering-urp/manual-lighting-configuration-workflow.md), [manual-choose-a-lighting-setup](../reference/rendering-urp/manual-choose-a-lighting-setup.md).

**MUST** assign the single shared `Settings/Lighting/SheNicest.lighting` Lighting Settings Asset to every `_Environment` / `_Lighting` scene and `MainMenu.unity` (Lighting > Scene > Lighting Settings) and bake with the **Progressive GPU** lightmapper. **[project decision]**
- *Why:* One asset shares bake settings across scenes; the GPU lightmapper is "much faster" in most configurations. Close other GPU-heavy apps and lower samples + use the Denoiser when bakes are slow.
- *Source:* [manual-global-illumination-configure](../reference/rendering-urp/manual-global-illumination-configure.md), [manual-gpuprogressivelightmapper](../reference/rendering-urp/manual-gpuprogressivelightmapper.md).

**MUST** treat baking as the scene owner's job: bake before handing the scene over, never bake a scene you do not own (see [11](./11-scenes-prefabs-workflow.md) for ownership and [06](./06-version-control.md) for what is committed).

### 5.3 Probe lighting: Adaptive Probe Volumes

**MUST** set **Light Probe System = Adaptive Probe Volumes** in every URP asset in use (Lighting > Light Probe Lighting) and give every level one APV in its `<Level>_Environment.unity` (or `<Level>_Lighting.unity` when split out; `MainMenu.unity` for the menu) — never in a `_Gameplay` part (see [11](./11-scenes-prefabs-workflow.md)): **GameObject > Light > Adaptive Probe Volume**, **Mode = Global**. Keep Memory Budget / SH Bands / Streaming at their defaults.
- *Why:* APV places probes automatically (bricks of 64 probes, spacing 1/3/9/27 m) and lights per pixel, which removes manual Light Probe Groups and seams; it is the Unity 6 probe system. Streaming matters only for open worlds.
- *Source:* [manual-probevolumes-use](../reference/rendering-urp/manual-probevolumes-use.md), [manual-probevolumes-concept](../reference/rendering-urp/manual-probevolumes-concept.md), [manual-probevolumes](../reference/rendering-urp/manual-probevolumes.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md).

**MUST** configure renderers so the bake is cheap: static environment Mesh Renderers get **Contribute Global Illumination = on** and **Receive Global Illumination = Light Probes**; props, debris and dynamic objects keep Contribute GI **off**. Lights must be Mixed or Baked to be captured.
- *Why:* Receiving GI from probes means no lightmaps and no lightmap UVs are needed; limiting Contribute GI to large, complex geometry "is absolutely crucial to minimize baking times".
- *Source:* [manual-probevolumes-use](../reference/rendering-urp/manual-probevolumes-use.md), [manual-lightmapping](../reference/rendering-urp/manual-lightmapping.md), [manual-gpuprogressivelightmapper](../reference/rendering-urp/manual-gpuprogressivelightmapper.md).

**SHOULD** bake from **Window > Rendering > Lighting > Adaptive Probe Volumes** with baking mode **Single Scene**, with the level's `_Environment` (or `_Lighting`) scene open and active so it forms the Baking Set, using **Generate Lighting** (or **Bake Probe Volumes** for probes only); `_Gameplay` parts contain no lights, APV or Contribute-GI geometry. The bootstrap scene contains no lights, no APV and no static geometry. **[project decision]**
- *Why:* Only one Baking Set is active at a time; keeping the persistent scene empty of lighting avoids cross-scene baking sets.
- *Source:* [manual-probevolumes-use](../reference/rendering-urp/manual-probevolumes-use.md), [manual-probevolumes-concept](../reference/rendering-urp/manual-probevolumes-concept.md) (Baking Sets).

**MAY** add local APVs with **Override Probe Spacing** for dense interiors (or sparser empty areas), and a **Probe Adjustment Volume** to invalidate probes inside walls. Dark blotches or light leaks: follow the APV troubleshooting pages before touching light intensities.
- *Source:* [manual-probevolumes-changedensity](../reference/rendering-urp/manual-probevolumes-changedensity.md), [manual-probevolumes-fixissues](../reference/rendering-urp/manual-probevolumes-fixissues.md).

### 5.4 Lightmaps (opt-in)

**MAY** lightmap a large hero surface (floor, walls of a showcase room) when probe lighting is visibly too soft. Then, and only then: model import **Generate Lightmap UVs** (or author UVs in `Mesh.uv2` without overlap), **Receive Global Illumination = Lightmaps** on that renderer, and a Lightmap Resolution low enough that a bake stays under a few minutes.
- *Source:* [manual-lightinggiuvs-generatinglightmappinguvs](../reference/rendering-urp/manual-lightinggiuvs-generatinglightmappinguvs.md), [manual-lightmapping](../reference/rendering-urp/manual-lightmapping.md), [manual-lightmappers](../reference/rendering-urp/manual-lightmappers.md), [manual-lightmapping-bake](../reference/rendering-urp/manual-lightmapping-bake.md).

### 5.5 Shadows

**MUST** keep the tier values from §3 (main light 2048, Max Distance 50 m, 2 cascades + soft shadows on the desktop tier only; Additional Lights > Cast Shadows may stay enabled in the desktop-tier asset, but the per-scene budget in §11 is 0 unless measured) and enable **Conservative Enclosing Sphere** (advanced property) in every URP asset in use.
- *Why:* Shadow cost scales with casters, receivers, shadow-casting lights, cascades, resolution and soft filtering; Unity's performance table says to **Enable** Conservative Enclosing Sphere — it improves shadow frustum culling and is disabled only for legacy-project compatibility.
- *Source:* [manual-shadows-optimization](../reference/rendering-urp/manual-shadows-optimization.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md), [manual-optimize-for-better-performance](../reference/rendering-urp/manual-optimize-for-better-performance.md).

**NEVER** let a **Point** light cast shadows; **SHOULD** set **Mesh Renderer > Lighting > Cast Shadows = Off** on small props and use **Shadows Only** on a simplified mesh for complex hero objects; **MAY** swap far shadow-casting lights off with `Light.enabled` driven by distance.
- *Why:* A point-light shadow map renders the scene six times (six spot lights' worth).
- *Source:* [manual-shadows-optimization](../reference/rendering-urp/manual-shadows-optimization.md).

### 5.6 Reflection probes

**SHOULD** place one **Baked** Reflection Probe per visually distinct area (interior, tunnel, different ground colour) and mark contributing static meshes with the **Reflection Probe** static flag; rely on the skybox reflection elsewhere.
- *Why:* Reflection probes only matter where reflections change noticeably; after **Generate Lighting** Unity creates the ambient baked probe that replaces the fixed hidden default. Forward+ blends more than 2 probes and always enables Probe Blending.
- *Source:* [manual-reflectionprobes](../reference/rendering-urp/manual-reflectionprobes.md), [manual-staticobjects](../reference/performance/manual-staticobjects.md), [manual-rendering-paths-comparison](../reference/rendering-urp/manual-rendering-paths-comparison.md), [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.36.

## 6. Post-processing via Volumes

**MUST** add post-processing per level, in `<Level>_Environment.unity` (or `<Level>_Lighting.unity` when split out; `MainMenu.unity` for the menu) — never in a `_Gameplay` part (see [11](./11-scenes-prefabs-workflow.md)) — exactly like this: the Base Camera has **Post Processing** enabled; the scene has one **GameObject > Volume > Global Volume** whose profile is `Settings/VolumeProfiles/<Context>Profile.asset` (e.g. `ForestProfile.asset`, `MainMenuProfile.asset`; naming per [02](./02-project-structure.md)); effects are **Add Override** entries on that profile. The camera's **Volume Mask** must include the layer the Volume is on (keep Volumes on **Default**). **[project decision]**
- *Why:* New URP scenes have no post-processing; volumes override the two default volumes (project default from Graphics > URP > Default Volume Profile, and the per-quality profile in the URP asset), which have the lowest priority and are evaluated once per scene load.
- *Source:* [manual-add-post-processing](../reference/rendering-urp/manual-add-post-processing.md), [manual-volumes](../reference/rendering-urp/manual-volumes.md), [manual-set-up-a-volume](../reference/rendering-urp/manual-set-up-a-volume.md), [manual-urp-global-settings](../reference/rendering-urp/manual-urp-global-settings.md).

**SHOULD** limit the per-scene profile to **Tonemapping**, **Bloom** (High Quality Filtering off), **Color Adjustments**, **Vignette**, and optionally **Film Grain** / **Chromatic Aberration**; Depth of Field (Gaussian on the low tier, Bokeh on the desktop tier via a quality-level profile), Motion Blur, Lens Distortion and Screen Space Lens Flare need a specific art reason. This is the canonical per-scene set; [05 §6.4](./05-performance.md) links here rather than listing effects. **[project decision]**
- *Why:* Bloom (without HQ filtering), chromatic aberration, colour grading, lens distortion and vignette are the cheap effects; Bloom needs the HDR tier to carry values above 1.
- *Source:* [manual-integration-with-post-processing](../reference/rendering-urp/manual-integration-with-post-processing.md), [manual-effectlist](../reference/rendering-urp/manual-effectlist.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md) (HDR).

**MAY** use a local **Box Volume** (collider **Is Trigger**, higher **Priority**) for area-based looks (caves, boss rooms). Set the Base Camera's **Volume Trigger** to the player Transform for third-person cameras so the player's position, not the camera's, selects the volume.
- *Source:* [manual-set-up-a-volume](../reference/rendering-urp/manual-set-up-a-volume.md), [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md).

**MUST** keep **Grading Mode = Low Dynamic Range**, **LUT Size = 32** (16 on the low tier) and **Volume Update Mode = Every Frame** (URP asset defaults); **NEVER** instantiate Volume Profiles at runtime — tweak overrides on the existing profile instead.
- *Why:* LDR grading and small LUTs are the recommended performance settings; with **Strip Unused Post Processing Variants** enabled, Unity "assumes that the Player does not create new Volume Profiles at runtime" and keeps only the variants the existing profiles use, so a runtime-created profile may hit stripped shader variants.
- *Source:* [manual-optimize-for-better-performance](../reference/rendering-urp/manual-optimize-for-better-performance.md), [manual-urp-global-settings](../reference/rendering-urp/manual-urp-global-settings.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md).

## 7. Cameras and Cinemachine

**MUST** use the single `MainCamera` defined in [09 §Cinemachine 3.1](./09-packages-systems.md) (one `Camera` tagged `MainCamera` with `CinemachineBrain` and `AudioListener`, living in `Bootstrap.unity` per [11](./11-scenes-prefabs-workflow.md); content scenes hold only `CinemachineCamera`s) and set on it the URP values: **Render Type = Base**, **Post Processing** on, **Anti-aliasing = None**, **Dithering** on, **Background Type = Skybox**. **[project decision]**
- *Why:* Every extra active camera runs the full render loop even if it draws nothing; Dithering reduces banding on gradients.
- *Source:* [manual-add-and-remove-cameras-in-a-stack](../reference/rendering-urp/manual-add-and-remove-cameras-in-a-stack.md), [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md). The camera/Brain rule and Cinemachine usage (Follow, blends, impulse) are owned by [09 Packages](./09-packages-systems.md).

**NEVER** add a camera stack for UI: UI Toolkit HUD/menus do not need a camera (see [09](./09-packages-systems.md)). **MAY** stack only for "3D model inside a 2D UI" or a first-person weapon/cockpit, and then:
1. Overlay cameras: **Render Type = Overlay**, added to the Base Camera's **Stack** list, **Culling Mask** reduced to their own layer; the Base Camera's Culling Mask excludes that layer.
2. Post-processing enabled only on the last camera of the stack; no camera in the stack uses a 2D Renderer (2D and 3D renderers cannot be mixed); no TAA anywhere in the stack.
3. Runtime changes through `camera.GetUniversalAdditionalCameraData().cameraStack` (a `List<Camera>`), never by toggling extra Base cameras.
- *Source:* [manual-camera-stacking-concepts](../reference/rendering-urp/manual-camera-stacking-concepts.md), [manual-camera-stacking](../reference/rendering-urp/manual-camera-stacking.md), [manual-add-and-remove-cameras-in-a-stack](../reference/rendering-urp/manual-add-and-remove-cameras-in-a-stack.md), [manual-anti-aliasing](../reference/rendering-urp/manual-anti-aliasing.md).

**NEVER** set **Background Type = Uninitialized** unless the camera provably covers every pixel, and **NEVER** enable **Stop NaNs** except to hunt a NaN bug (it is a full-screen pass).
- *Source:* [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md).

## 8. Anti-aliasing and HDR

**SHOULD** rely on **MSAA** from the URP asset (desktop tier: 2x; low tier: Disabled) and keep the camera's **Anti-aliasing = None**. **MAY** switch the Base Camera to **SMAA** (quality Medium) on art-direction request if geometry edges still shimmer on the desktop tier. **NEVER** select **TAA** or the **STP** upscaler. **[project decision]**
- *Why:* MSAA is hardware AA that works with Forward+ and can be combined with post-process AA; FXAA is cheapest but blurs; SMAA is sharper; TAA ghosts on fast movers, needs motion vectors and cannot be combined with MSAA, camera stacking or dynamic resolution; STP forces TAA. Depth Priming is unavailable under MSAA — consistent with §2.
- *Source:* [manual-anti-aliasing](../reference/rendering-urp/manual-anti-aliasing.md), [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md), [how-to-performance-optimization-high-end-graphics](../reference/performance/how-to-performance-optimization-high-end-graphics.md).

**MUST** keep HDR on only in the desktop-tier asset, with **HDR Precision = 32 Bit**; leave **Alpha Processing** off.
- *Why:* HDR enlarges the colour buffer; 64-bit precision is only needed for alpha output or to fight banding.
- *Source:* [manual-configure-for-better-performance](../reference/rendering-urp/manual-configure-for-better-performance.md), [manual-universalrp-asset](../reference/rendering-urp/manual-universalrp-asset.md).

## 9. Materials and shaders

### 9.1 Choosing a shader

| Need | Shader | Notes |
|:--|:--|:--|
| Any lit surface (default) | **Universal Render Pipeline/Lit** | PBR, Metallic workflow; pack metallic, occlusion and smoothness into one RGBA texture. |
| Stylised, cheap lighting (many instances, vegetation) | **Simple Lit** | Blinn-Phong, not energy-conserving; not available in Shader Graph. |
| Static décor lit only by baked data | **Baked Lit** | No real-time lighting; receives lightmaps/probe lighting only. |
| Unlit props, effects, world-space UI quads | **Unlit** | No lighting; fastest to compile and run. |
| Particles | **Particles/Unlit** first, **Particles/Simple Lit** if they must be lit | Particles Lit is the heaviest model. |
| Anything custom | **Shader Graph** with the **URP Lit / Unlit / Fullscreen / Decal** target | See §9.3. |

**NEVER** use **Complex Lit** (clear coat) or leave **Clear Coat** enabled. **NEVER** assign Built-in (`Standard`, `Legacy Shaders/*`), HDRP or `Create > Shader > Unlit Shader` template shaders — the last one is a Built-in template that also breaks SRP Batcher compatibility.
- *Source:* [manual-shaders-in-universalrp-choose](../reference/rendering-urp/manual-shaders-in-universalrp-choose.md), [manual-shading-model](../reference/rendering-urp/manual-shading-model.md), [manual-lit-shader](../reference/rendering-urp/manual-lit-shader.md), [manual-configure-for-better-performance](../reference/rendering-urp/manual-configure-for-better-performance.md), [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.94.

### 9.2 SRP Batcher compatibility

**MUST** keep every renderer on the SRP Batcher path: mesh or skinned mesh, no `MaterialPropertyBlock`, shader declares material properties in `UnityPerMaterial` and engine properties in `UnityPerDraw` (all URP shaders and Shader Graph shaders already do). Check the shader's Inspector line "SRP Batcher: compatible".
- *Source:* [manual-srpbatcher-materials](../reference/rendering-urp/manual-srpbatcher-materials.md), [manual-shaders-in-universalrp-srp-batcher](../reference/rendering-urp/manual-shaders-in-universalrp-srp-batcher.md), [URP cookbook](../reference/rendering-urp/ebook-urp-cookbook-shaders-and-visual-effects-unity-6-final.md) p.26.

- Material sharing, Material Variants, `MaterialPropertyBlock` and the GPU Instancing checkbox: [05 §6.1](./05-performance.md).

**SHOULD** disable unused Lit features per material (Emission, Height Map, Detail maps, Specular Highlights, Environment Reflections when the surface is matte) and keep **Surface Type = Opaque** unless the material really blends.
- *Why:* "URP implements certain Lit shader material features as shader variants, which require more SRP Batcher batches."
- *Source:* [manual-lit-shader](../reference/rendering-urp/manual-lit-shader.md).

**SHOULD** confirm batching in **Window > Analysis > Frame Debugger > Render Camera > Render Opaques > RenderLoopNewBatcher.Draw**: many SRP batches with few draws means too many shader variants.
- *Source:* [manual-srpbatcher-profile](../reference/rendering-urp/manual-srpbatcher-profile.md).

### 9.3 Shader Graph conventions

- **MUST** create graphs via **Create > Shader Graph > URP > Lit / Unlit / Fullscreen / Decal Shader Graph** so the Universal target is active; save under `Assets/SheNicest/Shaders/` with the material next to it in `Materials/`. *Source:* [manual-prebuilt-shader-graphs-urp](../reference/rendering-urp/manual-prebuilt-shader-graphs-urp.md), [manual-shader-graph](../reference/rendering-urp/manual-shader-graph.md).
- **MUST** name the primary inputs `_BaseMap` (Texture2D) and `_BaseColor` (Color) so materials stay interchangeable with URP Lit and material upgraders; other reference names `_PascalCase` with a leading underscore. **[project decision]** (naming follows URP's own `[MainTexture] _BaseMap` / `[MainColor] _BaseColor`, [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.97.)
- **SHOULD** move shared node groups into **Sub Graphs** (`Shaders/SubGraphs/`) instead of copy-pasting nodes. *Source:* [URP cookbook](../reference/rendering-urp/ebook-urp-cookbook-shaders-and-visual-effects-unity-6-final.md) (DepthFade, TextureMovement, Main Light sub graphs).
- **SHOULD** keep graphs small: delete unused nodes, do not wire defaults, bake constant adjustments into textures, use `half` / smaller vectors where possible. *Source:* [how-to-performance-optimization-high-end-graphics](../reference/performance/how-to-performance-optimization-high-end-graphics.md).
- Graphs that sample **Scene Depth** / **Scene Color** require the camera's Depth/Opaque Texture (see §2); document that requirement in the graph's name or a comment node. **[project decision]**

### 9.4 Hand-written HLSL (last resort)

**MUST** follow the URP template: `Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }` on the SubShader, `HLSLPROGRAM` with `#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"`, material properties inside `CBUFFER_START(UnityPerMaterial) … CBUFFER_END`, passes tagged `UniversalForward`, `ShadowCaster`, `DepthOnly` (and `DepthNormalsOnly` if SSAO is ever enabled, `Meta` if the material must bake). Never mix Built-in include files with SRP ones.
- *Why:* Without the `RenderPipeline` tag URP skips the SubShader and shows the magenta error shader; without `ShadowCaster`/`DepthOnly` the object casts no shadows and breaks depth-based features.
- *Source:* [manual-writing-shaders-urp-basic-unlit-structure](../reference/rendering-urp/manual-writing-shaders-urp-basic-unlit-structure.md), [manual-urp-shaderlab-pass-tags](../reference/rendering-urp/manual-urp-shaderlab-pass-tags.md), [manual-shaders-in-universalrp-srp-batcher](../reference/rendering-urp/manual-shaders-in-universalrp-srp-batcher.md), [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.93–97.

## 10. Texture import settings that affect rendering

| Texture | Texture Type | sRGB (Color Texture) |
|:--|:--|:--|
| Albedo / Base Map, emission colour | Default | **On** |
| Normal map | **Normal map** | Off |
| Metallic/occlusion/smoothness mask, height, any data map | Default | **Off** (pack into one RGBA when possible) |
| UI sprites, UI Toolkit images | Sprite (2D and UI) | On |

- *Source (table):* [how-to-mobile-game-optimization-tips-part-1](../reference/performance/how-to-mobile-game-optimization-tips-part-1.md) ("Textures that are not processed as color must not be in the sRGB color space … metallic, roughness, and normal maps"); the **Normal map** Texture Type and the packed mask are **[project decision]** following the URP Lit workflow in §9.1.
- Size, Max Size, compression format, Read/Write and mipmap rules: [05 §7.1](./05-performance.md).
- *Why sRGB matters:* data maps marked sRGB are gamma-decoded by the linear pipeline and shade incorrectly. *Source:* [how-to-mobile-game-optimization-tips-part-1](../reference/performance/how-to-mobile-game-optimization-tips-part-1.md).

## 11. Render budgets (per level — its `_Environment`/`_Lighting` scene — per camera view)

This table is the canonical render budget; [05 §6.4](./05-performance.md) links here.

| Item | Budget | Why / source |
|:--|:--|:--|
| Directional lights | 1 (Mixed, Sun Source) | §5.2 |
| Additional realtime/mixed lights visible at once | ≤ 8 | Forward+ has no per-object limit but every visible light costs; the Forward fallback limit is 8 per object. [manual-light-limits-in-urp](../reference/rendering-urp/manual-light-limits-in-urp.md) **[project decision]** |
| Shadow-casting additional lights | **0** by default — realtime shadows come only from the main directional light ([05 §6.4](./05-performance.md)); a shadow-casting **spot** light on the desktop tier needs a Profiler capture in the PR; point lights never | [manual-shadows-optimization](../reference/rendering-urp/manual-shadows-optimization.md) **[project decision]** |
| Shadow Max Distance / cascades | 50 m / 2 (desktop tier) | template values |
| Active cameras | 1 (+ overlay cameras only per §7) | each camera runs the full loop. [manual-add-and-remove-cameras-in-a-stack](../reference/rendering-urp/manual-add-and-remove-cameras-in-a-stack.md) |
| Renderer Features per renderer asset | ≤ 2 (no SSAO, no Decal unless approved) | each adds passes; Decal adds a full pass. [manual-configure-for-better-performance](../reference/rendering-urp/manual-configure-for-better-performance.md) |
| Post-processing overrides | the §6 set | [manual-integration-with-post-processing](../reference/rendering-urp/manual-integration-with-post-processing.md) |
| Realtime Reflection Probes | 0 (all Baked) | [manual-lighting-configuration-workflow](../reference/rendering-urp/manual-lighting-configuration-workflow.md) **[project decision]** |
| Render Scale | 1.0 (lower on the low tier only with a measured need) | [manual-optimize-for-better-performance](../reference/rendering-urp/manual-optimize-for-better-performance.md) |

Use the **Rendering Debugger** (Lighting Complexity, overdraw) and **Frame Debugger** to check; frame-time measurement and CPU/GPU budgets are in [05](./05-performance.md).
- *Source:* [manual-rendering-debugger](../reference/rendering-urp/manual-rendering-debugger.md), [manual-understand-performance](../reference/rendering-urp/manual-understand-performance.md).

## 12. When something renders pink, black or invisible

Work through the list top to bottom; stop at the first hit.

**Pink / magenta (error shader):**
1. Material uses a Built-in/Standard, HDRP or Asset Store shader → **Edit > Rendering > Materials > Convert Selected Built-In Materials to Current SRP** (or **Window > Rendering > Render Pipeline Converter > Built-In Render Pipeline to URP > Material Upgrade** for a whole pack; it is irreversible, so do it in a clean commit). Custom shaders are not converted: port them per §9.4 or replace with Shader Graph. *Source:* [manual-upgrade-material](../reference/rendering-urp/manual-upgrade-material.md), [manual-rp-converter](../reference/rendering-urp/manual-rp-converter.md), [manual-upgrading-from-birp](../reference/rendering-urp/manual-upgrading-from-birp.md).
2. Shader compile error: the Console and the material Inspector show it; fix the shader or re-save the Shader Graph. *Source:* [manual-upgrade-material](../reference/rendering-urp/manual-upgrade-material.md).
3. Hand-written shader without a `"RenderPipeline" = "UniversalPipeline"` SubShader, or Shader Graph without the Universal target. *Source:* [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.93, [manual-writing-shaders-urp-basic-unlit-structure](../reference/rendering-urp/manual-writing-shaders-urp-basic-unlit-structure.md).
4. No URP asset active (Graphics default or the Quality override cleared, or `SamplesPipelineAsset` substituted after importing URP samples) → re-assign per §1. *Source:* [manual-known-issues](../reference/rendering-urp/manual-known-issues.md), [manual-srp-setting-render-pipeline-asset](../reference/rendering-urp/manual-srp-setting-render-pipeline-asset.md).

**Black / too dark:**
1. Dynamic object lit only by **Baked** lights → set the light to Mixed (dynamic objects receive nothing from Baked lights). *Source:* [manual-lightmodes-introduction](../reference/rendering-urp/manual-lightmodes-introduction.md).
2. Pitch-black shadows / no bounce → lights are Realtime or lighting was never generated; set Mixed and **Generate Lighting** (APV). *Source:* [manual-lightmodes-introduction](../reference/rendering-urp/manual-lightmodes-introduction.md), [manual-probevolumes-use](../reference/rendering-urp/manual-probevolumes-use.md).
3. Ambient/reflections stale after changing the skybox → **Generate Lighting** (Skybox ambient and the default reflection probe need a bake). *Source:* [manual-reflectionprobes](../reference/rendering-urp/manual-reflectionprobes.md), [URP e-book](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) p.41.
4. Dark blotches or leaks on probe-lit objects → APV validity/leak fixes, Probe Adjustment Volume. *Source:* [manual-probevolumes-fixissues](../reference/rendering-urp/manual-probevolumes-fixissues.md).
5. Lights flicker or vanish → the renderer fell back to Forward (check `m_RenderingMode: 2`) or the light's **Render Mode** should be **Important**. *Source:* [manual-ts-lights-flicker-disappear](../reference/rendering-urp/manual-ts-lights-flicker-disappear.md).
6. Whole view black or garbage → a camera with **Background Type = Uninitialized**, a Base Camera culling mask that excludes the content layers, or an Overlay camera left as Base. *Source:* [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md), [manual-camera-stacking](../reference/rendering-urp/manual-camera-stacking.md).
7. Post-processing missing → camera **Post Processing** unchecked, the Volume's layer not in the camera's **Volume Mask**, or the pass is applied on a non-final camera of a stack. *Source:* [manual-add-post-processing](../reference/rendering-urp/manual-add-post-processing.md), [manual-camera-stacking-concepts](../reference/rendering-urp/manual-camera-stacking-concepts.md).

**Invisible:**
1. Opaque custom shader with **Depth Priming Mode** on and no `DepthOnly` pass → keep priming Disabled or add the pass. *Source:* [manual-urp-universal-renderer](../reference/rendering-urp/manual-urp-universal-renderer.md).
2. Custom blit pass injected at `AfterRendering` reads the back buffer and skips itself → inject at `AfterRenderingPostProcessing` or earlier. *Source:* [BlitAndSwapColorRendererFeature.cs](../reference/rendering-urp/github-graphics-blitandswapcolorrendererfeature-cs.md).
3. Object on a layer that the renderer's **Opaque/Transparent Layer Mask** or the camera's **Culling Mask** excludes. *Source:* [manual-urp-universal-renderer](../reference/rendering-urp/manual-urp-universal-renderer.md), [manual-camera-component-reference](../reference/rendering-urp/manual-camera-component-reference.md).

## Anti-patterns

- ❌ Renderer left on Forward "because the template did it" → ✅ set Forward+ and check `m_RenderingMode: 2` (§2).
- ❌ A third quality level "Ultra" or a per-feature URP asset → ✅ tune the template's tier assets (§1, §3).
- ❌ `ScriptableRenderPass.Execute`, `ScriptableRendererFeature.SetupRenderPasses`, `CommandBuffer.Blit`, `URP_COMPATIBILITY_MODE` → ✅ `RecordRenderGraph` + `AddBlitPass` (§4, [10](./10-unity6-facts.md)).
- ❌ Tinting instances with `MaterialPropertyBlock` or `renderer.material` (instantiates a material) → ✅ Material Variants or a shared material with a texture atlas (§9.2).
- ❌ `Create > Shader > Unlit Shader` or a Standard-shader material from the Asset Store left as-is → ✅ URP Lit / Shader Graph URP target; run the material converter on imported packs (§9, §12).
- ❌ Realtime point light with shadows for a torch → ✅ Mixed spot light without shadows, or a light cookie (§5.5).
- ❌ Manual Light Probe Groups scattered by hand → ✅ one global Adaptive Probe Volume (§5.3).
- ❌ Every mesh marked Contribute GI → ✅ only large static architecture; props use probes (§5.3).
- ❌ Post-processing configured on a Volume component inside a prefab that is instantiated many times, or profiles created with `ScriptableObject.CreateInstance` at runtime → ✅ one global Volume per level in its `_Environment` scene with a saved `<Context>Profile` (§6).
- ❌ A second Unity Camera for the HUD or "cutscene camera" GameObjects with `Camera` components → ✅ the single `MainCamera` ([09](./09-packages-systems.md)); shots are `CinemachineCamera`s (§7).
- ❌ TAA or STP enabled for "free" AA → ✅ MSAA in the URP asset, SMAA at most (§8).
- ❌ Normal maps imported as Default/sRGB → ✅ Texture Type Normal map (§10).
- ❌ Settings changes buried in a gameplay commit → ✅ separate, announced commit by the rendering owner (TL;DR 13).

## Review checklist

- [ ] The desktop-tier renderer asset contains `m_RenderingMode: 2` (and so does any other renderer in use); no renderer asset was added, removed or renamed; no Renderer Feature shares a renderer's name.
- [ ] The quality levels and `Settings/` file names equal the day-one record in §1; every level has its URP asset override; Graphics default = desktop-tier asset; tier values match §3 (or the diff is explained in the commit).
- [ ] Any new `ScriptableRendererFeature` uses `RecordRenderGraph`, no `Execute`/`SetupRenderPasses`, no `*.Blit` calls, allocates nothing in `AddRenderPasses`, lives in `Scripts/Runtime/Rendering`, and the asmdef references from §4 were added in the same commit.
- [ ] Player Color Space is Linear (unchanged).
- [ ] Level `_Environment` (or `_Lighting`) scene: one Mixed Directional light set as Sun Source, Baked GI on, Lighting Mode Baked Indirect, shared Lighting Settings Asset assigned, one global APV, lighting generated by the scene owner; the `_Gameplay` part has no lights, APV or Volume.
- [ ] Static architecture: Contribute GI on + Receive GI = Light Probes; props: Contribute GI off; no shadow-casting point lights; Cast Shadows off on small props.
- [ ] One global Volume per level in its `_Environment` (or `_Lighting`) scene with a `<Context>Profile` asset under `Settings/VolumeProfiles/`; Base Camera has Post Processing on and the Volume layer in its Volume Mask; overrides within the §6 set.
- [ ] The single `MainCamera` ([09](./09-packages-systems.md)) is the only Base Camera; new shots are `CinemachineCamera`s; any Overlay camera follows §7 (layers, masks, post on last camera only, no TAA).
- [ ] Camera Anti-aliasing is None (or SMAA with a noted reason); no TAA/STP; HDR only in the desktop-tier asset.
- [ ] New materials use URP Lit/Unlit/Simple Lit/Baked Lit or a URP-target Shader Graph; unused Lit features off; material sharing/variants per [05 §6.1](./05-performance.md); no `MaterialPropertyBlock` in code.
- [ ] Shader Graph inputs named `_BaseMap`/`_BaseColor`; graphs saved under `Shaders/`; shared logic in Sub Graphs.
- [ ] Imported textures: sRGB only on colour maps, normal maps typed Normal map; size/Read-Write/mipmaps per [05 §7.1](./05-performance.md).
- [ ] No new Renderer Feature, SSAO, Decal, Depth/Opaque Texture, GPU Resident Drawer, GPU Occlusion or Depth Priming without a Profiler/Frame Debugger capture in the PR.
- [ ] No magenta materials and no shader errors in the Console after the change.

## Sources

1. [../reference/rendering-urp/manual-urp-asset-and-renderer.md](../reference/rendering-urp/manual-urp-asset-and-renderer.md) — Universal Render Pipeline asset — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-asset-and-renderer.html
2. [../reference/rendering-urp/manual-universalrp-asset.md](../reference/rendering-urp/manual-universalrp-asset.md) — Universal Render Pipeline asset reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html
3. [../reference/rendering-urp/manual-urp-universal-renderer.md](../reference/rendering-urp/manual-urp-universal-renderer.md) — Universal Renderer asset reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html
4. [../reference/rendering-urp/manual-installurpintoaproject.md](../reference/rendering-urp/manual-installurpintoaproject.md) — Install URP into an existing project — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/InstallURPIntoAProject.html
5. [../reference/rendering-urp/manual-srp-setting-render-pipeline-asset.md](../reference/rendering-urp/manual-srp-setting-render-pipeline-asset.md) — Change or detect the active render pipeline — https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html
6. [../reference/rendering-urp/manual-quality-settings-through-code.md](../reference/rendering-urp/manual-quality-settings-through-code.md) — Change the active URP asset at runtime — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/quality-settings-through-code.html
7. [../reference/rendering-urp/manual-change-urp-asset-settings.md](../reference/rendering-urp/manual-change-urp-asset-settings.md) — Change URP asset settings at runtime — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/quality/change-urp-asset-settings.html
8. [../reference/rendering-urp/github-graphics-qualitysettings-asset.md](../reference/rendering-urp/github-graphics-qualitysettings-asset.md) — Legacy URP template in the Unity Graphics repo (6000.3/staging): QualitySettings.asset — indicative values, not the shipped asset names — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/ProjectSettings/QualitySettings.asset
9. [../reference/rendering-urp/github-graphics-universalrenderer-asset.md](../reference/rendering-urp/github-graphics-universalrenderer-asset.md) — Legacy URP template in the Unity Graphics repo (6000.3/staging): UniversalRenderer.asset — indicative values, not the shipped asset names — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/Assets/Settings/UniversalRenderer.asset
10. [../reference/rendering-urp/github-graphics-universalrp-highquality-asset.md](../reference/rendering-urp/github-graphics-universalrp-highquality-asset.md) — Legacy URP template in the Unity Graphics repo (6000.3/staging): UniversalRP-HighQuality.asset — indicative values, not the shipped asset names — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/Assets/Settings/UniversalRP-HighQuality.asset
11. [../reference/rendering-urp/github-graphics-universalrp-mediumquality-asset.md](../reference/rendering-urp/github-graphics-universalrp-mediumquality-asset.md) — Legacy URP template in the Unity Graphics repo (6000.3/staging): UniversalRP-MediumQuality.asset — indicative values, not the shipped asset names — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/Assets/Settings/UniversalRP-MediumQuality.asset
12. [../reference/rendering-urp/github-graphics-universalrp-lowquality-asset.md](../reference/rendering-urp/github-graphics-universalrp-lowquality-asset.md) — Legacy URP template in the Unity Graphics repo (6000.3/staging): UniversalRP-LowQuality.asset — indicative values, not the shipped asset names — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/Assets/Settings/UniversalRP-LowQuality.asset
13. [../reference/rendering-urp/manual-how-to-custom-effect-render-objects.md](../reference/rendering-urp/manual-how-to-custom-effect-render-objects.md) — Example of creating a custom rendering effect using a Render Objects Renderer Feature in URP (names `Settings > PC_Renderer`) — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/how-to-custom-effect-render-objects.html
14. [../reference/rendering-urp/manual-rendering-paths-comparison.md](../reference/rendering-urp/manual-rendering-paths-comparison.md) — Choose a rendering path in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-comparison.html
15. [../reference/rendering-urp/manual-rendering-paths-set.md](../reference/rendering-urp/manual-rendering-paths-set.md) — Set the rendering path in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-paths-set.html
16. [../reference/rendering-urp/manual-forward-rendering-paths.md](../reference/rendering-urp/manual-forward-rendering-paths.md) — Forward and Forward+ rendering paths in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html
17. [../reference/rendering-urp/manual-forward-plus-rendering-path-limitations.md](../reference/rendering-urp/manual-forward-plus-rendering-path-limitations.md) — Troubleshooting the Forward+ rendering path in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-plus-rendering-path-limitations.html
18. [../reference/rendering-urp/manual-light-limits-in-urp.md](../reference/rendering-urp/manual-light-limits-in-urp.md) — Light limits in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/light-limits-in-urp.html
19. [../reference/rendering-urp/manual-known-issues.md](../reference/rendering-urp/manual-known-issues.md) — Known issues in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/known-issues.html
20. [../reference/rendering-urp/manual-srpbatcher.md](../reference/rendering-urp/manual-srpbatcher.md) — Scriptable Render Pipeline Batcher in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html
21. [../reference/rendering-urp/manual-srpbatcher-materials.md](../reference/rendering-urp/manual-srpbatcher-materials.md) — Check whether a GameObject is compatible with the SRP Batcher in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Materials.html
22. [../reference/rendering-urp/manual-srpbatcher-profile.md](../reference/rendering-urp/manual-srpbatcher-profile.md) — Troubleshoot the SRP Batcher in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Profile.html
23. [../reference/rendering-urp/manual-shaders-in-universalrp-srp-batcher.md](../reference/rendering-urp/manual-shaders-in-universalrp-srp-batcher.md) — Make a URP shader compatible with the SRP Batcher — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shaders-in-universalrp-srp-batcher.html
24. [../reference/rendering-urp/manual-gpu-resident-drawer.md](../reference/rendering-urp/manual-gpu-resident-drawer.md) — Enable the GPU Resident Drawer in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-resident-drawer.html
25. [../reference/rendering-urp/manual-make-object-compatible-gpu-rendering.md](../reference/rendering-urp/manual-make-object-compatible-gpu-rendering.md) — Make a GameObject compatible with the GPU Resident Drawer in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/make-object-compatible-gpu-rendering.html
26. [../reference/rendering-urp/manual-gpu-culling.md](../reference/rendering-urp/manual-gpu-culling.md) — Enable GPU occlusion culling in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/gpu-culling.html
27. [../reference/rendering-urp/manual-configure-for-better-performance.md](../reference/rendering-urp/manual-configure-for-better-performance.md) — Configure for better performance in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/configure-for-better-performance.html
28. [../reference/rendering-urp/manual-optimize-for-better-performance.md](../reference/rendering-urp/manual-optimize-for-better-performance.md) — Adjust settings to improve performance in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/optimize-for-better-performance.html
29. [../reference/rendering-urp/manual-understand-performance.md](../reference/rendering-urp/manual-understand-performance.md) — Introduction to performance in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/understand-performance.html
30. [../reference/rendering-urp/manual-render-graph-introduction.md](../reference/rendering-urp/manual-render-graph-introduction.md) — Introduction to the render graph system in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-introduction.html
31. [../reference/rendering-urp/manual-render-graph-write-render-pass.md](../reference/rendering-urp/manual-render-graph-write-render-pass.md) — Write a render pass using the render graph system in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-write-render-pass.html
32. [../reference/rendering-urp/manual-render-graph-blit.md](../reference/rendering-urp/manual-render-graph-blit.md) — Blit using the render graph system in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-blit.html
33. [../reference/rendering-urp/manual-blit-overview.md](../reference/rendering-urp/manual-blit-overview.md) — Blit in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/blit-overview.html
34. [../reference/rendering-urp/manual-render-graph-optimize.md](../reference/rendering-urp/manual-render-graph-optimize.md) — Optimize a render graph — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-optimize.html
35. [../reference/rendering-urp/manual-render-graph-view.md](../reference/rendering-urp/manual-render-graph-view.md) — Analyze a render graph in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html
36. [../reference/rendering-urp/manual-custom-rendering-pass-workflow-in-urp.md](../reference/rendering-urp/manual-custom-rendering-pass-workflow-in-urp.md) — Custom render pass workflow in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/custom-rendering-pass-workflow-in-urp.html
37. [../reference/rendering-urp/manual-inject-a-pass-using-a-scriptable-renderer-feature.md](../reference/rendering-urp/manual-inject-a-pass-using-a-scriptable-renderer-feature.md) — Inject a render pass with a Scriptable Renderer Feature in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/scriptable-renderer-features/inject-a-pass-using-a-scriptable-renderer-feature.html
38. [../reference/rendering-urp/manual-custom-pass-injection-points.md](../reference/rendering-urp/manual-custom-pass-injection-points.md) — Injection points reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/custom-pass-injection-points.html
39. [../reference/rendering-urp/manual-urp-renderer-feature.md](../reference/rendering-urp/manual-urp-renderer-feature.md) — Add a Renderer Feature to a URP Renderer — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-renderer-feature.html
40. [../reference/rendering-urp/manual-custom-post-processing.md](../reference/rendering-urp/manual-custom-post-processing.md) — Custom post-processing in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/custom-post-processing.html
41. [../reference/rendering-urp/manual-post-processing-custom-effect-low-code.md](../reference/rendering-urp/manual-post-processing-custom-effect-low-code.md) — Create a low-code custom post-processing effect in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/post-processing-custom-effect-low-code.html
42. [../reference/rendering-urp/github-graphics-copyrenderfeature-cs.md](../reference/rendering-urp/github-graphics-copyrenderfeature-cs.md) — URP render graph sample: CopyRenderFeature.cs — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Packages/com.unity.render-pipelines.universal/Samples~/URPRenderGraphSamples/Blit/CopyRenderFeature.cs
43. [../reference/rendering-urp/github-graphics-blitandswapcolorrendererfeature-cs.md](../reference/rendering-urp/github-graphics-blitandswapcolorrendererfeature-cs.md) — URP render graph sample: BlitAndSwapColorRendererFeature.cs — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Packages/com.unity.render-pipelines.universal/Samples~/URPRenderGraphSamples/BlitWithMaterial/BlitAndSwapColorRendererFeature.cs
44. [../reference/unity6-release/manual-upgradeguideunity63.md](../reference/unity6-release/manual-upgradeguideunity63.md) — Unity 6.3 upgrade guide (URP Compatibility Mode removal) — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html
45. [../reference/rendering-urp/manual-linearrendering-linearorgammaworkflow.md](../reference/rendering-urp/manual-linearrendering-linearorgammaworkflow.md) — Set a project's color space — https://docs.unity3d.com/6000.3/Documentation/Manual/LinearRendering-LinearOrGammaWorkflow.html
46. [../reference/rendering-urp/manual-render-pipelines-feature-comparison.md](../reference/rendering-urp/manual-render-pipelines-feature-comparison.md) — Render pipeline feature comparison — https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines-feature-comparison.html
47. [../reference/rendering-urp/manual-lighting-ambient-light.md](../reference/rendering-urp/manual-lighting-ambient-light.md) — Add ambient light from the environment — https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-ambient-light.html
48. [../reference/project-structure/manual-setupmultiplescenes.md](../reference/project-structure/manual-setupmultiplescenes.md) — Set up multiple scenes (scene-specific rendering settings) — https://docs.unity3d.com/6000.3/Documentation/Manual/setupmultiplescenes.html
49. [../reference/rendering-urp/manual-lightmodes-choose.md](../reference/rendering-urp/manual-lightmodes-choose.md) — Choose a Light Mode — https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-choose.html
50. [../reference/rendering-urp/manual-lightmodes-introduction.md](../reference/rendering-urp/manual-lightmodes-introduction.md) — Light Modes — https://docs.unity3d.com/6000.3/Documentation/Manual/LightModes-introduction.html
51. [../reference/rendering-urp/manual-lighting-mode.md](../reference/rendering-urp/manual-lighting-mode.md) — Lighting Mode — https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html
52. [../reference/rendering-urp/manual-lighting-configuration-workflow.md](../reference/rendering-urp/manual-lighting-configuration-workflow.md) — Lighting configuration workflow — https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-configuration-workflow.html
53. [../reference/rendering-urp/manual-choose-a-lighting-setup.md](../reference/rendering-urp/manual-choose-a-lighting-setup.md) — Global illumination — https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-lighting-setup.html
54. [../reference/rendering-urp/manual-global-illumination-configure.md](../reference/rendering-urp/manual-global-illumination-configure.md) — Configure lightmapping with a Lighting Settings Asset — https://docs.unity3d.com/6000.3/Documentation/Manual/global-illumination-configure.html
55. [../reference/rendering-urp/manual-gpuprogressivelightmapper.md](../reference/rendering-urp/manual-gpuprogressivelightmapper.md) — Optimize baking — https://docs.unity3d.com/6000.3/Documentation/Manual/GPUProgressiveLightmapper.html
56. [../reference/rendering-urp/manual-probevolumes.md](../reference/rendering-urp/manual-probevolumes.md) — Adaptive Probe Volumes (APV) in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes.html
57. [../reference/rendering-urp/manual-probevolumes-concept.md](../reference/rendering-urp/manual-probevolumes-concept.md) — Introduction to Adaptive Probe Volumes — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-concept.html
58. [../reference/rendering-urp/manual-probevolumes-use.md](../reference/rendering-urp/manual-probevolumes-use.md) — Use Adaptive Probe Volumes — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-use.html
59. [../reference/rendering-urp/manual-probevolumes-changedensity.md](../reference/rendering-urp/manual-probevolumes-changedensity.md) — Configure the size and density of Adaptive Probe Volumes — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-changedensity.html
60. [../reference/rendering-urp/manual-probevolumes-fixissues.md](../reference/rendering-urp/manual-probevolumes-fixissues.md) — Troubleshooting Adaptive Probe Volumes — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes-fixissues.html
61. [../reference/rendering-urp/manual-lightmapping.md](../reference/rendering-urp/manual-lightmapping.md) — Set up your scene and lights for baking — https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmapping.html
62. [../reference/rendering-urp/manual-lightmappers.md](../reference/rendering-urp/manual-lightmappers.md) — Introduction to lightmaps and baking — https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmappers.html
63. [../reference/rendering-urp/manual-lightmapping-bake.md](../reference/rendering-urp/manual-lightmapping-bake.md) — Bake lighting — https://docs.unity3d.com/6000.3/Documentation/Manual/Lightmapping-bake.html
64. [../reference/rendering-urp/manual-lightinggiuvs-generatinglightmappinguvs.md](../reference/rendering-urp/manual-lightinggiuvs-generatinglightmappinguvs.md) — Generate lightmap UVs — https://docs.unity3d.com/6000.3/Documentation/Manual/LightingGiUvs-GeneratingLightmappingUVs.html
65. [../reference/rendering-urp/manual-shadows-optimization.md](../reference/rendering-urp/manual-shadows-optimization.md) — Optimize shadow rendering in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/shadows-optimization.html
66. [../reference/rendering-urp/manual-ts-lights-flicker-disappear.md](../reference/rendering-urp/manual-ts-lights-flicker-disappear.md) — Troubleshooting lights flickering or disappearing — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/ts-lights-flicker-disappear.html
67. [../reference/rendering-urp/manual-reflectionprobes.md](../reference/rendering-urp/manual-reflectionprobes.md) — Introduction to Reflection Probes — https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html
68. [../reference/performance/manual-staticobjects.md](../reference/performance/manual-staticobjects.md) — Static GameObjects — https://docs.unity3d.com/6000.3/Documentation/Manual/StaticObjects.html
69. [../reference/rendering-urp/manual-integration-with-post-processing.md](../reference/rendering-urp/manual-integration-with-post-processing.md) — Introduction to post-processing in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/integration-with-post-processing.html
70. [../reference/rendering-urp/manual-add-post-processing.md](../reference/rendering-urp/manual-add-post-processing.md) — Add post-processing in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/add-post-processing.html
71. [../reference/rendering-urp/manual-volumes.md](../reference/rendering-urp/manual-volumes.md) — Understand volumes in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/Volumes.html
72. [../reference/rendering-urp/manual-set-up-a-volume.md](../reference/rendering-urp/manual-set-up-a-volume.md) — Set up a volume in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/set-up-a-volume.html
73. [../reference/rendering-urp/manual-effectlist.md](../reference/rendering-urp/manual-effectlist.md) — Post-processing Volume Overrides reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/EffectList.html
74. [../reference/rendering-urp/manual-urp-global-settings.md](../reference/rendering-urp/manual-urp-global-settings.md) — Graphics settings window reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-global-settings.html
75. [../reference/rendering-urp/manual-camera-component-reference.md](../reference/rendering-urp/manual-camera-component-reference.md) — Camera Inspector window reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-component-reference.html
76. [../reference/rendering-urp/manual-camera-stacking-concepts.md](../reference/rendering-urp/manual-camera-stacking-concepts.md) — Camera stacking in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-stacking-concepts.html
77. [../reference/rendering-urp/manual-camera-stacking.md](../reference/rendering-urp/manual-camera-stacking.md) — Set up a camera stack in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html
78. [../reference/rendering-urp/manual-add-and-remove-cameras-in-a-stack.md](../reference/rendering-urp/manual-add-and-remove-cameras-in-a-stack.md) — Add and remove cameras in a camera stack in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html
79. [../reference/rendering-urp/manual-anti-aliasing.md](../reference/rendering-urp/manual-anti-aliasing.md) — Add anti-aliasing in the Universal Render Pipeline — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html
80. [../reference/performance/how-to-performance-optimization-high-end-graphics.md](../reference/performance/how-to-performance-optimization-high-end-graphics.md) — Performance optimization for high-end graphics on PC and console — https://unity.com/how-to/performance-optimization-high-end-graphics
81. [../reference/rendering-urp/manual-shaders-in-universalrp-choose.md](../reference/rendering-urp/manual-shaders-in-universalrp-choose.md) — Choose a prebuilt shader in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shaders-in-universalrp-choose.html
82. [../reference/rendering-urp/manual-shading-model.md](../reference/rendering-urp/manual-shading-model.md) — Shading models in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shading-model.html
83. [../reference/rendering-urp/manual-lit-shader.md](../reference/rendering-urp/manual-lit-shader.md) — Lit shader material Inspector window reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lit-shader.html
84. [../reference/rendering-urp/manual-shader-graph.md](../reference/rendering-urp/manual-shader-graph.md) — Creating shaders with Shader Graph — https://docs.unity3d.com/6000.3/Documentation/Manual/shader-graph.html
85. [../reference/rendering-urp/manual-prebuilt-shader-graphs-urp.md](../reference/rendering-urp/manual-prebuilt-shader-graphs-urp.md) — Shader graph material Inspector window reference for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/prebuilt-shader-graphs-urp.html
86. [../reference/rendering-urp/manual-writing-shaders-urp-basic-unlit-structure.md](../reference/rendering-urp/manual-writing-shaders-urp-basic-unlit-structure.md) — Write an unlit basic shader in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html
87. [../reference/rendering-urp/manual-urp-shaderlab-pass-tags.md](../reference/rendering-urp/manual-urp-shaderlab-pass-tags.md) — ShaderLab Pass tags in URP reference — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/urp-shaderlab-pass-tags.html
88. [../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) — Introduction to the Universal Render Pipeline for advanced Unity creators (Unity 6 edition) — https://unity.com/resources/introduction-to-urp-advanced-creators-unity-6
89. [../reference/rendering-urp/ebook-urp-cookbook-shaders-and-visual-effects-unity-6-final.md](../reference/rendering-urp/ebook-urp-cookbook-shaders-and-visual-effects-unity-6-final.md) — Create shaders and visual effects with URP (Unity 6) — https://unity.com/resources/create-shaders-visual-effects-urp-unity-6
90. [../reference/performance/manual-optimizing-draw-calls-choose-method.md](../reference/performance/manual-optimizing-draw-calls-choose-method.md) — Choose a method for optimizing draw calls — https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html
91. [../reference/performance/how-to-mobile-game-optimization-tips-part-1.md](../reference/performance/how-to-mobile-game-optimization-tips-part-1.md) — Art optimization tips for mobile game developers part 1 — https://unity.com/how-to/mobile-game-optimization-tips-part-1
92. [../reference/rendering-urp/manual-upgrade-material.md](../reference/rendering-urp/manual-upgrade-material.md) — Upgrade material assets to Scriptable Render Pipeline — https://docs.unity3d.com/6000.3/Documentation/Manual/upgrade-material.html
93. [../reference/rendering-urp/manual-rp-converter.md](../reference/rendering-urp/manual-rp-converter.md) — Convert assets using the Render Pipeline Converter — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html
94. [../reference/rendering-urp/manual-upgrading-from-birp.md](../reference/rendering-urp/manual-upgrading-from-birp.md) — Upgrading from the Built-In Render Pipeline to URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrading-from-birp.html
95. [../reference/rendering-urp/manual-rendering-debugger.md](../reference/rendering-urp/manual-rendering-debugger.md) — Rendering Debugger in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger.html
96. [../reference/rendering-urp/manual-requirements.md](../reference/rendering-urp/manual-requirements.md) — Requirements and compatibility for URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/requirements.html
