---
title: "Decal Projector reference"
page_title: "Decal Projector reference | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-projector-reference.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-projector-reference.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Decal Projector reference

To edit a Decal Projector’s properties, select the GameObject with the Decal Projector component and use the Inspector. If you just want to change the size of the projection, you can either use the Inspector or one of the Decal Projector's Scene view gizmos.

## Scene view

The Decal Projector includes a Scene view representation of its bounds and projection direction to help you position the projector. The Scene view representation includes:

- A box that describes the 3D size of the projector; the projector draws its decal on every Material inside the box.

- An arrow that indicates the direction the projector faces. The base of this arrow is on the pivot point.

![Decal Projector Scene view.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/DecalProjector2.png)

The decal Projector also includes three gizmos. The first two add handles on every face for you to click and drag to alter the size of the projector's bounds.

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th><strong>Button</strong></th>
<th><strong>Gizmo</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><img src="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/DecalProjector3.png" alt="Decal Projector Scale gizmo." /></td>
<td><strong>Scale</strong></td>
<td>Scales the decal with the projector box. This changes the UVs of the Material to match the size of the projector box. This stretches the decal. The Pivot remains still.</td>
</tr>
<tr>
<td><img src="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/DecalProjector4.png" alt="Decal Projector Crop gizmo." /></td>
<td><strong>Crop</strong></td>
<td>Crops the decal with the projector box. This changes the size of the projector box but not the UVs of the Material. This crops the decal. The Pivot remains still.</td>
</tr>
<tr>
<td><img src="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/DecalProjector5.png" alt="Decal Projector Pivot / UV gizmo." /></td>
<td><strong>Pivot / UV</strong></td>
<td>Moves the decal's pivot point without moving the projection box. This changes the transform position.<br />
Note this also sets the UV used on the projected texture.</td>
</tr>
</tbody>
</table>

The color of the gizmos can be set up in the Preference window inside Color panel.

## Inspector properties

Using the Inspector allows you to change all of the Decal Projector properties, and lets you use numerical values for **Size**, **Tiling**, and **Offset**, which allows for greater precision than the click-and-drag gizmo method.

