---
title: "Unity 6.3 Manual: Modify source assets from code"
page_title: "Unity - Manual: Modify source assets from code"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ModifyingSourceAssetsThroughScripting.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ModifyingSourceAssetsThroughScripting.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Modify source assets from code

You can modify assets from your runtime code. Depending on the asset type and method you use, the modifications can either be temporary or permanent. Temporary modifications reset on exiting Play mode, and permanent modifications persist on exiting Play mode.

## Temporary modification

Modifications to assets at application runtime are usually temporary. For example, you might want to modify the shader component of the material for a character to represent a temporary invincibility power-up. The shader modification in this case is not permanent and does not persist on exiting Play mode.

The following example demonstrates this by changing the `shader` property of the `material` component:

``` lang-cs
using UnityEngine;

public class ExampleScript : MonoBehaviour

    public void StartInvincibility()
    
    }
}
```

On exiting Play mode, the state of the [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) resets to whatever it was before entering Play mode. Accessing `renderer.material` automatically instantiates the material and returns the instance. This instance is simultaneously and automatically applied to the renderer, so any changes you make aren’t permanent.

**Note:** If you declare a public variable that holds a reference to the material and modify that instead of modifying the `renderer.material.shader` class member directly, you won’t get the benefits of automatic instantiation before the modifications are applied.

## Permanent modification

**Important**: The method presented here modifies actual source asset files used within Unity. You can’t undo these modifications. Use them with caution.

To avoid the material resetting on exiting Play mode, you can use [Renderer.sharedMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterial.html). The `sharedMaterial` property returns the actual asset used by the renderer.

The following example permanently changes the material to use the Specular shader and does not reset the material to the state it was in before Play mode:

``` lang-cs
using UnityEngine;

public class ExampleScript : MonoBehaviour

    public void StartInvincibility()
    
    }
}
```

## Applicable classes and properties

The previously described programming pattern of using local or shared properties for temporary or permanent changes respectively applies for the following asset types:

| Asset type        | Property for temporary changes                                                                              | Property for permanent changes                                                                                          |
|:------------------|:------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------|
| Material          | [`Renderer.material`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html) | [`Renderer.sharedMaterial`](https://docs.unity3d.com/6000.3/Documentation/Manual/Renderer-sharedMaterial)               |
| Mesh              | [`MeshFilter.mesh`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MeshFilter-mesh.html)     | [`MeshFilter.sharedMesh`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/meshFilter-sharedMesh.html)     |
| Physics Materials | [`Collider.material`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider-material.html) | [`Collider.sharedMaterial`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider-sharedMaterial.html) |

**Note**: If you declare a public variable of any of these classes and make modifications to the asset using that variable instead of using the relevant class member, you won’t get the benefits of automatic instantiation before the modifications are applied.

## Assets that are not automatically instantiated

The following asset types are not automatically instantiated when modified:

-   [Texture2D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Texture2D.html)
-   [TerrainData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TerrainData.html)

Any modifications made to these assets from code are always permanent, and can’t be undone. If, for example, you change a terrain’s heightmap or the pixels of a texture file from code, you’ll need to account for instantiating and assigning values manually.

## Additional resources

-   [Loading resources at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html)
-   [Streaming assets directly into a build](https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html)
