---
title: "Unity Manual 6.3 LTS: YAML serialization of prefabs"
page_title: "Unity - Manual: YAML serialization of prefabs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# YAML serialization of prefabs

Unity represents prefab instances, nested prefabs, and prefab variants in serialized scene (`.unity`) and prefab (`.prefab`) files using a small set of related YAML elements. This page describes those elements and how they fit together.

Understanding this format is useful when you resolve merge conflicts in prefab files manually, inspect files produced by an automated build, or work with Unity assets from scripts that run outside the Editor.

For general information about Unity serialization format, refer to [Format of text serialized files](https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html) and [UnityYAML](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html). For annotated YAML examples from prefab files, refer to [Example of YAML prefab serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html).

## Prefab serialization elements

Unity represents a reference to a prefab inside a scene or another prefab file using four related elements:

-   A **[PrefabInstance](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#prefabinstance)** YAML element that links to the source prefab asset and records a set of override changes.
-   An **[m_Modification](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#m-modification)** block inside the `PrefabInstance` element that records individual [property modifications](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#property-modifications) and the objects added or removed relative to the source prefab.
-   **[Stripped placeholder objects](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#stripped-objects)** that let other objects in the same file reference specific objects inside the prefab instance (such as a child `Transform`).
-   A **[prefab asset handle](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#prefab-asset-handle)** in the source prefab asset. Its fileID is always `100100000`, and `PrefabInstance` objects reference it through the `m_SourcePrefab` property.

For information on how these elements are arranged in prefab variant files, refer to [Prefab variants](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#prefab-variants).

## PrefabInstance element

Unity represents a prefab instance as a YAML document with class ID `1001` and document type `PrefabInstance`:

``` lang-yml
--- !u!1001 &<fileID>
PrefabInstance:
  m_ObjectHideFlags: 0
  serializedVersion: 2
  m_Modification:
    ...
  m_SourcePrefab: 
```

The key properties are:

-   **`m_Modification`**: a block of data that records everything that differs between this instance and the source prefab. For more information, refer to [The m_Modification block](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#m-modification).
-   **`m_SourcePrefab`**: a cross-file reference to the source prefab asset. The fileID is always `100100000` (the prefab asset handle), so only the `guid` value varies between references. For more information, refer to [The prefab asset handle](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#prefab-asset-handle).

For a complete example of a prefab instance in a scene, refer to [Prefab instance in a scene](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html#prefab-instance-in-a-scene).

## The m_Modification block

The `m_Modification` block stores data that differs between the instance and the source prefab, including property overrides and any objects that are added or removed. It has the following fields:

| Field                  | Description                                                                                                                                                                                                                                                                                            |
|:-----------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `m_TransformParent`    | Reference to this instance’s parent `Transform` component in the containing file. `{fileID: 0}` means that the instance has no parent, which is a characteristic of prefab variants because the instance is the root of the variant file.                                                              |
| `m_Modifications`      | Array of property override entries. Each entry points to an object in the source prefab and records a new value for one property. For more information, refer to [Property modifications](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html#property-modifications). |
| `m_RemovedComponents`  | Components from the source prefab that are removed in this instance.                                                                                                                                                                                                                                   |
| `m_RemovedGameObjects` | GameObjects from the source prefab that are removed in this instance.                                                                                                                                                                                                                                  |
| `m_AddedGameObjects`   | GameObjects added to this instance that don’t exist in the source prefab.                                                                                                                                                                                                                              |
| `m_AddedComponents`    | Components added to this instance that don’t exist in the source prefab.                                                                                                                                                                                                                               |

Unity writes empty lists for any of these fields even when there are no entries. A clean prefab instance with no overrides still contains `m_Modifications: []`, `m_RemovedComponents: []`, and so on.

**Note:** `m_Modification` (singular) is the name of the block. `m_Modifications` (plural) is the name of the property-override array inside the block. The two names differ by one letter.

## Property modifications

Each entry in the `m_Modifications` array has four fields:

| Field             | Description                                                                                                                                                                                                                                              |
|:------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `target`          | Cross-file reference to the object inside the source prefab whose property this entry overrides. The `guid` matches the source prefab asset.                                                                                                             |
| `propertyPath`    | Path to the property being overridden. Matches [`SerializedProperty.propertyPath`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty-propertyPath.html). Dotted paths such as `m_LocalPosition.x` describe subproperties. |
| `value`           | The override value, stored as a string. Empty for object-reference overrides.                                                                                                                                                                            |
| `objectReference` | Reference to another object when the override value is a reference. `{fileID: 0}` when the override isn’t an object reference.                                                                                                                           |

A typical property override uses the `value` field:

``` lang-yml
- target: 
  propertyPath: m_LocalPosition.x
  value: 39.341
  objectReference: 
```

An object-reference override uses `objectReference` instead, with an empty `value` field:

``` lang-yml
- target: 
  propertyPath: m_Material
  value: 
  objectReference: 
```

For more information about the `{fileID, guid, type}` format in references, refer to [Direct reference asset management](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html).

## Stripped placeholder objects

A scene file or a containing prefab file can reference specific objects inside a prefab instance. For example, if a prefab instance’s root is a child of a GameObject in the scene, the parent GameObject’s `Transform` component contains the prefab instance’s root in its `m_Children` array.

In these cases, Unity doesn’t serialize the referenced object directly into the scene or containing prefab file. Instead, it adds a **stripped** placeholder element to that file. The placeholder contains only the information needed to identify the source object:

``` lang-yml
--- !u!4 &<fileID> stripped
Transform:
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
```

The `stripped` keyword on the document header indicates that the object is a placeholder. The fields are:

| Field                         | Description                                                                                                                                    |
|:------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|
| `m_CorrespondingSourceObject` | Cross-file reference to the matching object in the source prefab asset.                                                                        |
| `m_PrefabInstance`            | Local reference to the `PrefabInstance` element in the current file that this placeholder belongs to.                                          |
| `m_PrefabAsset`               | Has the value `{fileID: 0}` in scenes and containing prefabs. This field is only set when the object is itself part of a prefab asset on disk. |

## The prefab asset handle

When Unity imports a `.prefab` asset, it creates a special object called the prefab asset handle with fileID `100100000`. The handle doesn’t appear as a YAML document in the source `.prefab` file on disk. It’s generated during import and is stored in the prefab’s serialized artifact in the `Library` folder.

The handle is the target of the `m_SourcePrefab` reference on a `PrefabInstance`:

``` lang-yml
  m_SourcePrefab: 
```

Because fileID `100100000` is constant for every prefab, only the `guid` changes between references to different prefabs. The `type: 3` indicates that the reference resolves to the imported artifact in the `Library` folder rather than to a file in the `Assets` folder. For more information about type values, refer to [Type field values](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html#type-field-values).

## Prefab variants

A prefab variant is a `.prefab` file that inherits from a base prefab.

On disk, Unity represents a prefab variant’s root as a `PrefabInstance` element (class ID `1001`) rather than as a separately serialized `GameObject` element. Inside that `PrefabInstance`, the `m_Modification.m_TransformParent` field has the value `{fileID: 0}`, because the instance has no parent inside the file. This is how Unity identifies a prefab as a variant.

The `m_SourcePrefab` field references the base prefab that the variant inherits from. The `m_Modification` block records the data unique to the variant, such as overridden property values, components, and added or removed objects, using the same format as any other prefab instance.

For an annotated example of a variant file, refer to [Prefab variant](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html#prefab-variant).

## Additional resources

-   [Example of YAML prefab serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html)
-   [Format of text serialized files](https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html)
-   [An example of a YAML scene file](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html)
-   [Direct reference asset management](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html)
-   [Nest prefab instances in other prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html)
-   [Create variations of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html)
-   [Smart merge](https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html)
