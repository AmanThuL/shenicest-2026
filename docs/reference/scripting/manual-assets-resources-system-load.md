---
title: "Load and unload assets with the Resources system"
page_title: "Unity - Manual: Load and unload assets with the Resources system"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-resources-system-load.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-resources-system-load.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Load and unload assets with the Resources system

To load assets with the Resources system:

1.  Create a new folder called `Resources` in your project, and add assets to it. Unity then makes these assets available even if they’re not directly referenced in a scene. **Note:** You can have multiple `Resources` folders located in different subfolders within your `Assets` folder, and packages can also contain `Resources` folders.
2.  Whenever you want to load an asset from one of these folders, call [`Resources.Load`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html) in your code. Only assets in the `Resources` folder can be accessed in this way.

For example, you can apply the following script to load and apply a texture to it:

``` lang-csharp
using UnityEngine;

public class LoadTexture : MonoBehaviour

        else
        
    }
}
```

Unity stores all assets in the `Resources` folders and their dependencies in a file in the build output called `resources.assets`. If a scene in the build references an asset, Unity serializes that asset into a `sharedAssets*.assets` file instead.

Additional assets might end up in the `resources.assets` file if they’re dependencies. For example, a material in the `Resources` folder might reference a texture outside of the `Resources` folder. In that case the texture is also included in the `resources.assets` file, but isn’t available to load directly.

## Unload assets

If you want to destroy objects that [`Resources.Load`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html) loaded before loading another scene, call [`Object.Destroy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) on them. To recover memory used by unreferenced objects, use [`Resources.UnloadUnusedAssets`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html).

## Additional resources

-   [Introduction to the Resources system](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html)
-   [Introduction to asset management](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html)
-   [`Resources.Load` API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html)
