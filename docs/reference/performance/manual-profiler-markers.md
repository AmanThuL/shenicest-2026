---
title: "Profiler markers reference"
page_title: "Unity - Manual: Profiler markers reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Profiler markers reference

Unity’s code is instrumented with [profiler markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-adding-information-code-intro.html#profiler-markers) that give you insight into what takes up time in your application. The following tables contain a list of some of the in-built markers.

-   [Main thread base markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#main-thread)
-   [Script update markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#script-update)
-   [Rendering and VSync markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#rendering)
-   [Back end scripting markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#backend)
-   [Multithreading markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#multithreading)
-   [Physics markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#physics)
-   [Animation markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#animation)
-   [UI Toolkit markers](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-profiler-markers.html)
-   [Performance warnings](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#warnings)

<span id="main-thread"></span>

## Main thread base markers

The main thread base markers provide a clear separation between the time spent on your application and time spent on Unity Editor and Profiler activities. You can also use these markers with the [`ProfilerRecorder`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.html) API to get the timing of a frame on the main thread, or the [`FrameTimingManager`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FrameTimingManager.html) API for high level frame stats at runtime.

You can also use the rendering profiler counters CPU Main Thread Frame Time, CPU Render Thread Frame Time, and CPU Total Frame Time to get high-level timings of the CPU usage of your application. For more information, refer to [Rendering profiler counters reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html#rendering).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>PlayerLoop</strong></td><td style="text-align: left;">Contains any samples that originate from your application’s main loop. If you <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-edit-mode.html">target the Editor</a> instead of Play mode while the Player is running within the Editor in active Play mode, PlayerLoop samples nest under the EditorLoop.</td></tr><tr class="even"><td style="text-align: left;"><strong>EditorLoop</strong><br />
<em>(Editor only marker)</em></td><td style="text-align: left;">Contains any samples that originate from the Editor’s main loop. This is only present while you <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-edit-mode.html">profile a player in the Editor</a>. When you <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-play-mode.html">target Play mode with the Profiler</a>, EditorLoop samples indicate the amount of time spent rendering and running the Editor that contains the Player.<br />
<br />
For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-play-edit-samples.html">Play mode and Edit mode samples</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Profiler.CollectEditorStats</strong><br />
<em>(Editor only marker)</em></td><td style="text-align: left;">Contains any samples that relate to collecting statistics for different active Profiler modules.<br />
<br />
Samples nested under the <code>Profiler.CollectGlobalStats</code> marker indicate how much overhead the Player has when it collects the statistics of a particular module. All other child samples only reflect their effect in the Editor.<br />
<br />
To remove the overhead that a particular module has, close the module’s chart, or call <code>Profiler.SetAreaEnabled</code>.<br />
<br />
<strong>Note:</strong> <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-customizing.html">Custom Profiler modules</a> that use built-in counters enable the built-in counter’s area, even if the module it belongs is disabled. To prevent the Profiler from collecting these statistics and creating collection overhead, make sure that both the built-in Profiler module and your custom Profiler module are disabled.</td></tr></tbody></table>

<span id="script-update"></span>

## Script update markers

Unless you’re using the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html), most of your scripting code is nested underneath the following markers. For information on job system samples, refer to the [Multi threading markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html#multithreading) section of this page.

For further details on Unity’s Update Loop, refer to the documentation on [Order of execution of event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html). You can insert your own callbacks into the [Player Loop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html) using [`PlayerLoop.SetPlayerLoop`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.SetPlayerLoop.html). If you insert callbacks directly into the main loop, your script update samples appear on their own. If you insert callbacks as a subsystem, the samples appear under the respective main PlayerLoopSystem marker.

| **Marker**                                     | **Description**                                                                                                                                                                                                                           |
|:-----------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **BehaviourUpdate**                            | Contains all samples of [`MonoBehaviour.Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) methods.                                                                                        |
| **CoroutinesDelayedCalls**                     | Contains all samples of [coroutines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine..html) after their first yield.                                                                                              |
| **FixedBehaviourUpdate**                       | Contains all samples of [`Monobehaviour.FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) methods.                                                                              |
| **PreLateUpdate.ScriptRunBehaviourLateUpdate** | Contains all samples of [`Monobehaviour.LateUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html) methods.                                                                                |
| **Update.ScriptRunBehaviourUpdate**            | Contains all samples of [`MonoBehaviour.Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) and [coroutines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html). |

<span id="rendering"></span>

## Rendering and VSync markers

These markers contain the samples where the CPU spends time processing data for the GPU, or where it might be waiting for the GPU to finish. If the [GPU Profiler module](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerGPU.html) isn’t available, or it adds too much overhead, the toolbar in the Profiler module details pane doesn’t display this information. The samples under these markers can give you a good idea of whether your application is CPU-bound or GPU-bound.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>WaitForTargetFPS</strong></td><td style="text-align: left;">Indicates how much time your application spent waiting for the targeted FPS that <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-targetFrameRate.html"><code>Application.targetFrameRate</code></a> specifies.<br />
<br />
If the sample is a subsample of Gfx.WaitForPresentOnGfxThread, it represents the amount of time that your application spent waiting for the GPU. For example, this could be time that the GPU spent waiting for the next VSync, if that is configured in <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings-vSyncCount.html">QualitySettings.vSyncCount</a>, or if vSync is enforced on your target platform. However, samples with this marker are also emitted if the GPU hasn’t finished computing the frame.<br />
<br />
To determine what is causing samples with this marker to use a lot of time, switch to the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html">Timeline view in the CPU Profiler module</a>. In this view, you can check what happened on the render thread and how much time passed between this sample ending in the current frame and the same sample ending in surrounding frames.<br />
<br />
If the duration is larger than your application’s frame time should be (based on the targeted frame rate or vSync) your frames are taking too long to render or compute. If that’s the case, investigate the render thread and see how much time it spent on Gfx.PresentFrame over other work it did to prepare and issue commands to the GPU. If the render thread spent a large amount of time in Gfx.PresentFrame, your rendering work is GPU-bound. If the render thread’s time was spent preparing commands, your application is CPU-bound.<br />
<br />
To find out what to focus on, if your application is GPU bound, profile the GPU work with the Unity Profiler or a platform profiler. For more information, see the User manual documentation on how to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/OptimizingGraphicsPerformance.html">optimize graphics performance</a>.<br />
<br />
<strong>Note:</strong> The Editor doesn’t VSync on the GPU and instead uses WaitForTargetFPS to simulate the delay for VSync. Some platforms, in particular Android and iOS, enforce VSync or have a default frame rate cap of 30 or 60.</td></tr><tr class="even"><td style="text-align: left;"><strong>Gfx.PresentFrame</strong></td><td style="text-align: left;">Represents the time your application spent waiting for the GPU to render and present the frame, which includes waiting for VSync.<br />
<br />
Samples with the WaitForTargetFPS marker on the main thread show how much time is spent waiting for VSync.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Gfx.ProcessCommands</strong></td><td style="text-align: left;">Contains all processing of the rendering commands on the render thread. Your application might have spent some of this processing time waiting for VSync or new commands from the main thread, which you can see from its child sample Gfx.WaitForPresentOnGfxThread.</td></tr><tr class="even"><td style="text-align: left;"><strong>Gfx.WaitForCommands</strong></td><td style="text-align: left;">Indicates that the render thread was ready for new commands. If you see this marker, it might indicate a bottleneck on the main thread.</td></tr><tr class="odd"><td style="text-align: left;"><code>&lt;GraphicsAPIName&gt;.WaitForLastPresent</code> for example:<br />
<strong>GfxDeviceD3D11.WaitForLastPresent</strong><br />
<strong>GfxDeviceD3D12.WaitForLastPresent</strong><br />
<strong>GfxDeviceMetal.WaitForLastPresent</strong></td><td style="text-align: left;">Samples with this marker appear when the main thread waited for the GPU to flip the frame number to the screen (<code>Time.frameCount - QualitySettings.maxQueuedFrames + 1</code>). This means that if QualitySettings.maxQueuedFrames is greater than one, this time is spent waiting for the GPU to flip a frame that your application requested to render in a previous main thread frame.<br />
<br />
For more details on this sample and an overview of Unity’s Frame Pipeline, see <a href="https://unity.com/blog/engine-platform/fixing-time-deltatime-in-unity-2020-2-for-smoother-gameplay">Unity’s blog post on fixing Delta Time</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Gfx.WaitForPresentOnGfxThread</strong></td><td style="text-align: left;">Indicates that the main thread was ready to start rendering the next frame, but the render thread didn’t finish waiting for the GPU to present the frame. This might indicate that your application is GPU-bound. To check what the render thread is simultaneously spending time on, check the CPU Profiler module’s <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-cpu-introduction.html#timeline-view">Timeline view</a>.<br />
<br />
If the render thread spends time in Camera.Render, your application is CPU-bound and might be spending too much time sending draw calls or textures to the GPU.<br />
<br />
If the render thread spends time in <code>Gfx.PresentFrame</code>, your application is GPU-bound, or it might be waiting for VSync on the GPU. A <code>WaitForTargetFPS</code> sub-sample of <code>Gfx.WaitForPresentOnGfxThread</code> represents the portion of the Present phase that your application spent waiting for VSync. The Present phase is the portion of time between Unity instructing the graphics API to swap the buffers, to the time that this operation completed.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Gfx.WaitForRenderThread</strong></td><td style="text-align: left;">Indicates that the main thread was waiting for the render thread to process all the commands in its command stream. Samples with this marker only appear in multithreaded rendering.</td></tr></tbody></table>

<span id="backend"></span>

## Back end scripting markers

The samples highlight Mono or IL2CPP scripting backend activities and are useful for troubleshooting issues with garbage collection and allocation.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>GC.Alloc</strong></td><td style="text-align: left;">Represents an allocation in the managed heap that contains managed allocations that are subject to automatic garbage collection. To reduce the time your application spends on automatic garbage collection, you should minimize these types of samples.</td></tr><tr class="even"><td style="text-align: left;"><strong>GC.Collect</strong></td><td style="text-align: left;">Represents samples that relate to garbage collection. Whenever Unity needs to perform garbage collection, it stops running your program code and only resumes normal execution when the garbage collector has finished all its work. <strong>Note:</strong> If you have enabled <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html">Incremental Garbage Collection</a> the garbage collector might not finish its work in a single frame.<br />
<br />
This interruption might cause delays in the execution of your application that last anywhere from less than one millisecond to hundreds of milliseconds. This depends on how much memory the garbage collector needs to process and the platform your application is running on. For more information, see the documentation on <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory.html">Understanding automatic memory management</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Mono.JIT</strong><br />
<em>Mono-only</em></td><td style="text-align: left;">Contains samples that relate to just-in-time compilation of a scripting method. When a function is executed for the first time, Mono compiles it and Mono.JIT represents this compilation overhead.</td></tr><tr class="even"><td style="text-align: left;"><strong>UnsafeUtility.Malloc</strong></td><td style="text-align: left;">Contains samples that call UnsafeUtility.Malloc to allocate unmanaged memory. While the Garbage Collector does not track this memory, allocating memory might have a significant performance impact which is shown with this sample. To investigate the source of this call, you can enable <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html">Call Stack</a> recording for this marker in the Profiler window.</td></tr></tbody></table>

<span id="multithreading"></span>

## Multithreading markers

These markers contain samples that don’t measure the CPU cycles consumed, but instead highlight information that relates to thread synchronization and the job system. When you see these samples, use the CPU Profiler module’s [Timeline view](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html) to check what’s happening on other threads at the same time.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Idle</strong></td><td style="text-align: left;">Contains samples that indicate the length of time that a Worker Thread is inactive for. A worker thread is inactive any time that the job system doesn’t use it, and it goes into wait mode, where it waits on the semaphore.<br />
<br />
Small gaps between Idle samples usually happen when the Job System wakes them up, for example, to schedule new jobs. Longer gaps might indicate that a native job that hasn’t been instrumented is running on the thread.</td></tr><tr class="even"><td style="text-align: left;"><strong>JobHandle.Complete</strong></td><td style="text-align: left;">Contains samples that indicate when a sync point on a job happened. Sync points might have a performance impact on your application and might interfere with the execution of multi-threaded job code. To make it easier to find where exactly the sync point happened, enable <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html">Call Stack</a> recording for this sample. In the CPU Profiler module’s <strong>Timeline</strong> view you can enable <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html">Flow Events</a> to identify which jobs finished at this point.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Semaphore.WaitForSignal</strong></td><td style="text-align: left;">Contains a sample that depicts a synchronization point on a thread. To find the thread it’s waiting for, check the Timeline view for samples that ended shortly before this one.</td></tr><tr class="even"><td style="text-align: left;"><strong>WaitForJobGroupID</strong></td><td style="text-align: left;">A Sync Fence on a JobHandle was triggered. This might lead to <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Jobs.IJobParallelFor.html">work stealing</a>, which happens when a worker finishes its work and then looks at other workers’ jobs to complete. These display as job samples executed under this marker. Jobs that were stolen aren’t necessarily the jobs that were being waited for.</td></tr></tbody></table>

<span id="physics"></span>

## Physics markers

The following table outlines some high-level physics Profiler markers. [`FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) calls all these measurements.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Physics.FetchResults</strong></td><td style="text-align: left;">Contains samples that collect the results of the physics simulation from the physics engine, such as contact streams, trigger overlaps, and joint breakage events.</td></tr><tr class="even"><td style="text-align: left;"><strong>Physics.Interpolation</strong></td><td style="text-align: left;">Contains samples that measure the execution time of the <code>Physics.Interpolation</code> method. This method manages the interpolation of positions and rotations for all the physics objects in your application.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physics.Processing</strong></td><td style="text-align: left;">Contains samples that spent time waiting on the main thread until the physics simulation completed across all threads. If your application spends a lot of time in <code>Physics.Processing</code> but only has a few physics related GameObjects in the Scene, it might indicate that worker threads picked up other systems tasks due to job stealing and reported as physics. This is because while waiting, the main thread picks up jobs from the high priority queue.</td></tr><tr class="even"><td style="text-align: left;"><strong>Physics.ProcessingCloth</strong></td><td style="text-align: left;">Contains samples that measure the execution time of the <code>Physics.ProcessingCloth</code> method. This method processes all cloth physics jobs. Expand this sample to display the low-level detail of the work done internally in the physics system.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physics.ProcessReports</strong></td><td style="text-align: left;">Contains samples that correspond to time spent forwarding physics data to scripts via callbacks such as <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html"><code>OnTriggerEnter</code></a>. <strong>Note:</strong> These samples don’t compute the data required because they have already been prepared during <code>FetchResults</code>.<br />
<br />
There are four distinct stages:<br />
<ul><li><strong>Physics.Contacts</strong>: Contains samples that measure the execution time of <code>Physics.Contacts</code>. This processes <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html"><code>OnCollisionEnter</code></a>, <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionExit.html"><code>OnCollisionExit</code></a>, and <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionStay.html"><code>OnCollisionStay</code></a> events.</li><li><strong>Physics.JointBreaks</strong>: Contains samples that measure the execution time of <code>Physics.JointBreaks</code>. This processes updates and messages related to broken joints.</li><li><strong>Physics.TriggerEnterExits</strong>: Contains samples that measure the execution time of <code>Physics.TriggerEnterExits</code>. This processes <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html"><code>OnTriggerEnter</code></a> and <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerExit.html"><code>OnTriggerExit</code></a> events.</li><li><strong>Physics.TriggerStays</strong>: Contains samples that measure the execution time of <code>Physics.TriggerStays</code>. This processes <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerStay.html"><code>OnTriggerStay</code></a> events.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Physics.Simulate</strong></td><td style="text-align: left;">Contains samples that measure the amount of time spent working on the pre-requisites for the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Simulate.html"><code>Physics.Simulate</code></a> method. This method instructs the physics system to run its simulation, which updates the state of the current physics.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Physics.UpdateBodies</strong></td><td style="text-align: left;">Contains samples that update all the physics bodies’ positions and rotations. For each GameObject that has a Rigidbody component, samples with this marker read the pose from the physics system and write it to the Transform.</td></tr><tr class="even"><td style="text-align: left;"><strong>Physics.UpdateCloth</strong></td><td style="text-align: left;">Contains samples that measure the execution time of the <code>Physics.UpdateCloth</code> method. This method processes updates that relate to cloth and their Skinned Meshes.</td></tr></tbody></table>

For more information about script lifecycles and general samples within a script lifecycle, refer to [Order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html#UpdateOrder).

<span id="animation"></span>

## Animation markers

The following tables contain markers from the [Animation system](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animator.html). For general information on Animation system performance, refer to the [Mecanim Performance and and Optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/MecanimPeformanceandOptimization.html) page.

### PreLateUpdate.DirectorUpdateAnimationBegin stage

In this stage, every Animator that’s active and enabled is processed. Active Animators are processed regardless of Culling Mode and visibility.

Markers that start with `Director.` can also cover Playables and Timeline.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Director.PrepareFrame</strong></td><td style="text-align: left;">Set up, schedule, and await <code>Director.PrepareFrameJob</code> jobs. These jobs evaluate the state machines for all active Animator components.</td></tr><tr class="even"><td style="text-align: left;"><strong>Director.PrepareFrameJob <em>(job)</em></strong></td><td style="text-align: left;">Evaluate the state machine of a single active Animator. The amount of time taken to process an Animator grows with the complexity of its state machine (i.e. the number of states, transitions, properties, and layers).<br />
<br />
Evaluation of state machines with <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBehaviours.html"><code>StateMachineBehaviours</code></a> that implement <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineEnter.html"><code>OnStateMachineEnter</code></a> or <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineExit.html"><code>OnStateMachineExit</code></a> listeners will be constrained to the main thread.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Animators.PrepareFirstPass</strong></td><td style="text-align: left;">Prepare for the next processing steps.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animators.ProcessGraphJob</strong></td><td style="text-align: left;">Build, schedule, and await the results of <code>Animator.ProcessGraph</code> jobs.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Animators.ProcessGraph <em>(job)</em></strong></td><td style="text-align: left;">Evaluate all properties across all connected AnimationClips.<br />
<br />
Calculate the root motion displacements by blending the root motion properties from all clips together.<br />
<br />
Collect new animation events for the current <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html"><code>deltaTime</code></a>.<br />
<br />
When evaluating AnimationClips’ properties, the curve segments are cached locally between frames to avoid reading from the AnimationClips’ memory more than necessary.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animators.FireAnimationEventsAndBehaviours</strong></td><td style="text-align: left;">Fire all animation events messages on <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBehaviours.html"><code>StateMachineBehaviours</code></a> and MonoBehaviours, except <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineEnter.html"><code>OnStateMachineEnter</code></a> or <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineExit.html"><code>OnStateMachineExit</code></a> listeners which have already been fired in <code>Director.PrepareFrameJob</code>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Animators.ApplyOnAnimatorMove</strong></td><td style="text-align: left;">Apply root motion and trigger the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnAnimatorMove.html"><code>OnAnimatorMove</code></a> message on MonoBehaviours.</td></tr></tbody></table>

### PreLateUpdate.DirectorUpdateAnimationEnd

In this stage, only Animators with the Culling Mode `Always Update` and visible Animators with the Culling Mode `UpdateTransform` or `Cull Completely` get processed. Animators with `Cull Completely` that were moved out of frame by the Root Motion don’t participate in this phase. Neither do Animators that were disabled by user code triggered by StateMachineBehaviours and AnimationEvents

<table><thead><tr class="header"><th style="text-align: left;"><strong>Marker</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Animators.PrepareSecondPass</strong></td><td style="text-align: left;">Set up the next processing steps. This includes filtering out Animators based on their Culling Mode and visibility status.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animators.SortWriteJob</strong></td><td style="text-align: left;">The Transform system only allows a single thread to modify a Transform Hierarchy at a time. To accommodate this constraint, <code>Animators.SortWriteJob</code> groups <code>Animators.WriteTransforms</code> jobs by their <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-root.html">Transform.root</a>.<br />
<br />
For the best performance, avoid having multiple Animators in the same transform hierarchy to increase the granularity at which jobs can be scheduled and parallelized.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Animators.ProcessAnimationsJob</strong></td><td style="text-align: left;">Build, schedule, and await the results of <code>Animators.ProcessAnimations</code> jobs.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animator.ProcessAnimations (<em>job</em>)</strong></td><td style="text-align: left;">Blend all properties on current active AnimationClips for a single Animator, except for root motion. Apply them to the internal avatar representation.<br />
<br />
The length of this marker scales with animation and blending complexity.</td></tr><tr class="odd"><td style="text-align: left;"><strong>OnAnimatorIK</strong></td><td style="text-align: left;">Sets up animation IK. This is called once for each Animator Controller layer with IK pass enabled.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animators.WriteJob</strong></td><td style="text-align: left;">Build, schedule, and await the results of <code>Animator.WriteTransform</code> jobs. These jobs write transform poses from Animation avatars to the related GameObject transform hierarchy.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Animators.WriteTransforms <em>(job)</em></strong></td><td style="text-align: left;">Writes all animated transforms to the scene from worker threads.</td></tr><tr class="even"><td style="text-align: left;"><strong>Animator.WriteProperties</strong></td><td style="text-align: left;">Write any animated property that is not a transform pose to the target object.</td></tr></tbody></table>

<span id="warnings"></span>

## Performance warnings

The CPU Profiler detects some common performance issues and warns you about them. These appear in the Warning column of the [CPU Profiler module’s Hierarchy](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-cpu-introduction.html#hierarchy-views) view in the module details pane.

The Profiler detects some specific calls to avoid in performance-critical contexts. It displays the warnings with the reasons the operations are affecting performance as follows:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Warning</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Animation.DestroyAnimationClip</strong><br />
<strong>Animation.AddClip</strong><br />
<strong>Animation.RemoveClip</strong><br />
<strong>Animation.Clone</strong><br />
<strong>Animation.Deactivate</strong></td><td style="text-align: left;">Indicates that RebuildInternalState has been triggered. RebuildInternalState is an operation that goes through the list of curves for each clip in the Animation component, and then rebinds each curve to a value on a component, on a GameObject.<br />
<br />
This is a resource-intensive operation, so you should avoid calling these methods at runtime as much as possible.</td></tr><tr class="even"><td style="text-align: left;"><strong>AssetBundle.asset/allAssets</strong></td><td style="text-align: left;">Indicates that Unity called the AssetBundleRequest.assets/allAssets API while the AssetBundle loading was not complete (AssetBundleRequest.isDone is false). This causes a stall on the main thread and waits for the loading operation to complete.</td></tr><tr class="odd"><td style="text-align: left;"><strong>AsyncUploadManager.AsyncBufferResized</strong><br />
<strong>AsyncUploadManager.AsyncBufferDelete</strong></td><td style="text-align: left;">Indicates that the internal buffer for uploading data to the GPU is resized because it’s not big enough. This resizing is slow and causes spikes in CPU activity.<br />
<br />
You can avoid this warning if you can spare the memory to allocate a larger size up front.<br />
<br />
You can use <strong>Async Upload Buffer Size</strong> setting in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html">Quality Settings</a> to set the default size.<br />
<br />
The <code>AsyncUploadManager.AsyncBufferResized</code> marker indicates the newly allocated size which you can use as a guide for the default buffer size.</td></tr><tr class="even"><td style="text-align: left;"><strong>Rigidbody.SetKinematic</strong></td><td style="text-align: left;">Recreate non-convex MeshCollider for Rigidbody.</td></tr></tbody></table>

## Additional resources

-   [UI Toolkit markers](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-profiler-markers.html)
-   [Play mode and Editor samples](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-play-edit-samples.html)
-   [CPU Usage Profiler module](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-cpu.html)
-   [Adding profiling information to your code](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-adding-information-code.html)
