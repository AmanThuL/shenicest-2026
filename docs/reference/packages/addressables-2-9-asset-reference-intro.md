---
title: "Introduction to asset references"
page_title: "Introduction to asset references | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/asset-reference-intro.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/asset-reference-intro.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to asset references

To reference Addressable assets in your code, use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a> type in a `MonoBehaviour` or `ScriptableObject` script. When you add a serializable `AssetReference` field to one of these classes, you can assign a value to the field in an Inspector window. You can optionally restrict the field to [only accept certain asset types](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/asset-reference-intro.html#assetreference-types) or [labels](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html).

![image alt text](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/asset-reference-inspector.png)  
*An Inspector window displaying a **Referenced Prefab** `AssetReferenceGameObject` field. The object picker displays Addressable prefabs to choose from.*

To assign a value, drag an asset to the field or select the object picker icon to open a dialog that lets you choose an Addressable asset.

If you drag a non-Addressable asset to an `AssetReference` field, Unity automatically makes the asset Addressable and adds it to the [default Addressables group](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-create.html). Sprite and SpriteAtlas assets can have sub objects and display an additional object picker that you can use to specify which sub object to reference.

##### Important

To assign assets from a group to an AssetReference field, you must enable the **Include GUIDs in Catalog** property in the group's Advanced Options. The **Include GUIDs in Catalog** option is enabled by default. For more information, refer to [Group Inspector settings reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html).

## AssetReference types

The Addressables API provides <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a> subclasses for common types of assets. You can use the generic subclass, <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceT-1.html" class="xref"><code>AssetReferenceT&lt;TObject&gt;</code></a>, to restrict an AssetReference field to other asset types.

The types of AssetReference include:

| **AssetReference type**                                                                                                                                                                             | **Description**                                          |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a>                           | Can reference any asset type                             |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceT-1.html" class="xref"><code>AssetReferenceT&lt;TObject&gt;</code></a>        | Can reference assets that are the same type as `TObject` |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceTexture.html" class="xref"><code>AssetReferenceTexture</code></a>             | Can reference a `Texture` asset.                         |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceTexture2D.html" class="xref"><code>AssetReferenceTexture2D</code></a>         | Can reference a `Texture2D` asset.                       |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceTexture3D.html" class="xref"><code>AssetReferenceTexture3D</code></a>         | Can reference a `Texture3D` asset.                       |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceGameObject.html" class="xref"><code>AssetReferenceGameObject</code></a>       | Can reference a `Prefab` asset.                          |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceAtlasedSprite.html" class="xref"><code>AssetReferenceAtlasedSprite</code></a> | Can reference a `SpriteAtlas` asset.                     |
| <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReferenceSprite.html" class="xref"><code>AssetReferenceSprite</code></a>               | Can reference a single `Sprite` asset.                   |

##### Note

If you want to use a <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/editor-PropertyDrawers.html" class="xref"><code>CustomPropertyDrawer</code></a> with a generic `AssetReferenceT`, or are using a version of Unity earlier than 2020.1, you must make a concrete subclass to support custom `AssetReference` types.

## Additional resources

-   [Create an asset reference field](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/asset-reference-create.html)
-   [Load asset references](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAssetReferences.html)
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code> API reference</a>
