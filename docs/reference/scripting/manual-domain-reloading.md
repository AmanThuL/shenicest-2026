---
title: "Enter Play mode with domain reload disabled"
page_title: "Unity - Manual: Enter Play mode with domain reload disabled"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Enter Play mode with domain reload disabled

The scripting domain, also known as the [application domain](https://learn.microsoft.com/en-us/dotnet/framework/app-domains/application-domains), or simply domain, is a core feature of Unity’s managed scripting environment. The domain is an isolated section of memory dedicated to a particular application, which contains the compiled types required by the application, grouped into logical units called [assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html). It also contains the data that represents the current application state, such as the values of variables and object references in the various sections of [managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory.html).

By default Unity reloads the domain on entering Play mode to reset the application state. Resetting state before entering Play mode is often desirable so your application starts up as it would at the beginning of a new build. For example, static counters that were incremented in a previous Play mode session should begin from zero again in the next one. However, domain reload is also a time-consuming operation that negatively impacts iteration times when you frequently switch between Edit and Play mode. For faster iteration times, you can [disable domain reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode.html#configure-play-mode) on entering Play mode but you must then manually [reset state in your code](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html#reset-state).

**Note**: Unity also performs domain reload as part of an asset database refresh when it detects changes to scripts. This still happens even when domain reload on entering Play mode is disabled. For more information on when and how asset database refreshes happen, refer to [Refreshing the Asset Database](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetDatabaseRefreshing.html).

## Effects of disabling domain reload when entering Play mode

When you disable domain reload:

-   Non-serialized fields keep the values assigned to them during Play mode on returning to Edit mode. This applies for fields of all script types, including MonoBehaviours (including those on prefab assets), ScriptableObjects, and your own custom C# types. For detailed information on what is and isn’t serialized in different contexts, refer to [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html).
-   Static variables keep their values between Play mode sessions.
-   Static events keep their registered subscribers between Play mode sessions.
-   There are no additional `OnDisable` or `OnEnable` calls for scripts marked with the [`[ExecuteInEditMode]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteInEditMode.html) or [`[ExecuteAlways]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html).

To compensate for this persistence of data between Play mode sessions and enter Play mode with a fresh application state, you must [reset state in your code](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html#reset-state).

For more information on the effects of disabling domain and scene reload, refer to [Details of disabling domain and scene reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html).

<span id="reset-state"></span>

## Resetting state from code

When domain reloading is disabled, the values of [static fields](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/static-classes-and-static-class-members#static-members) and the handlers assigned to static events persist between Play mode runs. The following code example has a static counter that increments on a press of any keyboard key. The code also registers a method to handle the static event [`EditorApplication.playModeStateChanged`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html).

With domain reload enabled, Unity reinitializes this code on entering Play mode, erasing the state from the previous Play mode run, including the counter value and the registration of the event handler. With domain reload disabled, the counter value and the event handler registration are both preserved from the previous run. On the next run of Play mode, the counter begins with the value it had at the end of the previous run and the event handler method is called multiple times on one occurrence of the event, generating multiple “Exiting Play mode!” messages in the console.

``` lang-cs
// Copy-paste this code into a MonoBehaviour script attached to a GameObject in your project.
// Run it with domain reload enabled and then with domain reload disabled and note the different behavior.

using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class StateResetExample : MonoBehaviour

    void Update()
    
    }
#if UNITY_EDITOR
    private static void OnExitPlayMode(PlayModeStateChange state)
    
    }
#endif
}
```

You can fix the problem behavior with code that explicitly resets the counter and unregisters the event handler between Play mode runs. You can either do this on entering Play mode or on exiting Play mode.

<span id="reset-on-exit"></span>

### Resetting state on exiting Play mode

It’s often most efficient to reset state on exiting Play mode rather than on entering. You can use the [`EditorApplication.playModeStateChanged`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html) event and its [`ExitingPlayMode`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayModeStateChange.ExitingPlayMode.html) enum value to catch the Play mode exit event and reset state at that point. In the following example the event handler for Play mode exit is used to unregister itself, but you can also use this method to unregister any other static event handlers at this point:

``` lang-cs
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class StateResetOnExit : MonoBehaviour

    // Update is called once per frame
    void Update()
    
    }

#if UNITY_EDITOR
    private static void OnExitPlayMode(PlayModeStateChange state)
    
    }
#endif
}
```

[`EditorApplication.playModeStateChanged`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html) is in the `UnityEditor` namespace so it only works in Play mode within the Unity Editor and not in a standalone Player build.

If your code executes in Edit mode in addition to Play mode, you can’t rely on resetting state on exiting Play mode. Your code might modify a static variable while in Edit mode, so you must reset the variable [on entering Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html#reset-on-enter) instead.

**Note**: For scripts that execute in Edit mode, disabling domain reload skips [`MonoBehaviour.OnDisable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html) and disabling scene reload skips [`MonoBehaviour.OnDestroy`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html), which makes these methods inappropriate for resetting state in such scripts. For more information, refer to [Details of disabling domain and scene reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html).

<span id="reset-on-enter"></span>

### Resetting state on entering Play mode

You can also reset state on entering Play mode. This can be a useful alternative if you encounter any platform-specific problems with capturing the exiting Play mode event, or if you have code that also executes in Edit mode. For the purposes of illustration, the following example demonstrates both resetting static variables and unregistering static event handlers on entering Play mode. Best practice is to always unregister static event handlers [on exiting Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html#reset-on-exit). Waiting until the next Play mode session can cause object reference issues that lead to unregistering the wrong handler.

Unity has custom initialization attributes in both the `UnityEngine` and `UnityEditor` namespaces, which you can use to perform initialization work, including manual state reset. Which attributes you should use depends on whether your code runs in Edit mode or Play mode. To reset state on entering Play mode for your Player (runtime) scripts, you can use the [`[RuntimeInitializeOnLoadMethod]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html) attribute with the [`RuntimeInitializeLoadType.SubsystemRegistration`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.SubsystemRegistration.html) parameter:

``` lang-cs
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class StateResetOnEnter : MonoBehaviour

    void Start()
    
    // Update is called once per frame
    void Update()
    
    }
#if UNITY_EDITOR
    private static void OnExitPlayMode(PlayModeStateChange state)
    
    }
#endif
}
```

[`[RuntimeInitializeOnLoadMethod]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html) is in the `UnityEngine` namespace so it’s only available in Play mode. For Editor-only scripts such as custom Editor windows or Inspectors that use statics, you can do one of the following:

-   Use [`[InitializeOnLoadAttribute]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InitializeOnLoadAttribute.html) to register a handler for [`EditorApplication.playModeStateChanged`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html) and then perform state cleanup on either entering or exiting Play mode. Refer to the [`EditorApplication.playModeStateChanged`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html) API reference for an example.
-   Use the [`[InitializeOnEnterPlayMode]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InitializeOnEnterPlayModeAttribute.html) attribute to perform cleanup specifically on entering Play mode.

**Note**: While the previous code examples use MonoBehaviour classes, you can also use these initialization attributes on scripts of any kind, including those that inherit from ScriptableObject or your own custom C# types.

## Additional resources

-   [Project Settings window](https://docs.unity3d.com/6000.3/Documentation/Manual/comp-ManagerGroup.html)
-   [Editor Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-EditorManager.html)
-   [Toolbar](https://docs.unity3d.com/6000.3/Documentation/Manual/Toolbar.html)
-   [Scene Reloading](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-reloading.html)
-   [Configurable Enter Play Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode.html)
