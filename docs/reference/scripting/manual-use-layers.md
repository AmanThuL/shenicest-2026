---
title: "Use layers"
page_title: "Unity - Manual: Uses of layers in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/use-layers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/use-layers.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Uses of layers in Unity

You can use layers to optimize your project and workflow. Common uses of layers include:

-   Layer-based rendering
-   Layer-based collision

## Use the Camera culling mask with layers

You can render only the objects in a particular layer, or selection of layers, if you use the Camera’s culling mask. To change the culling mask, select the camera you want to use, and select the **Culling Mask** dropdown in the Inspector window. If you clear the checkbox of a layer, it doesn’t render in the scene.

**Note**: UI elements and screen space canvas children are exceptions to this and render regardless.

## Ray cast with layers

You can use layers to specify which GameObjects that a ray cast can intersect with. To make a ray cast ignore a GameObject, you can assign it to the Ignore Raycast layer, or pass a [LayerMask](https://docs.unity3d.com/6000.3/Documentation/Manual/layers-and-layermasks.html) to the ray cast API call.

If you don’t pass a LayerMask to the ray cast API call, Unity uses [Physics.DefaultRaycastLayers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.DefaultRaycastLayers.html) which matches every layer except Ignore Raycast.

The Physics.Raycast function uses a bitmask, and each bit determines if a layer is ignored by rays or not. If all bits in the layerMask are on, the ray collides against all colliders. If the layerMask = 0, there are no collisions.

For example, if you want to cast a ray on layer 8, see the code sample below:

``` lang-cs
int layerMask = 1 << 8;

// Does the ray intersect any objects which are in layer 8?
if (Physics.Raycast(transform.position, Vector3.forward, Mathf.Infinity, layerMask))

```

You can then do the inverse, so that the ray collides with all layers except layer 8.

``` lang-cs
void Update ()

    else
    
}
```

**Note**: If you don’t pass a layerMask to the Raycast function, it still ignores colliders that use the IgnoreRaycast layer.

## Additional resources

-   [Tags and layers](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TagManager.html)
-   [Unity Learn: Unity Essentials](https://learn.unity.com/pathway/5f7bcab4edbc2a0023e9c38f)
-   [Layer-based collision detection](https://docs.unity3d.com/6000.3/Documentation/Manual/LayerBasedCollision.html)
