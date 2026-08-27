---
title: "HDRP graphics settings window reference (Project Settings > Graphics > HDRP)"
page_title: "HDRP graphics settings window reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# HDRP graphics settings window reference

If a project has the High Definition Render Pipeline (HDRP) package installed, Unity shows HDRP-specific graphics settings in **Project Settings** \> **Graphics** \> **Pipeline Specific Settings** \> **HDRP**.

The section contains the following settings that let you define project-wide settings for HDRP.

You can also add your own settings. Refer to [Add custom settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/manual/add-custom-graphics-settings.html) in the Scriptable Render Pipeline (SRP) Core manual for more information.

## Lightmap Sampling Settings

| **Property** | **Description** |
|----|----|
| **Use Bicubic Lightmap Sampling** | Improves the visual fidelity of lightmaps by smoothening sharp or jagged edges, especially at the edges of shadows. Enabling this property might reduce performance on lower-end platforms. |

## Additional Shader Stripping Settings

| **Property** | **Description** |
|----|----|
| Shader Variant Log Level | Use the drop-down to select what information HDRP logs about Shader variants when you build your Unity Project. • Disabled: HDRP doesn’t log any Shader variant information.• Only SRP Shaders: Only log Shader variant information for HDRP Shaders.• All Shaders: Log Shader variant information for every Shader type. |
| Export Shader Variants | Controls whether to output shader variant information to a file. Unity saves the information to the folder with your project files, in `Temp/graphics-settings-stripping.json` and `Temp/shader-stripping.json`. |

## Custom Post Process Orders

Use this section to select which custom post processing effect HDRP uses in the project and at which stage in the render pipeline it executes them.

HDRP provides one list for each post processing injection point. See the [Custom Post Process](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Post-Process.html) documentation for more details.

## Frame Settings (Default Values)

The [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html) control the rendering passes that Cameras perform at runtime.

Use this section to set default values for the Frame Settings that all Cameras use if you don't enable their Custom Frame Settings checkbox. For information about what each property does, see [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html).

## Miscellaneous

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>Lens Attenuation Mode</td>
<td>Set the attenuation mode of the lens that HDRP uses to compute exposure.<br />
•<strong>Imperfect lens</strong>: This mode loses some energy when HDRP converts from EV100 to the exposure multiplier.<br />
•<strong>Perfect lens</strong>: This mode has no attenuation and doesn't lose any energy.</td>
</tr>
<tr>
<td>Dynamic Render Pass Culling</td>
<td>When you enable this option, HDRP uses the RendererList API to skip drawing passes based on the type of GameObjects visible in the current frame objects. For example, if HDRP doesn't draw an object with distortion, it skips the Render Graph passes that draw the distortion effect and their dependencies, like the color pyramid generation.</td>
</tr>
<tr>
<td>Specular Fade</td>
<td>Reduce the effect of specular highlights on Lit or StackLit materials that receive specular light. This effect is not physically correct.</td>
</tr>
<tr>
<td>Use DLSS Custom Project ID</td>
<td>Controls whether to use a custom project ID for the NVIDIA Deep Learning Super Sampling module. If you enable this property, you can use <strong>DLSS Custom Project ID</strong> to specify a custom project ID.<br />
This property only appears if you enable the NVIDIA package (com.unity.modules.nvidia) in your Unity project.</td>
</tr>
<tr>
<td>DLSS Custom Project ID</td>
<td>Controls whether to use a custom project ID for the NVIDIA Deep Learning Super Sampling (DLSS) module. If you enable this property, you can use <strong>DLSS Custom Project ID</strong> to specify a custom project ID. If you disable this property, Unity generates a unique project ID.<br />
This property only appears if you enable the NVIDIA package (com.unity.modules.nvidia) in your Unity project.</td>
</tr>
<tr>
<td>Runtime Debug Shaders</td>
<td>When enabled, Unity includes shader variants that let you use the Rendering Debugger window to debug your build. When disabled, Unity excludes (strips) these variants. Enable this when you want to debug your shaders in the Rendering Debugger window, and disable it otherwise.</td>
</tr>
<tr>
<td>Auto Register Diffusion Profiles</td>
<td>When enabled, diffusion profiles referenced by an imported material will be automatically added to the diffusion profile list in the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">HDRP Graphics settings window</a></td>
</tr>
</tbody>
</table>

## Volume Profiles

You can use the **Volume Profiles** section to assign and edit a [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html) that [Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) use by default in your Scenes. You do not need to create a Volume for this specific Volume Profile to be active, because HDRP always processes it as if it's assigned to a global Volume in the Scene, but with the lowest priority. This means that any Volume that you add to a Scene takes priority.

The **Default Volume Profile Asset** (A) references a Volume Profile in the HDRP package folder called `DefaultSettingsVolumeProfile` by default. Below it, you can add [Volume overrides](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html), and edit their properties. You can assign your own Volume Profile to this property field. Be aware that this property must always reference a Volume Profile. If you assign your own Volume Profile and then delete it, HDRP automatically re-assigns the `DefaultSettingsVolumeProfile` from the HDRP package folder.

The **LookDev Volume Profile Asset** (B) references the Volume Profile HDRP uses in the [LookDev window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/test-and-debug-materials-in-different-lighting-conditions-look-dev.html). This Asset works in almost the same way as the Default Volume Profile Asset, except that it overrides [Visual Environment Components](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/visual-environment-volume-override-reference.html) and sky components.

## Resources

The Resources list includes the Shaders, Materials, Textures, and other Assets that HDRP uses.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Property</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Player Resources</strong></td>
<td>Stores references to Shaders and Materials that HDRP uses. When you build your Unity Project, HDRP embeds all the resources that this Asset references.<br />
<br />
Use this property to set up multiple render pipelines in a Unity Project. When you build the Project Unity only embeds Shaders and Materials relevant for that pipeline. This is the Scriptable Render Pipeline equivalent of Unity’s Resources folder mechanism.<br />
When you create a new HDRP Global Settings Asset, the <code>HDRenderPipelineRuntimeResources</code> from HDRP package is automatically referenced in it.</td>
</tr>
<tr>
<td><strong>Ray Tracing Resources</strong></td>
<td>Stores references to Shaders and Materials that HDRP uses for ray tracing.<br />
HDRP stores these resources in a separate Asset file from the main pipeline resources so that it can use less memory for applications that don't support ray tracing. When you create a new HDRP Global Settings Asset, the <code>HDRenderPipelineRayTracingResources</code> from HDRP package is automatically referenced in it if your project use ray tracing.</td>
</tr>
<tr>
<td><strong>Editor Resources</strong></td>
<td>Stores reference resources for the Editor only.<br />
Unity doesn't include these when you build your Unity Project. When you create a new HDRP Global Settings Asset, the <code>HDRenderPipelineEditorResources</code> from HDRP package is automatically referenced in it.</td>
</tr>
</tbody>
</table>
