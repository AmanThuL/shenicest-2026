---
title: "Unity 6.3 Manual: Details of disabling domain and scene reload"
page_title: "Unity - Manual: Details of disabling domain and scene reload"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Details of disabling domain and scene reload

## What Unity skips when domain reload and scene reload is disabled

From a high-level perspective, entering Play mode consists of the following main stages:

-   **Backup current scenes**. This only happens when the Scene has been modified. Allows Unity to revert the Scenes when exiting Play mode to the state they were in before Play mode started.
-   **Domain reload**. Resets the scripting state, by reloading the scripting domain.
-   **Scene reload**. Resets the Scene state, by reloading the Scene.
-   **Update scene**. This happens twice; once without rendering, and once with rendering.

The combined tasks of domain reload and scene reload resets the scripting domain and simulates the startup behavior of your application as it would run in the Player. Unity skips these steps when you disable them in your Project Settings.

The following diagram provides detailed information about the exact events which Unity skips when domain reload and scene reload are disabled. Blue indicates the events Unity skips when domain reload is disabled, and green indicates the events Unity skips when scene reload is disabled.

![Event functions in the MonoBehaviour script lifecycle. Event functions skipped when domain reload is disabled are highlighted blue. Event functions skipped when scene reload is disabled are highlighted green.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/EnterPlayModeEvents.svg)

## What Unity does when scene reloading and domain reloading are both enabled

With scene reload and domain reload enabled, this is the full list of all processes and events that Unity performs when entering Play mode:

1.  The [AssemblyReloadEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssemblyReloadEvents.html) `beforeAssemblyReload` event is raised.
2.  The C# domain is stopped:  
    a. `OnDisable()` is called for all ScriptableObjects and MonoBehaviours.  
    b. Unity waits for all async operations to finish.
3.  The state of all MonoBehaviours and ScriptableObjects is serialized.  
    a. `OnBeforeSerialize()` is called.  
    b. All public and private field values are serialized, except those marked with `[NonSerialized]`.
4.  Managed wrappers are disconnected from native Unity objects.
5.  The Unity Child Domain is reloaded:  
    a. Mono domain unload:  
    i. The `AppDomain.DomainUnload` event is raised.  
    ii. The Unity Child Domain is destroyed  
    1. GC and finalizers are called.  
    2. Threads are terminated.  
    3. All JIT info is deleted.  
    b. The new Unity Child Domain is created.
6.  The assemblies are loaded:  
    a. System assemblies are loaded.  
    b. Unity assemblies are loaded.  
    c. User assemblies are loaded.
7.  The synchronization context is initialized.
8.  The scripting state is restored.  
    a. The scriptable part of all Unity objects is recreated.  
    i. Constructors are called, and statics are assigned their default values.  
    b. The state of all Unity objects is deserialized:  
    i. The serialized states of all Unity objects are restored.  
    1. The `OnAfterDeserialize` event is raised.  
    ii. `OnValidate()` is called.  
    iii. For scripts using the `[ExecuteInEditMode]` attribute:  
    1. `OnEnable()` is called.  
    2. `OnDisable()` is called.  
    3. `OnDestroy()` is called.
9.  Methods with the [InitializeOnLoad](https://docs.unity3d.com/ScriptReference/InitializeOnLoadAttribute.html) and [InitializeOnLoadMethod](https://docs.unity3d.com/ScriptReference/InitializeOnLoadMethodAttribute.html) are called.
10. The [AssemblyReloadEvent](https://docs.unity3d.com/ScriptReference/AssemblyReloadEvents.html) `afterAssemblyReload` is called.

## Additional resources

-   [Enter Play mode with domain reload disabled](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html)
-   [Enter Play mode with scene reload disabled](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-reloading.html)
