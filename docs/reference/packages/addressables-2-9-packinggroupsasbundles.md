---
title: "Define how to pack groups into AssetBundles"
page_title: "Define how to pack groups into AssetBundles | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/PackingGroupsAsBundles.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/PackingGroupsAsBundles.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Define how to pack groups into AssetBundles

Choose optimal packing strategies for AssetBundles, including options to pack together, separately, or by labels, with considerations for project scale.

You have a few options when choosing how the assets in a group are packed into AssetBundles:

-   You can pack all Addressables assigned to a group together in a single bundle. This corresponds to the **Pack Together** bundle mode.
-   You can pack each Addressable assigned to a group separately in its own bundle. This corresponds to the **Pack Separately** bundle mode.
-   You can pack all Addressables sharing the same set of labels into their own bundles. This corresponds to the **Pack Together By Label** bundle mode.

For more information on bundle modes, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html" class="xref">Advanced Group Settings</a>.

Scene assets are always packed separately from other Addressable assets in the group. Therefore, a group containing a mix of scene and non-scene assets always produces at least two bundles when built: one for scenes and one for everything else.

Unity treats assets in folders marked as Addressable, and compound assets like sprite sheets differently if you pack each Addressable separately:

-   Unity packs all the assets in a folder marked as Addressable together in the same folder (except for assets in the folder that are individually marked as Addressable themselves).
-   Sprites in an Addressable Sprite Atlas are included in the same bundle.

For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html" class="xref">Content Packing &amp; Loading settings</a>.

##### Note

Keeping many assets in the same group increases the chance of version control conflicts when many people work on the same project.

## AssetBundle packing strategy

The choice whether to pack your content into a few large bundles or into many smaller bundles both have disadvantages as follows:

### Disadvantages of lots of small AssetBundles

-   Each bundle has <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assets.html" class="xref">memory overhead</a>. Hundreds of bundles loaded in memory at once, can use a noticeable amount of memory.
-   There are concurrency limits for downloading bundles. If you have thousands of bundles you need all at once, they can't all be downloaded at the same time. Some are downloaded, and as they finish, more will trigger. In practice this is a fairly minor concern, so minor that you'll often be gated by the total size of your download, rather than how many bundles it's broken into.
-   Bundle information can bloat the catalog. To be able to download or load catalogs, Unity stores string-based information about your bundles. Thousands of bundles of data can increase the size of the catalog.
-   Greater likelihood of duplicated assets. For example, if you have two materials marked as Addressable and each depend on the same texture. If they're in the same bundle, then the texture is pulled in once, and referenced by both. If they're in separate bundles, and the texture isn't Addressable, then it's duplicated. You then either need to mark the texture as Addressable, accept the duplication, or put the materials in the same bundle. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetDependencies.html" class="xref">Asset and AssetBundle dependencies</a>.

### Disadvantages of several large AssetBundles

-   `UnityWebRequest`, which Unity uses to download assets doesn't resume failed downloads. If a large AssetBundle is downloading and your user loses connection, the download is started over once they regain connection.
-   Items can be loaded individually from AssetBundles, but can't be unloaded individually. For example, if you have 10 materials in a bundle, load all 10, then tell Addressables to release 9 of them, all 10 will likely be in memory. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assets.html" class="xref">Memory management</a>.

## Group optimization for large projects

As your project grows larger, be aware of the following aspects of your assets and bundles:

-   **Total bundle size**: Historically Unity hasn't supported files larger than 4 GB. Later versions of Unity support larger files, but there can still be issues. Aim to keep the content of a given AssetBundle under this limit for best compatibility across all platforms.
-   **Bundle layout at scale**: The memory and performance trade-offs between the number of AssetBundles produced by your content build and the size of those bundles can change as your project grows larger.
-   **Bundle dependencies**: When an Addressable asset is loaded, all its AssetBundle dependencies are loaded. Be aware of any references between assets when creating Addressable groups. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetDependencies.html" class="xref">Asset and AssetBundle dependencies</a>.
-   **Subassets affecting UI performance**: If you have a lot of assets, and those assets have many subassets, disable subasset display. This option only affects how the data is displayed in the Groups window, and doesn't affect what you can and can't load at runtime. To disable this option, go to **Window** > **Asset Management** > **Addressables** > **Groups**. In the **Tools** dropdown menu, select **Groups View** > **Show Sprite and Subobject Addresses**. Disabling this will make the UI more responsive.
-   **Group hierarchy display**: Another UI-only option to help with scale is [**Group Hierarchy with Dashes**](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html#tools). This is available within the Inspector of the top level settings. With this enabled, groups that contain dashes `-` in their names display as if the dashes represented folder hierarchy. This doesn't affect the actual group name, or the way things are built. For example, two groups called `characters-animals-cats` and `characters-animals-dogs` display inside a subfolder folder of `characters` called `animals`. Inside that folder are two groups, called `characters-animals-cats` and `characters-animals-dogs`. This doesn't affect UI responsiveness, but makes it easier to browse a large collection of groups.

## Additional resources

-   [Addressable asset dependencies](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetDependencies.html)
-   [Managing asset memory](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assets.html)
