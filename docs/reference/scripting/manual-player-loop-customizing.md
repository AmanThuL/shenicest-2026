---
title: "Customizing the Player loop (Unity 6.3 Manual)"
page_title: "Unity - Manual: Customizing the Player loop"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Customizing the Player loop

Unity runtime applications run in a continuous loop called the Player loop. During each iteration of the Player loop, Unity calls various systems to perform tasks such as rendering, physics simulation, and input handling.

The various systems and subsystems updated during the Player loop are called in a defined default order. You can see and customize this order using the static methods from the [`PlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html) API. You can retrieve the default or current Player loop and insert your own own custom Player loop systems, or remove, reorder, or replace existing ones.

There are several reasons you might want to customize the Player loop:

-   Creating your own managed updates as part of a custom [update manager](https://docs.unity3d.com/6000.3/Documentation/Manual/events-per-frame-optimization.html) can be a more performant alternative to Unity’s native event functions. For more information, refer to [10000 Update calls](https://unity.com/blog/engine-platform/10000-update-calls) on the Unity blog.
-   You might want to optimize the Player loop for a specific platform, for example by removing Physics, AI, and XR updates for a mobile game.
-   You might want to create visualizations of the update loop in Edit mode or Play mode to help with debugging.

## Accessing the Player loop

The Player loop consists of a series of nested Player loop systems, each of which is a [`PlayerLoopSystem`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoopSystem.html) structure. The root or outermost Player loop system represents the full Player loop, under which other Player loop systems are nested.

In this context, a Player loop system is just an abstract representation of anything that needs to update during the Player loop. The default systems are representations of native Unity systems such as Audio and Input, but you can also create your own custom systems from your C# code.

To access Unity’s default Player loop, use [`PlayerLoop.GetDefaultPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.GetDefaultPlayerLoop.html). To access the Player loop currently in effect, use [`PlayerLoop.GetCurrentPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.GetCurrentPlayerLoop.html). The default and current Player loop will be the same unless you apply a new custom Player loop with [`PlayerLoop.SetPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.SetPlayerLoop.html).

