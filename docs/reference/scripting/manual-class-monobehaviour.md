---
title: "MonoBehaviour (Unity 6.3 Manual)"
page_title: "Unity - Manual: MonoBehaviour"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# MonoBehaviour

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html" class="switch-link gray-btn sbtn left" title="Go to MonoBehaviour page in the Scripting Reference">Switch to Scripting</a>

The MonoBehaviour class provides the framework that allows you to attach your script to a GameObject in the Editor. It also provides hooks into useful Events such as [Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html) and [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html).

You can create new MonoBehaviour scripts in the Editor as described in [Create scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html).

For a complete reference of every member of the MonoBehaviour class, and its technical details, refer to the [MonoBehaviour script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).

## Content of a MonoBehaviour script file

Double-click a script Asset in Unity to open it in a text editor. By default, Unity uses Visual Studio, but you can select any editor you like from the **External Tools** panel in Unity’s preferences (menu: **Unity** \> **Preferences**).

If you choose to create a MonoBehaviour script, the initial contents of the file will look something like this:

``` lang-cs
using UnityEngine;
using System.Collections;

public class NewMonoBehaviourScript : MonoBehaviour 
    // Update is called once per frame
    void Update()
    
}
```

This script makes its connection with the internal workings of Unity by implementing a class which derives from the built-in class called `MonoBehaviour`. You can think of a class as a kind of blueprint for creating a new Component type that can be attached to GameObjects. Each time you attach a script component to a GameObject, it creates a new instance of the object defined by the blueprint. The name of the class is taken from the name you supplied when the file was created. It’s best practice to keep the class name and file name in sync, refer to [Naming considerations](https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html#script-file-names).

The main things to note, however, are the two functions defined inside the class. The **Update** function is the place to put code that will handle the frame update for the GameObject. This might include movement, triggering actions and responding to user input, basically anything that needs to be handled over time during gameplay. To enable the Update function to do its work, it is often useful to be able to set up variables, read preferences and make connections with other GameObjects before any game action takes place. The **Start** function will be called by Unity before gameplay begins (before the Update function is called for the first time) and is an ideal place to do any initialization.

**Note**: Experienced programmers may be surprised that initialization of an object is not done using a constructor function. This is because the construction of objects is handled by the Unity Editor and does not take place at the start of gameplay as you might expect. If you attempt to define a constructor for a MonoBehaviour, it will interfere with the normal operation of Unity and can cause major problems with the project.

## Controlling a GameObject

A script only defines a blueprint for a Component, so none of its code will be active until an instance of the script is attached to a GameObject. You can attach a script by dragging the script asset to a GameObject in the hierarchy panel or to the Inspector of the GameObject that is currently selected. There is also a Scripts submenu on the Component menu which will contain all the scripts available in the project, including those you have created yourself. The script instance looks much like any other Component in the Inspector:

![A script component attached to a GameObject in the Inspector.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ScriptInInspector.png)

Once attached, the script will start working when you press Play and run the game. You can check this by adding the following code in the `Start` function:

``` lang-cs
// Use this for initialization
void Start () 

```

**Debug.Log** is a simple command that just prints a message to Unity’s console output. If you press Play now, you should see the message at the bottom of the main Editor window and in the Console window (menu: **Window** \> **General** \> **Console**).

## Coroutines

The MonoBehaviour class allows you to start, stop, and manage coroutines.

For more information on coroutines, refer to [Coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html) and the [StartCoroutine method script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html).

## Events

The MonoBehaviour class provides access to a large collection of [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html), which allows you to execute your code based on what is currently happening in your project. Here are a few of the more common examples. For a list of them all, see the **Messages** section on the [MonoBehaviour script reference page](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html)

## Additional resources

-   [Event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html)
-   [MonoBehaviour API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html)
