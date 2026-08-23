---
title: "Direct reference asset management"
page_title: "Unity - Manual: Direct reference asset management"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Direct reference asset management

Direct reference asset management is the default way of managing assets at runtime in Unity. Whenever you drag an asset into a scene or onto a component through the Inspector window of the Unity Editor, you create a direct reference to that asset. When you build your application, Unity saves any referenced assets in a separate file associated with the scenes in your project.

You can use direct references with `ScriptableObject` instances to efficiently manage large asset sets and reduce build sizes. A benefit of only using direct references is that Unity only includes assets that your project directly references in the build, so your application doesn’t load unnecessary or duplicated assets.

Direct references have some limitations, as follows:

-   When your application runs on the target device, Unity loads the entire asset file into memory before loading a scene. This approach isn’t dynamic and you can only load or unload a scene, which might lead to slow load times, especially on devices with less memory.
-   At the time of loading, the asset must already be present in the local file system, and can’t be hosted on a content delivery network (CDN).
-   You can’t make incremental content updates and need to rebuild and redeploy your entire application if you want to make changes.

## Direct reference overview

In Unity, a direct reference is a serialized link from one object to another. When one object holds a direct reference to another, it creates a dependency on that object. When Unity creates a build of your project, it follows all direct references to make sure that all objects that reference each other are included in the build.

In your C# code, these references are typically held by objects derived from [`UnityEngine.Object`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) such as [`GameObject`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), [`Material`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html), or [`MonoBehaviour`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).

For example, a GameObject directly references each `Component` attached to it, such as a `Transform`, `MeshRenderer`, or a `MonoBehaviour` script, and the `Component` holds a direct reference back to its parent GameObject.

You can also use [`[SerializeReference]`](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html) to create references to non-`UnityEngine.Object` derived C# objects.

Unity handles object references in different ways depending on if the referenced object is derived from `UnityEngine.Object`, or if it’s a C# object referenced with `[SerializeReference]`.

## Unity object references

If a field references an object derived from `UnityEngine.Object`, then Unity doesn’t serialize the entire object’s data, and instead serializes a pointer to that object.

The pointer contains the following information:

-   **A global unique identifier (GUID)**: A 128-bit (32-character hexadecimal) ID that uniquely identifies the asset file on disk that contains the target `UnityEngine.Object`. Every asset file in your Unity project such as `.prefab`, `.mat`, `.png`, `.unity` scene files, and `.cs` script files have a corresponding `.meta` file that stores its GUID.
-   **A fileID**: A 64-bit ID that is unique to the target object within that specific asset file. For example, a prefab asset contains multiple `GameObject` instances with their own components. Each of these internal `UnityEngine.Object` instances has its own unique `fileID` within that single prefab file.

Internally, Unity represents these references with a `PPtr<T>` type. When Unity loads these objects into memory at runtime, it resolves the GUID and fileID pair to an `InstanceID`, which it then uses to track the live object. The `InstanceID` is unique to the current Unity Editor session or runtime instance.

If you open a scene file (`.unity`) or prefab file (`.prefab`) in a text editor, you can check the references to `UnityEngine.Object` derived types represented like the following:

``` lang-yaml
# A MonoBehaviour on a GameObject referencing a Prefab asset
MonoBehaviour:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: {fileID: 100100000} # Reference to the GameObject this component is on (internal fileID)
  m_Enabled: 1
  m_EditorHideFlags: 1
  m_Script: {fileID: 11500000, guid: f5ee4a4c1e4c3b448a97448840cdf0f41, type: 3} # Reference to the MonoBehaviour script asset (GUID of script file, fileID 11500000 often for MonoBehaviour)
  myTargetPrefab: {fileID: 100100000, guid: 61da4d63ca179b54a97448840cdf0f41, type: 3} # Reference to an external Prefab asset (GUID of Prefab file, fileID 100100000 for the root GameObject within the Prefab)
```

In this example, `myTargetPrefab` points to: \* `fileID: 100100000`: The specific referenced object (likely the root GameObject) within the target prefab file. \* `guid: 61da4d63ca179b54a97448840cdf0f41`: The GUID of the prefab asset file. \* `type: 3`: The type of asset. `type: 3` typically means a prefab or script asset.

## C# object references

By default, Unity serializes any objects not derived from `UnityEngine.Object` by value. This means that it embeds the entire data of the object directly into the serialized data of the object that holds the reference.

You can use the [`[SerializeReference]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html) attribute to change this behavior and instruct Unity to store references to plain c# objects by reference rather than value. This is useful if you want to allow multiple objects to reference the same C# object within a serialized structure and avoid data duplication.

You can’t use `[SerializeReference]` to reference a `UnityEngine.Object`-derived class. For more information, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html).

## Object tracking and mapping

When Unity loads assets and scenes into memory, it uses internal data structures to map references to live objects. These data structures include `InstanceID`, `PPtr`, `Remapper`, and `PersistentManager`. For `UnityEngine.Object` references, Unity maps the serialized GUID and fileID pairs to a live C++ `Object`. The C++ `Object` has a pointer to the associated C# `UnityEngine.Object` and finally, the C# object references back to the associated C++ object via the [instance ID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html).

For `[SerializeReference]` objects, Unity maps managed reference IDs to live object instances. For details see [ManagedReferenceUtility.GetManagedReferenceIdForObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.ManagedReferenceUtility.GetManagedReferenceIdForObject.html).

When Unity builds or loads assets, it creates a dependency graph starting from the root object and recursively traverses all direct references. Unity loads the complete graph into memory so the root object functions correctly.

Direct references can impact the build size of your application. If a `UnityEngine.Object` asset is directly referenced by any object in your project that makes it into the build, then that asset (and its entire graph of direct dependencies, resolved via `GUID` and `fileID` pairs) are included. This means careful management of direct references is crucial to prevent unused or unintentionally included assets.

For more information about the files Unity creates when it makes a build, refer to [Content output of a build](https://docs.unity3d.com/6000.3/Documentation/Manual/build-content-output.html).

## Organizing large asset sets

If you have large lists of assets that you need to share across multiple scenes, or update without modifying scene files, you can use a [`ScriptableObject`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html) instance to manage this. A `ScriptableObject` can hold direct references to other assets, which act as an asset catalog of references to your project’s assets. `ScriptableObject` instances are serialized assets and persist across Editor sessions and builds. You can reuse them across multiple different MonoBehaviour instances, and they can help reduce scene file size. For more information, refer to the [ScriptableObject documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html).

You can also use [`AssetDatabase.FindAssets`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html) to find assets and populate a `ScriptableObject` with the data.

## Additional resources

-   [Introduction to asset management](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html)
-   [ScriptableObject documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html)
-   [Output of build files](https://docs.unity3d.com/6000.3/Documentation/Manual/build-content-output.html)
