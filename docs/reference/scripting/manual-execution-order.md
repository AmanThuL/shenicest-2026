---
title: "Order of execution for event functions (Unity 6.3 Manual)"
page_title: "Unity - Manual: Event function execution order"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Event function execution order

The following diagram provides a high-level overview of the execution sequence for event functions that run during the lifecycle of a MonoBehaviour script component. For readability, the scope of the chart is limited to key parts of the script lifecycle, with some extra internal subsystem updates provided for context. The full Player loop is a longer and more complex sequence of updates for specific systems and subsystems, which run one after the other in a defined default order. To retrieve the full Player loop and all of its systems, you can use the [PlayerLoop API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html). You can also use this API to [customize the Player loop](https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html) sequence by removing systems, adding your own, and changing the update order.

For more information on each individual callback’s meaning and limitations, refer to the **Messages** section of the [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) API reference.

![Order of execution for event functions during the lifecycle of a MonoBehaviour script.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/monobehaviour_flowchart.svg)

## Before scene load and unload

Not shown in the previous diagram are the [`SceneManager.sceneLoaded`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html) and [`SceneManager.sceneUnloaded`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneUnloaded.html) events which allow you to receive callbacks when a scene has loaded and unloaded respectively. Unity raises the `sceneLoaded` event after `OnEnable` but before `Start` for all objects in the scene. For details and example usage, refer to the relevant API reference pages.

For a diagram that includes scene load as part of the execution flow, refer to [Details of disabling Domain and Scene reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html)

## Run code on Editor launch

Sometimes it can be useful to make parts of your code run immediately on launch of the Unity Editor or runtime, without any additional user action and without the code needing to be part of a MonoBehaviour script. You can run code on Editor launch without requiring any user action by applying the [`[InitializeOnLoad]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InitializeOnLoadAttribute.html) attribute to a class that has a [static constructor](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/static-constructors). Alternatively, you can apply the [`[InitializeOnLoadMethod]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InitializeOnLoadMethodAttribute.html) attribute to individual methods. For more information and usage examples, refer to the API references for these attributes.

## Run code on runtime intialization

You can run code on initialization of the runtime application by applying the [`[RuntimeInitializeOnLoadMethodAttribute]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html) to methods. You can also specify a [`RunTimeInitializeLoadType`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html) attribute parameter to control where in the Player loop the attributed code executes. For more information on the execution order of methods marked with this attribute, refer to the API reference for [`RuntimeInitializeOnLoadMethodAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html).

<span id="AnimationUpdateLoop"></span>

## Internal animation update

The following diagram shows the order of execution for the regular Animation update loop, and expands the nodes labelled **Internal animation update** in the previous diagram:

![Order of execution for the regular Animation update loop.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/animation-update-sequence.svg)

The following Animation loop callbacks shown in the diagram are called on scripts that derive from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html):

-   [`MonoBehaviour.OnAnimatorMove`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorMove.html)
-   [`MonoBehaviour.OnAnimatorIK`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorIK.html)

Additional animation-related event functions are called on scripts that derive from [`StateMachineBehaviour`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.html):

-   [`StateMachineBehaviour.OnStateMachineEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineEnter.html)
-   [`StateMachineBehaviour.OnStateMachineExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineExit.html)
-   [`StateMachineBehaviour.OnStateEnter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateEnter.html)
-   [`StateMachineBehaviour.OnStateUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateUpdate.html)
-   [`StateMachineBehaviour.OnStateExit`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateExit.html)
-   [`StateMachineBehaviour.OnStateMove`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMove.html)
-   [`StateMachineBehaviour.OnStateIK`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateIK.html)

