---
title: "Unity 6.3 Manual: Static GameObjects"
page_title: "Unity - Manual: Static GameObjects"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StaticObjects.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StaticObjects.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Static GameObjects

If a GameObject does not move at runtime, it is known as a **static GameObject**. If a GameObject moves at runtime, it is known as a **dynamic GameObject**.

Many systems in Unity can precompute information about static GameObjects in the Editor. Because the GameObjects do not move, the results of these calculations are still valid at runtime. This means that Unity can save on runtime calculations, and potentially improve performance.

## The Static Editor Flags property

![The Static Editor Flags checkbox and drop-down menu, as seen when viewing a GameObject in the Inspector](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/GameObjectStaticDropDownMenu1.png)

The **Static Editor Flags** property lists a number of Unity systems which can include a static GameObject in their precomputations. Use the drop-down to define which systems include the GameObject in their precomputations. Setting Static Editor Flags at runtime has no effect on these systems.

Only include a GameObject in the precomputations for systems that need to know about that GameObject. Including a GameObject in the precomputations for a system that does not need to know about that GameObject can result in wasted calculations, unnecessarily large data files, or unexpected behavior.

The **Static Editor Flags** property is located in the Inspector for a GameObject, in the extreme top-right. It includes a checkbox, which sets the value to **Everything** or **Nothing**, and a dropdown menu that lets you choose which values to include.

To set the Static Editor Flags property in code, use the [GameObjectUtility.SetStaticEditorFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.SetStaticEditorFlags.html) API and the [GameObject.isStatic](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-isStatic.html). To get the status of the Static Editor Flags property in code, use the [GameObjectUtility.GetStaticEditorFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.GetStaticEditorFlags.html) API.

The following values are available:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Nothing</strong></td><td style="text-align: left;">Do not include the GameObject in precomputations for any systems.</td></tr><tr class="even"><td style="text-align: left;"><strong>Everything</strong></td><td style="text-align: left;">Include the GameObject in precomputations for all systems below.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Contribute GI</strong></td><td style="text-align: left;">When you enable this property, Unity includes the target <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html">Mesh Renderer</a> in global illumination calculations. These calculations take place while precomputing lighting data at bake time. The ContributeGI property exposes the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ReceiveGI.html">ReceiveGI</a> property. The ContributeGI property only takes effect if you enable a global illumination setting such as <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-LightingSettings.html#MixedLighting">Baked Global Illumination</a> or <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-LightingSettings.html#RealtimeLighting">Enlighten Realtime Global Illumination</a> for the target Scene. For additional context, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-lighting-setup.html">this tutorial for setting up the Built-in Render Pipeline and lighting</a> in Unity.</td></tr><tr class="even"><td style="text-align: left;"><strong>Occluder Static</strong></td><td style="text-align: left;">Mark the GameObject as a Static Occluder in the occlusion culling system. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html">the Occlusion Culling system</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Occludee Static</strong></td><td style="text-align: left;">Mark the GameObject as a Static Occludee in the occlusion culling system. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html">the Occlusion Culling system</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Batching Static</strong></td><td style="text-align: left;">Combine the GameObject’s Mesh with other eligible Meshes, to potentially reduce runtime rendering costs. For more information, refer to the documentation on <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html">Static Batching</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Navigation Static</strong></td><td style="text-align: left;">Include the GameObject when precomputing navigation data. This workflow is deprecated and you cannot set <strong>Navigation Static</strong> here. However, you can still set this option in code with <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StaticEditorFlags.NavigationStatic.html"><code>StaticEditorFlags.NavigationStatic</code></a>.<br />
Instead of <strong>Navigation Static</strong> flags, use the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@latest/index.html?subfolder=/manual/NavMeshModifier.html"><strong>NavMesh Modifier</strong></a> component together with <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@latest/index.html?subfolder=/manual/NavMeshSurface.html"><strong>NavMesh Surfaces</strong></a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Off Mesh Link Generation</strong></td><td style="text-align: left;">Attempt to generate an OffMesh Link that starts from this GameObject when precomputing navigation data. This workflow is deprecated and you cannot set <strong>Off Mesh Link Generation</strong> from this menu. However, you can still set this option in code with <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StaticEditorFlags.OffMeshLinkGeneration.html"><code>StaticEditorFlags.OffMeshLinkGeneration</code></a>.<br />
Instead of <strong>Off Mesh Link Generation</strong> flags, use the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@latest/index.html?subfolder=/manual/NavMeshModifier.html"><strong>NavMesh Modifier</strong></a> component together with <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@latest/index.html?subfolder=/manual/NavMeshSurface.html"><strong>NavMesh Surfaces</strong></a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Reflection Probe</strong></td><td style="text-align: left;">Include this GameObject when precomputing data for <strong>Reflection Probes</strong> whose <strong>Type</strong> property is set to <strong>Baked</strong>. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html">Reflection Probes</a>.</td></tr></tbody></table>

## Additional resources

-   [GameObjectUtility.SetStaticEditorFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.SetStaticEditorFlags.html)
-   [GameObjectUtility.GetStaticEditorFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.GetStaticEditorFlags.html)
-   [StaticEditorFlags.NavigationStatic](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StaticEditorFlags.NavigationStatic.html)
-   [StaticEditorFlags.OffMeshLinkGeneration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StaticEditorFlags.OffMeshLinkGeneration.html)
-   [StaticEditorFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StaticEditorFlags.html)
-   [Draw call batching](https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html)
-   [Occlusion Culling](https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html)
-   [NavMesh Modifier component](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshModifier.html)
-   [NavMesh Surface component](https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html)
-   [Reflection Probes](https://docs.unity3d.com/6000.3/Documentation/Manual/ReflectionProbes.html)
