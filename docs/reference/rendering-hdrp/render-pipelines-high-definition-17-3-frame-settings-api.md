---
title: "Modify frame settings at runtime"
page_title: "Frame Settings Scripting API | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings-API.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings-API.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Frame Settings Scripting API

In the High Definition Render Pipelines (HDRP), [Frame Settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings.html) control how a rendering component, such as a [Camera](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/hdrp-camera-component-reference.html), [Reflection Probe](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Probe.html), or [Planar Reflection Probe](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Planar-Reflection-Probe.html), renders a Scene. You can specify default Frame Setting values for your entire Project and then override them for a particular rendering component. This means that each Frame Setting has a default value, set in the [HDRP Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html), then each individual rendering component in your Scene can have an override for it. This is useful if you have lower priority rendering components that do not need to use certain effects. To specify which default Frame Setting values a rendering component overrides, each rendering component contains an <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.FrameSettingsOverrideMask.html" class="xref">override mask</a>. A mask is an array of bits, where each bit represents one of two states (0 for disabled and 1 for enabled). Each bit in the override mask represents the override state of a particular Frame Setting.

To get the final value of a Frame Setting for a particular rendering component, HDRP performs the following steps:

1.  Checks the Project-wide default value for the Frame Setting. In this step, HDRP checks the current value stored for the Frame Setting in the HDRP Global Settings Asset.
2.  Checks the rendering component's override mask to see if the bit that corresponds to the Frame Setting is set. The state of the Frame Setting's bit in the override mask corresponds to the state of the override checkbox to the left of the Frame Setting in the rendering component's Inspector.
3.  Gets the Frame Setting's override value from the rendering component's custom Frame Settings.
4.  Sanitizes the result. To lighten your Project, you can specify which features to use in the HDRP Asset. If the Frame Setting you try to modify affects an unavailable feature, Unity discards it in this final sanitization pass. To make sure it is not possible for HDRP to process features that are not available, you cannot access the sanitization process via scripting API.

## Modifying default Frame Setting values

The project's HDRP Global Settings asset stores default values to apply to Frame Settings, so it is not good practice to modify them at runtime. Instead, you can modify them in Edit mode in the [HDRP Graphics settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html).

Note that you can set individual default values for three types of rendering component:

- Cameras
- Realtime Reflection Probes and Realtime Planar Reflection Probes
- Baked/custom Reflection Probes and Baked/custom Planar Reflection Probe

There is currently no scripting API to modify default values for the Frame Settings.

## Modifying Frame Setting values for a particular rendering component

HDRP stores the Frame Settings for rendering components in additional data components attached to the rendering component. The additional data components are:

| **Rendering component** | **Additional data component** |
|-------------------------|-------------------------------|
| **Camera**              | HDAdditionalCameraData        |
| **Reflection Probe**    | HDAdditionalReflectionData    |

To modify the value of a Frame Setting, the first step is to get a reference to the additional data component. To do this, either create a public variable and assign it in the Inspector, or use [GetComponent()](https://docs.unity3d.com/ScriptReference/GameObject.GetComponent.html) where T is the additional data component type.

Next, access the Frame Settings override mask. This controls which Frame Settings to use overridden values for and is of type `FrameSettingsOverrideMask`. Accessing the Frame Settings override mask is different depending on whether you want to modify the Frame Settings of a Camera or a Reflection Probe:

- **Camera**: `HDAdditionalCameraData.renderingPathCustomFrameSettingsOverrideMask`
- **Reflection Probe**: `HDAdditionalReflectionData.frameSettingsOverrideMask`

For information on the API available for `FrameSettingsOverrideMask`, including how to set/unset a bit in the mask, see [FrameSettingsOverrideMask Scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings-API.html#framesettingsoverridemask-scripting-api).

Finally, access the Frame Settings structure itself. This controls the actual value for each Frame Setting and is of type `FrameSettings`. Accessing the Frame Settings is also different depending on whether you want to modify the Frame Settings of a Camera or a Reflection Probe:

- **Camera**: `HDAdditionalCameraData.renderingPathCustomFrameSettings`
- **Reflection Probe**: `HDAdditionalReflectionData.frameSettings`

For information on the API available for `FrameSettings`, including how to edit the value of a Frame Setting, see [FrameSettings Scripting API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings-API.html).

## Frame Setting enumerations

To make it easier to set the value of some Frame Settings, HDRP provides the following enum types.

### LitShaderMode

An enum which helps to switch a rendering component between deferred and forward rendering.

For information on what each enum value does, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.LitShaderMode.html" class="xref">LitShaderMode</a>.

### LODBiasMode

An enum which defines how HDRP calculates a LOD bias.

For information on what each enum value does, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.LODBiasMode.html" class="xref">LODBiasMode</a>.

### MaximumLODLevelMode

An enum which defines how HDRP calculates the maximum LOD level.

For information on what each enum value does, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.MaximumLODLevelMode.html" class="xref">MaximumLODLevelMode</a>.

### FrameSettingsField

An enum where each entry represents a particular Frame Setting. For a list of entries in this enum, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.FrameSettingsField.html" class="xref">FrameSettingsField</a>.

As well as an entry for each Frame Settings, this enum also includes the value `FrameSettingsField.None` that is set to **-1** for convenience and internal usage.

## FrameSettingsOverrideMask Scripting API

This is a structure that has a single field which stores the override mask. For more information about this structure and the API it contains, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.FrameSettingsOverrideMask.html" class="xref">FrameSettingsOverrideMask</a>.

In the override mask, to allow you to easily access the bit for a given Frame Setting, HDRP provides the [FrameSettingsField](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Frame-Settings-API.html#framesettingsfield) enum. You can use this, for example, to find the bit responsible for overriding the **Opaque Objects** Frame Setting. To do this, you would do `this[(int)FrameSettingsField.OpaqueObjects]`.

The following example shows how to compare the `humanizedData` from a rendering component's override mask with the rendering component's custom Frame Settings. There are some custom Frame Settings set, but the mask is all zeros which means that this rendering component uses the default Frame Settings.

## FrameSettings Scripting API

This is a structure that contains information on how a rendering component should render the Scene. For more information about this structure and the API it contains, see <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/api/UnityEngine.Rendering.HighDefinition.FrameSettings.html" class="xref">FrameSettings</a>.

### Example

The following example demonstrates a component that changes a Camera's Frame Settings so the Camera does not render opaque GameObjects. It has the public field `cameraToChange`, which represents the Camera to change the Frame Settings for, and the public function `RemoveOpaqueObjectsFromRendering`, which contains the logic to change the Camera's Frame Settings.

    using UnityEngine;
    using UnityEngine.Rendering.HighDefinition;

    public class ChangeFrameSettings : MonoBehaviour
    
    }
