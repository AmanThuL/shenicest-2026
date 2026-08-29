# 07. Rendering and HDRP conventions

> **Scope:** How this project configures and uses the High Definition Render Pipeline (HDRP 17.3) in Unity 6.3: the pipeline asset, the HDRP graphics settings and the single quality tier, the **Forward Only** Lit Shader Mode, custom passes and custom post-process, physically based lighting with fixed exposure, volumetric fog and sky through Volumes, cameras and Cinemachine, materials and Shader Graph HDRP targets, SMAA and HDR, rendering-relevant texture import settings, and what to check when something renders pink, black or invisible.
> **Applies to:** every HDRP asset, Volume profile, lighting setting, material, shader, Shader Graph and camera under `Assets/RootsDance/`, and any C# under `Assets/RootsDance/Scripts/Runtime/Rendering` (folder and namespace `RootsDance.Rendering` are created only with the first custom pass, per [02](./02-project-structure.md)). Generic profiling and CPU/GPU budgets are owned by [05 Performance](./05-performance.md); Unity 6.3 facts and deprecations by [10 Unity 6.3 facts](./10-unity6-facts.md).
> **Status:** Unity 6000.3 LTS · HDRP 17.3.0 · last reviewed 2026-08-27

## TL;DR — rules at a glance

1. **MUST** render with **HDRP 17.3.0** and **Lit Shader Mode = Forward Only** on `Assets/RootsDance/Settings/HDRP/HDRP_Desktop.asset`. There is no deferred GBuffer in this project, and no second render pipeline package.
2. **MUST** keep exactly one quality level, **`Desktop`**, bound to `HDRP_Desktop.asset`, with the global settings and default profiles beside it in `Assets/RootsDance/Settings/HDRP/` (§1). Nobody adds, renames or reorders quality levels or settings assets.
3. **MUST** implement custom rendering as an HDRP **Custom Pass** (a `CustomPass` subclass run by a `CustomPassVolume`) or a **Custom Post Process** (a `CustomPostProcessVolumeComponent` registered in HDRP graphics settings). **NEVER** `ScriptableRendererFeature` / `ScriptableRenderPass` / `RecordRenderGraph` (URP-only APIs), **NEVER** `Graphics.Blit` or `CommandBuffer.Blit`.
4. **MUST** keep **Color Space = Linear** (Player settings). HDRP does not support gamma space at all.
5. **MUST** light each level from its `<Level>_Environment.unity` scene: one Directional light named `Sun` in **lux** at real-world magnitudes, one **Global Volume** whose profile sets **Fixed** exposure, and **Adaptive Probe Volumes** as the light-probe system. Lightmaps are opt-in (§5.5).
6. **MUST** apply post-processing, sky and fog only through **Volume** components and Volume Profile assets named `<Context>Profile` in `Assets/RootsDance/Settings/VolumeProfiles/`; one global Volume per level, in that level's `_Environment` scene (or its optional `_Lighting` split scene when present, per [11](./11-scenes-prefabs-workflow.md)).
7. **MUST** keep the single `Main Camera` in `Bootstrap.unity` and its `HDAdditionalCameraData`. **HDRP has no camera stacking** — overlays are a uGUI canvas, a custom pass or a render texture (§7).
8. **MUST** use HDRP shaders only: `HDRP/Lit` by default, `HDRP/Unlit`, `HDRP/TerrainLit` for terrain, Shader Graph with an **HDRP target** for anything custom. Built-in and URP shaders render magenta; uGUI shaders must not include URP headers.
9. **MUST** keep materials SRP-Batcher compatible: no `MaterialPropertyBlock`, **Material Variants** for colour/texture variations, and `HDMaterial.ValidateMaterial` after every scripted material change (§9.2, §9.5).
10. **SHOULD** anti-alias with **SMAA**, **SMAA Quality Preset = High**, on `Main Camera`. **NEVER** TAA, MSAA, DLSS or FSR without a measured reason (§8).
11. **SHOULD** import textures per §10: only colour maps are sRGB, `Mask` maps are linear with **Alpha Is Transparency off**, normal maps use Texture Type **Normal map**.
12. **SHOULD** stay inside the per-level render budgets in §11.
13. **NEVER** change the HDRP asset, HDRP graphics settings, Quality or Graphics settings inside a feature commit — a settings change is its own `chore:` commit, made by the rendering owner and announced in the team channel.
14. **NEVER** enable ray tracing, SSGI, SSR, subsurface scattering, decals, the water system, volumetric clouds, high-quality volumetrics or dynamic resolution "just in case" — each costs memory, shader variants and build time (§2).
15. **NEVER** embed `com.unity.render-pipelines.high-definition-config`, and **NEVER** create Volume Profiles at runtime — edit overrides on an existing, saved profile instead (§6).

## 1. Pipeline assets and where they live

**MUST** use exactly this layout; the names are fixed and reviewers check them. **[project decision]**

```text
Assets/RootsDance/Settings/
  HDRP/HDRP_Desktop.asset                    # the HDRP Asset — pipeline features + memory allocation (§2)
  HDRP/HDRenderPipelineGlobalSettings.asset  # project-wide HDRP settings, referenced from Graphics > HDRP
  HDRP/DefaultVolumeProfile.asset            # Default Volume Profile: the lowest-priority global volume
  HDRP/DefaultLookDevProfile.asset           # LookDev Volume Profile (Editor look-dev window only)
  VolumeProfiles/MainProfile.asset           # Main level: Visual Environment, sky, fog, exposure, post (§6)
  VolumeProfiles/PlayerTestProfile.asset     # PlayerTest level
```

`Assets/HDRPDefaultResources/` (the folder the HDRP template and the Wizard create by default) is not used; everything project-owned lives under `Assets/RootsDance/` per [02](./02-project-structure.md).

**MUST** assign `HDRP_Desktop.asset` as **Edit > Project Settings > Graphics > Default Render Pipeline**, and assign the *same* asset explicitly to the `Desktop` quality level's **Render Pipeline Asset** (**Project Settings > Quality**).
- *Why:* The asset assigned in Graphics is the project's default HDRP Asset; a quality level without its own assignment falls back to that default, so an explicit assignment makes the level self-describing and survives level reordering. Both are read at load time — HDRP allocates memory for the features the asset enables, so they cannot be changed at runtime.
- *Source:* [create-an-hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdrp-asset.md), [quality-settings](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md).

**MUST** keep a valid `HDRenderPipelineGlobalSettings` asset referenced in **Project Settings > Graphics > Pipeline Specific Settings > HDRP**, together with the **Default Volume Profile** (`DefaultVolumeProfile.asset`) and the **LookDev Volume Profile** (`DefaultLookDevProfile.asset`).
- *Why:* The HDRP section of the Graphics window is where project-wide HDRP settings live: Frame Settings defaults, Custom Post Process Orders, shader-stripping settings and the two Volume Profiles. The Default Volume Profile is processed as a global volume with the lowest priority, so it is the safety net every scene inherits; if it is deleted, HDRP silently re-assigns the package's own `DefaultSettingsVolumeProfile`, which we do not control.
- *Source:* [default-settings-window](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-default-settings-window.md), [set-up-a-volume](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-up-a-volume.md), [understand-volumes](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md), template asset [HDRenderPipelineGlobalSettings.asset](../reference/rendering-hdrp/github-graphics-hdrenderpipelineglobalsettings-asset.md), [DefaultSettingsVolumeProfile.asset](../reference/rendering-hdrp/github-graphics-defaultsettingsvolumeprofile-asset.md).

