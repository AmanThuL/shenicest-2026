---
title: "Add and remove cameras in a camera stack in URP"
page_title: "Unity - Manual: Add and remove cameras in a camera stack in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add and remove cameras in a camera stack in URP

Camera stacks contain a single Base Camera with one or more Overlay Cameras stacked on top. In the Editor, you can add, remove, and reorder these cameras as much as you like to achieve the desired effects.

This page is split into the following sections:

-   [Add a camera to a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html#add-a-camera-to-a-camera-stack)
-   [Remove a camera from a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html#remove-a-camera-from-a-camera-stack)
-   [Reorder cameras in a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html#reorder-cameras-in-a-camera-stack)

<span id="add-a-camera-to-a-camera-stack"></span>

## Add a camera to a camera stack

To add a camera to a camera stack, use the following steps:

1.  Select a Camera in your scene with the **Render Type** set to **Base**, making it a Base Camera. If you do not have a Base Camera in your scene, create one.
2.  Create another camera in your scene, and select it.
3.  In the camera Inspector window, set the **Render Type** to **Overlay**.
4.  Select the Base Camera again. In the camera Inspector window, go to the **Stack** section, select **Add** (**+**), then select the name of the Overlay Camera.

The Overlay Camera is now part of the Base Camera’s camera stack. Unity renders the Overlay Camera’s output on top of the Base Camera’s output.

**Note:** When you create multiple cameras for a camera stack, consider whether the cameras are all necessary. Each camera you add makes rendering slower, because an active camera runs through the entire rendering loop even if it renders nothing.

<span id="add-a-camera-with-a-script"></span>

### Add a camera to a camera stack with a C# script

You can also add a camera to a camera stack with a C# script. Use the `cameraStack` property of the Base Camera’s [Universal Additional Camera Data](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.UniversalAdditionalCameraData.html) component, as shown below:

``` lang-cs
var cameraData = camera.GetUniversalAdditionalCameraData();
cameraData.cameraStack.Add(myOverlayCamera);
```

<span id="remove-a-camera-from-a-camera-stack"></span>

## Remove a camera from a camera stack

To remove a camera from a camera stack, use the following steps:

1.  Create a camera stack that contains at least one Overlay Camera. For instructions, refer to [Add a camera to a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html#add-a-camera-to-a-camera-stack).
2.  Select the camera stack’s Base Camera.
3.  In the camera Inspector window, go to the **Stack** section, select the name of the Overlay Camera you want to remove, then then select **Remove** (**-**).

The Overlay Camera remains in the scene, but is no longer part of the camera stack.

<span id="remove-a-camera-with-a-script"></span>

### Remove a camera from a camera stack with a C# script

You can also remove a Camera from a camera stack with a C# script. Use the `cameraStack` property of the Base Camera’s [Universal Additional Camera Data](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.UniversalAdditionalCameraData.html) component, as shown below:

``` lang-cs
var cameraData = camera.GetUniversalAdditionalCameraData();
cameraData.cameraStack.Remove(myOverlayCamera);
```

<span id="reorder-cameras-in-a-camera-stack"></span>

## Reorder cameras in a camera stack

To reorder the cameras in a camera stack, use the following steps:

1.  Create a camera stack that contains more than one Overlay Camera. For instructions, refer to [Add a camera to a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html#add-a-camera-to-a-camera-stack).
2.  Select the Base Camera in the camera stack.
3.  In the Camera Inspector, go to the **Stack** section.
4.  Use the handles next to the names of the Overlay Cameras to reorder the list of Overlay Cameras.

The Base Camera renders the base layer of the camera stack, and the Overlay Cameras in the stack render on top of this in the order that they are listed, from top to bottom.

<span id="reorder-a-camera-stack-with-a-script"></span>

### Reorder a camera from a camera stack with a C# script

You can also reorder a camera stack with a C# script. Use the `cameraStack` property of the Base Camera’s [Universal Additional Camera Data](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEngine.Rendering.Universal.UniversalAdditionalCameraData.html) component. The `cameraStack` is a `List` and can be reordered in the same way as any other `List`.
