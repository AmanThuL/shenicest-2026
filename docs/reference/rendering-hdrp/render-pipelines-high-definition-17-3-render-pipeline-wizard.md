---
title: "HDRP Wizard reference"
page_title: "High Definition Render Pipeline Wizard reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# High Definition Render Pipeline Wizard reference

The High Definition Render Pipeline (HDRP) includes the **HDRP Wizard** to help you configure your Unity Project so that it's compatible with HDRP.

To open the **Render Pipeline Wizard**, go to **Window \> Rendering** and select **HDRP Wizard**.

## Packages

At the top of the window, there is an information text that shows you the currently installed version of HDRP. The **Package Manager** button provides a shortcut to the HDRP package in the Package Manager window.

## General Settings

| **Property** | **Description** |
|----|----|
| **Default Resources Folder** | Set the folder name that the Render Pipeline Wizard uses when it loads or creates resources. |

## Configuration Checking

Select the **Embed Configuration Editable Package** button to create a local instance of the [High Definition Render Pipeline Config package](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-a-project-using-the-hdrp-config-package.html) in the `LocalPackage` folder of your HDRP Project. If the package is already installed, information about its location is displayed below.

Your Unity Project must adhere to all the configuration tests in this section for HDRP to work correctly. If a test fails, a message explains the issue and you can click a button to fix it. This helps you to quickly fix any major issues with your HDRP Project. The Render Pipeline Wizard can load or create any resources that are missing by placing new resources in the folder set as the **Default Resources Folder**.

There are three sections that you can use to set up your HDRP Project for different use cases.