## Properties

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
<td><strong>Scale Mode</strong></td>
<td>The scaling mode to apply to decals that use this Decal Projector. The options are:<br />
• <strong>Scale Invariant</strong>: Ignores the transformation hierarchy and uses the scale values in this component directly.<br />
• <strong>Inherit from Hierarchy</strong>: Multiplies the <a href="https://docs.unity3d.com/ScriptReference/Transform-lossyScale.html">lossy scale</a> of the Transform with the Decal Projector's own scale then applies this to the decal. Note that since the Decal Projector uses orthogonal projection, if the transformation hierarchy is <a href="https://docs.unity3d.com/Manual/class-Transform.html">skewed</a>, the decal does not scale correctly.</td>
</tr>
<tr>
<td><strong>Size</strong></td>
<td>The size of the projector influence box, and thus the decal along the projected plane. The projector scales the decal to match the <strong>Width</strong> (along the local x-axis) and <strong>Height</strong> (along the local y-axis) components of the <strong>Size</strong>.</td>
</tr>
<tr>
<td><strong>Projection Depth</strong></td>
<td>The depth of the projector influence box. The projector scales the decal to match <strong>Projection Depth</strong>. The Decal Projector component projects decals along the local z-axis.</td>
</tr>
<tr>
<td><strong>Pivot</strong></td>
<td>The offset position of the transform regarding the projection box. To rotate the projected texture around a specific position, adjust the <strong>X</strong> and <strong>Y</strong> values. To set a depth offset for the projected texture, adjust the <strong>Z</strong> value.</td>
</tr>
<tr>
<td><strong>Material</strong></td>
<td>The decal Material to project. The decal Material must use a HDRP/Decal Shader. Use the <strong>New</strong> dropdown to create a new material and its associated shader from a template. The options are the following:
<ul>
<li><strong>HDRP Decal</strong>: Creates a new decal Material that uses the default HDRP Decal Shader. This provides a ready‑to‑use decal shader set up for HDRP’s decal system.</li>
<li><strong>ShaderGraph Decal</strong>: Creates a new material or material variant from a new shader graph asset based on the <strong>Decal Simple</strong> shader graph template, which uses the default <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/decal-master-stack-reference.html"><strong>HDRP Decal</strong> material type</a>. This is recommended for building decals visually without writing shader code.<br />
<strong>Note</strong>: To define if Unity creates a material or a material variant from the shader graph asset, refer to the <strong>Graph Template Workflow</strong> option in the <a href="https://docs.unity3d.com/Packages/com.unity.shadergraph@latest/index.html?subfolder=/manual/Shader-Graph-Preferences.html">Shader Graph Preferences</a>.</li>
</ul></td>
</tr>
<tr>
<td><strong>Decal Layer</strong></td>
<td>The layer that specifies the Materials to project the decal onto. Any Mesh Renderers or Terrain that uses a matching Decal Layer receives the decal.</td>
</tr>
<tr>
<td><strong>Draw Distance</strong></td>
<td>The distance from the Camera to the Decal at which this projector stops projecting the decal and HDRP no longer renders the decal.</td>
</tr>
<tr>
<td><strong>Start Fade</strong></td>
<td>Use the slider to set the distance from the Camera at which the projector begins to fade out the decal. Scales from 0 to 1 and represents a percentage of the <strong>Draw Distance</strong>. A value of 0.9 begins fading the decal out at 90% of the <strong>Draw Distance</strong> and finished fading it out at the <strong>Draw Distance</strong>.</td>
</tr>
<tr>
<td><strong>Angle Fade</strong></td>
<td>Use the min-max slider to control the fade out range of the decal based on the angle between the Decal backward direction and the vertex normal of the receiving surface. Only available if <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-decals.html">Decal Layers</a> feature is enabled.</td>
</tr>
<tr>
<td><strong>Tiling</strong></td>
<td>Scales the decal Material along its UV axes.</td>
</tr>
<tr>
<td><strong>Offset</strong></td>
<td>Offsets the decal Material along its UV axes. Use this with the <strong>UV Scale</strong> when using a Material atlas for your decal.</td>
</tr>
<tr>
<td><strong>Fade Factor</strong></td>
<td>Allows you to manually fade the decal in and out. A value of 0 makes the decal fully transparent, and a value of 1 makes the decal as opaque as defined by the <strong>Material</strong>. The <strong>Material</strong> manages the maximum opacity of the decal using <strong>Global Opacity</strong> and an opacity map.</td>
</tr>
<tr>
<td><strong>Affects Transparent</strong></td>
<td>Enable the checkbox to allow HDRP to draw the projector’s decal on top of transparent surfaces. HDRP packs all Textures from decals with <strong>Affects Transparent</strong> enabled into an atlas, which can affect memory and performance. You can edit the dimensions of this atlas in the <strong>Decals</strong> section of your Unity Project’s <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#Decals">HDRP Asset</a>.</td>
</tr>
<tr>
<td><strong>Transparent Texture Resolution</strong></td>
<td>Determines the size of the texture within the decal atlas. This is only being used if the selected material is a <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-master-stack-reference.html">Decal Master Stack</a> material and <strong>Affects Transparent</strong> is enabled. The same resolution applies to all textures that the material affects. If multiple projectors use the same material but have different texture resolutions only the largest resolution is added to the atlas. The default values can be changed in the Decal section of your Unity Project’s <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#Decals">HDRP Asset</a>.</td>
</tr>
</tbody>
</table>

## Limitations

- Emissive decals isn't supported on Transparent Material.
- Emissive decals always give an additive positive contribution. This property does not affect the existing emissive properties of the Materials assigned to a GameObject.
- The **Receive Decals** property of Materials in HDRP does not affect emissive decals. HDRP always renders emissive decals unless you use Decal Layers, which can disable emissive decals on a Layer by Layer basis.
- If you project a decal onto a transparent surface, HDRP ignores the decal's Texture tiling.
- [Decal Master Stack](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-master-stack-reference.html) materials that have **Affects Transparent** enabled do not support changes to the vertex inputs. Geometry, scene, and buffer inputs are also not supported.
- In **Project Settings \> Graphics**, if **Instancing Variants** is set to **Strip All**, Unity strips the Decal Shader this component references when you build your Project. This happens even if you include the Shader in the **Always Included Shaders** list. If Unity strips the Shader during the build process, the decal does not appear in your built Application.
