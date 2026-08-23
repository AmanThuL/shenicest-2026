---
title: "Unity 6.3 Manual: Rig tab Import Settings reference"
page_title: "Unity - Manual: Rig tab Import Settings reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Rig tab Import Settings reference

The settings on the **Rig** tab define how Unity maps the deformers to the mesh in the imported model so that you can animate it. For humanoid characters, this means [assigning or creating an avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html). For non-humanoid (generic) characters, this means [identifying a root bone in the skeleton](https://docs.unity3d.com/6000.3/Documentation/Manual/GenericAnimations.html).

To open the Rig tab, select a mesh, and in the Inspector select the **Rig** tab.

## Animation Type

The value you select for the **Animation Type** determines the layout for the **Rig** tab.

By default, when you select a model in the **Project** view, Unity determines which **Animation Type** best matches the selected model and displays it in the **Rig** tab. If Unity has never imported the file, the Animation Type is set to **None**.

| **Property** | **Description**                                                                                                                                                                                                                                                                                                                                                     |
|:-------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **None**     | No animation present.                                                                                                                                                                                                                                                                                                                                               |
| **Legacy**   | Use the [Legacy Animation System](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#LegacyRig). Import and use animations as with Unity version 3.x and earlier.                                                                                                                                                                            |
| **Generic**  | Use the [Generic Animation System](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#GenericRig) if your rig is non-humanoid (quadruped or any entity to be animated). Unity picks a root node automatically but you can identify another bone to use as the **Root node** instead.                                                         |
| **Humanoid** | Use the [Humanoid Animation System](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#HumanoidRig) if your rig is humanoid (it has two legs, two arms and a head). Unity usually detects the skeleton and maps it to the Avatar correctly. In some cases, you may need to set the **Avatar Definition** and configure the mapping manually. |

<span id="GenericRig"></span>

## Generic animation types

[Generic Animations](https://docs.unity3d.com/6000.3/Documentation/Manual/GenericAnimations.html) do not use Avatars like Humanoid animations do. Since the skeleton can be arbitrary, you must specify which bone is the **Root node**. The Root node allows Unity to establish consistency between Animation clips for a generic model, and blend properly between Animations that have not been authored “in place” (that is, where the whole model moves its world position while animating).

Specifying the root node helps Unity determine between movement of the bones relative to each other, and motion of the Root node in the world (controlled from [OnAnimatorMove](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorMove.html)).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Avatar Definition</strong></td><td style="text-align: left;">Choose where to get the Avatar definition. The following options are available:<ul><li><strong>Create from this model</strong> - Create an Avatar based on this model</li><li><strong>Copy from Other Avatar</strong> - Point to an Avatar set up on another model.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Root node</strong></td><td style="text-align: left;">Select the bone to use as a root node for this Avatar.<br />
<br />
This setting is only available if you set the <strong>Avatar Definition</strong> to <strong>Create From This Model</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Source</strong></td><td style="text-align: left;">Copy another Avatar with an identical rig to import its animation clips.<br />
<br />
This setting is only available if you set the <strong>Avatar Definition</strong> to <strong>Copy from Other Avatar</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Skin Weights</strong></td><td style="text-align: left;">Set the maximum number of bones that can influence a single vertex. The following options are available:<ul><li><strong>Standard (4 Bones)</strong> - Use a maximum influence of four bones. This is the default, and is recommended for performance.</li><li><strong>Custom</strong> - Set your own maximum number of bones. When you select this option, the <strong>Max Bones/Vertex</strong> and <strong>Max Bone Weight</strong> properties appear.</li></ul></td></tr><tr class="odd"><td style="text-align: left;"><strong>Max Bones/Vertex</strong></td><td style="text-align: left;">Set the maximum number of bones per vertex to influence a given vertex. You can set between 1 and 32 bones per vertex, but the higher the number of bones you use to influence a vertex, the greater the performance cost.<br />
<br />
This setting is only available you set the <strong>Skin Weights</strong> property to <strong>Custom</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Max Bone Weight</strong></td><td style="text-align: left;">Set the bottom threshold for considering bone weights. The weighting calculation ignores anything smaller than this value, and Unity scales up the bone weights higher than this value to a total of 1.0.<br />
<br />
This setting is only available if the <strong>Skin Weights</strong> property is set to <strong>Custom</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Strip Bones</strong></td><td style="text-align: left;">Enable to only add bones to Skinned Mesh Renderers that have skin weights assigned to them.</td></tr><tr class="even"><td style="text-align: left;"><strong>Optimize Game Object</strong></td><td style="text-align: left;">Remove and store the GameObject Transform hierarchy of the imported character in the Avatar and Animator component. If enabled, the SkinnedMeshRenderers of the character use the Unity animation system’s internal skeleton, which improves the performance of the animated characters.<br />
<br />
Only available if the <strong>Avatar Definition</strong> is set to <strong>Create From This Model</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Extra Transforms to Expose</strong></td><td style="text-align: left;">Specify which Transform paths you want Unity to ignore when <strong>Optimize Game Object</strong> is enabled. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#ExtraTransforms">Including extra Transforms</a>.<br />
<br />
This section only appears when <strong>Optimize Game Object</strong> is enabled.</td></tr></tbody></table>

<span id="HumanoidRig"></span>

## Humanoid animation types

![Your rig is *humanoid* (it has two legs, two arms and a head)](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/Rig-2.png)

With rare exceptions, humanoid models have the same basic structure. This structure represents the major articulated parts of the body: the head and limbs. The first step to using Unity’s [Humanoid animation features](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html) is to [set up and configure](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Avatar.html) an **Avatar**. Unity uses the Avatar to map the simplified humanoid bone structure to the actual bones present in the Model’s skeleton.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Avatar Definition</strong></td><td style="text-align: left;">Choose where to get the Avatar definition. The following options are available:<ul><li><strong>Create from this model</strong> - Create an Avatar based on this model</li><li><strong>Copy from Other Avatar</strong> - Point to an Avatar set up on another model.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Source</strong></td><td style="text-align: left;">Copy another Avatar with an identical rig to import its animation clips.<br />
<br />
Only available if the <strong>Avatar Definition</strong> is set to <strong>Copy from Other Avatar</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Configure</strong></td><td style="text-align: left;">Open the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Avatar.html">Avatar configuration</a>.<br />
<br />
Only available if the <strong>Avatar Definition</strong> is set to <strong>Create From This Model</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Skin Weights</strong></td><td style="text-align: left;">This property is identical for both Humanoid and Generic Models. Refer to the <strong>Skin Weights</strong> property for <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#GenericRig">Generic</a> models above for more information.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Strip Bones</strong></td><td style="text-align: left;">Enable to only add bones to Skinned Mesh Renderers that have skin weights assigned to them.</td></tr><tr class="even"><td style="text-align: left;"><strong>Optimize Game Object</strong></td><td style="text-align: left;">Remove and store the GameObject Transform hierarchy of the imported character in the Avatar and Animator component. If enabled, the SkinnedMeshRenderers of the character use the Unity animation system’s internal skeleton, which improves the performance of the animated characters.<br />
<br />
Only available if the <strong>Avatar Definition</strong> is set to <strong>Create From This Model</strong>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Extra Transforms to Expose</strong></td><td style="text-align: left;">Specify which Transform paths you want Unity to ignore when <strong>Optimize Game Object</strong> is enabled. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#ExtraTransforms">Including extra Transforms</a>.<br />
<br />
This section only appears when <strong>Optimize Game Object</strong> is enabled.</td></tr></tbody></table>

<span id="ExtraTransforms"></span>

## Including extra Transforms

When you enable the **Optimize Game Object** property, Unity ignores any Transform which is part of the hierarchy but is not mapped in the Avatar, in order to improve CPU performance. However, you can mark specific nodes in the GameObject hierarchy to include in calculations using the **Extra Transforms to Expose** section:

![The Extra Transforms to Expose property appears when Optimize Game Objects is enabled](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ExtraTransforms.png)

**(A)** Enter the full or partial name in the search box to filter the list of Transforms. This makes it easier to navigate through characters with a large number of bones.

**(B)** Enable each Transform (bones of a skeleton) you want Unity to include in calculations.

**(C)** Use the buttons to help select specific Transforms. For example, the **Toggle All** button selects or deselects everything at once (regardless of the current selection, including filtered items).

**(D)** Use the **Revert** button to undo your selections or the **Apply** button to apply the exceptions to the Model.

**Note**: In optimized mode, skinned Mesh matrix extraction is multi-threaded.

<span id="LegacyRig"></span>

## Legacy animation types

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Generation</strong></td><td style="text-align: left;">Select the animation import method. The following options are available:<ul><li><strong>Don’t Import</strong> - Do not import animation</li><li><strong>Store in Original Roots (Deprecated)</strong> - Deprecated. Do not use.</li><li><strong>Store in Nodes (Deprecated)</strong> - Deprecated. Do not use.</li><li><strong>Store in Root (Deprecated)</strong> - Deprecated. Do not use.</li><li><strong>Store in Root (New)</strong> - Import the animation and store it in the Model’s root node. This is the default setting.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Skin Weights</strong></td><td style="text-align: left;">This property is the same for Legacy as for Humanoid and Generic Models. Refer to the <strong>Skin Weights</strong> property for <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html#GenericRig">Generic</a> models above for more information.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Strip Bones</strong></td><td style="text-align: left;">Enable to only add bones to Skinned Mesh Renderers that have skin weights assigned to them.</td></tr></tbody></table>

For more information about legacy animation, refer to the documentation for [Legacy Animation System](https://docs.unity3d.com/6000.3/Documentation/Manual/Animations.html).
