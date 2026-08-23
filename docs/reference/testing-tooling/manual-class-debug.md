---
title: "The Debug class"
page_title: "Unity - Manual: The Debug class"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# The Debug class

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html" class="switch-link gray-btn sbtn left" title="Go to Debug page in the Scripting Reference">Switch to Scripting</a>

The Debug class allows you to visualize information in the Unity Editor that might help you understand or investigate what is going on in your project while it’s running. For example, you can use it to print messages into the Console window, draw visualization lines in the Scene view and Game view, and pause Play mode in the Editor from script.

This page provides an overview of the Debug class and its common uses when scripting with it. For an exhaustive reference of every member of the Debug class, refer to the [Debug script reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html).

## Logging errors, warnings and messages

Unity sometimes logs errors, warnings, and messages to the Console window. The `Debug` class provides you with the ability to do exactly the same from your own code, as shown in the following example:

``` lang-cs
Debug.Log("This is a log message.");
Debug.LogWarning("This is a warning message!");
Debug.LogError("This is an error message!");
```

The three types (error, warning, and message) each have their own icon type in the Console window.

![The Console window displays the three types of debug message: a regular log with a white exclamation icon, a warning with a yellow exclamation icon, and an error with a red exclamation icon.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleShowingMessageWarningAndError.png)

Everything that is written to the Console Window (by Unity, or your own code) is also written to a [Log File](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html).

If **Error Pause** is enabled in the Console, any errors written to the Console via the `Debug` class cause Play mode to pause.

You can also provide a second optional parameter to these log methods to indicate that the message is associated with a particular GameObject, like the following:

``` lang-cs
using UnityEngine;

public class DebugExample : MonoBehaviour

}
```

The benefit of this is that when you click the message in the console, the GameObject you associated with that message is highlighted in the Hierarchy, allowing you to identify which GameObject the message related to. In the following image, selecting the `I come in peace!` warning message highlights the **Alien (8)** GameObject.

![The Console window displays “I come in peace!” as a warning-level log message.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleMessageWithContextGameObject.png)

## Using the Debug class

The `Debug` class has two methods for drawing lines in the Scene view and Game view. These are [`DrawLine`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawLine.html) and [`DrawRay`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.DrawRay.html).

In this example, a script has been added to every Sphere GameObject in the scene, which uses `Debug.DrawLine` to indicate its vertical distance from the plane where Y equals zero. Note that the last parameter in this example is the duration in seconds that the line stays visible in the Editor.

``` lang-cs
using UnityEngine;

public class DebugLineExample : MonoBehaviour

}
```

And the result in the Scene view looks like this:

![The Scene view displays a group of spheres, each with a magenta line indicating its distance from the plane where Y equals zero.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/DebugDrawLineExampleInScene.png)

### Excluding Debug code from non-development builds

The [`UnityEngine.Debug`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html) logging APIs aren’t stripped from [release builds](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html), and write to log files if called. You can prevent this by using `#if` directives or a conditional attribute to make compilation of `Debug` calls dependent on a scripting symbol that’s only defined in development builds.

The following example uses a conditional attribute with a scripting symbol called `ENABLE_LOGS` that is only defined in development builds:

``` lang-cs
    public static class Logger 
    }
```

For more information, refer to [Conditional compilation in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html).

## Additional resources

-   [Console window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html)
-   [Log files](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html)
