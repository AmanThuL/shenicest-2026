---
title: "The GameObject class"
page_title: "Unity - Manual: The GameObject class"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# The GameObject class

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html" class="switch-link gray-btn sbtn left" title="Go to GameObject page in the Scripting Reference">Switch to Scripting</a>

Unity’s GameObject class represents anything that can exist in a **Scene**. GameObjects are the building blocks for scenes in Unity and act as a container for functional components which determine how the GameObject looks and what it does.

The [GameObject class](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) class provides a collection of methods which allow you to work with GameObjects in your code. These include methods for finding, making connections, and sending messages between GameObjects, adding or removing components attached to the GameObject, and setting values relating to their status within the scene.

For a complete reference of every member of the GameObject class, refer to the [GameObject script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).

For information on using GameObjects in the Scene and Hierarchy in the Unity Editor, refer to [Introduction to GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/GameObjects.html).

## Scene status properties

All GameObjects share a set of controls at the top of the Inspector relating to the GameObject’s status within the scene, and these can be controlled via the GameObject’s scripting API.

![A typical GameObject viewed in the Inspector. In this case, a directional light. The Scene status properties are outlined in red.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/GameObjectSceneStatusProperties.png)

<span id="active-status"></span>

## Active status

![The Active status of a GameObject](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/GOInspectorActiveSetting.png)

GameObjects are active by default, but can be deactivated, which turns off all components attached to the GameObject. This generally means it will become invisible, and not receive any of the normal callbacks or events such as [`Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) or [`FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html).

The GameObject’s **active** status is represented by the checkbox to the left of the GameObject’s name. You can control this using [`GameObject.SetActive`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html).

You can also use [`GameObject.activeSelf`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html) to read the current active state of a GameObject. Use [`GameObject.activeInHierarchy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) to read whether the GameObject is actually active in the scene. [`GameObject.activeInHierarchy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) is necessary because whether a GameObject is actually active is determined by its own active state and the active state of all its parents. If any of its parents aren’t active, then it’s not active despite its own active setting.

<span id="static-status"></span>

## Static status

![The Static status of a GameObject](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/GOInspectorStaticSetting.png)