**MUST** run **Window > Rendering > HDRP Wizard** after any change in this section and leave with **zero outstanding fixes**; commit `ProjectSettings/HDRPProjectSettings.asset` (which stores the Wizard's Default Resources Folder) with that change. **[project decision]**
- *Why:* The Wizard's HDRP tab checks exactly the things that break silently: an HDRP Asset assigned as Default Render Pipeline, a valid `HDRenderPipelineGlobalSettings` referenced in Graphics > HDRP, valid settings/resources inside it, a Default Volume Profile that is not the package's own, and Color Space = Linear. A red check means some scenes render with the Built-in pipeline fallback.
- *Source:* [render-pipeline-wizard](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-pipeline-wizard.md), [configure-a-project-using-the-hdrp-wizard](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-a-project-using-the-hdrp-wizard.md).

**NEVER** install the Universal Render Pipeline, the Built-in pipeline's Post Processing Stack v2, or a second pipeline asset "for the Web build".
- *Why:* "Projects made using HDRP aren't compatible with the Universal Render Pipeline (URP) or the Built-in Render Pipeline." HDRP needs compute shaders and does not support OpenGL or OpenGL ES; the supported targets are Windows (DX11/DX12, SM 5.0), macOS 10.13+ (Metal), Linux/Windows (Vulkan) and current consoles — i.e. exactly our desktop targets, and no mobile or Web.
- *Source:* [system-requirements](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md), [install-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-install-hdrp.md), [high-definition-render-pipeline](../reference/rendering-hdrp/manual-high-definition-render-pipeline.md), [configure-build-settings-for-different-platforms](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-build-settings-for-different-pla.md).

## 2. HDRP asset feature switches

**MUST** keep `HDRP_Desktop.asset` on this "HDRP-lite" configuration. Anything not listed stays at the value the asset was created with. **[project decision]**

| Setting (HDRP Asset section) | Value | Why |
|:--|:--|:--|
| Rendering > **Lit Shader Mode** | **Forward Only** | Forward uses the vertex normal for shadow bias (fewer artifacts), applies AO correctly to lightmaps/probes, and does not compress material properties into a GBuffer. Picking one mode instead of **Both** halves the Lit shader set. The HD template ships a different value — set it explicitly and verify in the Inspector. |
| Rendering > **Color Buffer Format** | **R11G11B10** | Half the memory of R16G16B16A16; we do not output alpha. Switch only if banding is visible in a capture. |
| Rendering > **Multisample Anti-aliasing Quality** | **None** | MSAA exists only under Forward, but it disables SSR and screen-space shadows and is far more expensive than the SMAA we use (§8). |
| Rendering > **Motion Vectors** | **On** (default) | Needed by TAA and motion blur; cheap to leave on and required if we ever measure a reason for either. |
| Rendering > **Custom Pass** | **On** | §4 is the only supported way to add rendering work. |
| Rendering > **Decals** | **Off** | Adds a DBuffer pass and an atlas we do not use; turn on only with approval (§9.1). |
| Rendering > **Realtime Raytracing (Preview)** | **Off** | Preview feature with hardware requirements our machines do not all meet. |
| Rendering > **Dynamic Resolution** | **Off** (no DLSS/FSR/STP) | Upscalers change the whole AA story and need per-camera work; out of scope for the jam. |
| Rendering > **LOD Bias** | **1** | Neutral; LOD tuning belongs to [05](./05-performance.md). |
| Lighting > **Screen Space Ambient Occlusion** | **On** | The one screen-space effect we keep; it is driven by an **Ambient Occlusion** volume override (§6) and adds contact darkening that probe lighting alone cannot give. |
| Lighting > **Screen Space Global Illumination** | **Off** | Expensive, noisy, and redundant next to APV. |
| Lighting > **Volumetrics** | **On** | Volumetric fog is the look (§5.8); the asset has no separate quality switch — volumetric quality is the level Fog override's **Quality** level (Medium in the level profiles). |
| Lighting > **Light Layers** | default | Not used; leave as created. |
| Lighting > **Lens Flare (data-driven)** | default | Not used yet, but cheap while no flare asset exists; leave as created. |
| Light Probe Lighting > **Light Probe System** | **Adaptive Probe Volumes** | §5.4. |
| Reflections > **Screen Space Reflection** (opaque and **Transparent**) | **Off** | The most expensive reflection technique; baked reflection probes plus sky reflection cover our surfaces (§5.7). |
| Lighting > Shadows > **Shadowmask** | default | We bake nothing yet (§5.3); revisit together with the Lighting Mode. |
| Shadows > shadow atlases and resolution tiers | defaults | Budgets in §11; per-light resolution comes from the tiers, not from raw numbers. |
| Material > **Subsurface Scattering** | **Off** | No skin or translucent hero material in this game. |
| Water, Volumetric Clouds | **Off** | Unused subsystems; both cost memory and variants, and the water system is incompatible with MSAA. |
| Post-processing > Grading LUT Size | **32** (default) | Good speed/quality balance; the size is fixed for the project, so decide before grading starts. |

- *Source:* [hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md), [forward-and-deferred-rendering](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-forward-and-deferred-rendering.md), [anti-aliasing](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-anti-aliasing.md), [volumetric-lighting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md), [override-ambient-occlusion](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-ambient-occlusion.md), [override-screen-space-reflection](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-reflection.md), [override-screen-space-gi](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-gi.md), [skin-and-diffusive-surfaces-subsurface-scattering](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-skin-and-diffusive-surfaces-subsurface-sca.md), [understand-decals](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-decals.md), [create-realistic-clouds-volumetric-clouds](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-realistic-clouds-volumetric-clouds.md), [water-use-the-water-system-in-your-project](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-water-use-the-water-system-in-your-project.md), [ray-tracing-getting-started](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ray-tracing-getting-started.md), [dynamic-resolution](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-dynamic-resolution.md), template asset [DefaultHDRPAsset.asset](../reference/rendering-hdrp/github-graphics-defaulthdrpasset-asset.md).

**MUST** treat **Frame Settings** as project-wide defaults, edited only in **Project Settings > Graphics > Pipeline Specific Settings > HDRP > Frame Settings (Default Values)** — for **Camera**, **Realtime Reflection** and **Baked or Custom Reflection** alike. **NEVER** tick **Custom Frame Settings** on `Main Camera` without a written reason in the PR. **[project decision]**
- *Why:* Frame Settings decide which passes a camera or reflection probe actually runs; a feature enabled in the HDRP Asset but disabled in Frame Settings is simply absent (SSAO and APV both need the matching Frame Setting). Keeping one set of defaults means the Game view, the Scene view and reflection captures agree. Baked reflection probes bake with the Frame Settings that were active at bake time.
- *Source:* [frame-settings](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings.md), [frame-settings-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings-reference.md), [override-ambient-occlusion](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-ambient-occlusion.md), [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md).

**Trade-off to know before arguing about §2:** Unity's shader-stripping page recommends **Deferred** as the Lit Shader Mode that produces the *fewest* variants; we accept Forward Only's larger variant set for quality and because MSAA remains available if we ever need it. If build time or shader memory becomes the measured problem, that is the row to revisit — in its own `chore:` commit.
- *Source:* [reduce-shader-variants](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md), [forward-and-deferred-rendering](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-forward-and-deferred-rendering.md).

## 3. Quality tiers

**MUST** keep exactly one quality level, **`Desktop`**, bound to `HDRP_Desktop.asset`, with every **Default Quality** per-platform entry pointing at it and no excluded platforms. **[project decision]**
- *Why:* Two tiers means two HDRP assets, two sets of shader variants and two configurations to keep in sync; HDRP's own template ships five levels (`Ray Tracing (Realtime GI)`, `Ray Tracing`, `High`, `Balanced`, `Performant`) and we deliberately do not inherit them. One level also makes "what the reviewer sees" unambiguous.
- *Source:* [quality-settings](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md), template [QualitySettings.asset](../reference/rendering-hdrp/github-graphics-qualitysettings-asset.md).

**MAY** add a second tier — `Desktop_Low` — only with a measured reason (a Profiler capture in the PR). Then, in one `chore:` commit: duplicate the HDRP asset as `Assets/RootsDance/Settings/HDRP/HDRP_Desktop_Low.asset`, lower **Volumetrics**, shadow atlas resolution and **Screen Space Ambient Occlusion**, add the Quality level, assign the asset to its **Render Pipeline Asset**, set the per-platform default, and record the diff in this section.
- *Why:* HDRP scales by "one HDRP Asset per platform or quality tier"; per-light shadow resolution then resolves through the tier names (Low/Medium/High/Ultra) in the active asset instead of raw numbers.
- *Source:* [quality-settings](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md), [hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md).

**NEVER** add a mobile or Web tier. HDRP has no mobile or WebGL path at all (§1); if the team ever wants a Web build, that is a pipeline decision, not a quality level.
- *Source:* [system-requirements](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md).

Switching quality at runtime (options menu) uses `QualitySettings.SetQualityLevel`; read the active asset with `GraphicsSettings.currentRenderPipeline as HDRenderPipelineAsset`. With a single level there is nothing to switch, so no such code exists today.

## 4. Custom rendering: custom passes and custom post-process

**NEVER** write a URP-style render pass. In HDRP the render graph is internal: "Unlike in the Universal Render Pipeline (URP), you can't use the render graph system to write custom render passes in HDRP. Use Custom Passes instead." `ScriptableRendererFeature`, `ScriptableRenderPass`, `RecordRenderGraph` and `AddBlitPass` do not exist for HDRP users.
- *Source:* [render-graph-introduction](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-graph-introduction.md).

**MUST** pick, in this order: a **Volume Override** (§6) → a **Custom Pass** on a `CustomPassVolume` → a **Custom Post Process**. Write C# only when the no-code options cannot express the effect.
- *Why:* A Custom Pass Volume already ships Full-screen, Draw Renderers and Object ID passes that need only a material; a Fullscreen Shader Graph (**Assets > Create > Shader Graph > HDRP > Fullscreen Shader Graph**) covers most screen effects without any pipeline code.
- *Source:* [custom-passes-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-passes-understand.md), [custom-pass-create-gameobject](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-create-gameobject.md), [create-a-fullscreen-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-fullscreen-material.md).

Custom Pass rules (all **MUST**):
- Live on a **Custom Pass Volume** GameObject in the level's `_Environment` scene, **Mode = Global** unless the effect is area-bound (then **Local** + a trigger collider + **Fade Radius**). Priority orders volumes that share an injection point; between two Globals the order is undefined, so never rely on it. *Source:* [custom-pass-volume-workflow](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-volume-workflow.md), [custom-pass-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-reference.md).
- Choose the **Injection Point** from the reference table (`BeforeRendering`, `AfterOpaqueDepthAndNormal`, `AfterOpaqueColor`, `AfterOpaqueAndSky`, `BeforePreRefraction`, `BeforeTransparent`, `BeforePostProcess`, `AfterPostProcess`) — each one exposes a different set of readable/writable buffers, and fog is applied *after* `AfterOpaqueAndSky`. *Source:* [custom-pass-injection-points](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-injection-points.md).
- Create the script from **Assets > Create > Rendering > HDRP C# Custom Pass** so it appears in the volume's pass list, and use the three entry points as intended: allocate in `Setup`, record GPU work in `Execute(CustomPassContext ctx)`, release **everything** in `Cleanup` (missing releases leak). *Source:* [custom-pass-scripting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-scripting.md).
- Use `CoreUtils.SetRenderTarget` rather than `CommandBuffer.SetRenderTarget`, and multiply UVs by `_RTHandleScale.xy` when sampling an `RTHandle` — otherwise the effect is scaled wrongly between Game and Scene view. *Source:* [custom-pass-troubleshooting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-troubleshooting.md).
- Keep the shader as `HDRP Custom FullScreen Pass` (**Assets > Create > Shader > HDRP Custom FullScreen Pass**) or a Fullscreen Shader Graph; never a Built-in or URP blit shader.
- Create `Scripts/Runtime/Rendering/` (namespace `RootsDance.Rendering`) with the first pass and, in the same commit, add the HDRP and SRP Core runtime assemblies to the `references` array of `RootsDance.Runtime.asmdef` ([02 §8](./02-project-structure.md)) — pick them from the asmdef Inspector rather than typing the names. **[project decision]**
- **MAY** register a pass without a GameObject via the static `CustomPassVolume.Register` / `UnRegister` API when the effect must not touch user scenes. *Source:* [global-custom-pass-api](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-global-custom-pass-api.md).

```csharp
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Rendering
{
    /// <summary>Runs a full-screen material over the camera colour. Add it to a Custom Pass Volume.</summary>
    public class FullScreenMaterialPass : CustomPass
    {
        private const string k_PassName = "RootsDance FullScreenMaterial";

        [SerializeField] private Material m_material;

        protected override void Setup(ScriptableRenderContext renderContext, CommandBuffer cmd)
        {
            // Allocate render textures, materials and compute buffers here — Cleanup() must release each one.
        }

        protected override void Execute(CustomPassContext ctx)
        {
            if (m_material == null)
            {
                return; // runs every frame per camera: no allocation, no logging spam
            }

            ctx.cmd.BeginSample(k_PassName);
            CoreUtils.DrawFullScreen(ctx.cmd, m_material, ctx.cameraColorBuffer, shaderPassId: 0);
            ctx.cmd.EndSample(k_PassName);
        }

        protected override void Cleanup()
        {
            // Release everything allocated in Setup.
        }
    }
}
```

Custom post-process rules (all **MUST**):
- Create the pair from the templates — **Assets > Create > Rendering > HDRP C# Post Process Volume** and **Assets > Create > Shader > HDRP > Post Process** — and give the C# file and the shader the **same name**, or update `kShaderName` in the script.
- Register the effect in **Edit > Project Settings > Graphics > Pipeline Specific Settings > HDRP > Custom Post Process Orders**, in the list for its `CustomPostProcessInjectionPoint` (`BeforeTransparent`, `BeforePostProcess`, `AfterPostProcess`). An effect that is not in a list never runs — and renaming the class or the file removes it from the list again.
- Add the effect to a scene by adding its component as a **Volume Override** on the level's Volume, like any other override.
- *Source:* [custom-post-processing-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-understand.md), [custom-post-processing-create-apply](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-create-apply.md), [custom-post-processing-scripts](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-scripts.md), [default-settings-window](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-default-settings-window.md).

The project's first custom post-process is `RootsDance.Rendering.PsxPostProcess` (`Scripts/Runtime/Rendering/`, shader `Shaders/PostProcess/PsxPostProcess.shader`), injection point **After Post Process**. Because `CustomPostProcessOrdersSettings` is `internal`, registration goes through the Editor tool **RootsDance > Rendering > Register PSX Post Process**, which writes the injection point's order list on `HDRenderPipelineGlobalSettings.asset` and adds the shader to **Always Included Shaders** on `GraphicsSettings.asset` through a `SerializedObject` — idempotent, and its two file changes land in one `chore(rendering):` commit. `RootsDance.Runtime.asmdef` now references `Unity.RenderPipelines.Core.Runtime` and `Unity.RenderPipelines.HighDefinition.Runtime`, per the project decision above. **[project decision]**

The custom override provides two mutually exclusive looks selected by `grainMode`. PSX mode runs pixelation → colour quantisation + Bayer dither → interlacing; Grain mode runs only monochrome noise, re-seeded `grainRate` times a second and biased into shadows by `grainShadowBias`. The authored pixel scale is the screen-pixel size at 1080p and scales with output height, so its visual granularity stays consistent across resolutions. `MainProfile` carries the level-wide PSX baseline (`OpeningAtmosphereParams.PsxBaseline`) and the opening's local volumes override it per checkpoint (`OpeningLook.Psx`); a new checkpoint is a local Volume with its own `PsxPostProcess` override, nothing more. **RootsDance > Rendering > Apply PSX Baseline** (batch: `OpeningAtmosphereBuilder.ApplyPsxBaselineFromCommandLine`) writes only the PSX override onto `MainProfile` and the four `Opening*Profile`s and removes HDRP's Film Grain from them, leaving fog, sky and exposure untouched; the opening builder's overwrite entry does the same as part of its reset. **[project decision]**

## 5. Lighting workflow

### 5.1 Colour space and physical light units

**MUST** keep **Edit > Project Settings > Player > Other Settings > Rendering > Color Space = Linear**, and **MUST** light in **physical units at real-world magnitudes** — 1 Unity unit = 1 metre.
- *Why:* "HDRP does not support gamma space, so your Project must use linear color space." Physical Light Units only behave correctly at the real scale, and they are what makes a fixed exposure (§5.2) transferable between scenes.
- *Source:* [create-an-hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdrp-asset.md), [physical-light-units](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md).

Unit per light type — HDRP fixes these, they are not a style choice:

| Light type | Units it accepts | What we use |
|:--|:--|:--|
| Directional | **Lux** only | Lux |
| Spot, Point | Lumen, Candela, Lux, EV100 | **Lumen** |
| Area (Rectangle, Tube) | Lumen, Nits, EV100 | Lumen |
| Material emission (`HDRP/Lit` **Emission Intensity**) | **Nits** or EV100 | Nits |
| Exposure | EV100 | EV100 |

- *Source:* [reference-light-component](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-light-component.md), [lit-material-inspector-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material-inspector-reference.md), [override-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-exposure.md).

Project convention table — the ranges an artist may pick from without asking. **[project decision]**, anchored on Unity's lighting-and-exposure cheat sheet:

| Situation | Value |
|:--|:--|
| Sun (Directional), clear day | 80 000 – 130 000 lux |
| Sun (Directional), overcast | 10 000 – 25 000 lux |
| Interior bulb (Point) | 600 – 1 700 lumen |
| Flashlight / practical (Spot) | 1 000 – 3 000 lumen |
| Emissive surface (`HDRP/Lit`) | 10 – 5 000 nits |
| Fixed exposure — sunny exterior | EV100 **14 – 15** |
| Fixed exposure — overcast exterior | EV100 **12 – 13** |
| Fixed exposure — dusk | EV100 **8 – 10** |
| Fixed exposure — lab interior | EV100 **5 – 7** |
| Fixed exposure — dark corridor | EV100 **2 – 4** |

Current scenes: `Sun` = **20 000 lux** in `PlayerTest`, colour temperature off, shadows on, Volumetrics **Multiplier = 1** — these were tuned by screenshot so mid-tones match the pre-migration baseline (nothing clipped, nothing black); in `Main`, the opening-atmosphere builder seeds `Sun` to **12 000 lux** (overcast), colour (1.00, 0.96, 0.88), angular diameter 6°, shadow dimmer 0.7, driven by `OpeningAtmosphereParams.Sun` — like the four Opening profiles, this is a first-pass seed value, only reapplied by a plain re-run while the Sun still carries its pre-branch 20 000 lux, and only reset once tuned by the explicit `Rebuild Opening Atmosphere Profiles (overwrite)` entry; the level profiles use **Fixed EV100 12.5**; Gradient Sky **Intensity Mode = Exposure, Exposure = 12**. **[project decision]**
- *Note:* Unity's illuminance table quotes "overcast sky at midday 1 000 – 2 000 lux" while its cheat sheet places "cloudy" at 20 000 lux; the ranges above follow the cheat sheet, which is the one calibrated against HDRP exposure.
- *Source:* [physical-light-units](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md) (lighting & exposure cheat sheet), [reference-light-component](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-light-component.md).

### 5.2 Exposure

**MUST** put an **Exposure** override with **Mode = Fixed** on every level Volume profile, and keep **Automatic** only in `DefaultVolumeProfile.asset` with **Limit Min 8 / Limit Max 16** as a safety net. **[project decision]**
- *Why:* Exposure is a Volume override expressed in EV100, so it interpolates with everything else; a fixed value makes the level's look reproducible and screenshot-comparable, while an auto-exposure that adapts differently on two machines makes "is this a regression?" unanswerable. The default profile's automatic mode with limits keeps a scene that forgot its Volume readable instead of white or black.
- *Source:* [override-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-exposure.md), [reference-override-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-override-exposure.md), [understand-volumes](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md).

**SHOULD** verify a new exposure value with the Rendering Debugger's **Scene EV100 Values** heat map (and **Histogram View** when tuning limits) before committing it, not by eye on one monitor.
- *Source:* [test-debug-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-test-debug-exposure.md), [use-the-rendering-debugger](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-the-rendering-debugger.md).

### 5.3 Light modes and Lighting Mode

**MUST** give each level exactly one Directional light, named **`Sun`**, in its `<Level>_Environment.unity` scene — never in a `_Gameplay` part (see [11](./11-scenes-prefabs-workflow.md)). Every Light GameObject carries HDRP's **HD Additional Light Data** component; Unity adds it automatically when the light is created in an HDRP project.
- *Why:* With additive scene loading Unity uses the **active** scene's rendering settings, so the level's environment part must own the lighting. Animating or scripting a light means touching the properties on `HDAdditionalLightData`, not the built-in `Light` values, which HDRP ignores.
- *Source:* [light-component](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-light-component.md), [setupmultiplescenes](../reference/project-structure/manual-setupmultiplescenes.md), [11 Scenes](./11-scenes-prefabs-workflow.md).

**MUST** keep every light **Realtime** while the levels change daily, and switch to **Mixed** + **Baked Global Illumination** only in the commit that starts baking APV data (§5.4). When that happens, the Lighting Mode is **Baked Indirect**; **Shadowmask** needs the HDRP asset switch from §2 and a per-light shadowmask mode, so it is a separate decision. **[project decision]**
- *Why:* Realtime lights have no bounce, which is exactly what APV will add; Baked and Mixed lights only contribute once someone bakes, and a stale bake is worse than no bake while geometry moves every day.
- *Source:* [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md), [lighting-mode-shadowmask](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lighting-mode-shadowmask.md).

### 5.4 Adaptive Probe Volumes

**MUST** keep **Light Probe System = Adaptive Probe Volumes** (Project Settings > Quality > HDRP > Lighting > Light Probe Lighting) and, once baking starts, give each level one APV in its `_Environment` scene: **GameObject > Light > Adaptive Probe Volumes > Adaptive Probe Volume**, **Mode = Global**. Memory Budget, SH Bands and streaming stay at their defaults.
- *Why:* APV places probes automatically and is Unity 6's probe system; it replaces hand-placed Light Probe Groups and their seams. It only works if the matching Frame Setting is on — **Frame Settings (Default Values) > Camera > Lighting > Adaptive Probe Volumes**, plus the same entry under **Realtime Reflection** and **Baked or Custom Reflection** so probes capture APV lighting too.
- *Source:* [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md), [probevolumes-concept](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-concept.md), [hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md).

**MUST** configure renderers so a bake stays cheap: large static architecture gets **Contribute Global Illumination = on** and **Receive Global Illumination = Light Probes**; props, debris and anything that moves keep Contribute GI **off**. Lights must be Mixed or Baked to be captured. Bake from **Window > Rendering > Lighting > Adaptive Probe Volumes** with **Baking Mode = Single Scene**, with the level's `_Environment` scene open and active. Baking is the scene owner's job ([11](./11-scenes-prefabs-workflow.md)).
- *Source:* [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md), [staticobjects](../reference/performance/manual-staticobjects.md).

### 5.5 Lightmaps (opt-in)

**MAY** lightmap a single hero surface when probe lighting is visibly too soft. Then, and only then: **Generate Lightmap UVs** on the model importer, **Receive Global Illumination = Lightmaps** on that renderer, and a resolution low enough that the bake stays under a few minutes. Everything else stays on probes.
- *Why:* Lightmaps cost UV space, bake time and memory, and HDRP does not use the ambient light probe for objects that already receive lightmap or probe lighting — mixing the two per level makes "why is this object darker?" hard to answer.
- *Source:* [ambient-lighting-configure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ambient-lighting-configure.md), [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md).

### 5.6 Shadows

**MUST** set shadow distance and cascades in the level Volume profile's **Shadows** override (`HDShadowSettings`): **Max Distance ≤ 150 m**, **Cascade Count = 4** (HDRP's default), splits left at their defaults unless a capture says otherwise. Per-light shadow resolution uses the named tiers from the HDRP asset (Low/Medium/High/Ultra), never a hand-typed number. **[project decision]**
- *Why:* Directional shadows render one shadow map per cascade and all real-time shadows share atlases sized in the HDRP asset, so distance × cascades × resolution is the whole cost. Tier names keep quality consistent across lights and survive a future second quality asset.
- *Source:* [override-shadows](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-shadows.md), [reference-shadows-volume-override](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-shadows-volume-override.md), [shadows-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md).

