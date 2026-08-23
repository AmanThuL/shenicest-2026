---
title: "Unity 6.3 Manual: Programming with gizmos and handles"
page_title: "Unity - Manual: Programming with gizmos and handles"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/gizmos-handles-programming.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/gizmos-handles-programming.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Programming with gizmos and handles

The [`Gizmos`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Gizmos.html) and [`Handles`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Handles.html) classes allow you to draw lines and shapes in the **Scene** view and **Game** view, as well as interactive handles and controls. These two classes together provide a way for you to extend what is shown in these views and build interactive tools to edit your project in any way you like.

For example, rather than entering numbers in the Inspector, you could create a draggable circle radius gizmo around a non-player character in a game, which represents the area within which they can hear or see the player.

## Gizmos

The `Gizmos` class allows you to draw lines, spheres, cubes, icons, textures and meshes into the Scene view to use as debugging, set-up aids, or tools while developing your project.

The following example draws a 10 unit yellow wire cube around a GameObject:

``` lang-cs
using UnityEngine;
public class GizmosExample : MonoBehaviour

}
```

The following image shows how this cube looks when placed on a Directional Light GameObject:

![A light GameObject with an extra script applied which draws a cube gizmo around its position](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ScriptingGizmoExample.png)

For a full API reference including usage examples, refer to the API reference page for [`Gizmos`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Gizmos.html).

## Handles

Handles are similar to gizmos, but provide more interactivity and manipulation. The default 3D controls that Unity provides to manipulate items in the Scene view are a combination of gizmos and handles. There are a number of built-in handle GUIs, such as the familiar tools to position, scale and rotate an object via the [Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html) component.

You can define your own handle GUIs to use with custom component editors. Such GUIs can be a very useful way to edit procedurally-generated Scene content, “invisible” items and groups of related objects, such as waypoints and location markers.

The following example creates an arc area with an arrowhead handle, allowing you to modify a “shield area” in the Scene view:

``` lang-cs
using UnityEditor;
using UnityEngine;
using System.Collections;

//this class should exist somewhere in your project
public class WireArcExample : MonoBehaviour

// Create a 180 degrees wire arc with a ScaleValueHandle attached to the disc
// that lets you modify the "shieldArea" value in the WireArcExample
[CustomEditor(typeof(WireArcExample))]
public class DrawWireArc : Editor

}
```

![An example of an Arc handle and an Scale handle](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ScriptingHandlesExample.png)

For a full API reference including usage examples, refer to the API reference page for [`Handles`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Handles.html).

## Additional resources

-   [Gizmos Menu](https://docs.unity3d.com/6000.3/Documentation/Manual/GizmosMenu.html)
-   [Programming in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting.html)
