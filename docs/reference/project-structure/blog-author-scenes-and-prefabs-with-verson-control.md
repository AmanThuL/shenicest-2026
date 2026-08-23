---
title: "How to author Scenes and Prefabs with a focus on version control"
page_title: "How to Author Scenes and Prefabs with Version Control"
source_url: "https://unity.com/blog/author-scenes-and-prefabs-with-verson-control"
final_url: "https://unity.com/blog/author-scenes-and-prefabs-with-verson-control"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to Author Scenes and Prefabs with Version Control

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# How to author Scenes and Prefabs with a focus on version control

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ADRIAN WOODS / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Contributor</span>

<span class="mr-2">Jul 15, 2024</span><span class="mr-2">\|</span><span class="mr-2">16 Min</span>

Programming and DevOps

DevOps

Best practices for creating content in Unity (with a focus on version control)

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The goal of this guide is to provide best practices for authoring content in [Unity](https://unity.com) that works with version control. For more information about using [version control](https://unity.com/solutions/version-control), check out Unity’s [Take on version control for stronger collaboration](https://blog.unity.com/engine-platform/take-on-version-control-for-stronger-collaboration) blog or the more in-depth [Best practices for version control](https://unity.com/how-to/version-control-systems) e-book. Though both of these resources contain good general information for working with version control, the focus of this blog is on how content integrates with version control and how to avoid merge conflicts when many creators are working on the same or adjacent content at the same time.

.meta files

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

There is a lot of confusion online about .meta files and version control. .meta files should **always** be checked into version control. [They contain important information](https://docs.unity3d.com/Manual/AssetMetadata.html#:~:text=Meta%20files%20and%20asset%20files), such as the file GUID that connects all references between assets. They should be kept in sync with their source files (both the name and location should always match the associated source file). Never move or rename an asset file outside of the Unity Editor unless specific tools have been built for this purpose or the functionality of .meta files is completely understood.

The default [version control .meta file mode](https://docs.unity3d.com/Manual/Versioncontrolintegration.html#:~:text=Function-,Mode,-Select%20the%20version) is Visible Files, which shows the .meta files on disk in the operating system, rather than hiding them. If you’re using [Perforce](https://www.perforce.com/), select the Perforce mode.

Smart Merge

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The first thing any team should do when working with Unity and version control is set up [Smart Merge](https://docs.unity3d.com/2022.3/Documentation/Manual/SmartMerge.html). By default, Unity stores [YAML](https://blog.unity.com/engine-platform/understanding-unitys-serialization-language-yaml) files as text, which makes them mergeable in version control. Changing the [Asset Serialization Mode](https://docs.unity3d.com/Manual/class-EditorManager.html#:~:text=Asset%20Serialization-,Mode,-Choose%20which%20format) to binary will remove the ability to merge these files by version control.

Because Unity’s YAML files are text-based, a lot of version control merging software will try to merge them using text or coding rules. Smart Merge is built by Unity to merge with the YAML structure in mind. We recommend enforcing the usage of Smart Merge as the default merging tool for all YAML files.

Smart Merge will greatly reduce the amount of lost work due to merge conflicts, but if your team has zero tolerance for potential lost work, we recommend also using file locking and enforcing manual merge conflict resolution for any YAML files.

  

File locking

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

File locking is a common practice for large studios where multiple content creators might work on the same binary file (or YAML file) at the same time. [Unity version control](https://unity.com/solutions/version-control-artists) prevents anyone from checking out a [locked file](https://docs.unity.com/ugs/en-us/manual/devops/manual/smart-locks). [Perforce](https://www.perforce.com/manuals/cmdref/Content/CmdRef/p4_lock.html) prevents anyone from submitting a [locked file](https://www.perforce.com/manuals/cmdref/Content/CmdRef/p4_lock.html).

Git requires [Git LFS](https://git-lfs.com/) to be initialized in order to support [file locking](https://docs.gitlab.com/ee/user/project/file_lock.html). We recommend using Git LFS for any project that has large content files and uses Git for version control.

Good guidelines and tools

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Successful teams often have strict guidelines regarding naming conventions, folder structures, where assets should be located, and how assets should be edited. Because every team is different, there is no one set of universal guidelines. Picking the right system for your team and sticking with it for as long as it works is the most important thing.

Specific, strict guidelines makes developing tools to verify content simpler. This prevents bugs before they even get into the game. Validating content with code and tools becomes much easier with clarity on asset location and naming. You can then more easily enforce Unity import standards via [Asset Postprocessing](https://docs.unity3d.com/ScriptReference/AssetPostprocessor.html) and [Presets](https://docs.unity3d.com/Manual/Presets.html).

Separation of concerns

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

When building content, it’s important to utilize the [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) principles. Thinking about how content should be divided and where it should live will keep the project clean and prevent most content creators from running into merge conflicts. It can also help with discoverability and onboarding feature experts, where individual features live in specific sub scenes or Prefabs. The main building blocks that can be used to separate content into files are [Scenes](https://docs.unity3d.com/Manual/CreatingScenes.html), [Prefabs](https://docs.unity3d.com/Manual/Prefabs.html), and Subgraphs.

Scenes

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Scenes are the macro building blocks for any Unity application. Each scene is serialized (saved) to a file, which means they can be used to organize content in a way that is friendly for source control and simultaneous editing. [Additive Scene Loading](https://docs.unity3d.com/2020.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.Additive.html) is often used effectively to create very large scenes, streaming content, or even very simple scenes that have multiple components with separate concerns.

In general, we recommend storing scene-dependent data in scenes. For example, in the case of baked lighting, lights, lightmaps, and environment settings, all are dependent on which scene they are in. Almost everything else can be stored in Prefabs. If a scene is small and has specific content in it that will only be edited within that scene, it might make sense to store all of that data in a single scene. However, it is important to note that if there are two GameObjects in a scene, any changes to one of those objects will result in changes to the scene file.

While Smart Merge should handle the scenario where two content creators change two different objects in the scene at the same time, more elaborate changes can result in unresolvable conflicts. We recommend utilizing Prefabs to help mitigate this issue.

In terms of explicit scene structure, the [Unity Netcode Demo](https://docs-multiplayer.unity3d.com/netcode/current/learn/bossroom/bossroom-architecture/#application-flow-diagram) contains a useful flow chart of a standard scene layout for a simple project that is similar to those we’ve seen in many scenarios.

  

Prefabs

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Prefabs can be used to build modular, separate content. For more information, check out this tutorial on [Prefabs and Nested Prefabs](https://visualdesigncafe.com/learn/nested-prefabs). The most important section in that tutorial is the [Best Practices](https://visualdesigncafe.com/learn/nested-prefabs#:~:text=longer%20override%20them.-,Best%20Practices,-Increase%20the%20quality) section. There aren’t any explicit rules about building content with Prefabs. Each team will have to decide what works best for them based on their project. There are, however, a few good guidelines to follow:

-   Think of Prefabs as the building blocks of your house, or project. Generally, there is a root Prefab that represents the foundation of the house. Within that are the Prefabs for each reusable component that make up the rest of the house. They could be as granular as a windowsill, or as broad as a wall with windows in it. The level of granularity needed will depend on how content creators want to edit their Prefabs.
-   Prefabs can be [nested](https://docs.unity3d.com/2020.3/Documentation/Manual/NestedPrefabs.html). This means that in the example above, there might be a house Prefab, with wall, roof, window, and door Prefabs that compose the house. One important thing to note with nesting Prefabs is that the deeper the hierarchy is, the more likely it becomes that the project will encounter performance issues. We generally recommend keeping Prefab hierarchies below 5-7 levels of depth.
-   When nesting Prefabs, it is generally a good idea to edit the Prefabs in [Prefab Mode](https://docs.unity3d.com/2022.3/Documentation/Manual/EditingInPrefabMode.html). This guarantees that the Prefab properties or overrides are set in the proper location. Editing Prefab properties in the scene view can result in overrides residing in the wrong Prefab or in the scene itself. This can have unintended consequences and cause merge conflicts. Sometimes, it is necessary to override a child Prefab property in a parent Prefab (variations can be achieved this way without affecting every reference to a specific Prefab). This is a standard workflow, but it is important to be careful to make changes and apply overrides in the proper Prefab or scene.
-   Everything in a Prefab will be loaded and instantiated into memory at runtime when a Prefab is loaded and instantiated. This means if visual effects, or attached objects that aren’t always present, are inside of a Prefab, those objects will be instantiated into memory. This can result in memory bloat, as every Prefab instantiated will instantiate everything inside of it. If objects have occasional visual effects or models attached to them, it is better to have a [pooling system](https://learn.unity.com/tutorial/introduction-to-object-pooling#) and an attachment manager that adds those components at runtime. Anything in a pooling system should generally not be placed inside a Prefab.
-   Everything does not need to be a Prefab. Smaller building blocks can be GameObjects inside a Prefab or even a scene. If an object is unique to a scene or Prefab, there is no need to create a Prefab for it.
-   Prefab variants should be used with care. Generally, the best use of a Prefab variant is when the core building blocks of an object are identical with only simple differences. For example, it might be helpful to use a Prefab variant for a game component that has identical functionalities, but different visuals. In this scenario, changing the core functionality will affect the functionality of both the Prefab and its variants, but the visual will remain overridden.Be careful about making overly-complex Prefab variants, as changes to the root Prefab could have unintended consequences on the overridden Prefab. As a general rule of thumb, something like a character variation system or any other complex visual skinning system, should not be based on Prefab variants unless the system is very simple.

We recommend creating a consistent strategy for determining what should be Prefabs and what should be GameObjects within Prefabs or scenes.

  

FBX and prefabs

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If a Prefab is created directly from an FBX file, a special kind of Prefab called a [model Prefab](https://docs.unity3d.com/Packages/com.unity.formats.fbx@5.1/manual/prefab-variants.html) is created. The result is a Prefab variant of the FBX file. Any additions or changes will be stored as overrides in the Prefab file. However, because most of the data is stored in the FBX file, changes and additions to the Prefab cannot be applied to model Prefabs. If you’re using the model Prefab variant workflow, it’s important to keep [structural changes to a minimum](https://docs.unity3d.com/Packages/com.unity.formats.fbx@5.1/manual/prefab-variants-workflow.html#:~:text=size%20remains%201.-,WARNING,-To%20avoid%20any).

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

There are two alternative workflows that allow less tightly coupled structures between the FBX model and the Prefab:

1.  **Adding the FBX file directly into a scene and then adding components or structural modifications onto GameObjects in the scene**. In this scenario, any changes are now stored in the scene file. This can result in merge conflicts if many people are using this workflow in the same scene. We only recommend this workflow if the changes have to live in the scene and conflicts are not an issue.
2.  **Creating a standard Unity Prefab out of the exploded model**. In this method, the FBX model is dragged into the scene and then [unpacked](https://docs.unity3d.com/Manual/UnpackingPrefabInstances.html) completely. This is then used to [create a Prefab](https://docs.unity3d.com/Manual/CreatingPrefabs.html). This methodology completely decouples the FBX file from the Prefab. This is useful if very loose coupling is desired between the FBX file and the Prefab. It will no longer inherit any structural changes made to the original FBX file. The coupling will only be between the names of the meshes, materials, and animations. Everything else will reside in the Prefab file itself. This can be useful for creating entirely unique variants of an FBX model. For example if two characters use the same model, but need completely different meshes, materials, or even different hierarchies, this methodology might be better than creating multiple FBX files that take up extra memory and disk space.One thing to note with this method is that when a mesh or material name changes on the original FBX file, the object does not disappear, but instead, references a missing mesh or material. This can be handy when extremely complex component setups are required. Rather than having the GameObject disappear and lose all components, the object sticks around and components can be transferred to the new object, or the renamed mesh or material can be slotted back into the GameObject that is now referencing a missing mesh or material.

In the two images below, changes are made to an FBX file and then reimported. The circle around the Unity logo on the ball is deleted. The main support stand is renamed. The material for the main ball is changed from black to green and a new parent is introduced above the stand logo with transforms on it that raise it above the model.

  

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This is all closely matched in both the FBX file and the model Prefab. In the non-model Prefab, the original hierarchy, names, and materials are kept. The deleted mesh is now a missing mesh, but the GameObject is still present. The renamed mesh is also not visible because it is referencing a mesh name that doesn’t exist in the model anymore. The changed material is not updated because the GameObject is still referencing the original material. Additionally, the hierarchy change is not respected and the mesh stays in the same place because its parent has not changed.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the before and after images below, the results of the changes made above are displayed in the scene hierarchy. The FBX file that is referenced directly in the scene and the standard model Prefab respond to any changes made to the original FBX file. The unpacked Prefab retains its original hierarchy and does not respond to deletions or name changes.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

It is important to make careful decisions about which methodology is used in a given scenario. If tight coupling is desired between the Editor and the FBX files, then the standard model Prefab is probably the best choice. If very loose coupling is desired (for example a very flexible character system where meshes or materials may be swapped out frequently), then creating non-model Prefabs with soft references to the components of the FBX file will work better.

Subgraphs

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the case of graph tools like [Shader Graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@12.1/manual/index.html) or [Visual Effect Graph](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@12.1/manual/index.html), [Shader Graph Subgraphs](https://docs.unity3d.com/Packages/com.unity.shadergraph@12.1/manual/Sub-graph-Asset.html) and [Visual Effect Graph Subgraphs](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@12.1/manual/Subgraph.html) can be used to create reusable functional nodes that live in a separate file and can be edited without causing conflicts in every Shader Graph or Visual Effect Graph. This allows users to separate concerns in a similar way to Prefabs and scenes. We recommend creating a strategy for reusability by taking advantage of subgraphs where it makes the most sense.

Avoid deep hierarchies

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Avoiding deep hierarchies is a universal statement for content that relates to Scenes, Prefabs, GameObjects, Animation, UI, and anything else. In general, deep hierarchies of any kind tend to result in performance problems. Deep animation hierarchies in characters will result in fewer characters being able to be drawn on screen due to CPU performance concerns. Because of this, we recommend placing all animated hierarchies at the root node of the scene to help with performance. Opting for flat hierarchies when using [UGUI](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/index.html) and [Canvases](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/UICanvas.html) will result in better performance due to fewer cascading layout updates. Deeply nested Prefabs can cause performance problems and also lead to confusion when overrides are not carefully managed.

Source content

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We often see teams store source content in a variety of locations, from network drives to local machines. We recommend putting all important source content into version control in one way or another.

The most common method we see is to put source content into a folder in version control that is outside of the Assets folder. This ensures that Unity does not try to import any content from the source files directly. [Maya, 3ds Max, Blender, and Photoshop](https://docs.unity3d.com/2021.3/Documentation/Manual/AssetTypes.html) files will import automatically into models and textures if they are placed anywhere in the assets folder. While Unity does support this, we don’t recommend this practice. Additionally, we do recommend mirroring the source directory to the content in the Assets directory so that tracking assets is relatively easy.

Source content should be maskable for users, as most users will not need it all and source content can be extremely large on disk (think terabytes). In some version control software, creating content masks is fairly simple. In Unity version control, this is achieved with [cloaked files](https://docs.plasticscm.com/gui/plastic-scm-version-control-gui-guide#addToCloakedListCommand:~:text=Add%20to%20cloaked%20list%20/%20Remove%20from%20cloaked%20list). In Perforce, [Views](https://www.perforce.com/manuals/cmdref/Content/CmdRef/views.html) are used to mask content from the client. Git, however, isn’t designed to work in this way. Because of this, we recommend creating a separate Git repository for source content or a separate repository for each type of content (for example, 3D artists may never need to sync the full audio source and vice versa).

*Creating content that works with version control and supports multiple users working in the same areas is a difficult task. However, Unity provides building blocks that can be used with careful thought and planning to create large-scale content that does not result in unresolvable merge conflicts or lost work.*
