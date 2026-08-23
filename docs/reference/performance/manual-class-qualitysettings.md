---
title: "Quality settings tab reference"
page_title: "Unity - Manual: Quality settings tab reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Quality settings tab reference

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings.html" class="switch-link gray-btn sbtn left" title="Go to QualitySettings page in the Scripting Reference">Switch to Scripting</a>

To configure the levels of graphical quality that Unity uses to render your project for different platforms, go to **Edit** \> **Project Settings** \> **Quality**.

**Note**: You can access **Quality** settings from the **Build Profiles** window (menu: **File** \> **Build Profiles**). With [build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html), you can customize the Quality settings per build profile to set different values for each platform. For more information, refer to [Customize settings with build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html).

A higher quality usually results in a lower frame rate. It’s best to use lower quality on mobile devices and older platforms, to avoid having a detrimental effect on gameplay.

![Edit the settings for a specific Quality level](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/quality-settings-panel.png)  

The **Quality** tab contains the following sections:

-   **A**: The matrix of quality levels and build platforms in this project.
-   **B**: The active build platform.
-   **C**: The active quality level.
-   **D**: The configuration of the active quality level.

## Quality levels matrix

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Levels</strong></td><td style="text-align: left;">Lists the quality levels in the project, and the platforms they apply to when Unity builds your project. To make a quality level active in the Editor and the configuration section, select it to highlight it. To apply a quality level to a build platform, enable the checkbox under the platform.<br />
<br />
To rename a level, under <strong>Current Active Quality Level</strong>, select <strong>Name</strong>.<br />
<br />
To delete a quality level, select the trashcan icon next to the quality level.</td></tr><tr class="even"><td style="text-align: left;"><strong>Default</strong></td><td style="text-align: left;">Sets the default quality level for each platform. The checkbox for the default platform displays green.</td></tr><tr class="odd"><td style="text-align: left;"><span id="define"></span><strong>Add Quality Level</strong></td><td style="text-align: left;">Adds a quality level by duplicating the highlighted quality level.</td></tr></tbody></table>

## Configuration section

The configuration section contains the following sections:

-   [Rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Rendering)
-   [Textures](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Textures)
-   [Particles](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Particles)
-   [Terrain](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Terrain)
-   [Shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Shadows)
-   [Async Asset Upload](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#AsyncAssetUpload)
-   [Level of Detail](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#LevelOfDetail)
-   [Meshes](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#Meshes)

<span id="Rendering"></span>

### Rendering

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Render Pipeline</strong></td><td style="text-align: left;">Sets the render pipeline asset to use at this quality level.</td></tr><tr class="even"><td style="text-align: left;"><strong>Pixel Light Count</strong></td><td style="text-align: left;">Sets the maximum number of per-pixel lights if you use a forward rendering path. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/PerPixelLights.html">Per-pixel and per-vertex lights</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Anti Aliasing</strong></td><td style="text-align: left;">Smooths edges using multisample anti-aliasing (MSAA). The higher the antialiasing level, the smoother the appearance of the edges of polygons, but the more processing time needed on the GPU. MSAA is supported only in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/rendering-paths-introduction.html#forward">forward rendering paths</a>. For the dropdown options, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#anti-aliasing-dropdown">Anti Aliasing dropdown</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Realtime Reflection Probes</strong></td><td style="text-align: left;">Indicates whether to update <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html">reflection probes</a> at runtime.</td></tr><tr class="odd"><td style="text-align: left;"><span id="FixedDPIFactor"></span><strong>Resolution Scaling Fixed DPI Factor</strong></td><td style="text-align: left;">Increases or decreases the screen resolution of the device. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Scaling">Android Player settings</a> and <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsiOS.html#Scaling">iOS Player settings</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>VSync Count</strong></td><td style="text-align: left;">Synchronizes rendering with the refresh rate of the display device to avoid <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/CameraTroubleshooting.html#tearing">tearing artifacts</a>. For the dropdown options, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#vsync-count-dropdown">VSync Count dropdown</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Realtime GI CPU Usage</strong></td><td style="text-align: left;">Controls how much CPU capacity Unity can use to calculate <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/realtime-gi-using-enlighten-landing.html">Enlighten Realtime Global Illumination</a>. Higher settings make the system react faster to changes in lighting. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#realtime-gi-cpu-usage-dropdown">Realtime GI CPU Usage dropdown</a><br />
<br />
This property is available in the <strong>Quality</strong> window only if your project uses the Universal Render Pipeline (URP) or the High Definition Render Pipeline (HDRP). For the Built-In Render Pipeline, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GraphicsSettings.html">graphics settings</a>.</td></tr></tbody></table>

<span id="anti-aliasing-dropdown"></span>

#### Anti Aliasing dropdown

| **Value**             | **Description**                |
|:----------------------|:-------------------------------|
| **Disabled**          | Disables MSAA.                 |
| **2x Multi Sampling** | Samples twice per pixel.       |
| **4x Multi Sampling** | Samples four times per pixel.  |
| **8x Multi Sampling** | Samples eight times per pixel. |

<span id="vsync-count-dropdown"></span>

#### VSync Count dropdown

| **Value**                | **Description**                                                                                    |
|:-------------------------|:---------------------------------------------------------------------------------------------------|
| **Don’t Sync**           | Disables synchronizing rendering with the display device.                                          |
| **Every V Blank**        | Synchronizes rendering so that Unity switches frames every time the display isn’t updating.        |
| **Every Second V Blank** | Synchronizes rendering so that Unity switches frames every second time the display isn’t updating. |

<span id="realtime-gi-cpu-usage-dropdown"></span>

#### Realtime GI CPU Usage dropdown

| **Value**     | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|:--------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Low**       | Limits Enlighten Realtime Global Illumination to a low amount of CPU capacity.                                                                                                                                                                                                                                                                                                                                                                                       |
| **Medium**    | Limits Enlighten Realtime Global Illumination to a medium amount of CPU capacity.                                                                                                                                                                                                                                                                                                                                                                                    |
| **High**      | Limits Enlighten Realtime Global Illumination to a high amount of CPU capacity.                                                                                                                                                                                                                                                                                                                                                                                      |
| **Unlimited** | Uses no CPU capacity limit for Enlighten Realtime Global Illumination. **Note:** Some platforms have their own limit on how many CPU threads or cores Unity can use. For example, Android might limit Unity to one less than the total number of CPUs, or to only little CPUs on devices with big/little CPUs. For more information, refer to [Android thread configuration](https://docs.unity3d.com/6000.3/Documentation/Manual/android-thread-configuration.html) |

<span id="Textures"></span>

### Textures

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Global Mipmap Limit</strong></td><td style="text-align: left;">Limits the mipmap resolution level that Unity uses when it renders textures. To use lower resolutions that require less GPU memory and processing time, set this property to a higher mipmap level. For the dropdown options, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#global-mipmap-limit-dropdown">Global Mipmap Limit dropdown</a>.<br />
<br />
This property only affects textures with a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html#textureshape">texture shape</a> of 2D or 2D Array.</td></tr><tr class="even"><td style="text-align: left;"><strong>Mipmap Limit Groups</strong></td><td style="text-align: left;">Lists the custom groups that you can add textures to so they override the <strong>Global Mipmap Limit</strong>. Use Mipmap Limit Groups to allocate more memory for important textures, and less memory for less important textures. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#mipmap-limit-groups-properties">Mipmap Limit Groups properties</a><br />
<br />
This property affects only textures with a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html#textureshape">texture shape</a> of 2D or 2D Array.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Anisotropic Textures</strong></td><td style="text-align: left;">Controls which textures use anisotropic filtering, which improves the visual quality when you view a texture at a steep angle. Anisotropic filtering increases rendering time. For dropdown options, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#anisotropic-textures-dropdown">Anisotropic Textures dropdown</a>.</td></tr><tr class="even"><td style="text-align: left;"><span id="texStream"></span><strong>Mipmap Streaming</strong></td><td style="text-align: left;">Limits the size of textures in GPU memory by using <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/TextureStreaming.html">mipmap streaming</a>. Disable this setting to reduce processing time. For dropdown options, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#mipmap-streaming-dropdown">Mipmap Streaming dropdown</a>.</td></tr></tbody></table>

<span id="global-mipmap-limit-dropdown"></span>

#### Global Mipmap Limit dropdown

For more information about mipmaps and mipmap limits, refer to [Mipmaps](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-mipmaps-introduction.html).

| **Value**                 | **Description**                                                                                                  |
|:--------------------------|:-----------------------------------------------------------------------------------------------------------------|
| **0: Full Resolution**    | Uses no limit for texture resolution. Unity can use mipmap level 0, which is the full resolution of the texture. |
| **1: Half Resolution**    | Limits the highest resolution to mipmap level 1, which is half resolution.                                       |
| **2: Quarter Resolution** | Limits the highest resolution to mipmap level 2, which is quarter resolution.                                    |
| **3: Eighth Resolution**  | Limits the highest resolution to mipmap level 3, which is eighth resolution.                                     |

<span id="mipmap-limit-groups-properties"></span>

#### Mipmap Limit Groups properties

To create a new group, select the **Add** (**+**) button. To delete a group, select the **Remove** (**−**) button. If you delete a group, a dialog appears that checks if you want to remove the textures from the group and reimport them. You can’t undo this.

The dropdown for each group contains the following options.

| **Group property**                                   | **Description**                                                                                                                                                                                                                                                                                             |
|:-----------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Offset Global Mipmap Limit: –3**                   | Allows the textures in this group to use eight times the resolution of **Global Mipmap Limit**. This results in Unity using higher resolution textures and more memory. For example, if **Global Mipmap Limit** is **3: Eighth Resolution**, Unity limits this group of textures to **0: Full Resolution**. |
| **Offset Global Mipmap Limit: –2**                   | Allows the textures in this group to use four times the resolution of **Global Mipmap Limit**.                                                                                                                                                                                                              |
| **Offset Global Mipmap Limit: –1**                   | Allows the textures in this group to use two times the resolution of **Global Mipmap Limit**.                                                                                                                                                                                                               |
| **Use Global Mipmap Limit**                          | Uses **Global Mipmap Limit** for the textures in this group.                                                                                                                                                                                                                                                |
| **Offset Global Mipmap Limit: +1**                   | Limits the textures in this group to half the resolution of **Global Mipmap Limit**. This results in Unity using lower resolution textures and less memory. For example, if **Global Mipmap Limit** is **1: Half Resolution**, Unity limits this group of textures to **2: Quarter Resolution**.            |
| **Offset Global Mipmap Limit: +2**                   | Limits the textures in this group to a quarter of the resolution of **Global Mipmap Limit**.                                                                                                                                                                                                                |
| **Offset Global Mipmap Limit: +3**                   | Limits the textures in this group to an eighth of the resolution of **Global Mipmap Limit**.                                                                                                                                                                                                                |
| **Override Global Mipmap Limit: Full Resolution**    | Limits the textures in this group to mipmap level 0, which is full resolution.                                                                                                                                                                                                                              |
| **Override Global Mipmap Limit: Half Resolution**    | Limits the textures in this group to mipmap level 1, which is half resolution.                                                                                                                                                                                                                              |
| **Override Global Mipmap Limit: Quarter Resolution** | Limits the textures in this group to mipmap level 2, which is quarter resolution.                                                                                                                                                                                                                           |
| **Override Global Mipmap Limit: Eighth Resolution**  | Limits the textures in this group to mipmap level 3, which is eighth resolution.                                                                                                                                                                                                                            |

Open the **More** (**⋮**) menu for additional properties.

| **Additional property** | **Description**                                                                                                                                                                                                                                                                        |
|:------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Identify textures**   | Selects all the textures that belong to the group in the **Project** window. For more information about adding textures to a Mipmap Limit Group, refer to [Texture Import Settings window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html). |
| **Duplicate Group**     | Duplicate the group.                                                                                                                                                                                                                                                                   |
| **Rename Group**        | Rename the group. If you rename a group, a dialog appears that checks if you want to reassign the textures from the old group to the new group, and reimport them. You can’t undo this.                                                                                                |

<span id="anisotropic-textures-dropdown"></span>

#### Anisotropic Textures dropdown

For more detail about anisotropic texture filtering levels, refer to the [`Texture-anisoLevel`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Texture-anisoLevel.html) API.

| **Value**       | **Description**                                                                                                                                                    |
|:----------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Disabled**    | Disables anisotropic filtering.                                                                                                                                    |
| **Per Texture** | Uses the **Aniso Level** each texture is set to in its [texture import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html). |
| **Forced On**   | Uses anisotropic filtering for all textures.                                                                                                                       |

<span id="mipmap-streaming-dropdown"></span>

### Mipmap Streaming dropdown

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Add All Cameras</strong></td><td style="text-align: left;">Indicates whether to use mipmap streaming for all active cameras in the project. If you disable this setting, Unity calculates mipmap streaming only for cameras that have a <strong>Streaming Controller</strong> component.<br />
<br />
For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/TextureStreaming-configure.html">Configure mipmap streaming</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Memory Budget</strong></td><td style="text-align: left;">Limits the total amount of memory for loaded textures, in MB. The default is 512 MB. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/TextureStreaming-configure.html#memory-budget">Set the memory budget for textures</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Renderers Per Frame</strong></td><td style="text-align: left;">Limits how many renderers mipmap streaming processes per frame. A lower number decreases the processing time on the CPU, but increases texture loading times. The default is 512.</td></tr><tr class="even"><td style="text-align: left;"><strong>Max Level Reduction</strong></td><td style="text-align: left;">Sets the number of mipmap levels that the mipmap streaming system can discard if it reaches the <strong>Memory Budget</strong>. The default is 2.<br />
<br />
This value is also the mipmap level that the mipmap streaming system initially loads at startup. For example, when <strong>Max Level Reduction</strong> is set to 2, Unity skips mipmap level 0 and 1 on first load.<br />
<br />
For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/TextureStreaming-configure.html#memory-budget">Set the memory budget for textures</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Max IO Requests</strong></td><td style="text-align: left;">Limits the maximum number of file requests the mipmap streaming system makes at any one time. Lower values avoid the system trying to load too many textures if the scene changes quickly, but reduce how quickly the system reacts to texture changes. The default is 1024, which is high enough to prevent any limit outside the <a href="https://unity.com/blog/engine-platform/understanding-the-async-upload-pipeline">Async Upload pipeline</a> and the file system itself.</td></tr></tbody></table>

<span id="Particles"></span>

### Particles

| **Property**                | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|:----------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Soft Particles**          | Indicates whether to fade particles as they approach the edges of opaque GameObjects. For more information, refer to [Soft particles](https://docs.unity3d.com/6000.3/Documentation/Manual/particle-color.html#soft-particles). This property is only available if your project uses the Built-In Render Pipeline. For the Universal Render Pipeline, refer to [Universal Render Pipeline asset reference for URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html). |
| **Particle Raycast Budget** | Sets the maximum number of raycasts to use for particle system collisions if **Collision Quality** is set to **Medium** or **Low**. For more information, refer to [Particle collisions](https://docs.unity3d.com/6000.3/Documentation/Manual/particle-collisions.html).                                                                                                                                                                                                                             |

<span id="Terrain"></span>

### Terrain

| **Property**                        | **Description**                                                                                                                                                                                                                                                                                                |
|:------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Billboards Face Camera Position** | Enable this option to force billboards to face the camera while rendering instead of the camera plane. This produces a better, more realistic image, but is more expensive to render.                                                                                                                          |
| **Use Legacy Details Distribution** | Enable this option to use the previously supported scattering algorithm that often resulted in overlapping details. Included for backward compatibility with Terrains authored in Unity 2022.1 and earlier.                                                                                                    |
| **Terrain Setting Overrides**       | Various override settings that, when enabled, override the value of all active terrains (except those with the “Ignore Quality Settings” setting enabled). For more information about these settings, see [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html). |
|   Pixel Error                       | Value set to Terrain Pixel Error. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                     |
|   Base Map Dist.                    | Value set to Terrain Basemap Distance. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                |
|   Detail Density Scale              | Value set to Terrain Density Scale. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                   |
|   Detail Distance                   | Value set to Terrain Detail Distance. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                 |
|   Tree Distance                     | Value set to Terrain Tree Distance. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                   |
|   Billboard Start                   | Value set to Terrain Billboard Start. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                 |
|   Fade Length                       | Value set to Terrain Fade Length. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                     |
|   Max Mesh Trees                    | Value set to Terrain Max Mesh Trees. See [Terrain Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-OtherSettings.html).                                                                                                                                                                  |

<span id="Shadows"></span>

### Shadows

| **Property**        | **Description**                                                                                                                                                                                                                                                                       |
|:--------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Shadowmask Mode** | Controls when Unity uses baked shadows and real-time shadows if you set **Lighting Mode** to **Shadowmask**. For the dropdown options, refer to [Shadowmask mode dropdown](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#shadowmask-mode-dropdown). |

The following properties are only available if your project uses the Built-In Render Pipeline. For the Universal Render Pipeline, refer to [Universal Render Pipeline asset reference for URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html).

| **Property**                 | **Description**                                                                                                                                                                                                                                                                                                                                                                                           |
|:-----------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Shadows**                  | Identifies whether to render soft or hard shadows, or no shadows.                                                                                                                                                                                                                                                                                                                                         |
| **Shadow Resolution**        | Controls the visual fidelity of shadows. The higher the resolution, the greater the processing overhead, and the memory used on the GPU.                                                                                                                                                                                                                                                                  |
| **Shadow Projection**        | Controls the quality and stability of shadows from the directional light. For the dropdown settings, refer to [Shadows Projection dropdown](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html#shadows-projection-dropdown).                                                                                                                                                 |
| **Shadow Distance**          | Sets the distance away from the camera where Unity no longer renders shadows, in meters.                                                                                                                                                                                                                                                                                                                  |
| **Shadow Near Plane Offset** | Sets how far to pull back the near clip plane of a shadow map. Use this setting to fix distorted shadows cast by large triangles. For more information, refer to [Shadow pancaking](https://docs.unity3d.com/6000.3/Documentation/Manual/ShadowPerformance.html#shadow-pancaking).                                                                                                                        |
| **Shadow Cascades**          | Choose the number of shadow cascades to use. A higher number of shadow cascades results in higher-quality shadows but a longer processing time. For more information, refer to [Shadow cascades](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-landing.html).                                                                                                                      |
| **Cascade splits**           | Controls the distance where each shadow cascade starts and ends. To adjust the distances, select and drag the vertical lines between each pair of cascades. This property is only available if you set **Shadow Cascades** to **Two Cascades** or **Four Cascades**. For more information, refer to [Shadow cascades](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-landing.html). |

#### Shadowmask mode dropdown

For more information, refer to [Lighting Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html).

| **Value**               | **Description**                                                                                                                            |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------|
| **Shadowmask**          | Casts baked shadows from static GameObjects at all distances.                                                                              |
| **Distance Shadowmask** | Casts baked shadows only from static GameObjects beyond the distance set in **Shadow Distance**. Other GameObjects cast real-time shadows. |

#### Shadows Projection dropdown

| **Value**      | **Description**                                                                             |
|:---------------|:--------------------------------------------------------------------------------------------|
| **Close Fit**  | Renders higher resolution shadows that might sometimes wobble slightly if the camera moves. |
| **Stable Fit** | Renders lower resolution shadows that don’t wobble.                                         |

<span id="AsyncAssetUpload"></span>

### Async Asset Upload

For more information about the asynchronous upload pipeline, refer to [Texture and mesh loading](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingTextureandMeshData.html).

| **Property**          | **Description**                                                                                               |
|:----------------------|:--------------------------------------------------------------------------------------------------------------|
| **Time Slice**        | Sets the amount of CPU time in ms per frame Unity spends uploading buffered texture and mesh data to the GPU. |
| **Buffer Size**       | Sets the size in MB of the asynchronous upload buffer Unity uses to stream texture and mesh data to the GPU.  |
| **Persistent Buffer** | Indicates whether the upload buffer persists when there’s nothing left to upload.                             |

<span id="LevelOfDetail"></span>

### Level of Detail

For more information, refer to [Optimize mesh rendering using level of detail (LOD)](https://docs.unity3d.com/6000.3/Documentation/Manual/lod-landing.html).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><span id="LODBias"></span><strong>LOD Bias</strong></td><td style="text-align: left;">Adjusts the detail level of GameObjects by scaling the distances where Unity transitions between different level of detail (LOD) meshes. A <strong>LOD Bias</strong> value between 0 and 1 results in Unity selecting lower-quality LODs at closer distances than normal. A value of 1 or more results in Unity selecting lower-quality LODs at farther distances than normal, so GameObjects retain higher quality for longer. For example, if you set <strong>LOD Bias</strong> to 2, a transition to a lower-quality LOD level that usually happens at 50% distance now happens at 25% distance (50% / 2 = 25%).</td></tr><tr class="even"><td style="text-align: left;"><span id="maxLOD"></span><strong>Maximum LOD Level</strong></td><td style="text-align: left;">Sets the lowest LOD level the project uses. Unity removes LOD meshes below the <strong>Maximum LOD level</strong> from the build, which makes the build smaller, and reduces memory use at runtime. If you have different quality levels that use different <strong>Maximum LOD Level</strong> values, Unity uses the smallest value. For example, if any quality level uses a <strong>Maximum LOD Level</strong> of 0, Unity includes all LOD levels in the build.<br />
<strong>Note:</strong> If a model is included in <a href="http://docs.unity3d.com/Packages/com.unity.addressables@latest/index.html">Addressables</a> group, Unity adds the entire model including all LOD meshes in the build, regardless of the <strong>Maximum LOD level</strong> property.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Mesh LOD Threshold</strong></td><td style="text-align: left;">Affects how Unity selects a LOD index to render. Increasing the value makes Unity favor less detailed LODs in the evaluation process. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-quality.html#project-wide-quality-setting">Mesh LOD runtime quality</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>LOD Cross Fade</strong></td><td style="text-align: left;">Smooths the transition between LOD meshes by fading between two LOD levels using a dithering pattern. This property is only available if your project uses the Built-In Render Pipeline. For the Universal Render Pipeline, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html">Universal Render Pipeline asset reference for URP</a>.</td></tr></tbody></table>

<span id="Meshes"></span>

### Meshes

| **Property**                                    | **Description**                                                                                                                                                                                                                         |
|:------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span id="BlendWeights"></span>**Skin Weights** | Sets the number of bones that can affect a vertex during an animation. For more information, refer to [Skinned Mesh Renderer component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SkinnedMeshRenderer.html). |

## Additional resources

-   [Create and manage build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html)
