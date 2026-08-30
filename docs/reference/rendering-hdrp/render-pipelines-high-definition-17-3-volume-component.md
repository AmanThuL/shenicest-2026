---
title: "Volume component reference"
page_title: "Volume component | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Volume component

The Volume component lets you configure a Volume. Refer to [Understand volumes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) for more information about Volumes.

## Properties

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>Mode</strong></td>
<td style="text-align: left;">Use the drop-down to select the method that HDRP uses to calculate whether this Volume can affect a Camera:<br />
• <strong>Global</strong>: Makes the Volume have no boundaries and allow it to affect every Camera in the Scene.<br />
• <strong>Local</strong>: Allows you to specify boundaries for the Volume so that the Volume only affects Cameras inside the boundaries. Add a Collider to the Volume's GameObject and use that to set the boundaries.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Blend Distance</strong></td>
<td style="text-align: left;">The furthest distance from the Volume’s Collider that HDRP starts blending from. A value of 0 means HDRP applies this Volume’s overrides immediately upon entry.<br />
This property only appears when you select <strong>Local</strong> from the <strong>Mode</strong> drop-down.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Weight</strong></td>
<td style="text-align: left;">The amount of influence the Volume has on the Scene. HDRP applies this multiplier to the value it calculates using the Camera position and Blend Distance.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Priority</strong></td>
<td style="text-align: left;">HDRP uses this value to determine which Volume it uses when Volumes have an equal amount of influence on the Scene. HDRP uses Volumes with higher priorities first. If multiple volumes have the same priority, HDRP can evaluate them in any order. This means a global volume can take precedence over a local volume, even if the camera is inside the local volume.</td>
</tr>
<tr>
<td style="text-align: left;"><strong>Profile</strong></td>
<td style="text-align: left;">A Volume Profile Asset that contains the Volume overrides that store the properties HDRP uses to handle this Volume.</td>
</tr>
</tbody>
</table>

## Volume Profiles

The **Profile** field stores a [Volume Profile](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-volume-profile.html), which is an Asset that contains the properties that HDRP uses to render the Scene. You can edit this Volume Profile, or assign a different Volume Profile to the **Profile** field. You can also create a Volume Profile or clone the current one by clicking the **New** and **Clone** buttons respectively.

## Configuring a local Volume

If you select **Local** from the **Mode** drop-down on your Volume, you must attach a Trigger Collider to the GameObject to define its boundaries:

1.  Select the Volume to open it in the Inspector.
2.  Got to **Add Component** \> **Physics** \> **Box Collider**.
3.  To define the boundary of the Volume, adjust the **Size** field of the Box Collider, and the **Scale** field of the Transform.

You can use any type of 3D Collider, from simple Box Colliders to more complex convex Mesh Colliders. However, for performance reasons, use simple colliders because traversing Mesh Colliders with many vertices is resource intensive. Local volumes also have a **Blend Distance** that represents the outer distance from the Collider surface where HDRP begins to blend the settings for that Volume with the others affecting the Camera.