Some of Unity’s systems, such as Global Illumination, Occlusion, Batching, Navigation, and Reflection Probes, rely on the static status of a GameObject. You can control which of Unity’s systems consider the GameObject to be **static** by using [`GameObjectUtility.SetStaticEditorFlags`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.SetStaticEditorFlags.html). For more information, refer to [Static GameObjects](https://docs.unity3d.com/Manual/StaticObjects.html).

## Tags and Layers

![The Tag and Layer fields of a GameObject](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/GOInspectorTagsAndLayers.png)

**Tags** provide a way of marking and identifying types of GameObject in your scene and **Layers** provide a similar but distinct way of including or excluding groups of GameObjects from certain built-in actions, such as [rendering](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html) or [physics collisions](https://docs.unity3d.com/6000.3/Documentation/Manual/CollidersOverview.html).

For more information about how to use Tags and Layers in the editor, refer to the main user manual pages for [Tags](https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html) and [Layers](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html).

You can modify tag and layer values via script using the [`GameObject.tag`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-tag.html) and [`GameObject.layer`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-layer.html) properties. You can also check a GameObject’s tag efficiently by using the [`CompareTag`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html) method, which includes validation of whether the tag exists, and doesn’t cause any memory allocation.

## Add and remove components

You can add or remove components at runtime, which can be useful for procedurally creating GameObjects, or modifying how a GameObject behaves. Note, you can also [`enable` or `disable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html) script components, and some types of built-in component, via script without destroying them.

The best way to add a component at runtime is to use [`AddComponent<Type>`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html), specifying the type of component within angle brackets as shown. To remove a component, you must use [`Object.Destroy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) method on the component itself.

<span id="AccessingComponents"></span>

## Access components

The simplest case is where a script on a GameObject needs to access another Component attached to the same GameObject (remember, other scripts attached to a GameObject are also Components themselves). To do this, the first step is to get a reference to the Component instance you want to work with. This is done with the [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html) method. Typically, you want to assign the Component object to a variable, which is done in using the following code. In this example the script is getting a reference to a Rigidbody component on the same GameObject:

``` lang-cs
void Start ()

```

Once you have a reference to a Component instance, you can set the values of its properties much as you would in the Inspector:

``` lang-cs
void Start ()

```

You can also call methods on the Component reference, for example:

``` lang-cs
void Start ()

```

Note: you can have multiple custom scripts attached to the same GameObject. If you need to access one script from another, you can use GetComponent as usual and just use the name of the script class (or the file name) to specify the Component type you want.

If you attempt to retrieve a Component type that hasn’t actually been added to the GameObject then GetComponent will return null. You will get a null reference error at runtime if you try to change any values on a null object.

<span id="AccessingOtherGameObjects"></span>

## Access components on other GameObjects

Although they sometimes operate in isolation, it’s common for scripts to keep track of other GameObjects, or more commonly, components on other GameObjects. For example, in a cooking game, a chef might need to know the position of the stove. Unity provides different ways to retrieve other objects, each appropriate to certain situations.

### Link to GameObjects with variables in the Inspector

The most straightforward way to find a related GameObject is to add a public GameObject variable to the script:

``` lang-cs
public class Chef : MonoBehaviour

```

This variable will be visible in the Inspector, as a **GameObject field**.

You can now drag an object from the scene or Hierarchy panel onto this variable to assign it.

The GetComponent function and Component access variables are available for this object as with any other, so you can use code like the following:

``` lang-cs
public class Chef : MonoBehaviour 
}
```

Additionally, if you declare a public variable of a Component type in your script, you can drag any GameObject that has that Component attached onto it. This accesses the Component directly rather than the GameObject itself.

``` lang-cs
public Transform playerTransform;
```

Linking objects together with variables is most useful when you are dealing with individual objects that have permanent connections. You can use an array variable to link several objects of the same type, but the connections must still be made in the Unity editor rather than at runtime. It’s often convenient to locate objects at runtime and Unity provides two basic ways to do this, as described below.

### Find child GameObjects

Sometimes, a game Scene makes use of multiple GameObjects of the same type, such as collectibles, waypoints, and obstacles. These might need to be tracked by a particular script that supervises or reacts to them (for example, all waypoints might need to be available to a pathfinding script). Using variables to link these GameObjects is a possibility but it makes the design process tedious if each new waypoint has to be dragged to a variable on a script. Likewise, if a waypoint is deleted, then it’s a nuisance to have to remove the variable reference to the missing GameObject. In cases like this, it is often better to manage a set of GameObjects by making them all children of one parent GameObject. The child GameObjects can be retrieved using the parent’s Transform component (because all GameObjects implicitly have a Transform):

``` lang-cs
using UnityEngine;

public class WaypointManager : MonoBehaviour 
    }
}
```

You can also locate a specific child object by name using the [Transform.Find](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Find.html) method:

``` lang-cs
transform.Find("Frying Pan");
```

This can be useful when a GameObject has a child GameObject that can be added and removed during gameplay. A tool or utensil that can be picked up and put down during gameplay is a good example of this.

## Send and broadcast messages

While editing your project you can set up references between GameObjects in the Inspector. However, sometimes it’s impossible to set these up in advance (for example, finding the nearest item to a character in your game, or making references to GameObjects that were instantiated after the Scene loaded). In these cases, you can find references and send messages between GameObjects at runtime.

[`BroadcastMessage`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.BroadcastMessage.html) allows you to send out a call to a named method, without being specific about where that method should be implemented. You can use it to call a named method on every MonoBehaviour on a particular GameObject or any of its children. You can optionally choose to enforce that there must be at least one receiver (or an error is generated).

[`SendMessage`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SendMessage.html) is a little more specific, and only sends the call to a named method on the GameObject itself, and not its children.

[`SendMessageUpwards`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SendMessageUpwards.html) is similar, but sends out the call to a named method on the GameObject and all its *parents*.

## Find GameObjects by Name or Tag

It’s always possible to locate GameObjects anywhere in the Scene hierarchy as long as you have some information to identify them. Individual objects can be retrieved by name using the [GameObject.Find](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.Find.html) function:

``` lang-cs
GameObject player;

void Start()

```

An object or a collection of objects can also be located by their tag using the [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html) and [GameObject.FindGameObjectsWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindGameObjectsWithTag.html) methods.

For example, in a cooking game with one chef character, and multiple stoves in the kitchen (each tagged “Stove”):

``` lang-cs
GameObject chef;
GameObject[] stoves;

void Start()

```

## Create and destroy GameObjects

You can create and destroy GameObjects while your project is running. In Unity, a GameObject can be created using the [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html) method which makes a new copy of an existing object.

For a full description and examples of how to instantiate GameObjects, see [Instantiating Prefabs at Runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs.html).

The [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html) method destroys an object after the frame update has finished or optionally after a short time delay:

``` lang-cs
void OnCollisionEnter(Collision otherObj) 
}
```

Note that the Destroy function can destroy individual components and not affect the GameObject itself. A common mistake is to write `this` and assume it destroys the GameObject the script is attached to:

``` lang-cs
Destroy(this);
```

`this` represents the script, and not the GameObject. It will actually just destroy the script component that calls it and leave the GameObject intact but with the script component removed.

## Primitives

The GameObject class offers script-based alternatives to the options available in Unity’s GameObject menu that allows you to create [primitive objects](https://docs.unity3d.com/6000.3/Documentation/Manual/PrimitiveObjects.html).

To create instances of Unity’s built-in primitives, use [GameObject.CreatePrimitive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CreatePrimitive.html), which instantiates a primitive of the type that you specify. The available primitive types are [Sphere](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Sphere.html), [Capsule](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Capsule.html), [Cylinder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Cylinder.html), [Cube](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Cube.html), [Plane](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Plane.html) and [Quad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrimitiveType.Quad.html).

![The Primitive shapes available in Unity’s GameObject menu](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AllPrimitives.png)

## Additional resources

-   [Introduction to GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/GameObjects.html)
-   [GameObject API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html)