- [HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html#HDRPTab): Use this section to set up a default HDRP Project.
- [VR](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html#VRTab): Use this section to set up your HDRP Project and enable support for virtual reality.
- [DXR](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html#DXRTab): Use this tab to set up your HDRP Project and enable support for ray tracing.

Each configuration is separated into two scopes:

- **Global:** Changes the configuration settings in the Unity Editor, [HDRP graphics settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html), or [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html)
- **Current Quality:** Changes the configuration settings in the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) set in [Quality settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/quality-settings.html). If no asset is assigned in the **Quality** settings, this mode uses the [HDRP Asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html) set in the [Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html).

### HDRP

<span id="HDRPTab"></span> This section provides you with configuration options to help you make your Unity Project use HDRP.

#### Global

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Configuration Option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Assigned - Default Render Pipeline in Graphics Settings</strong></td>
<td>Checks to make sure you have assigned an <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a> as the <strong>Default Render Pipeline</strong> (menu: <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Graphics</strong>).<br />
Select the <strong>Fix</strong> button to open a dialog that allows you to either assign an existing HDRP Asset or create and assign a new one.</td>
</tr>
<tr>
<td><strong>Global Settings Asset</strong></td>
<td>Checks that the current project has a valid instance of a <strong>HDRenderPipelineGlobalSettings</strong> asset referenced in the Graphics Settings (menu: <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Graphics</strong> &gt; <strong>HDRP</strong>).<br />
Select the <strong>Fix</strong> button to find and assign an available <strong>HDRenderPipelineGlobalSettings</strong> asset. If there isn't one available, Unity creates an <strong>HDRenderPipelineGlobalSettings</strong> asset in the <strong>Default Resources Folder</strong>.</td>
</tr>
<tr>
<td><strong>Settings and Resources</strong></td>
<td>Checks that all the <strong>IRenderPipelineGraphicsSettings</strong> and <strong>IRenderPipelineResources</strong> that belong to HDRP are valid and available in the <strong>HDRenderPipelineGlobalSettings</strong> asset</td>
</tr>
<tr>
<td><strong>Default Volume Profile</strong></td>
<td>Checks to make sure you have assigned a <strong>Default Volume Profile Asset</strong> in <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Graphics</strong> &gt; <strong>HDRP</strong> that's not the one included in the <strong>High Definition RP</strong> package.<br />
This check only needs to pass if you want to modify the <strong>Default Volume Profile Asset</strong>.<br />
Select the <strong>Fix</strong> button to copy the <strong>Default Volume Profile Asset</strong> from the <strong>High Definition RP</strong> package into the <strong>Default Resource Folder</strong> and assign it.</td>
</tr>
<tr>
<td><strong>Diffusion Profile</strong></td>
<td>Checks to make sure that your HDRP Asset references a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/diffusion-profile-reference.html"><strong>Diffusion Profile</strong></a> Asset.<br />
Select the <strong>Fix</strong> button to reload the runtime resources for the HDRP Asset.</td>
</tr>
<tr>
<td><strong>Default LookDev Volume Profile</strong></td>
<td>Checks to make sure you have assigned a <strong>LookDev Volume Profile Asset</strong> in <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Graphics</strong> &gt; <strong>HDRP</strong> that's not the one included in the <strong>High Definition RP</strong> package.<br />
This check only needs to pass if you want to use LookDev and modify the profile used in it.<br />
Select the <strong>Fix</strong> button to copy the <strong>LookDev Volume Profile Asset</strong> from the <strong>High Definition RP</strong> package into the <strong>Default Resource Folder</strong> and assign it.</td>
</tr>
<tr>
<td><strong>Color Space</strong></td>
<td>Checks to make sure <strong>Color Space</strong> is set to <strong>Linear</strong>. HDRP only supports <strong>Linear Color Space</strong> because it gives more physically accurate results than <strong>Gamma</strong>.<br />
Select the <strong>Fix</strong> button to set the <strong>Color Space</strong> to <strong>Linear</strong>.</td>
</tr>
<tr>
<td><strong>Lightmap Encoding</strong></td>
<td>Checks to make sure <strong>Lightmap Encoding</strong> is set to <strong>High Quality</strong>, which is the only mode that HDRP supports.<br />
Select the <strong>Fix</strong> button to make Unity encode lightmaps in <strong>High Quality</strong> mode. This fixes lightmaps for all platforms.</td>
</tr>
<tr>
<td><strong>Shadows</strong></td>
<td>Checks to make sure <strong>Shadow Quality</strong> is set to <strong>All</strong>. Unity hides this option when you install HDRP, and automatically sets it to <strong>All</strong>.<br />
Select the <strong>Fix</strong> button to set <strong>Shadow Quality</strong> to <strong>All</strong>.</td>
</tr>
<tr>
<td><strong>Shadowmask Mode</strong></td>
<td>Checks to make sure <strong>Shadowmask Mode</strong> is set to <strong>Distance Shadowmask</strong> at the Project level. This allows you to change the <strong>Shadowmask Mode</strong> on a per-<a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Light-Component.html">Light</a> level.<br />
Select the <strong>Fix</strong> button to set the <strong>Shadowmask Mode</strong> to <strong>Distance Shadowmask</strong>.</td>
</tr>
<tr>
<td><strong>Assets Migration</strong></td>
<td>Checks to make sure all <strong>HDRenderPipelineAsset</strong> used in quality levels have been upgraded to the current version of the High Definition Render Pipeline.<br />
Select the <strong>Fix</strong> button to upgrade any assets that require it. Assets that are migrated will be logged in the console. You will need to save your project to save the changes.</td>
</tr>
</tbody>
</table>

#### Current Quality

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Configuration Option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Assigned - Quality</strong></td>
<td>Checks to make sure you have assigned either an <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a> or null to the <strong>Quality Settings</strong> field corresponding to the currently used quality (menu: <strong>Edit</strong> &gt; <strong>Project Settings</strong> &gt; <strong>Quality</strong>).<br />
If the value is null, all <strong>Current Quality</strong> related configuration will be the one from the <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a> used in <strong>Global</strong>.<br />
Select the <strong>Fix</strong> button to nullify the field.</td>
</tr>
<tr>
<td><strong>SRP Batcher</strong></td>
<td>Checks to make sure that <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/SRPBatcher.html" class="xref">Scriptable Render Pipeline Batcher</a> is enabled.<br />
Select the <strong>Fix</strong> button to enable it in the used HDRP Asset.</td>
</tr>
</tbody>
</table>

### HDRP + VR

<span id="VRTab"></span> This section provides extra configuration options to help you set up your HDRP Project to support virtual reality. If you can't find an option in this section of the documentation, refer to the [HDRP section](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html#HDRPTab) options. This is only supported on Windows OS. You can adjust the extra configuration options in the **Global** scope.

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Configuration Option</strong></th>
<th><strong>Suboption</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Legacy VR System</strong></td>
<td></td>
<td>Checks that Virtual Reality Supported is disabled. This is the deprecated system.<br />
Select the Fix button to disable Virtual Reality Supported.</td>
</tr>
<tr>
<td><strong>XR Management Package</strong></td>
<td></td>
<td>Checks that the XR Management Package is installed.<br />
Select the Fix button to install it.</td>
</tr>
<tr>
<td><strong>XR Management Package</strong></td>
<td><strong>Oculus Plugin</strong></td>
<td>The wizard can't check this directly. This option gives information on the procedure to follow to check it.<br />
To install the plugin manually, go to Edit &gt; Project Settings &gt; XR Plugin Manager</td>
</tr>
<tr>
<td><strong>XR Management Package</strong></td>
<td><strong>Single-Pass Instancing</strong></td>
<td>The wizard can't check this directly. This option gives information on the procedure to follow to check it.<br />
Go to Edit &gt; Project Settings &gt; XR Plugin Manager &gt; Oculus and make sure Stereo Rendering Mode uses Single-Pass Instancing</td>
</tr>
<tr>
<td><strong>XR Legacy Helpers Package</strong></td>
<td></td>
<td>Checks that the XR Legacy Helpers Package is installed. It's required to handle inputs with the TrackedPoseDriver component.<br />
Select the Fix button to install it.</td>
</tr>
</tbody>
</table>

### HDRP + DXR

<span id="DXROptionalTab"></span> This section provides extra configuration options to help you set up your HDRP Project to support ray tracing. If you can't find an option in this section of the documentation, refer to the [HDRP tab](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html#HDRPTab) options. This is only supported on Windows OS.

**Note**: Every **Fix** will be disabled if your hardware or OS doesn't support DXR.

#### Global

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Configuration Option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Auto Graphics API</strong></td>
<td>Checks that <strong>Auto Graphics API</strong> is disabled in your <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html" class="xref">Player settings</a> for the current platform. DXR requires <strong>Direct3D 12</strong>.<br />
Select the <strong>Fix</strong> button to disable <strong>Auto Graphics API</strong>.</td>
</tr>
<tr>
<td><strong>Direct3D 12</strong></td>
<td>Checks that <strong>Direct3D 12</strong> is the first Graphic API set in Player Settings for the current platform.<br />
Select the <strong>Fix</strong> button to make Unity use <strong>Direct3D 12</strong>.</td>
</tr>
<tr>
<td><strong>Static Batching</strong></td>
<td><strong>Static Batching</strong> isn't supported while using DXR.<br />
Select the <strong>Fix</strong> button to deactivate it.</td>
</tr>
<tr>
<td><strong>Architecture 64 bits</strong></td>
<td>DXR only supports 64-bit architecture.<br />
Select the <strong>Fix</strong> button to change the target architecture to 64-bit.</td>
</tr>
<tr>
<td><strong>DXR Resources</strong></td>
<td>Checks that your HDRP Asset references an <strong>HD Render Pipeline RayTracing Resources</strong> asset.<br />
Select the <strong>Fix</strong> button to reload the ray tracing resources for the HDRP Asset.</td>
</tr>
<tr>
<td><strong>Screen Space Shadow (HDRP Default Settings)</strong></td>
<td>Checks to make sure that your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Default Settings</a> have the <strong>Screen Space Shadows</strong> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Setting</a> enabled by default for Cameras.<br />
Select the <strong>Fix</strong> button to enable the <strong>Screen Space Shadows</strong> Frame Setting.<br />
<strong>Note</strong>: This configuration option depends on <strong>Screen Space Shadows (Asset)</strong>. This means, before you fix this, you must fix <strong>Screen Space Shadows (Asset)</strong> first.</td>
</tr>
<tr>
<td><strong>Screen Space Reflection (HDRP Default Settings)</strong></td>
<td>Checks to make sure that your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Default Settings</a> have the <strong>Screen Space Reflections</strong> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Setting</a> enabled by default for Cameras.<br />
Select the <strong>Fix</strong> button to enable the <strong>Screen Space Reflections</strong> Frame Setting.<br />
<strong>Note</strong>: This configuration option depends on <strong>Screen Space Reflection (Asset)</strong>. This means, before you fix this, you must fix <strong>Screen Space Reflection (Asset)</strong> first.</td>
</tr>
<tr>
<td><strong>Screen Space Reflection - Transparents (HDRP Default Settings)</strong></td>
<td>Checks to make sure that your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Default Settings</a> have the <strong>Transparents</strong> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Setting</a> enabled by default for Cameras.<br />
Select the <strong>Fix</strong> button to enable the <strong>Screen Space Reflections</strong> Frame Setting.<br />
<strong>Note</strong>: This configuration option depends on <strong>Screen Space Reflection - Transparents (Asset)</strong>. This means, before you fix this, you must fix <strong>Screen Space Reflection - Transparents (Asset)</strong> first.</td>
</tr>
<tr>
<td><strong>Screen Space Global Illumination (HDRP Frame Settings)</strong></td>
<td>Checks to make sure that your <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html">Default Settings</a> have the <strong>Screen Space Global Illumination</strong> <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html">Frame Setting</a> enabled by default for Cameras.<br />
Select the <strong>Fix</strong> button to enable the <strong>Screen Space Global Illumination</strong> Frame Setting.<br />
<strong>Note</strong>: This configuration option depends on <strong>Screen Space Global Illumination (Asset)</strong>. This means, before you fix this, you must fix <strong>Screen Space Global Illumination (Asset)</strong> first.</td>
</tr>
<tr>
<td><strong>DXR Shader Config</strong></td>
<td>Checks to make sure that the <strong>ShaderConfig.cs.hlsl</strong>, in the <strong>High Definition RP Config</strong> package referenced in your project, has <strong>SHADEROPTIONS_RAYTRACING</strong> set to <strong>1</strong>.<br />
Select the <strong>Fix</strong> button to create a local copy of the <strong>High Definition RP Config</strong> package and, set <strong>SHADEROPTIONS_RAYTRACING</strong> to <strong>1</strong> in the <strong>ShaderConfig.cs.hlsl</strong>.</td>
</tr>
</tbody>
</table>

#### Current Quality

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th><strong>Configuration Option</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>DXR Activated</strong></td>
<td>Checks that <strong>DXR Activated</strong> is enabled in the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.<br />
Select the <strong>Fix</strong> button to enable <strong>DXR Activated</strong>.</td>
</tr>
<tr>
<td><strong>Screen Space Shadows (Asset)</strong></td>
<td>Checks that <strong>Screen Space Shadows</strong> is enabled in the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.<br />
Select the <strong>Fix</strong> button to enable <strong>Screen Space Shadows</strong>.</td>
</tr>
<tr>
<td><strong>Screen Space Reflection (Asset)</strong></td>
<td>Checks that <strong>Screen Space Reflection</strong> is enabled in the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.<br />
Select the <strong>Fix</strong> button to enable <strong>Screen Space Reflection</strong>.</td>
</tr>
<tr>
<td><strong>Screen Space Reflection - Transparents (Asset)</strong></td>
<td>Checks that <strong>Transparents</strong> is enabled in the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.<br />
Select the <strong>Fix</strong> button to enable <strong>Transparents</strong>.</td>
</tr>
<tr>
<td><strong>Screen Space Global Illumination (Asset)</strong></td>
<td>Checks that <strong>Screen Space Global Illumination</strong> is enabled in the current <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html">HDRP Asset</a>.<br />
Select the <strong>Fix</strong> button to enable <strong>Screen Space Global Illumination</strong>.</td>
</tr>
</tbody>
</table>
