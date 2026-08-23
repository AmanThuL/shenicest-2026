---
title: "Unity Manual 6.3 LTS: Format of text serialized files"
page_title: "Unity - Manual: Format of text serialized files"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Format of text serialized files

Unity’s Scene format uses a custom subset of the YAML data serialization language. YAML is an open format with documentation about it available on the [YAML website](http://yaml.org/spec/1.2/spec.html). For more information about the YAML used in unity, read the documentation on [UnityYAML](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityYAML.html).

The file writes each Object in a Scene as a separate YAML document. The `---` sequence introduces each Object in the file. In this context, the term “Object” refers to GameObjects, Components and other scene data collectively: each of these items needs its own YAML document in the scene file. The following example shows the basic structure of a serialized object:

``` lang-yml
--- !u!1 &6
GameObject:
  m_ObjectHideFlags: 0
  m_PrefabParentObject: 
  m_PrefabInternal: 
  importerVersion: 3
  m_Component:
  - 4: 
  - 33: 
  - 65: 
  - 23: 
  m_Layer: 0
  m_Name: Cube
  m_TagString: Untagged
  m_Icon: 
  m_NavMeshLayer: 0
  m_StaticEditorFlags: 0
  m_IsActive: 1
```

The first line contains the string `!u!1 &6` after the document marker. The first number after `!u!` indicates the class of the object (in this case, it is a GameObject). The number following the ampersand is an object ID number unique within the file, although the number is assigned to each object arbitrarily. Each of the object’s serializable properties is denoted by a line like the following:

``` lang-yml
m_Name: Cube
```

Properties are typically prefixed with `m_` but otherwise follow the name of the property as defined in the script reference. The following example shows how a second object, defined further down in the file looks:

``` lang-yml
--- !u!4 &8
Transform:
  m_ObjectHideFlags: 0
  m_PrefabParentObject: 
  m_PrefabInternal: 
  m_GameObject: 
  m_LocalRotation: 
  m_LocalPosition: 
  m_LocalScale: 
  m_Children: []
  m_Father: 
```

The following example shows an attached Transform component to the GameObject defined by the YAML document above. `{fileID:6}` is used to represent the GameObject as the GameObject’s object ID within the file was 6.

``` lang-yml
m_GameObject: 
```

…

Decimal representation or hexadecimal numbers in IEEE 754 format (denoted by a 0x prefix) can be used to represent floating point numbers. Unity uses the IEEE 754 representation for lossless encoding of values and to write floating point values which don’t have a short decimal representation. When Unity writes numbers in hexadecimal, it always writes the decimal format in parentheses for debugging purposes, but only the hex is actually parsed when loading the file. To edit these values manually, remove the hex and enter a decimal number. The following example shows a valid representation of floating point values (all representing the number one):

``` lang-yml
myValue: 0x3F800000
myValue: 1
myValue: 1.000
myValue: 0x3f800000(1)
myValue: 0.1e1
```
