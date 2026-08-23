---
title: "ScriptableObject (Unity 6.3 Manual)"
page_title: "Unity - Manual: ScriptableObject"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ScriptableObject

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="switch-link gray-btn sbtn left" title="Go to ScriptableObject page in the Scripting Reference">Switch to Scripting</a>

ScriptableObject is a serializable Unity type derived from [`UnityEngine.Object`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html). As with [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html), you don’t instantiate the ScriptableObject class directly but create your own custom C# classes that derive from it, and then create instances of those custom classes, usually through the **Assets** menu in the Unity Editor.

All instances of classes derived from ScriptableObject are commonly referred to as ScriptableObjects. Unlike MonoBehaviours, ScriptableObjects are not attached to GameObjects as components but exist in the project as [assets](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetWorkflow.html), independent of GameObjects. Because ScriptableObjects inherit from `UnityEngine.Object`, you can drag or pick instances of them into fields in the Inspector.

The main value of a ScriptableObject is as a data store, but they can also define behavior. A common use for ScriptableObjects is as a container for shared data used by multiple objects at runtime, which can reduce a project’s memory usage by avoiding copies of values.

For example, if your project has a prefab that stores unchanging data in attached MonoBehaviour scripts, then every new instance of the prefab gets its own copy of the data. Instead of duplicating data like this, you can use a ScriptableObject to store the data and then access it by reference from all the prefabs. This means that there is one copy of the data in memory.

The main use cases for ScriptableObjects are:

-   Saving and storing data during an Editor session. This is why many authoring tools in Unity, such as [`EditorTool`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorTools.EditorTool.html) and [`EditorWindow`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorWindow.html), derive from `ScriptableObject`.
-   Saving data as an asset in your project to use at runtime.

For a complete reference of every member of the ScriptableObject class, refer to the [ScriptableObject script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html).

## Create a ScriptableObject

To create a new ScriptableObject script, the quickest way is to use the predefined ScriptableObject script template from the **Assets** menu in one of the following ways:

-   In the main menu, go to **Assets** > **Create** > **Scripting** > and select **ScriptableObject Script**.
-   In the [Project window toolbar](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html), right-click to open the Project window context menu, then select **Create** > **Scripting** > **ScriptableObject Script**. You can also click the plus sign in the Project window to open the **Create** menu directly.

This gives you a custom base class that inherits from `UnityEngine.ScriptableObject`. You can then use the [CreateAssetMenu](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CreateAssetMenuAttribute.html) attribute to create instances of this class, each of which becomes an asset in your project.

## Example: Instantiate prefabs with a ScriptableObject

The following example uses a ScriptableObject to store data defined at authoring time that is later used to determine where to instantiate prefabs at runtime. First, create the following base ScriptableObject class in your `Assets` folder:

``` lang-cs
using UnityEngine;
// Use the CreateAssetMenu attribute to allow creating instances of this ScriptableObject from the Unity Editor.
[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/SpawnManagerScriptableObject", order = 1)]
public class SpawnManagerScriptableObject : ScriptableObject

```

With the previous script in your `Assets` folder, create an instance of your new ScriptableObject by navigating to **Assets \> Create \> ScriptableObjects \> SpawnManagerScriptableObject**. Give your new ScriptableObject instance a meaningful name and alter the values. To use these values at runtime, you need to create a new script that references your ScriptableObject, in this case, a `SpawnManagerScriptableObject` as follows:

``` lang-cs
using UnityEngine;

public class ScriptableObjectManagedSpawner : MonoBehaviour

    void SpawnEntities()
    
    }
}
```

**Note:** The script file must have the same name as the class.

Attach the previous script to a GameObject in your [Scene](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html). Then, in the Inspector, populate the **Spawn Manager Values** field with the new `.asset` instance of `SpawnManagerScriptableObject` that you set up.

Set the **Entity To Spawn** field to any prefab in your `Assets` folder, then enter Play mode. The prefab you referenced in the `ScriptableObjectManagedSpawner` instantiates using the values you set in the `SpawnManagerScriptableObject` instance.

If you’re working with ScriptableObject references in the Inspector, you can double click the reference field to open the Inspector for your ScriptableObject. You can also create a custom Inspector for your type to help manage the data that it represents.

## Saving changes to ScriptableObject data

In the Unity Editor, you can save data to ScriptableObjects in Edit mode and Play mode. In a standalone Player at runtime, you can only read saved data from the ScriptableObject assets. When you use Editor authoring tools or the Inspector to modify a ScriptableObject asset, Unity automatically writes the data to disk and it persists between Editor sessions.

However, Unity doesn’t automatically save changes to a `ScriptableObject` made via script in Edit mode. In these cases, you must call [`EditorUtility.SetDirty`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUtility.SetDirty.html) on the ScriptableObject to ensure Unity’s serialization system recognizes it as changed and saves the changes to disk. Without this, changes may not persist between Editor sessions.

The following is a simple ScriptableObject for storing game settings:

``` lang-cs
using UnityEngine;

[CreateAssetMenu(fileName = "GameSettings", menuName = "ScriptableObjects/GameSettingsScriptableObject", order = 2)]
public class GameSettingsScriptableObject : ScriptableObject

```

Create a new instance of the `GameSettingsScriptableObject` in your project via **Assets** \> **Create** \> **ScriptableObjects** \> **GameSettingsScriptableObject**. Then, in the Inspector, set the `highScore` value.

The following Editor script adds a simple window with a button for increasing the high score at **Window** \> **Game Settings Editor**.

``` lang-cs
using UnityEditor;
using UnityEngine;

public class GameSettingsEditor : EditorWindow

    void OnGUI()
    
    }
}
```

Without the call to [`EditorUtility.SetDirty`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUtility.SetDirty.html) in this example, the change to `highScore` appears in memory, but if you close and reopen the Editor the value reverts to its previous value.

## Additional resources

-   [`ScriptableObject` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html)
-   [Introduction to ScriptableObjects](https://learn.unity.com/tutorial/introduction-to-scriptable-objects)