**NEVER** let a **Point** light cast shadows (six shadow maps per light), and keep **Contact Shadows** and micro shadows off by default.
- *Why:* Contact shadows are ray-marched in screen space and cost 0.5–1.3 ms on a base PS4 at 1080p; they also ignore **Cast Shadows = Off** on Mesh Renderers, so they can resurrect shadows you deliberately removed. Turn them on only for a specific shot, with a capture in the PR.
- *Source:* [shadows-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md), [override-contact-shadows](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-contact-shadows.md).

### 5.7 Reflection probes

**SHOULD** place one **Baked** Reflection Probe per visually distinct area (lab interior, tunnel, a different ground colour) and rely on sky reflection elsewhere; **NEVER** a Realtime probe without a measured reason.
- *Why:* HDRP's reflection hierarchy resolves per pixel: SSR (high cost, off here) → reflection probes (baked = low, realtime = medium-high) → sky reflection (weight 1, low). Baked probes plus sky cover our surfaces. Give a probe a **Reflection Proxy Volume** when parallax looks wrong.
- *Source:* [reflection-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-understand.md), [reflection-probe](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-probe.md).

### 5.8 Fog and volumetrics

**MUST** enable fog through the level profile's **Fog** override (**State = Enabled**) with **Volumetric Fog** on. Current values: `PlayerTestProfile` keeps **Fog Attenuation Distance = 400 m** (the mean free path — at that distance the fog has absorbed and out-scattered 63 % of the background), **Base Height = 0**, **Maximum Height = 60**, neutral **Tint (0.78, 0.80, 0.84)**, everything else default. `MainProfile` is seeded by the opening-atmosphere builder's overwrite entry (`OpeningAtmosphereParams.BeyondFog`): **40 m**, **Base Height 12** (above eye height, so density does not thin along the route), **Maximum Height 50**, **Tint white**, **Volumetric Fog Distance 400 m** (past everything the fog can show, so the volumetric/analytic hand-off never appears as a ring), **Multiple Scattering 0.8**, quality **Custom** (Manual, 33 % resolution, 128 slices, slice uniformity 0.5 — the Medium preset's grid reads as blocky smears in dense fog) — the haze that continues, milder, from the opening's Threshold volume (8 → 22 m) up to the lab. Keep **Tint** neutral on every profile: the analytic fog beyond the Volumetric Fog Distance is Sky Color × Tint while the volumetric part is lit in-scatter, and a tint ≠ 1 shows as a bright ring at that distance following the camera. **[project decision]**
- *Why:* HDRP fog is a height fog: constant below **Base Height**, exponential above it, with **Maximum Height** controlling the falloff rate. Global volumetric fog is both cheaper and better looking than scattering local volumes around, so it is the default and Local Volumetric Fog is the exception.
- *Source:* [understand-fog](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-fog.md), [create-a-global-fog-effect](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-global-fog-effect.md), [fog-volume-override-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-fog-volume-override-reference.md).

**MAY** add a **Local Volumetric Fog** component for a pocket of mist — the current levels have none (budget in §11): set **Single Scattering Albedo** and **Fog Distance** on the component, and keep **Volumetric Fog Distance** on the Fog override between the component's Distance Fade Start and End.
- *Why:* The volumetric grid is low resolution (240×135×64 at 1080p with the default quality), so the frustum range decides the quality; mismatched distances are the usual cause of slice artifacts and flickering lights. Fixes: **Blend Distance > 0**, **Slice Distribution Uniformity** 0.5–0.9, **Denoising Mode = Gaussian** for soft fog.
- *Source:* [create-a-local-fog-effect](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-local-fog-effect.md), [local-volumetric-fog-volume-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-local-volumetric-fog-volume-reference.md), [troubleshoot-fog](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-troubleshoot-fog.md).

**SHOULD** keep light shafts under control per light: **Volumetrics > Enable** on, **Multiplier** at 1, **Shadow Dimmer** at 0 for lights that do not need volumetric shadows (that skips the shadow-map sample). Volumetric fog ignores light rendering layers.
- *Source:* [volumetric-lighting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md), [reference-light-component](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-light-component.md), [understand-fog](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-fog.md).

### 5.9 Sky

**MUST** put a **Visual Environment** override on every level profile with **Sky Type = Gradient Sky**, **Ambient Mode = Dynamic**, **Background Clouds = None**, and a matching **Gradient Sky** override (**Intensity Mode = Exposure**). **[project decision]**
- *Why:* The Visual Environment decides which sky override HDRP actually reads — a Gradient Sky override without the matching Sky Type is ignored. **Dynamic** ambient means the ambient light follows whichever Volume the camera is in, which is what we want for per-level looks; **Static** would tie ambient to a baked sky in the Lighting window.
- *Source:* [set-the-type-of-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-the-type-of-sky.md), [visual-environment-volume-override-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-visual-environment-volume-override-referen.md), [create-a-gradient-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-gradient-sky.md), [gradient-sky-volume-override-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gradient-sky-volume-override-reference.md), [understand-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-sky.md).

**MAY** switch a level to **HDRI Sky** when the art direction asks for a photographic backdrop (one cubemap, cheap, exposure in EV100). **Physically Based Sky** is *not* a default: it brings planet settings, a sun disc driven by the Directional light and interaction with clouds and fog, i.e. a whole tuning surface we have no time for.
- *Source:* [create-an-hdri-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdri-sky.md), [create-a-physically-based-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-physically-based-sky.md).

### 5.10 Time of day (discrete phases)

**MUST** express time of day as the discrete `RootsDance.Core.TimeOfDay` value in the world state (`Day`, `Night`; set through `SetTimeOfDayCommand`), never as a clock, a rotating Sun or a Physically Based Sky. A level's `_Environment` scene carries one `TimeOfDayController` on `_Lighting/TimeOfDay` with a **global Volume at priority 20** (above every local volume) and one `TimeOfDayPresetSO` per phase (`Assets/RootsDance/Data/Config/TimeOfDay/`). `Day` has no profile — the level's authored look *is* day; `Night` blends `NightProfile.asset` to weight 1 and moves the Sun to moonlight (8 lux, cool colour, Volumetrics Multiplier 0.5) over 2 s. The controller's `Level Default` is the phase the level opens in (Main = Night); story triggers and Dev Play checkpoints change it through the same command. **[project decision]**
- *Why:* A weight-blended overlay profile keeps the level profile and the opening volumes as the single authored source: `NightProfile` overrides only **Exposure (Fixed, EV100 5)**, **Gradient Sky** colours/exposure, the Fog's **Albedo / Anisotropy / Multiple Scattering** and **Denoising = Gaussian** — never Reprojection, which re-draws last frame's volumetric buffer and stacks copies of a beam that moves with the player. Density lives in a second, *lower* Volume: `_Lighting/TimeOfDay/TimeOfDayBase` at **priority 5** with `NightBaseProfile` (Fog attenuation 20 m only), driven at the same weight — above `MainProfile`'s 40 m day haze, below the opening segments' 8 → 22 m boxes, so the authored ramp still wins inside them and the terrace gets the "beam in smoke" density. Both are *overlays*, not level profiles, so the §5.9 Visual Environment and §5.6 Shadows requirements do not apply to them. Sun intensity blends in log space (`TimeOfDayBlend.LerpLux`) because 12 000 → 33 lux spans decades.
- *Emissives under a different exposure:* nits authored for the day's EV 12.5 are ten stops over at EV 5 — the opening motes rendered as white discs sweeping through the flashlight beam. Every emissive prop that must survive a phase change carries `EmissiveExposureFollower`, which rescales its material instance's `_EmissiveColor` by `EmissiveExposure.Scale(authoredEv, currentEv)` from the Volume stack's fixed exposure; the VFX prefab builder adds it to the motes. Author nits for one EV and let the follower do the rest — never hand-tune an emissive per phase.
- *How to (re)build:* `RootsDance > Environment > Build Time Of Day` seeds the assets once and rewires the scene; `Rebuild Time Of Day Profile (overwrite)` resets the seed values (batch: `TimeOfDayBuilder.BuildFromCommandLine` / `RebuildFromCommandLine`, `BuildAllFromCommandLine` also installs the flashlight and sets the Dev Play checkpoints to Night). `Capture Time Of Day Viewpoints` renders every checkpoint at night with a stand-in flashlight into `Logs/Captures/TimeOfDay/`.
- *Source:* [understand-volumes](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md), [override-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-exposure.md), [fog-volume-override-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-fog-volume-override-reference.md).

**SHOULD** give the player's flashlight exactly this shape: a **Spot** on the Player prefab's `Head/Flashlight`, **2 200 lumen**, 36° cone (inner 20°), range 30 m, colour temperature 5 000 K, shadows on at the Medium tier, **Volumetrics on, Multiplier 1, Shadow Dimmer 0**. It is one of the four volumetric lights in the §11 budget. `FlashlightController` switches it on when the phase becomes Night, toggles it on `Player/Flashlight` (F / D-pad up), and **snaps the Light to the game camera's exact pose in `RenderPipelineManager.beginCameraRendering`**; installed by `RootsDance > Player > Install Flashlight`. **[project decision]**
- *Why:* The cone in the volumetric fog is the night look; per-light volumetric shadows would sample the shadow map per froxel for no visible gain at this range (§5.8). The camera snap is not cosmetic: the Cinemachine hard-lock trails `Head` by a centimetre or two while walking, and a volumetric spot whose origin sits even that far *in front of* the near plane has HDRP integrate the near-singular irradiance around it — the whole view goes white the instant the player moves. At the camera's own pose that region is never rendered. Never parent a volumetric light to anything the camera merely follows.
- *Source:* [volumetric-lighting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md), [physical-light-units](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md).

## 6. Post-processing via Volumes

**MUST** set up post-processing per level exactly like this: the level's `_Environment` scene (or its optional `_Lighting` split scene when present, per [11](./11-scenes-prefabs-workflow.md)) holds one **GameObject > Volume > Global Volume** named `Global Volume`, **Is Global** on, **Priority 0**, whose **Profile** is `Assets/RootsDance/Settings/VolumeProfiles/<Context>Profile.asset` (`MainProfile.asset`, `PlayerTestProfile.asset`); effects are **Add Override** entries on that profile. `Bootstrap.unity`, `MainMenu.unity` and every `_Gameplay` part contain no Volume. **[project decision]**
- *Why:* HDRP evaluates every enabled Volume by camera position and interpolates; the two default volumes (the project's Default Volume Profile and the HDRP asset's quality profile) sit at the lowest priority, so a level's Global Volume always wins. Keeping one Volume per level in one scene means one file to merge and one place to look.
- *Source:* [understand-volumes](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md), [set-up-a-volume](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-up-a-volume.md), [volume-component](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volume-component.md), [create-a-volume-profile](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-volume-profile.md), [post-processing-main](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-main.md).

Allowed overrides on a level profile — this is the canonical set; [05 §6.4](./05-performance.md) links here rather than listing effects. **[project decision]**

| Override | Setting we use |
|:--|:--|
| **Exposure** | Mode Fixed, EV100 per §5.1 |
| **Visual Environment** + **Gradient Sky** | §5.9 |
| **Fog** | §5.8 |
| **Shadows** (`HDShadowSettings`) | §5.6 |
| **Ambient Occlusion** (SSAO) | intensity 0.6, Quality Medium; the HDRP asset switch is on (§2) |
| **Tonemapping** | **Neutral** (ACES only if the art direction asks and everyone re-grades) |
| **Bloom** | Quality Medium, intensity 0.1, threshold 0, scatter 0.7, **High Quality Filtering on** |
| **Color Adjustments** | post-exposure, contrast, saturation |
| **White Balance** | temperature/tint, for scene mood |
| **Vignette** | mild |
| **Film Grain** | **not used** in level profiles that carry `PsxPostProcess`; MAY still be used on a profile that has no custom override |
| **RootsDance PSX** (custom, `PsxPostProcess`) | `grainMode` selects either PSX pixelation / colour levels / Bayer dither / interlacing or grain intensity / size / rate / shadow bias; `MainProfile` currently keeps PSX mode always on, with local opening volumes overriding it per checkpoint |

Disallowed by default (need an art reason and a capture in the PR): **Motion Blur**, **Depth of Field**, **Chromatic Aberration**, **Lens Distortion**, **Panini Projection**, **Screen Space Reflection**, **Screen Space Global Illumination**, **Contact Shadows**.
- *Why:* Motion blur and depth of field are the two heaviest post effects in HDRP and both need motion vectors or a focus setup; the lens effects are look-specific and read as "shipped by accident" when nobody tuned them. Tonemapping is required for any HDR value above 1 to land on screen, which is why it is in the allowed set and not optional.
- *Source:* [post-processing-tonemapping](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-tonemapping.md), [post-processing-bloom](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-bloom.md), [post-processing-color-adjustments](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-color-adjustments.md), [post-processing-white-balance](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-white-balance.md), [post-processing-vignette](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-vignette.md), [post-processing-film-grain](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-film-grain.md), [post-processing-motion-blur](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-motion-blur.md), [post-processing-depth-of-field](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-depth-of-field.md), [configure-volume-overrides](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-volume-overrides.md).

**MAY** add a local **Box Volume** (collider **Is Trigger**, higher **Priority**) for an area look. Set the camera's **Volume Anchor Override** to the player Transform if a future camera ever sits far from the player, so the player's position selects the volume. The 00章室外 atmosphere (`docs/design/00章室外环境设计_起始点至检修通道前.md`) uses this pattern: the existing four local Box Volumes `OpeningVolume_{Wake,Ridge,Camp,Threshold}` sit under `_Lighting/OpeningAtmosphere` in `Main_Environment`, each pointing at its own `Opening{Wake,Ridge,Camp,Threshold}Profile` in `Settings/VolumeProfiles/`. The A-E revision extends this with continuously blended C/D/E volumes while preserving one exposure and PSX baseline. Existing profiles are seeded only when created; an explicit overwrite command is required to reset artist-tuned profiles.
- *Source:* [set-up-a-volume](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-up-a-volume.md), [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md).

**NEVER** create or instantiate a Volume Profile at runtime, and **NEVER** script a change into `DefaultVolumeProfile.asset` or the HDRP asset's quality profile.
- *Why:* Unity caches the default and quality profiles at startup, so writes to them from script simply do nothing (recaching via `VolumeManager.instance.OnVolumeProfileChanged` costs interpolation performance). Runtime changes belong on the level's Global Volume, where nothing is cached — enable the property on the override first, then write it through the [Volumes API](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-api.md).
- *Source:* [volumes-troubleshooting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-troubleshooting.md), [volumes-api](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-api.md), [understand-volumes](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md).

## 7. Cameras and Cinemachine

**MUST** keep the single `Main Camera` defined in [09 §Cinemachine 3.1](./09-packages-systems.md) — one `Camera` tagged `MainCamera`, with `CinemachineBrain`, `AudioListener` and HDRP's `HDAdditionalCameraData`, living in `Bootstrap.unity` per [11](./11-scenes-prefabs-workflow.md); content scenes hold only `CinemachineCamera`s. On it: **Post Anti-aliasing = Subpixel Morphological Anti-aliasing (SMAA)** with **SMAA Quality Preset = High**, **Dithering** on, **Background Type = Sky**, **Custom Frame Settings** off, **Physical Camera** off. **[project decision]**
- *Why:* HDRP stores those extra properties on `HDAdditionalCameraData`, so scripts read them there, not on `Camera`. Dithering reduces banding on wide gradients and dark areas — which is where an R11G11B10 colour buffer (§2) shows it. Physical Camera would tie exposure and depth of field to sensor/aperture values nobody is maintaining.
- *Source:* [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md), [frame-settings](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings.md). Cinemachine usage (Follow, blends, impulse) is owned by [09](./09-packages-systems.md).

**NEVER** add a second camera for the HUD, a weapon view or a "cutscene camera": **HDRP has no camera stacking**. "HDRP only supports a single Camera setup by default." When something genuinely needs a second view, the supported options are, in order of preference:
1. A **Screen Space – Overlay** uGUI canvas — it renders without a camera, and HDRP applies no post-processing to it ([09](./09-packages-systems.md#ugui-runtime-ui)).
2. A **Custom Pass** (§4) — e.g. inject **After Post Process** to blur the scene behind an open menu.
3. A camera rendering into a **Render Texture** shown on a UI Raw Image (3D model inside 2D UI).
4. The **Graphics Compositor**, only if 1–3 cannot do it and the rendering owner agrees.
- *Why:* HDRP renders UI in the transparent pass, *before* post-processing, so the usual "post effect behind the UI" trick has to be a custom pass. HDRP also supports only **Unlit** UI shaders on a Canvas.
- *Source:* [best-practices-for-ui-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-best-practices-for-ui-in-hdrp.md), [custom-passes-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-passes-understand.md).

**NEVER** set **Background Type = None** (the colour buffer is left uninitialized — it may show the previous frame or another camera), and **NEVER** enable **Stop NaNs** except to hunt a NaN bug; it is a resource-intensive full-screen pass.
- *Source:* [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md).

## 8. Anti-aliasing and HDR

**SHOULD** anti-alias with **SMAA, Quality Preset High**, on `Main Camera`. **NEVER** TAA, MSAA, DLSS or FSR2 without a measured reason in the PR. **[project decision]**
- *Why:* Anti-aliasing in HDRP is per camera. SMAA is much sharper than FXAA and suits flat, stylised art; the cost difference between its Low and High presets is small. TAA needs motion vectors, ghosts on fast movers, and is incompatible with MSAA and dynamic resolution. MSAA only exists under Forward and disables SSR and screen-space shadows, and is far more expensive than a post-process AA pass. DLSS/FSR2 require the dynamic-resolution machinery we switched off in §2.
- *Source:* [anti-aliasing](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-anti-aliasing.md), [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md), [dynamic-resolution](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-dynamic-resolution.md), [how-to-performance-optimization-high-end-graphics](../reference/performance/how-to-performance-optimization-high-end-graphics.md).

**MUST** keep **HDR display output off** (Project Settings > Player) and the HDRP asset's **Color Buffer Format = R11G11B10** (§2). HDRP always renders in high dynamic range internally and tonemaps to SDR; "HDR output" here means driving an HDR *monitor*, which we neither test nor ship.
- *Source:* [hdrp-asset](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md), [post-processing-tonemapping](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-tonemapping.md).

## 9. Materials and shaders

### 9.1 Choosing a shader

| Need | Shader | Notes |
|:--|:--|:--|
| Any lit surface (default) | **HDRP/Lit** | New materials use it automatically. Metallic workflow, **Material Type = Standard**, mask map per §9.1 table below. |
| Unlit props, world-space UI quads, effects | **HDRP/Unlit** | No lighting; also the only shading model HDRP supports on a uGUI Canvas. |
| Terrain | **HDRP/TerrainLit** | Up to **eight Terrain Layers**; our `Terrain_Main.mat` has mask maps on, **Enable Per-pixel Normal** on (requires `Terrain.drawInstanced = true`), **Enable Height-based Blend** off. |
| Blending two full material sets on one mesh | **HDRP/LayeredLit** | Approval only — it multiplies texture slots and variants. |
| Decals | **HDRP/Decal** | Approval only; Decals are off in the HDRP asset (§2). |
| Anything custom | **Shader Graph** with an **HDRP** target (Lit / Unlit / Fullscreen) | §9.3. |

- *Why (terrain):* HDRP's TerrainLit reads the terrain-layer **Mask Map** as **R metallic, G ambient occlusion, B height, A smoothness** — identical to URP's, which is why the layer textures survived the migration untouched. Height-based blend would take the blue channel as a height and re-blend the layers, changing the look; per-pixel normal preserves distant detail but only works with instanced drawing.
- *Source:* [lit-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material.md), [unlit-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-unlit-material.md), [terrain-lit-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material.md), [terrain-lit-material-inspector-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material-inspector-reference.md), [class-TerrainLayer](../reference/rendering-hdrp/manual-class-terrainlayer.md), [layered-lit-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-layered-lit-material.md), [material-type](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-material-type.md), [best-practices-for-ui-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-best-practices-for-ui-in-hdrp.md).

Mask map channels — the single most-confused table on the project:

| Channel | `HDRP/Lit` **Mask Map** | `HDRP/TerrainLit` terrain-layer **Mask Map** |
|:--|:--|:--|
| **R** | Metallic | Metallic |
| **G** | Ambient occlusion | Ambient occlusion |
| **B** | Detail mask | **Height** |
| **A** | Smoothness | Smoothness |

- *Source:* [mask-map-and-detail-map](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-mask-map-and-detail-map.md), [class-TerrainLayer](../reference/rendering-hdrp/manual-class-terrainlayer.md).

**MUST** keep **Surface Type = Opaque** unless the material really blends; a transparent material is more expensive, is always rendered in forward, and needs a deliberate **Blending Mode** and **Rendering Pass**. Prefer **Alpha Clipping** on an opaque material to a transparent one for foliage and grates. Emission uses **Emission Intensity** in **nits** (§5.1).
- *Source:* [surface-type](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-surface-type.md), [alpha-clipping](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-alpha-clipping.md), [forward-and-deferred-rendering](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-forward-and-deferred-rendering.md), [lit-material-inspector-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material-inspector-reference.md).

**NEVER** assign a Built-in (`Standard`, `Legacy Shaders/*`), URP (`Universal Render Pipeline/*`) or Asset-Store non-HDRP shader; they render magenta (§12). Sort transparents with the material's **Sorting Priority** / the renderer's priority, not by shuffling render queues by hand.
- *Source:* [convert-materials-and-shaders-to-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-convert-from-built-in-convert-materials-an.md), [renderer-and-material-priority](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-renderer-and-material-priority.md).

### 9.2 SRP Batcher compatibility

**MUST** keep every renderer on the SRP Batcher path: mesh or skinned mesh, shared materials, **no `MaterialPropertyBlock`**, and as few *shader variants* as possible (many materials on one shader is fine — that is the point of the batcher). Check the "SRP Batcher: compatible" line in a shader's Inspector.
- *Why:* The SRP Batcher keeps material constant buffers resident on the GPU and only re-binds them when the shader variant changes, so variant count — not material count — is what breaks batching.
- *Source:* [srpbatcher](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md), [optimizing-draw-calls-choose-method](../reference/performance/manual-optimizing-draw-calls-choose-method.md).

**SHOULD** switch off Lit features a material does not use (Emission, Height Map, Detail maps, Environment Reflections on matte surfaces) — each is a keyword, and each keyword is another variant to compile, strip and batch. Material sharing, Material Variants and the GPU Instancing checkbox: [05 §6.1](./05-performance.md).
- *Source:* [reduce-shader-variants](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md), [modify-materials-at-runtime](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md).

### 9.3 Shader Graph conventions

- **MUST** create graphs from **Assets > Create > Shader Graph > HDRP > Lit / Unlit / Fullscreen Shader Graph**, or add the **HDRP** target under **Graph Settings > Active Targets** and pick the **Material** type there. A graph without an HDRP target renders magenta. *Source:* [use-shader-graph-to-create-hdrp-shaders](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-shader-graph-to-create-hdrp-shaders.md), [understand-shader-graph-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-shader-graph-in-hdrp.md).
- **MUST** save graphs under `Assets/RootsDance/Shaders/` with their material next to it in `Materials/` ([02](./02-project-structure.md)), and name the primary inputs `_BaseColorMap` (Texture2D) and `_BaseColor` (Color) so materials stay interchangeable with `HDRP/Lit`; other reference names `_PascalCase` with a leading underscore. **[project decision]**
- **SHOULD** remember that enabling a setting in **Graph Settings** adds its Blocks automatically, and that a Block you add without enabling its setting is ignored when the shader is built — so read the Master Stack, not the node graph, when a value seems to have no effect. *Source:* [understand-shader-graph-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-shader-graph-in-hdrp.md), [lit-master-stack-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-master-stack-reference.md).
- **SHOULD** keep graphs small: delete unused nodes, do not wire defaults, move shared logic into Sub Graphs (`Shaders/SubGraphs/`). *Source:* [how-to-performance-optimization-high-end-graphics](../reference/performance/how-to-performance-optimization-high-end-graphics.md).

### 9.4 Hand-written HLSL (last resort)

**MUST** be an HDRP shader if it is lit: SubShader tagged for HDRP, `#include` files from `Packages/com.unity.render-pipelines.high-definition/…` (custom passes include `…/Runtime/RenderPipeline/RenderPass/CustomPass/CustomPassCommon.hlsl`), material properties inside `CBUFFER_START(UnityPerMaterial) … CBUFFER_END`. **NEVER** mix Built-in (`UnityCG.cginc`) or URP (`com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl`) includes into an HDRP shader.
- *Why:* HDRP's lit shading model is not something to re-derive by hand — Shader Graph with the HDRP target is the supported path, and hand-written HLSL is reserved for full-screen custom passes and post-process shaders, which have their own templates (§4). Pipeline-agnostic uGUI shaders are the one exception: they use only SRP Core (`com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl`) or plain Built-in macros, and no pipeline tag.
- *Source:* [custom-pass-scripting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-scripting.md), [custom-post-processing-create-apply](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-create-apply.md), [use-shader-graph-to-create-hdrp-shaders](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-shader-graph-to-create-hdrp-shaders.md).

### 9.5 Creating and changing materials from code

**MUST** call `HDMaterial.ValidateMaterial(material)` after any scripted change to an HDRP material, and use the `HDMaterial` helpers (`SetSurfaceType`, `SetAlphaClipping`, `SetAlphaCutoff`, `SetEmissiveColor`, …) instead of writing the underlying properties by hand.
- *Why:* Changing a property in the Inspector runs a validation step that sets keywords, passes and dependent properties; a script does not, so the material keeps rendering with the old keywords (no normal map, no alpha clip, no emission) until it is validated. Some HDRP properties are not independent — the helpers exist precisely to set all the required state together.
- *Source:* [modify-materials-at-runtime](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md), [hdrp-features](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-features.md).

```csharp
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace RootsDance.Rendering
{
    /// <summary>Creates HDRP Lit materials for Editor tooling. Runtime code shares materials
    /// instead (05 §6.1).</summary>
    public static class LitMaterialFactory
    {
        private static readonly int k_BaseColor = Shader.PropertyToID("_BaseColor");

        public static Material CreateOpaque(Color baseColor)
        {
            Material material = new Material(Shader.Find("HDRP/Lit"));
            material.SetColor(k_BaseColor, baseColor);
            HDMaterial.SetSurfaceType(material, transparent: false);
            HDMaterial.ValidateMaterial(material); // sets the keywords the Inspector would have set
            return material;
        }
    }
}
```

**NEVER** rely on a keyword combination that no committed material uses: Unity only builds the variants the project's materials need, so a keyword first enabled at runtime can land on a stripped variant.
- *Source:* [modify-materials-at-runtime](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md), [reduce-shader-variants](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md).

## 10. Texture import settings that affect rendering

Map names follow `<Asset>_<Map>.png` with Map ∈ **`BaseMap`, `Normal`, `Mask`, `Emission`, `Height`** ([02](./02-project-structure.md) and the art pipeline doc own the naming; this table owns the import settings).

| Map | Texture Type | sRGB (Color Texture) | Other |
|:--|:--|:--|:--|
| `BaseMap` | Default | **On** | Alpha carries opacity/clip only when the material uses it |
| `Emission` | Default | **On** | Intensity comes from the material, in nits (§5.1) |
| `Normal` | **Normal map** | Off (implied) | Tangent space; BC7/BC5/DXT5nm |
| `Mask` | Default | **Off** | **Alpha Is Transparency = off** — the alpha channel is smoothness, not opacity |
| `Height` | Default | **Off** | Only for materials that use displacement or terrain height blend |
| Terrain-layer maps | as above per map | as above | Terrain `Mask` = R metallic, G AO, **B height**, A smoothness (§9.1) |
| UI sprites, canvas images | Sprite (2D and UI) | On | Author in linear-correct sources; HDRP UI is Unlit only |

- *Why:* HDRP's own instruction for mask and detail maps is explicit: "make sure you disable **sRGB (Color Texture)** and you set **Texture Type** to **Default**". A data map marked sRGB is gamma-decoded by the linear pipeline and shades wrongly; leaving `alphaIsTransparency` on a mask map makes Unity pre-process an alpha channel that is really smoothness.
- *Source:* [mask-map-and-detail-map](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-mask-map-and-detail-map.md), [lit-material-inspector-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material-inspector-reference.md), [best-practices-for-ui-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-best-practices-for-ui-in-hdrp.md), [how-to-mobile-game-optimization-tips-part-1](../reference/performance/how-to-mobile-game-optimization-tips-part-1.md).
- Size, Max Size, compression format, Read/Write and mipmap rules: [05 §7.1](./05-performance.md).

## 11. Render budgets

Per level — its `_Environment` scene — per camera view. This table is the canonical render budget; [05 §6.4](./05-performance.md) links here.

| Item | Budget | Why / source |
|:--|:--|:--|
| Directional lights | **1** (`Sun`, lux) | §5.3 **[project decision]** |
| Punctual lights visible at once | **≤ 8** | Every visible light costs; keep the count reviewable [05](./05-performance.md) **[project decision]** |
| Shadow-casting punctual lights | **≤ 4**, spot only; point lights never | A point light renders six shadow maps [shadows-in-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md) |
| Lights with **Volumetrics > Enable** | **≤ 4** | Volumetric lighting is evaluated on a low-resolution 3D grid [volumetric-lighting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md) |
| Local Volumetric Fog components | **≤ 4** | Global fog first; local fog is the exception [create-a-local-fog-effect](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-local-fog-effect.md) |
| Shadow **Max Distance** / **Cascade Count** | **≤ 150 m** / **4** | §5.6 [reference-shadows-volume-override](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-shadows-volume-override.md) |
| Custom Pass Volumes | **≤ 2** | Each adds passes and buffers §4 **[project decision]** |
| Reflection probes | **≤ 8**, all **Baked**; Realtime **0** | Baked is low cost, realtime medium-high [reflection-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-understand.md) |
| Post-processing overrides | the §6 allowed set | [post-processing-main](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-main.md) |
| Active cameras | **1** | HDRP has no camera stacking §7 |
| Contact shadows / micro shadows | **0** | 0.5–1.3 ms on a base PS4 at 1080p [override-contact-shadows](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-contact-shadows.md) |

Check with the **Rendering Debugger** (**Window > Analysis > Rendering Debugger**) — Lighting, Volume and Frame Settings panels — and the Frame Debugger; frame-time measurement and CPU/GPU budgets live in [05](./05-performance.md).
- *Source:* [use-the-rendering-debugger](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-the-rendering-debugger.md), [rendering-debugger-window-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-rendering-debugger-window-reference.md).

## 12. When something renders pink, black or invisible

Work through the list top to bottom; stop at the first hit.

**Pink / magenta (error shader):**
1. The material uses a Built-in, URP or other non-HDRP shader → re-assign `HDRP/Lit` (or the right HDRP shader) and run **HDMaterial.ValidateMaterial**; for an imported pack, **Edit > Rendering > Materials > Convert Selected Built-in Materials to HDRP**. Custom shaders are not converted — port them (§9.4) or rebuild them in Shader Graph. *Source:* [convert-materials-and-shaders-to-hdrp](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-convert-from-built-in-convert-materials-an.md), [modify-materials-at-runtime](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md).
2. A Shader Graph without an **HDRP** target, or with the wrong **Material** type → fix it in **Graph Settings** and re-save. *Source:* [use-shader-graph-to-create-hdrp-shaders](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-shader-graph-to-create-hdrp-shaders.md).
3. Magenta **terrain** → the Terrain's **Material** is not an `HDRP/TerrainLit` material; assign `Assets/RootsDance/Materials/Terrain/Terrain_Main.mat` in **Terrain Settings**. *Source:* [terrain-lit-material](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material.md).
4. No HDRP asset active, or a missing `HDRenderPipelineGlobalSettings` → the project is rendering with the Built-in fallback. Open the **HDRP Wizard** and fix every red check (§1). *Source:* [render-pipeline-wizard](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-pipeline-wizard.md).
5. Shader compile error in the Console → fix the shader; a stale "array size" error after a package upgrade is fixed by restarting the Editor. *Source:* [known-issues](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-known-issues.md).

**Black or far too dark / too bright:**
1. Exposure vs light units mismatch — the usual cause. Check the level Volume's **Exposure** override (Fixed EV100) against the `Sun` intensity in lux (§5.1), then confirm with the **Scene EV100 Values** debug view. A scene lit at 20 000 lux and exposed at EV100 4 is white; the same scene at EV100 18 is black. *Source:* [test-debug-exposure](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-test-debug-exposure.md), [physical-light-units](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md).
2. No sky: the level profile has no **Visual Environment** override, or its **Sky Type** does not match the sky override present → §5.9. With no valid sky and **Background Type = Sky**, the camera clears to **Background Color**. *Source:* [set-the-type-of-sky](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-the-type-of-sky.md), [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md).
3. Fog too dense: **Fog Attenuation Distance** far below the scene scale, or **Max Fog Distance** shorter than the camera's far clip plane (which makes the sky and the geometry disagree). *Source:* [fog-volume-override-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-fog-volume-override-reference.md), [troubleshoot-fog](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-troubleshoot-fog.md).
4. A Volume override you edited does nothing → its checkbox is off, the Volume's layer is not in the camera's **Volume Layer Mask**, another Volume has higher **Priority**, or you wrote to a *cached* default/quality profile from script (§6). *Source:* [configure-volume-overrides](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-volume-overrides.md), [volumes-troubleshooting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-troubleshooting.md).
5. Objects unlit or blotchy after a bake → APV Frame Setting off, the light is Realtime while the object receives probes, or Contribute GI was never enabled (§5.4). *Source:* [probevolumes-use](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md).

**Invisible:**
1. A transparent material that never draws → **Surface Type**, **Blending Mode** and **Rendering Pass** disagree (e.g. **Before Refraction** on an opaque pass, or **After post-process** on a Lit material — that option is Unlit-only). *Source:* [surface-type](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-surface-type.md).
2. Transparent objects sorting behind each other → set **Sorting Priority** on the material or the renderer. *Source:* [renderer-and-material-priority](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-renderer-and-material-priority.md).
3. A custom pass that draws nothing → wrong **Injection Point** for the buffers it reads, `Mode = Local` with the camera outside the collider, or the volume disabled. *Source:* [custom-pass-injection-points](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-injection-points.md), [custom-pass-volume-workflow](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-volume-workflow.md).
4. A custom post-process that never runs → it is not registered in **Graphics > HDRP > Custom Post Process Orders**, or it was renamed and dropped off the list. *Source:* [custom-post-processing-create-apply](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-create-apply.md), [custom-post-processing-understand](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-understand.md).
5. An effect scaled or offset between Game and Scene view → missing `_RTHandleScale.xy` in the pass's shader, or `CommandBuffer.SetRenderTarget` instead of `CoreUtils.SetRenderTarget` (§4). *Source:* [custom-pass-troubleshooting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-troubleshooting.md).
6. Objects on a layer excluded by the camera's **Culling Mask**, or reflections missing because of **Probe Layer Mask**. *Source:* [hdrp-camera-component-reference](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md).

**Console errors with nothing wrong on screen:**
1. A burst of `NullReferenceException` at `RenderPipelineResourcesEditorUtils.TryReloadContainedNullFields` (called from `RenderPipelineGraphicsSettingsManager.PopulateRenderPipelineGraphicsSettings` / `HDRenderPipelineGlobalSettings.Ensure`) → HDRP's global settings tried to reload their resource fields while the package's shaders were still importing (the same log shows `Hidden/HDRP/TerrainLit_Basemap not found`). Seen once on this project, 2026-08-27, when the open Editor picked up the HDRP migration (≈40 identical entries). Clear the Console and restart the Editor; if the errors come back on a clean start, open the **HDRP Wizard** and report it to the rendering owner instead of clicking Fix All. *Source:* observed in `~/Library/Logs/Unity/Editor.log` on 2026-08-27; not covered by the Unity docs.

## Anti-patterns

- ❌ A `ScriptableRendererFeature` or a `RecordRenderGraph` pass ported from a URP tutorial → ✅ a `CustomPass` on a `CustomPassVolume`, or a `CustomPostProcessVolumeComponent` registered in Graphics > HDRP (§4).
- ❌ `Graphics.Blit` / `CommandBuffer.Blit` in a pass → ✅ `CoreUtils.DrawFullScreen` / `CoreUtils.SetRenderTarget` with `_RTHandleScale.xy` in the shader (§4).
- ❌ A second Quality level ("Ultra", "Mobile") or a second HDRP asset "just in case" → ✅ the single `Desktop` tier; a second tier needs a measured reason and a `chore:` commit (§3).
- ❌ A second Unity `Camera` for the HUD, the weapon or a cutscene → ✅ one `Main Camera`; overlays are a canvas, a custom pass or a render texture (§7).
- ❌ Intensities typed until it "looks right" (a 3-lux sun, a 500 000-lumen bulb) → ✅ real-world magnitudes from the §5.1 table, with exposure doing the rest.
- ❌ Auto-exposure left on in a level profile so screenshots never match → ✅ **Fixed** EV100 per level; Automatic only in `DefaultVolumeProfile.asset` with limits 8–16 (§5.2).
- ❌ A Gradient Sky override added without setting **Sky Type** in **Visual Environment** → ✅ both, on the same profile (§5.9).
- ❌ Post-processing tweaked by editing `DefaultVolumeProfile.asset` or the HDRP asset's quality profile, or by `ScriptableObject.CreateInstance` at runtime → ✅ the level's `Global Volume` and its saved `<Context>Profile` (§6).
- ❌ A material re-shadered from script and left un-validated (no normal map, no emission, no alpha clip) → ✅ `HDMaterial.*` helpers + `HDMaterial.ValidateMaterial` (§9.5).
- ❌ A `Mask` texture imported as sRGB, or with **Alpha Is Transparency** on → ✅ Default type, sRGB off, alpha-is-transparency off (§10).
- ❌ Terrain assigned the URP or package `TerrainLit.mat` after a merge → ✅ `Assets/RootsDance/Materials/Terrain/Terrain_Main.mat` (`HDRP/TerrainLit`) (§9.1, §12).
- ❌ `MaterialPropertyBlock` or `renderer.material` to tint one instance → ✅ a Material Variant or a shared material (§9.2, [05 §6.1](./05-performance.md)).
- ❌ MSAA or TAA switched on "for free AA" → ✅ SMAA High on the camera (§8).
- ❌ SSR, SSGI, decals, water or ray tracing enabled to "see what it looks like" and left on → ✅ the §2 table; every switch is a `chore:` commit with a capture.
- ❌ Settings changes buried inside a gameplay commit → ✅ a separate, announced commit by the rendering owner (TL;DR 13).

## Review checklist

- [ ] `HDRP_Desktop.asset` is the **Default Render Pipeline** in Graphics *and* the **Render Pipeline Asset** of the single `Desktop` quality level; no level was added, renamed or reordered.
- [ ] `HDRenderPipelineGlobalSettings.asset`, `DefaultVolumeProfile.asset` and `DefaultLookDevProfile.asset` are referenced in **Graphics > HDRP** and live in `Assets/RootsDance/Settings/HDRP/`; `Assets/HDRPDefaultResources/` does not exist.
- [ ] The **HDRP Wizard** reports no outstanding fixes; Player **Color Space = Linear**.
- [ ] The HDRP asset still matches the §2 table (Forward Only, MSAA off, Volumetrics on, SSAO on, SSR/SSGI/SSS/decals/water/clouds/ray tracing/dynamic resolution off, custom pass on, APV as the probe system); any diff is explained in the commit.
- [ ] No `ScriptableRendererFeature`, `ScriptableRenderPass`, `RecordRenderGraph` or `*.Blit` anywhere; new passes are `CustomPass` subclasses in `Scripts/Runtime/Rendering` with `Setup`/`Execute`/`Cleanup` paired, and the asmdef references were added in the same commit.
- [ ] Every custom post-process is registered in **Graphics > HDRP > Custom Post Process Orders**.
- [ ] The level `_Environment` scene has: one Directional light `Sun` in lux, one `Global Volume` with its `<Context>Profile`, and (once baking starts) one global Adaptive Probe Volume; the `_Gameplay` part has no light, Volume or APV.
- [ ] The level profile carries Exposure (**Fixed**), Visual Environment (**Gradient Sky**, Ambient **Dynamic**) + Gradient Sky, Fog (volumetric on), Shadows (Max Distance ≤ 150 m, 4 cascades) — and only overrides from the §6 allowed list.
- [ ] `Main Camera` is the only camera: SMAA **High**, Dithering on, Background Type **Sky**, Custom Frame Settings off, Physical Camera off; no camera stacking anywhere.
- [ ] New materials use `HDRP/Lit`, `HDRP/Unlit`, `HDRP/TerrainLit` or an HDRP-target Shader Graph; no Built-in/URP shader; unused Lit features off; no `MaterialPropertyBlock`.
- [ ] Every scripted material change ends in `HDMaterial.ValidateMaterial`.
- [ ] Imported textures follow §10 (sRGB only on `BaseMap`/`Emission`, `Normal` typed Normal map, `Mask` linear with Alpha Is Transparency off).
- [ ] The scene is inside the §11 budgets; no contact shadows, no realtime reflection probes, no shadow-casting point lights.
- [ ] Console shows no shader errors and the Game view has no magenta material after the change.

## Sources

1. [../reference/rendering-hdrp/manual-high-definition-render-pipeline.md](../reference/rendering-hdrp/manual-high-definition-render-pipeline.md) — High Definition Render Pipeline (Unity Manual landing page) — https://docs.unity3d.com/6000.3/Documentation/Manual/high-definition-render-pipeline.html
2. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-install-hdrp.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-install-hdrp.md) — Install HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/install-hdrp.html
3. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md) — System requirements and compatibility — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/System-Requirements.html
4. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-build-settings-for-different-pla.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-build-settings-for-different-pla.md) — Configure build settings for different platforms — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-build-settings-for-different-platforms.html
5. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdrp-asset.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdrp-asset.md) — Create an HDRP Asset — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-an-hdrp-asset.html
6. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md) — HDRP Asset reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html
7. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md) — Quality settings in HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/quality-settings.html
8. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-default-settings-window.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-default-settings-window.md) — HDRP graphics settings window reference (Project Settings > Graphics > HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html
9. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-pipeline-wizard.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-pipeline-wizard.md) — HDRP Wizard reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html
10. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-a-project-using-the-hdrp-wizard.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-a-project-using-the-hdrp-wizard.md) — Configure a project using the HDRP Wizard — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-a-project-using-the-hdrp-wizard.html
11. [../reference/rendering-hdrp/github-graphics-defaulthdrpasset-asset.md](../reference/rendering-hdrp/github-graphics-defaulthdrpasset-asset.md) — HDRP template 6000.3: DefaultHDRPAsset.asset (indicative template values, not our configuration) — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-hd/Assets/HDRPDefaultResources/DefaultHDRPAsset.asset
12. [../reference/rendering-hdrp/github-graphics-hdrenderpipelineglobalsettings-asset.md](../reference/rendering-hdrp/github-graphics-hdrenderpipelineglobalsettings-asset.md) — HDRP template 6000.3: HDRenderPipelineGlobalSettings.asset — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-hd/Assets/HDRPDefaultResources/HDRenderPipelineGlobalSettings.asset
13. [../reference/rendering-hdrp/github-graphics-defaultsettingsvolumeprofile-asset.md](../reference/rendering-hdrp/github-graphics-defaultsettingsvolumeprofile-asset.md) — HDRP template 6000.3: DefaultSettingsVolumeProfile.asset — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-hd/Assets/HDRPDefaultResources/DefaultSettingsVolumeProfile.asset
14. [../reference/rendering-hdrp/github-graphics-qualitysettings-asset.md](../reference/rendering-hdrp/github-graphics-qualitysettings-asset.md) — HDRP template 6000.3: QualitySettings.asset (five template levels we do not inherit) — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-hd/ProjectSettings/QualitySettings.asset
15. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-forward-and-deferred-rendering.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-forward-and-deferred-rendering.md) — Forward and deferred rendering for lighting (Lit Shader Mode) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Forward-And-Deferred-Rendering.html
16. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings.md) — Frame Settings — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html
17. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-frame-settings-reference.md) — Frame Settings reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/frame-settings-reference.html
18. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md) — Reduce shader variants (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-shader-variants.html
19. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-graph-introduction.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-render-graph-introduction.md) — Render graph system in HDRP (no user-written render graph passes) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/render-graph-introduction.html
20. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-passes-understand.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-passes-understand.md) — Understand custom passes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-passes-understand.html
21. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-volume-workflow.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-volume-workflow.md) — Understand custom pass volumes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Volume-Workflow.html
22. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-injection-points.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-injection-points.md) — Custom pass injection points — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Injection-Points.html
23. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-scripting.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-scripting.md) — Create a custom pass in a C# script — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html
24. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-create-gameobject.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-create-gameobject.md) — Create a custom pass GameObject — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html
25. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-reference.md) — Custom Pass reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-reference.html
26. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-troubleshooting.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-pass-troubleshooting.md) — Troubleshoot a custom pass — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Troubleshooting.html
27. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-global-custom-pass-api.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-global-custom-pass-api.md) — Manage a custom pass without a GameObject — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Global-Custom-Pass-API.html
28. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-understand.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-understand.md) — Understand custom post-processing — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-understand.html
29. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-create-apply.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-create-apply.md) — Create and apply a custom post-processing effect — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-create-apply.html
30. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-scripts.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-custom-post-processing-scripts.md) — Custom post-processing example scripts — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-scripts.html
31. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-fullscreen-material.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-fullscreen-material.md) — Create a Fullscreen material — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-fullscreen-material.html
32. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-physical-light-units.md) — Understand physical light units (lighting & exposure cheat sheet) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Physical-Light-Units.html
33. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-light-component.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-light-component.md) — Create and configure light sources — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html
34. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-light-component.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-light-component.md) — Light component reference (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-light-component.html
35. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-exposure.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-exposure.md) — Control exposure — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Exposure.html
36. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-override-exposure.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-override-exposure.md) — Exposure volume override reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-override-exposure.html
37. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-test-debug-exposure.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-test-debug-exposure.md) — Debug exposure — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/test-debug-exposure.html
38. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lighting-mode-shadowmask.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lighting-mode-shadowmask.md) — Use shadowmasks — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Lighting-Mode-Shadowmask.html
39. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-concept.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-concept.md) — Understanding Adaptive Probe Volumes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-concept.html
40. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-probevolumes-use.md) — Use Adaptive Probe Volumes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-use.html
41. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md) — Control shadow resolution and quality — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Shadows-in-HDRP.html
42. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-shadows.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-shadows.md) — Use the Shadows volume component override — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Shadows.html
43. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-shadows-volume-override.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reference-shadows-volume-override.md) — Shadows volume override reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reference-shadows-volume-override.html
44. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-contact-shadows.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-contact-shadows.md) — Use contact shadows — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Contact-Shadows.html
45. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-understand.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-understand.md) — Understand reflection in HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reflection-understand.html
46. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-probe.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reflection-probe.md) — Reflection Probe reference (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html
47. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-fog.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-fog.md) — Understand fog / atmospheric scattering — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Understand-Fog.html
48. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-global-fog-effect.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-global-fog-effect.md) — Create a global fog effect — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-global-fog-effect.html
49. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-fog-volume-override-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-fog-volume-override-reference.md) — Fog volume override reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/fog-volume-override-reference.html
50. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-local-fog-effect.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-local-fog-effect.md) — Create a local fog effect (Local Volumetric Fog) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-local-fog-effect.html
51. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-local-volumetric-fog-volume-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-local-volumetric-fog-volume-reference.md) — Local Volumetric Fog component reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/local-volumetric-fog-volume-reference.html
52. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md) — Enable and configure volumetric lights — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumetric-Lighting.html
53. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-troubleshoot-fog.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-troubleshoot-fog.md) — Troubleshoot fog — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/troubleshoot-fog.html
54. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-sky.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-sky.md) — Understand sky — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-sky.html
55. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-the-type-of-sky.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-the-type-of-sky.md) — Set the type of sky (Visual Environment) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-the-type-of-sky.html
56. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-visual-environment-volume-override-referen.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-visual-environment-volume-override-referen.md) — Visual Environment volume override reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html
57. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-gradient-sky.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-gradient-sky.md) — Create a gradient sky — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-gradient-sky.html
58. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gradient-sky-volume-override-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gradient-sky-volume-override-reference.md) — Gradient Sky volume override reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gradient-sky-volume-override-reference.html
59. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdri-sky.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-an-hdri-sky.md) — Create an HDRI sky — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-an-hdri-sky.html
60. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-physically-based-sky.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-physically-based-sky.md) — Create a physically based sky — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-physically-based-sky.html
61. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ambient-lighting-configure.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ambient-lighting-configure.md) — Configure environment lighting — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-lighting-configure.html
62. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-volumes.md) — Understand Volumes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html
63. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-up-a-volume.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-set-up-a-volume.md) — Set up a Volume — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/set-up-a-volume.html
64. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-volume-profile.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-a-volume-profile.md) — Create a Volume Profile — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html
65. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volume-component.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volume-component.md) — Volume component reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html
66. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-volume-overrides.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-configure-volume-overrides.md) — Configure Volume Overrides — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-volume-overrides.html
67. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-api.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-api.md) — Modify volume effects at runtime — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumes-API.html
68. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-troubleshooting.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumes-troubleshooting.md) — Troubleshooting volumes — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volumes-troubleshooting.html
69. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-main.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-main.md) — Understand post-processing (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Main.html
70. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-tonemapping.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-tonemapping.md) — Tonemapping — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Tonemapping.html
71. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-bloom.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-bloom.md) — Bloom — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Bloom.html
72. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-color-adjustments.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-color-adjustments.md) — Color Adjustments — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Color-Adjustments.html
73. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-white-balance.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-white-balance.md) — White Balance — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-White-Balance.html
74. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-vignette.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-vignette.md) — Vignette — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Vignette.html
75. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-film-grain.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-film-grain.md) — Film Grain — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Film-Grain.html
76. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-motion-blur.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-motion-blur.md) — Motion Blur — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Motion-Blur.html
77. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-depth-of-field.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-post-processing-depth-of-field.md) — Depth of Field — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Depth-of-Field.html
78. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-ambient-occlusion.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-ambient-occlusion.md) — Screen space ambient occlusion (SSAO) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Ambient-Occlusion.html
79. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-reflection.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-reflection.md) — Use screen space reflection — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-Reflection.html
80. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-gi.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-override-screen-space-gi.md) — Screen space global illumination (SSGI) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Screen-Space-GI.html
81. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-skin-and-diffusive-surfaces-subsurface-sca.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-skin-and-diffusive-surfaces-subsurface-sca.md) — Skin and diffusive surfaces (subsurface scattering) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/skin-and-diffusive-surfaces-subsurface-scattering.html
82. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-decals.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-decals.md) — Understand decals — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-decals.html
83. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-realistic-clouds-volumetric-clouds.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-create-realistic-clouds-volumetric-clouds.md) — Create realistic clouds (Volumetric Clouds) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-realistic-clouds-volumetric-clouds.html
84. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-water-use-the-water-system-in-your-project.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-water-use-the-water-system-in-your-project.md) — Use the water system in your project — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/water-use-the-water-system-in-your-project.html
85. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ray-tracing-getting-started.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-ray-tracing-getting-started.md) — Set up ray tracing — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Tracing-Getting-Started.html
86. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-dynamic-resolution.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-dynamic-resolution.md) — Dynamic resolution (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Dynamic-Resolution.html
87. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-anti-aliasing.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-anti-aliasing.md) — Antialiasing in HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Anti-Aliasing.html
88. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-camera-component-reference.md) — HDRP Camera component reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html
89. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-best-practices-for-ui-in-hdrp.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-best-practices-for-ui-in-hdrp.md) — Best practices for UI in HDRP (single-camera setup, Unlit UI) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/best-practices-for-ui-in-hdrp.html
90. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material.md) — Lit material — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material.html
91. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material-inspector-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-material-inspector-reference.md) — Lit Material Inspector reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-material-inspector-reference.html
92. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-unlit-material.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-unlit-material.md) — Unlit material — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/unlit-material.html
93. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material.md) — Terrain Lit material — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material.html
94. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material-inspector-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-terrain-lit-material-inspector-reference.md) — Terrain Lit Material Inspector reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-lit-material-inspector-reference.html
95. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-layered-lit-material.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-layered-lit-material.md) — Layered Lit material — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/layered-lit-material.html
96. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-mask-map-and-detail-map.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-mask-map-and-detail-map.md) — Mask and detail maps — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Mask-Map-and-Detail-Map.html
97. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-material-type.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-material-type.md) — Material Type reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Material-Type.html
98. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-surface-type.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-surface-type.md) — Surface Type reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html
99. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-alpha-clipping.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-alpha-clipping.md) — Alpha Clipping reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Alpha-Clipping.html
100. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-renderer-and-material-priority.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-renderer-and-material-priority.md) — Understand renderer and material priority — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Renderer-And-Material-Priority.html
101. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md) — Introduction to the SRP Batcher (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/SRPBatcher.html
102. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-modify-materials-at-runtime.md) — Modify materials at runtime (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/modify-materials-at-runtime.html
103. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-shader-graph-in-hdrp.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-understand-shader-graph-in-hdrp.md) — Understand Shader Graph in HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-shader-graph-in-hdrp.html
104. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-shader-graph-to-create-hdrp-shaders.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-shader-graph-to-create-hdrp-shaders.md) — Use Shader Graph to create HDRP shaders — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-shader-graph-to-create-hdrp-shaders.html
105. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-master-stack-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-lit-master-stack-reference.md) — Lit Master Stack reference — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/lit-master-stack-reference.html
106. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-convert-from-built-in-convert-materials-an.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-convert-from-built-in-convert-materials-an.md) — Convert materials and shaders to HDRP — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-materials-and-shaders.html
107. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-features.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-features.md) — HDRP features list (HDMaterial API) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Features.html
108. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-known-issues.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-known-issues.md) — HDRP known issues — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Known-Issues.html
109. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-the-rendering-debugger.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-use-the-rendering-debugger.md) — Use the Rendering Debugger (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html
110. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-rendering-debugger-window-reference.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-rendering-debugger-window-reference.md) — Rendering Debugger window reference (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html
111. [../reference/rendering-hdrp/manual-class-terrainlayer.md](../reference/rendering-hdrp/manual-class-terrainlayer.md) — Terrain Layers (Unity Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-TerrainLayer.html
112. [../reference/project-structure/manual-setupmultiplescenes.md](../reference/project-structure/manual-setupmultiplescenes.md) — Set up multiple scenes (scene-specific rendering settings) — https://docs.unity3d.com/6000.3/Documentation/Manual/setupmultiplescenes.html
113. [../reference/performance/manual-staticobjects.md](../reference/performance/manual-staticobjects.md) — Static GameObjects — https://docs.unity3d.com/6000.3/Documentation/Manual/StaticObjects.html
114. [../reference/performance/manual-optimizing-draw-calls-choose-method.md](../reference/performance/manual-optimizing-draw-calls-choose-method.md) — Choose a method for optimizing draw calls — https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html
115. [../reference/performance/how-to-performance-optimization-high-end-graphics.md](../reference/performance/how-to-performance-optimization-high-end-graphics.md) — Performance optimization for high-end graphics on PC and console — https://unity.com/how-to/performance-optimization-high-end-graphics
116. [../reference/performance/how-to-mobile-game-optimization-tips-part-1.md](../reference/performance/how-to-mobile-game-optimization-tips-part-1.md) — Art optimization tips (data maps must not be sRGB) — https://unity.com/how-to/mobile-game-optimization-tips-part-1
