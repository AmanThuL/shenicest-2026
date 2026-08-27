---
title: "Use Adaptive Probe Volumes"
page_title: "Use Adaptive Probe Volumes | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-use.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-use.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Use Adaptive Probe Volumes

This page provides the basic workflow you need to use Adaptive Probe Volumes in your project.

## Add and bake an Adaptive Probe Volume

### Enable Adaptive Probe Volumes

1.  From the main menu, select **Edit** \> **Project Settings** \> **Quality** \> **HDRP**.
2.  Expand **Lighting** \> **Light Probe Lighting**.
3.  Set **Light Probe System** to **Adaptive Probe Volumes**.
4.  Select the **Graphics** \> **Pipeline Specific Settings** \> **HDRP** tab.
5.  Go to **Frame Settings**.
6.  Expand **Camera** \> **Lighting** and enable **Adaptive Probe Volumes**.

To make sure Reflection Probes also capture lighting data from Adaptive Probe Volumes, you should also do the following:

1.  Expand **Realtime Reflection** \> **Lighting** and enable **Adaptive Probe Volumes**.
2.  Expand **Baked or Custom Reflection** \> **Lighting** and enable **Adaptive Probe Volumes**.

### Add an Adaptive Probe Volume to the Scene

1.  From the main menu, select **GameObject** \> **Light** \> **Adaptive Probe Volumes** \> **Adaptive Probe Volume**.
2.  In the Inspector for the Adaptive Probe Volume, set **Mode** to **Global** to make this Adaptive Probe Volume cover your entire Scene.

### Adjust your Light and Mesh Renderer settings

1.  To include a Light in an Adaptive Probe Volume's baked lighting data, open the Inspector for the Light then set the **Light Mode** to **Mixed** or **Baked**.
2.  To include a GameObject in an Adaptive Probe Volume's baked lighting data, open the Inspector for the GameObject and enable **Contribute Global Illumination**.
3.  To make a GameObject receive baked lighting, open the Inspector for the GameObject, then in the **Mesh Renderer** component set **Receive Global Illumination** to **Light Probes**.

### Bake your lighting

1.  From the main menu, select **Window** \> **Rendering** \> **Lighting**.
2.  Select the **Adaptive Probe Volumes** panel.
3.  Set **Baking Mode** to **Single Scene**.
4.  Select **Generate Lighting**.

If no scene in the Baking Set contains an Adaptive Probe Volume, Unity asks if you want to create an Adaptive Probe Volume automatically.

You can change baking settings in the Lighting window's [Lightmapping Settings](https://docs.unity3d.com/Documentation/Manual/class-LightingSettings.html#LightmappingSettings).

Refer to [Bake different lighting setups with Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-usebakingsets.html) for more information about Baking Sets.

If there are visual artefacts in baked lighting, such as dark blotches or light leaks, refer to [Fix issues with Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-fixissues.html).

## Configure an Adaptive Probe Volume

You can use the following to configure an Adaptive Probe Volume:

- Use the [Adaptive Probe Volumes panel](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-lighting-panel-reference.html) in the Lighting window to change the probe spacing and behaviour in all the Adaptive Probe Volumes in a Baking Set.
- Use the settings in the [Adaptive Probe Volume Inspector window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-inspector-reference.html) to change the Adaptive Probe Volume size and probe density.
- Add a [Probe Adjustment Volume component](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-adjustment-volume-component-reference.html) to the Adaptive Probe Volume, to make probes invalid in a small area or fix other lighting issues.
- Add a [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) to your scene with a [Probe Volumes Options Override](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-options-override-reference.html), to change the way HDRP samples Adaptive Probe Volume data when the camera is inside the volume. This doesn't affect baking.

## Additional resources

- [Bake multiple scenes together with Baking Sets](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-usebakingsets.html)
- [Change lighting at runtime](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/change-lighting-at-runtime.html)
- [Fix issues with Adaptive Probe Volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/probevolumes-fixissues.html)
- [Work with multiple Scenes in Unity](https://docs.unity3d.com/Documentation/Manual/MultiSceneEditing.html)
