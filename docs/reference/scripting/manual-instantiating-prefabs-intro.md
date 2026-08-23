---
title: "Introduction to instantiating prefabs"
page_title: "Unity - Manual: Introduction to instantiating prefabs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs-intro.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs-intro.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to instantiating prefabs

You can use [prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/prefabs-introduction.html) to instantiate complicated GameObjects or collections of GameObjects at runtime. Compared with creating GameObjects from scratch using code, instantiating prefabs using code has many advantages because you can do the following:

-   Instantiate a prefab using one line of code. Creating equivalent GameObjects from scratch requires many more lines of code.
-   Change which prefab is instantiated without changing the code. You can make a simple rocket into a super-charged rocket, without any code changes.

## Common scenarios

Instantiating prefabs at runtime is useful in the following common scenarios:

-   Building a structure out of a single prefab by replicating it multiple times in different positions, for example in a grid or circle formation.
-   Firing a projectile prefab from a launcher. The projectile prefab can be a complex configuration containing a mesh, Rigidbody, collider, audio source, dynamic light, and a child GameObject with its own trail Particle System.
-   A vehicle, building, or character, for example a robot, breaking apart into many pieces. In this scenario, the example script deletes and replaces the complete, operational robot prefab with a wrecked robot prefab. This wrecked prefab consists of separate broken parts of the robot, each set up with Rigidbody components and Particle Systems of their own. This technique allows you to blow up a robot into many pieces with just one line of code, which replaces the original GameObject with a wrecked prefab.

## Instantiate a prefab

To instantiate a prefab at runtime, your code needs a reference to the prefab. To make this reference, you can create a public field of type `GameObject` in your code, then assign the prefab you want to use to this field in the Inspector.

The following script example has a single public variable, `myPrefab`, which is a reference to a prefab. It creates an instance of that prefab in the `Start` method.

``` lang-cs
using UnityEngine;
public class InstantiationExample : MonoBehaviour 

}
```

To use this example:

1.  Create a new MonoBehaviour script in your Project, and name it `InstantiationExample`.
2.  Copy the code and paste it into your new script, and save it.
3.  Create an empty GameObject using the menu **GameObject** > **Create Empty**.
4.  Add the script to the new GameObject as a component by dragging it onto the empty GameObject.
5.  [Create any prefab](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html), and drag it from the **Project window** into the **My Prefab** field in the script component.

When you enter Play mode, the prefab instantiates at position (0 , 0 , 0) in the scene.

You can drag a different prefab into the **My Prefab** field in the **Inspector** window to change which prefab Unity instantiates, without having to change the script.

## Additional resources

-   [Build a structure with prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs-structure.html)
-   [Instantiate projectiles and explosions](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs-projectiles.html)
-   [`Instantiate` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)