Other animation functions shown in the diagram are internal to the animation system and are provided for context. These functions have associated Profiler markers so you can use the [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) to see when in the frame Unity calls them. Knowing when Unity calls these functions can help you understand exactly when the event functions you do call are executed. For a full execution order of animation functions and profiler markers, refer to [Profiler markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#animation).

<span id="Rendering"></span>

## Rendering

This execution order applies for the [Built-in Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/built-in-render-pipeline.html) only. For details of execution order in render pipelines based on the [Scriptable Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/scriptable-render-pipeline-introduction.html), refer to the relevant sections of the documentation for the [Universal Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/customize/custom-pass-injection-points.html) or the [High Definition Render Pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/rendering-execution-order.html). If you want to do work immediately prior to rendering, refer to [Application.onBeforeRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-onBeforeRender.html).

-   [`OnPreCull`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPreCull.html): Called before the camera culls the scene. Culling determines which objects are visible to the camera. `OnPreCull` is called just before culling takes place.
-   [`OnBecameVisible`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnBecameVisible.html)/[`OnBecameInvisible`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnBecameInvisible.html): Called when an object becomes visible/invisible to any camera. `OnBecameInvisible` is not shown in the flow chart above since an object may become invisible at any time.
-   [`OnWillRenderObject`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnWillRenderObject.html): Called **once** for each camera if the object is visible.
-   [`OnPreRender`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPreRender.html): Called before the camera starts rendering the scene.
-   [`OnRenderObject`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderObject.html): Called after all regular scene rendering is done. You can use [GL](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GL.html) class or [Graphics.DrawMeshNow](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.DrawMeshNow.html) to draw custom geometry at this point.
-   [`OnPostRender`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnPostRender.html): Called after a camera finishes rendering the scene.
-   [`OnRenderImage`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnRenderImage.html): Called after scene rendering is complete to allow post-processing of the image, see [Post-processing Effects](https://docs.unity3d.com/6000.3/Documentation/Manual/PostProcessingOverview.html).
-   [`OnGUI`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnGUI.html): Called multiple times per frame in response to GUI events. The Layout and Repaint events are processed first, followed by a Layout and keyboard/mouse event for each input event.
-   [`OnDrawGizmos`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmos.html) Used for drawing Gizmos in the scene view for visualisation purposes.

**Note**: [OnPreCull](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.OnPreCull.html), [OnPreRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.OnPreRender.html), [OnPostRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.OnPostRender.html), and [OnRenderImage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.OnRenderImage.html) are built-in Unity event functions that are called on MonoBehaviour scripts but **only if those scripts are attached to the same object as an enabled Camera component**. If you want to receive the equivalent callbacks for `OnPreCull`, `OnPreRender`, and `OnPostRender` on a MonoBehaviour attached to a **different** object, you must use the equivalent delegates (note the lowercase `on` in the names) [Camera.onPreCull](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-onPreCull.html), [Camera.onPreRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-onPreRender.html), and [Camera.onPostRender](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-onPostRender.html) as shown in the code examples in the relevant pages of the scripting reference.

## Resumption of coroutines and asynchronous tasks

Suspended coroutines can resume at different points in the execution sequence depending on the yield instruction used. For example, coroutines that use [`WaitForEndOfFrame`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForEndOfFrame.html) resume at the end of the frame, while those that use [`WaitForFixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForFixedUpdate.html) resume at the end of the fixed update step. For more information, refer to [Coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines.html).

Regular .NET Tasks and asynchronous methods resume in the `Update` phase. Similarly to coroutines, Unity’s custom [`Awaitable`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html) class can resume at different points depending on the method you use when awaiting. For more information, refer to [Asynchronous programming with the Awaitable class](https://docs.unity3d.com/6000.3/Documentation/Manual/async-await-support.html).

**Note**: The exact order of execution between resuming coroutines and asynchronous tasks is not guaranteed. Awaitables are grouped together and executed in the order they were awaited.

## Combining MonoBehaviours with Entities

When using the [Entity Component System](https://docs.unity3d.com/Packages/com.unity.entities@latest/index.html) (ECS), Unity merges ECS system group updates into the Player update loop.

You can use the Entities Systems window to view the update order of ECS system groups relative to the full Player loop. For more information, refer to [Update order of systems](https://docs.unity3d.com/Packages/com.unity.entities@1.4/manual/systems-update-order.html#update-order-of-systems) in the Entities package documentation.

<span id="GeneralPrinciples"></span>

## Limitations

In general, you can’t rely on the order in which the same event function is invoked for different GameObjects, except when the order is explicitly documented or settable.

You can’t specify the order in which an event function is called for different instances of the same MonoBehaviour script. For example, the `Update` function of one MonoBehaviour might be called before or after the `Update` function for the same MonoBehaviour on another GameObject, including its own parent or child GameObjects.

To configure the execution order between different MonoBehaviour scripts, refer to [Script execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-execution-order.html).

## Additional resources

-   [Event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html)
-   [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html)
-   [PlayerLoop API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html)
-   [Script execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-execution-order.html)
