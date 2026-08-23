---
title: "Set up a camera stack in URP"
page_title: "Unity - Manual: Set up a camera stack in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set up a camera stack in URP

This page describes how to use a camera stack to layer outputs from multiple cameras to the same render target. For more information on camera stacking, refer to [Understand camera stacking](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-stacking-concepts.html).

![A red capsule with a post-processing effect, and a blue capsule with no post-processing](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/camera-stacking-blur-background.png)

Follow these steps to set up a camera stack:

1.  [Create a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html#create-a-camera-stack).
2.  [Set up layers and culling masks](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-stacking.html#set-up-layers-and-culling-masks).

<span id="create-a-camera-stack"></span>

## Create a camera stack

Create a camera stack with a Base Camera and one or more Overlay Cameras.

For more information on how to do this, refer to [Add a camera to a camera stack](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/add-and-remove-cameras-in-a-stack.html).

<span id="set-up-layers-and-culling-masks"></span>

## Set up layers and culling masks

Once you create your camera stack, you must assign any GameObjects the Overlay Cameras need to render to a [layer](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html), then set the **Culling Mask** of each camera to match the layer.

To do this use the following steps:

1.  Add as many layers as your project requires. For information on how to do this, refer to [Add a new layer](https://docs.unity3d.com/6000.3/Documentation/Manual/create-layers.html).
2.  For each GameObject you want an Overlay Camera to render, assign the GameObject to the appropriate layer.
3.  Select the Base Camera of your camera stack and navigate to **Rendering** > **Culling Mask** in the Inspector Window.
4.  Remove any layers you don’t want the Base Camera to render, such as layers that contain objects only an Overlay Camera should render.
5.  Select the first Overlay Camera in the camera stack and navigate to **Rendering** > **Culling Mask** in the Inspector window.
6.  Remove all layers except for the layers that contain GameObjects you want this camera to render.
7.  Repeat Step 5 and Step 6 for each Overlay Camera in the camera stack.

**Note:** You don’t need to configure the **Culling Mask** property of the cameras. However, cameras in URP render all layers by default, so rendering is faster if you remove layers that contain unneeded GameObjects.