Each system in the Player loop has a [`PlayerLoopSystem.type`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoopSystem-type.html) property that identifies it. You can recursively iterate over a Player loop system structure and print the [`Name`](https://learn.microsoft.com/en-us/dotnet/api/system.reflection.memberinfo.name?view=net-9.0#system-reflection-memberinfo-name) of each `type` property to display the Player loop structure in the console. You can also use the `type` property, as shown in the following examples, to identify Player loop subsystems to add, remove, or replace. Valid types for default systems are available in the `UnityEngine.PlayerLoop` namespace.

The API reference [`PlayerLoop.GetDefaultPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.GetDefaultPlayerLoop.html) includes an example of how to retrieve the default Player loop, iterate over the nested Player loop systems and print the `Name` of their `type` properties. The code produces the following console output:

``` text
ROOT NODE
    TimeUpdate
        WaitForLastPresentationAndUpdateTime
    Initialization
        ProfilerStartFrame
        UpdateCameraMotionVectors
        DirectorSampleTime
        AsyncUploadTimeSlicedUpdate
        SynchronizeInputs
        SynchronizeState
        XREarlyUpdate
    EarlyUpdate
        PollPlayerConnection
        GpuTimestamp
        AnalyticsCoreStatsUpdate
        UnityWebRequestUpdate
        ExecuteMainThreadJobs
        ProcessMouseInWindow
        ClearIntermediateRenderers
        ClearLines
        PresentBeforeUpdate
        ResetFrameStatsAfterPresent
        UpdateAsyncInstantiate
        UpdateAsyncReadbackManager
        UpdateStreamingManager
        UpdateTextureStreamingManager
        UpdatePreloading
        UpdateContentLoading
        RendererNotifyInvisible
        PlayerCleanupCachedData
        UpdateMainGameViewRect
        UpdateCanvasRectTransform
        XRUpdate
        UpdateInputManager
        ProcessRemoteInput
        ScriptRunDelayedStartupFrame
        UpdateKinect
        DeliverIosPlatformEvents
        ARCoreUpdate
        DispatchEventQueueEvents
        Physics2DEarlyUpdate
        PhysicsResetInterpolatedTransformPosition
        SpriteAtlasManagerUpdate
        PerformanceAnalyticsUpdate
    FixedUpdate
        ClearLines
        NewInputFixedUpdate
        DirectorFixedSampleTime
        AudioFixedUpdate
        ScriptRunBehaviourFixedUpdate
        DirectorFixedUpdate
        LegacyFixedAnimationUpdate
        XRFixedUpdate
        PhysicsFixedUpdate
        Physics2DFixedUpdate
        PhysicsClothFixedUpdate
        DirectorFixedUpdatePostPhysics
        ScriptRunDelayedFixedFrameRate
    PreUpdate
        PhysicsUpdate
        Physics2DUpdate
        PhysicsClothUpdate
        CheckTexFieldInput
        IMGUISendQueuedEvents
        NewInputUpdate
        InputForUIUpdate
        SendMouseEvents
        AIUpdate
        WindUpdate
        UpdateVideo
    Update
        ScriptRunBehaviourUpdate
        ScriptRunDelayedDynamicFrameRate
        ScriptRunDelayedTasks
        DirectorUpdate
    PreLateUpdate
        AIUpdatePostScript
        DirectorUpdateAnimationBegin
        LegacyAnimationUpdate
        DirectorUpdateAnimationEnd
        DirectorDeferredEvaluate
        AccessibilityUpdate
        UIElementsUpdatePanels
        EndGraphicsJobsAfterScriptUpdate
        ConstraintManagerUpdate
        ParticleSystemBeginUpdateAll
        Physics2DLateUpdate
        PhysicsLateUpdate
        ScriptRunBehaviourLateUpdate
    PostLateUpdate
        PlayerSendFrameStarted
        DirectorLateUpdate
        ScriptRunDelayedDynamicFrameRate
        PhysicsSkinnedClothBeginUpdate
        UpdateRectTransform
        PlayerUpdateCanvases
        UIElementsRepaintPanels
        UpdateAudio
        VFXUpdate
        ParticleSystemEndUpdateAll
        EndGraphicsJobsAfterScriptLateUpdate
        UpdateCustomRenderTextures
        XRPostLateUpdate
        UpdateAllRenderers
        UpdateLightProbeProxyVolumes
        EnlightenRuntimeUpdate
        UpdateAllSkinnedMeshes
        ProcessWebSendMessages
        SortingGroupsUpdate
        UpdateVideoTextures
        UpdateVideo
        DirectorRenderImage
        PlayerEmitCanvasGeometry
        UIElementsRenderBatchModeOffscreen
        PhysicsSkinnedClothFinishUpdate
        FinishFrameRendering
        BatchModeUpdate
        PlayerSendFrameComplete
        UpdateCaptureScreenshot
        PresentAfterDraw
        ClearImmediateRenderers
        PlayerSendFramePostPresent
        UpdateResolution
        InputEndFrame
        TriggerEndOfFrameCallbacks
        GUIClearEvents
        ShaderHandleErrors
        ResetInputAxis
        ThreadedLoadingDebug
        ProfilerSynchronizeStats
        MemoryFrameMaintenance
        ExecuteGameCenterCallbacks
        XRPreEndFrame
        ProfilerEndFrame
        GraphicsWarmupPreloadedShaders
        ObjectDispatcherPostLateUpdate
```

## Insert a custom update into the default Player loop

The recommended and lowest risk way to customize the Player loop is to insert a custom Player loop system into the default Player loop. This way, you can add your own custom update logic without disrupting any of Unity’s built-in systems.

The code example in the [`PlayerLoop.SetPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.SetPlayerLoop.html) API reference shows how to insert a custom Player loop system into the default Player loop at a specified point. In that case, the behavior of the `CustomUpdate` method is defined in the `InsertSystem` class. But the following small modifications can make the `CustomUpdate` an event that your MonoBehaviour scripts can subscribe to and provide their own update logic for:

-   Declare an event as a public, static field of the `InsertSystem` class:

``` lang-cs
public static event Action AddCustomUpdate;
```

-   Modify the definition of the `CustomUpdate` method to invoke this event:

``` lang-cs
private static void CustomUpdate() => AddCustomUpdate?.Invoke();
```

You can then subscribe to the custom update from any MonoBehaviour script as follows:

``` lang-cs
using UnityEngine;

public class CustomUpdateFromEvent : MonoBehaviour

    private void Update()
    
    private void LateUpdate()
    
    private void OnDisable()
    
    private void MyCustomUpdate()
    
}
```

**Note**: The Player loop system you pass as a parameter to [`PlayerLoop.SetPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.SetPlayerLoop.html) overwrites the current Player loop. Therefore, make sure any loop you pass to this method contains all the systems you want to keep, including the ones you don’t replace. If you create a new Player loop system from scratch, you must explicitly add all the systems you want to keep to the new loop.

## Replace a default system in the Player loop

The following example replaces a default system in the Player loop with a custom update. The example replaces the `PreUpdate.AIUpdate` system, but you can replace any system in the Player loop by specifying its [PlayerLoopSystem.type](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoopSystem-type.html) identifier. Valid types for default systems can be obtained by iterating through the default Player loop, as shown in the previous section, or from the `UnityEngine.PlayerLoop` namespace.

**Important**: Replacing a system in the Player loop can have unintended consequences, as it removes the default functionality of that system. Use this method with caution, and only if you’re sure you want to replace the default functionality with your own custom logic.

``` lang-cs
using UnityEngine.LowLevel;
using UnityEngine.PlayerLoop;
using UnityEngine;

// Replace an existing system in the Unity Player Loop with a custom update.

public class MyReplacementCustomUpdate { } // Empty class to use as a type identifier for the custom update

public class SystemReplacement
{
    //Run this method on runtime initialization
    [RuntimeInitializeOnLoadMethod]
    private static void AppStart()
    {
        // Retrieve the default Player loop system. Get the current loop instead if the default was already modified previously.
        var defaultSystems = PlayerLoop.GetDefaultPlayerLoop();
        // Create a custom update system to replace an existing one
        var customUpdate = new PlayerLoopSystem()
        {
            updateDelegate = CustomUpdate,
            type = typeof(MyReplacementCustomUpdate)
        };
        // Specify the system to replace as the type parameter, in this case PreUpdate.AIUpdate
        ReplaceSystem<PreUpdate.AIUpdate>(ref defaultSystems, customUpdate);
        PlayerLoop.SetPlayerLoop(defaultSystems);
    }

    // Custom update method that will be called in the Player Loop
    private static void CustomUpdate()
    
    //Recursively replace a system of type T with a replacement system in the Player Loop
    private static bool ReplaceSystem<T>(ref PlayerLoopSystem system, PlayerLoopSystem replacement)
    
        if (system.subSystemList != null)
        
            }
        }
        return false;
    }
}
```

## Additional resources and examples

-   <span aria-hidden="true">📚</span> **Documentation**: [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html)
-   <span aria-hidden="true">📚</span> **Documentation**: [`LowLevel.PlayerLoop` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html)
-   <span aria-hidden="true">📚</span> **Documentation**: [10000 Update calls](https://unity.com/blog/engine-platform/10000-update-calls)
-   <span aria-hidden="true">👥</span> **Community**: [`LowLevel.PlayerLoop` topics at Unity Discussions](https://discussions.unity.com/search?expanded=true&q=LowLevel.PlayerLoop%20order%3Alatest_topic)
