---
title: "Load UXML and USS in C# scripts"
page_title: "Unity - Manual: Load UXML and USS in C# scripts"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Load UXML and USS in C# scripts

Unity represents UXML files as `VisualTreeAsset` objects in C# and represents USS files as `StyleSheet` objects in C#. Since `VisualTreeAsset` and `StyleSheet` are regular Unity assets, you can use Unity’s standard workflows to load them.

## Use serialization references

Unity automatically detect fields from your C# scripts which are of type `VisualTreeAsset` or `StyleSheet`. You can use the Inspector to set references to specific UXML or USS files imported in your project. Such references remain valid even when the location of your assets change in your project.

There are three ways to use this in your scripts:

| **Description**                                                              | **How to display the Inspector**                         | **Reference save location**                     |
|:-----------------------------------------------------------------------------|:---------------------------------------------------------|:------------------------------------------------|
| Instances of custom scripts (such as `MonoBehaviour`)                        | Select the GameObject holding the instance of the script | Inside the scene                                |
| Default references for a script that derives from `EditorWindow` or `Editor` | Select the actual C# file in the Project Browser         | Inside the meta file associated with the script |
| Custom assets in your project that derive from `ScriptableObject`            | Select the asset in the Project browser                  | Inside the serialized data of the asset itself  |

**Note**: The default references works for all scripts that derive from `MonoBehaviour` or `ScriptableObject`. It provides a way to populate default values for serialized fields of scripts.

The following example `MonoBehaviour` class receives a UXML file and a list of USS files from the Inspector:

``` lang-cs
using UnityEngine;
using UnityEngine.UIElements;

public class MyBehaviour : MonoBehaviour

```

![The Inspector window shows a single reference picker and a list of style sheets (the list is empty)](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/managing-asset-ref-mb.png)

The following example `EditorWindow` class receives default references from the Inspector:

``` lang-cs
using UnityEditor;
using UnityEngine.UIElements;

public class MyWindow : EditorWindow

```

![The Inspector window shows three reference fields: View Data Dictionary, UXML, and USS](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/managing-asset-ref-window.png)

## Use the Asset Database (Editor only)

You can load your UI Assets by path or GUID with the [`AssetDatabase`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html) class.

The following example shows how to locate an asset by path:

``` lang-cs
VisualTreeAsset uxml = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>("Assets/Editor/main_window.uxml");
StyleSheet uss = AssetDatabase.LoadAssetAtPath<StyleSheet>("Assets/Editor/main_styles.uss");
```

The following example shows how to locate an asset by path from a package:

``` lang-cs
VisualTreeAsset uxml = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>("Packages/<name-of-the-package>/main_window.uxml");
StyleSheet uss = AssetDatabase.LoadAssetAtPath<StyleSheet>("Packages/<name-of-the-package>/main_styles.uss");
```

## Use Addressables

The [Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@latest) system provides tools and scripts to organize and package content for your application and an API to load and release assets at runtime.

You can use UXML and USS assets with the Addressable system. A code-less way to use addressables is to create a prefab out of the UI Document component and then add that [prefab as an addressable](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html).

<span id="use-a-resources-folder"></span>

## Use a Resources folder

If you add a `Resources` folder in your project and place your UI assets in it, you can use the [`Resources.Load`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html) method to load your assets.

The following examples shows how to load an asset in the `Resources` folder:

``` lang-cs
VisualTreeAsset uxml = Resources.Load<VisualTreeAsset>("main_window");
StyleSheet uss = Resources.Load<StyleSheet>("main_styles");
```

**Note**: This method increases the final build size and memory loading time significantly because all files in the `Resources` folder are included in the build. If you are concerned about these, use [`Addressables`](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/index.html) instead.

## Additional resources

-   [Instantiate UXML from C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LoadingUXMLcsharp.html)
-   [Reference other files from UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reference-other-files-from-uxml.html)
-   <span aria-hidden="true">📚</span> **Documentation**: [Addressables: Planning and best practices](https://unity.com/blog/engine-platform/addressables-planning-and-best-practices)
