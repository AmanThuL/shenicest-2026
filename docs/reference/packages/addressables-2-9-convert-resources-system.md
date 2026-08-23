---
title: "Move assets from the Resources system"
page_title: "Move assets from the Resources system | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-resources-system.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-resources-system.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Move assets from the Resources system

If your project uses the <a href="https://docs.unity3d.com/Manual/LoadingResourcesatRuntime.html" class="xref">Resources system</a> to load assets, you can migrate those assets to the Addressables system:

1.  Make the assets Addressable. To do this, either enable the **Addressable** option in each asset's Inspector window or drag the assets to groups in the [Addressables Groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html) window.
2.  Change any runtime code that loads assets using the <a href="https://docs.unity3d.com/ScriptReference/Resources.html" class="xref"><code>Resources</code></a> API to load them with the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.html" class="xref"><code>Addressables</code></a> API. For more information, refer to [Load asset references](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAssetReferences.html).
3.  Add code to release loaded assets when no longer needed.

If you keep all the former Resources assets in one group, the loading and memory performance is equivalent.

When you mark an asset in a Resources folder as Addressable, the system automatically moves the asset to a new folder in your project named `Resources_moved`. The default address for a moved asset is the old path, omitting the folder name. For example, your loading code might change from:

    Resources.LoadAsync\<GameObject\>("desert/tank.prefab");

to:

    Addressables.LoadAssetAsync\<GameObject\>("Resources_moved/tank.prefab");.

## Update Resources code

You might have to implement some functionality of the `Resources` class differently after modifying your project to use the Addressables system.

For example, consider the [`Resources.LoadAll`](https://docs.unity3d.com/ScriptReference/Resources.LoadAll.html) method. Previously, if you had assets in a folder named `Resources/MyPrefabs/`, and ran `Resources.LoadAll\<SampleType\>("MyPrefabs");`, Unity loads all the assets in `Resources/MyPrefabs/` matching type `SampleType`. The Addressables system doesn't support this exact functionality, but you can achieve similar results using <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html" class="xref">Addressable labels</a>.

## Additional resources

-   [Load asset references](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAssetReferences.html)
-   [Labelling assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html)
-   [Organize assets into groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html)
-   <a href="https://docs.unity3d.com/Manual/LoadingResourcesatRuntime.html" class="xref">Resources system</a>
