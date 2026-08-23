---
title: "Unity Manual 6.3 LTS: Example of YAML prefab serialization"
page_title: "Unity - Manual: YAML prefab serialization example"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# YAML prefab serialization example

This page demonstrates annotated YAML excerpts of prefab instances, nested prefabs, and prefab variants from Unity project files. The excerpts are trimmed for readability: the original files contain more `m_Modifications` entries than this page shows. For a description of the data model that these excerpts follow, refer to [YAML serialization of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html).

The page covers the following concepts:

-   [Prefab instance in a scene](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html#prefab-instance-in-a-scene)
-   [Nested prefab](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html#nested-prefab)
-   [Prefab variant](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-example.html#prefab-variant)

## Prefab instance in a scene

The following excerpt is from a scene file that places an instance of a rock prefab into the scene. The instance overrides the rock’s position, rotation, and name.

``` lang-yml
--- !u!1001 &11866470
PrefabInstance:
  m_ObjectHideFlags: 0
  serializedVersion: 2
  m_Modification:
    serializedVersion: 3
    m_TransformParent: 
    m_Modifications:
    - target: 
      propertyPath: m_LocalPosition.x
      value: 39.341
      objectReference: 
    - target: 
      propertyPath: m_LocalPosition.y
      value: 4.425
      objectReference: 
    - target: 
      propertyPath: m_LocalPosition.z
      value: 26.527
      objectReference: 
    - target: 
      propertyPath: m_LocalRotation.w
      value: 0.69781095
      objectReference: 
    - target: 
      propertyPath: m_Name
      value: Rock_05_Prefab (4)
      objectReference: 
    m_RemovedComponents: []
    m_RemovedGameObjects: []
    m_AddedGameObjects: []
    m_AddedComponents: []
  m_SourcePrefab: 
--- !u!4 &11866471 stripped
Transform:
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
```

Key points in the excerpt:

-   The `PrefabInstance` element with fileID `11866470` represents the instance. Its `m_SourcePrefab` field references the rock prefab asset (by `guid`) through the prefab asset handle (fileID `100100000`).
-   `m_Modification.m_TransformParent` references a `Transform` component in the same scene file, making the prefab instance a child of that scene object in the hierarchy.
-   Each entry in `m_Modifications` contains one property override. The `target` identifies the object inside the source prefab by `guid` and `fileID`, and a combination of `propertyPath` and `value` specify the overridden property and its value.
-   The stripped `Transform` element (element with the `stripped` attribute) at fileID `11866471` is a placeholder for the `Transform` component on the prefab instance’s root GameObject. Other objects in the scene use this placeholder whenever they reference the prefab instance’s root, for example in the `m_Children` list of the parent scene object’s `Transform` component.

The original `m_Modifications` list in the source file also contains the other rotation components and euler-angle-hint overrides; they’re omitted here for readability.

## Nested prefab

The following example is the complete prefab file that nests one other prefab inside it.

``` lang-yml
%YAML 1.1
%TAG !u! tag:unity3d.com,2011:
--- !u!1 &6949479575104989305
GameObject:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  serializedVersion: 6
  m_Component:
  - component: 
  m_Layer: 0
  m_Name: Stone_01_Prefab
  m_TagString: Untagged
  m_Icon: 
  m_NavMeshLayer: 0
  m_StaticEditorFlags: 2147483647
  m_IsActive: 1
--- !u!4 &1188189139150009913
Transform:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_LocalRotation: 
  m_LocalPosition: 
  m_LocalScale: 
  m_ConstrainProportionsScale: 0
  m_Children:
  - 
  m_Father: 
  m_RootOrder: 0
  m_LocalEulerAnglesHint: 
--- !u!1001 &9179429690634107675
PrefabInstance:
  m_ObjectHideFlags: 0
  serializedVersion: 2
  m_Modification:
    serializedVersion: 3
    m_TransformParent: 
    m_Modifications:
    - target: 
      propertyPath: m_Name
      value: Stone_01_Mesh
      objectReference: 
    - target: 
      propertyPath: m_FadeMode
      value: 1
      objectReference: 
    - target: 
      propertyPath: m_AnimateCrossFading
      value: 1
      objectReference: 
    m_RemovedComponents: []
    m_RemovedGameObjects:
    - 
    m_AddedGameObjects: []
    m_AddedComponents: []
  m_SourcePrefab: 
--- !u!4 &8712595929885449456 stripped
Transform:
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
```

Key points in the example:

-   The outer prefab’s root is serialized as two separate YAML elements: a `GameObject` element (fileID `6949479575104989305`) and its `Transform` component element (fileID `1188189139150009913`). Unity writes them both directly into the file, the same way it writes any non-prefab GameObject.
-   The `m_Children` field on the outer `Transform` component element lists the fileID of the stripped `Transform` placeholder element for the nested instance (`8712595929885449456`). This reference places the nested prefab’s root as a child in the outer prefab’s hierarchy.
-   The `PrefabInstance` element with fileID `9179429690634107675` represents the nested prefab instance. Its `m_SourcePrefab` field references a different prefab asset (the `Stone` source prefab), identified by `guid`.
-   The `m_Modification.m_TransformParent` field on the nested `PrefabInstance` references the outer `Transform` component element. As a result, the nested instance is placed under the outer prefab’s root in the hierarchy.
-   The stripped `Transform` placeholder element at fileID `8712595929885449456` is the target that the outer `Transform` component’s `m_Children` field points to. Its `m_CorrespondingSourceObject` field identifies the specific `Transform` component inside the source `Stone` prefab that this placeholder represents.
-   The `m_RemovedGameObjects` list contains one entry, which indicates that one child GameObject from the source prefab is removed from this nested instance. The `m_RemovedComponents` and `m_AddedGameObjects` lists are empty.

The original `m_Modifications` list in the source file contains additional transform and static flag overrides, they’re omitted here for readability.

## Prefab variant

The following excerpt is from a prefab variant file. The variant is a horizontally flipped version of a base door prefab.

``` lang-yml
%YAML 1.1
%TAG !u! tag:unity3d.com,2011:
--- !u!1001 &5365984487090290000
PrefabInstance:
  m_ObjectHideFlags: 0
  serializedVersion: 2
  m_Modification:
    serializedVersion: 3
    m_TransformParent: 
    m_Modifications:
    - target: 
      propertyPath: m_Name
      value: DoorFusuma_100x200_01_Prefab (38) Variant
      objectReference: 
    - target: 
      propertyPath: m_LocalScale.x
      value: -1
      objectReference: 
    - target: 
      propertyPath: m_LocalScale.x
      value: -1
      objectReference: 
    - target: 
      propertyPath: m_LocalScale.x
      value: -1
      objectReference: 
    m_RemovedComponents: []
    m_RemovedGameObjects: []
    m_AddedGameObjects: []
    m_AddedComponents: []
  m_SourcePrefab: 
```

Key points in the excerpt:

-   The root YAML element of the variant file is a `PrefabInstance`, which has class ID `1001`. A non-variant prefab file, by contrast, starts with a `GameObject` element.
-   The `m_Modification.m_TransformParent` field is `{fileID: 0}`. The `PrefabInstance` element has no parent transform because it’s the root of the file. This is characteristic of prefab variants.
-   The `m_SourcePrefab` field references the base prefab that the variant inherits from.
-   The entries in the `m_Modifications` list contain the property overrides that make this variant distinct from the base. In this example, the negative `m_LocalScale.x` property values on three `Transform` components flip the door geometry horizontally.

The original file contains additional transform and position overrides that complete the flipped layout, they’re omitted here for readability.

## Additional resources

-   [YAML serialization of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html)
-   [Format of text serialized files](https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html)
-   [An example of a YAML scene file](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html)
-   [YAML class ID reference](https://docs.unity3d.com/6000.3/Documentation/Manual/ClassIDReference.html)
-   [Nest prefab instances in other prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html)
-   [Create variations of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html)
-   [Smart merge](https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html)
