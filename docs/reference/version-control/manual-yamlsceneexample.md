---
title: "Unity Manual 6.3 LTS: An example of a YAML scene file"
page_title: "Unity - Manual: YAML scene file example"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# YAML scene file example

This page shows excerpts from a simple Unity scene file. The scene contains a camera, a directional light, a global volume, and a cube. The excerpts below focus on the camera and cube as representative examples.

Unity scene files contain many serialized properties. To keep this page readable, the example omits repetitive sections and shows representative excerpts instead of a complete scene file.

For more information about the UnityYAML format, refer to [UnityYAML](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html).

## Example scene structure

This is one example of a scene file from a simple project. Your own scene file might contain different objects, components, and names. For example, it might not contain a camera named `Main Camera` or a GameObject named `Cube`. When reading a scene file, Unity tries to assign default values to any properties for which a value hasn’t been set.

This example is split into the following sections:

-   [Global scene-level settings](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html#global-scene-level-settings)
-   [Example camera GameObject and components](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html#example-camera-gameobject-and-components)
-   [Example cube GameObject and components](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html#example-cube-gameobject-and-components)
-   [Scene root transforms](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html#scene-root-transforms)

### Global scene-level settings

A scene file must start with the YAML version and tag directives shown in the first two lines below, followed by global scene-level settings such as graphics and navigation settings:

``` lang-yml
%YAML 1.1
%TAG !u! tag:unity3d.com,2011:
--- !u!29 &1
OcclusionCullingSettings:
  m_ObjectHideFlags: 0
  serializedVersion: 2
  m_OcclusionBakeSettings:
    smallestOccluder: 5
    smallestHole: 0.25
    backfaceThreshold: 100
  m_SceneGUID: 00000000000000000000000000000000
  m_OcclusionCullingData: 
--- !u!104 &2
RenderSettings:
  m_ObjectHideFlags: 0
  serializedVersion: 10
  m_Fog: 0
  m_FogColor: 
  m_AmbientSkyColor: 
  m_SkyboxMaterial: 
  m_Sun: 
--- !u!157 &3
LightmapSettings:
  m_ObjectHideFlags: 0
  serializedVersion: 13
  m_BakeOnSceneLoad: 0
  m_GISettings:
    serializedVersion: 2
    m_BounceScale: 1
    m_IndirectOutputScale: 1
    m_AlbedoBoost: 1
    m_EnvironmentLightingMode: 0
    m_EnableBakedLightmaps: 1
    m_EnableRealtimeLightmaps: 0
  m_LightmapEditorSettings:
    serializedVersion: 12
    m_Resolution: 2
    m_BakeResolution: 40
    m_AtlasSize: 1024
  m_LightingDataAsset: 
  m_LightingSettings: 
--- !u!196 &4
NavMeshSettings:
  serializedVersion: 2
  m_ObjectHideFlags: 0
  m_BuildSettings:
    serializedVersion: 3
    agentTypeID: 0
    agentRadius: 0.5
    agentHeight: 2
    agentSlope: 45
    agentClimb: 0.4
  m_NavMeshData: 
```

### Example camera GameObject and components

Each scene object is stored as a separate YAML element. A `GameObject` element lists its components, and each component element points to the same GameObject using `fileID`:

``` lang-yml
--- !u!1 &330585543
GameObject:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  serializedVersion: 6
  m_Component:
  - component: 
  - component: 
  - component: 
  - component: 
  m_Layer: 0
  m_Name: Main Camera
  m_TagString: MainCamera
  m_Icon: 
  m_NavMeshLayer: 0
  m_StaticEditorFlags: 0
  m_IsActive: 1
--- !u!81 &330585544
AudioListener:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_Enabled: 1
--- !u!20 &330585545
Camera:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_Enabled: 1
  serializedVersion: 2
  m_ClearFlags: 1
  m_BackGroundColor: 
  m_projectionMatrixMode: 1
  m_GateFitMode: 2
  m_FOVAxisMode: 0
  m_Iso: 200
  m_ShutterSpeed: 0.005
  m_Aperture: 16
  m_FocusDistance: 10
  m_FocalLength: 50
  m_BladeCount: 5
  m_Curvature: 
  m_BarrelClipping: 0.25
  m_Anamorphism: 0
  m_SensorSize: 
  m_LensShift: 
  m_NormalizedViewPortRect:
    serializedVersion: 2
    x: 0
    y: 0
    width: 1
    height: 1
  near clip plane: 0.3
  far clip plane: 1000
  field of view: 60
--- !u!4 &330585546
Transform:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  serializedVersion: 2
  m_LocalRotation: 
  m_LocalPosition: 
  m_LocalScale: 
  m_ConstrainProportionsScale: 0
  m_Children: []
  m_Father: 
  m_LocalEulerAnglesHint: 
--- !u!114 &330585547
MonoBehaviour:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_Enabled: 1
  m_EditorHideFlags: 0
  m_Script: 
```

### Example cube GameObject and components

Other scene objects follow the same pattern. For example, the Cube GameObject has its own `GameObject` element and separate component documents:

``` lang-yml
--- !u!1 &1106998149
GameObject:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  serializedVersion: 6
  m_Component:
  - component: 
  - component: 
  - component: 
  - component: 
  m_Layer: 0
  m_Name: Cube
  m_TagString: Untagged
  m_IsActive: 1
--- !u!65 &1106998150
BoxCollider:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_IsTrigger: 0
  m_Enabled: 1
  serializedVersion: 3
  m_Size: 
  m_Center: 
--- !u!23 &1106998151
MeshRenderer:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_Enabled: 1
  m_CastShadows: 1
  m_ReceiveShadows: 1
  m_Materials:
  - 
--- !u!33 &1106998152
MeshFilter:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  m_Mesh: 
--- !u!4 &1106998153
Transform:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: 
  m_PrefabInstance: 
  m_PrefabAsset: 
  m_GameObject: 
  serializedVersion: 2
  m_LocalRotation: 
  m_LocalPosition: 
  m_LocalScale: 
  m_Children: []
  m_Father: 
```

### Scene root transforms

At the end of the file, Unity stores the scene root transforms:

``` lang-yml
--- !u!1660057539 &9223372036854775807
SceneRoots:
  m_ObjectHideFlags: 0
  m_Roots:
  - 
  - 
  - 
  - 
```

## Additional resources

-   [UnityYAML](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html)
-   [Text-based scene files](https://docs.unity3d.com/6000.3/Documentation/Manual/TextSceneFormat.html)
-   [Smart Merge](https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html)
