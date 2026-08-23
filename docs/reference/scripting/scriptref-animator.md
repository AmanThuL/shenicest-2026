---
title: "Scripting API: Animator"
page_title: "Unity - Scripting API: Animator"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animator

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour.html" class="cl">Behaviour</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.AnimationModule.html" class="cl">UnityEngine.AnimationModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animator.html" class="switch-link gray-btn sbtn left show" title="Go to Animator Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Manages, controls, and evaluates the animation of a GameObject.

The Animator is the main [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) in the Mecanim animation system. The Animator evaluates [Animation Clips](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html) and manages [Animator States](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorState.html) in [Animator State Machines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorStateMachine.html).  
  
**Control the Animator with an AnimatorController**  
  
Typically, you configure an Animator with an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) asset. This asset determines which animation plays. To learn how to build an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html), consult [Animator Controller](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimatorController.html). Once configured with an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html), you can influence the flow of the state machine through the following methods:

-   Use [Animator.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetFloat.html), [Animator.SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetInteger.html), [Animator.SetBool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBool.html), or [Animator.SetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html), through AnimatorControllerProperty, to trigger an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) transition.
-   Use [Animator.Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html), [Animator.PlayInFixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.PlayInFixedTime.html), Animator.Crossfade, or [Animator.CrossFadeInFixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.CrossFadeInFixedTime.html) to force the [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) to a specific state.
-   Use [Animator.SetLayerWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetLayerWeight.html) to modify the weight of an [AnimatorControllerLayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorControllerLayer.html).

For more advanced use cases, you can control an Animator with the [Playables API](https://docs.unity3d.com/6000.3/Documentation/Manual/Playables.html).  
  
**Animator execution**  
  
By default, an Animator evaluates on each frame, following [Time.deltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html). On a frame where none of the paired [Renderers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.html) are visible, the Animator only updates the position of the root GameObject. No other transforms or component properties are updated. To change this default behavior, use one of the following methods:

-   Use [Animator.updateMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-updateMode.html) to choose how the Animator updates.
-   Use [Animator.cullingMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-cullingMode.html) to select what the Animator updates when none of the associated Renderers are visible.
-   Use [Animator.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Update.html) to evaluate the Animator immediately. This is independent of the update mode.

**Root Motion**  
  
Root Motion refers to the cumulative displacement of a GameObject hierarchy. For more information, consult [How Root Motion works](https://docs.unity3d.com/6000.3/Documentation/Manual/RootMotion.html).  
  
When [Animator.applyRootMotion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-applyRootMotion.html) is true, the Animator does the following on each frame:  
  
- Automatically calculates the displacement of the Root joint for the frame. - Adds this displacement to the position and rotation of the GameObject with the Animator Component. For information on how to override this behavior, consult [Scripting Root Motion](https://docs.unity3d.com/6000.3/Documentation/Manual/ScriptingRootMotion.html).  
  
**Generic and Humanoid animation**  
  
The Animator evaluates two types of [Animation Clips](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html): Generic and Humanoid.  
  
A Generic animation clip contains multiple animation curves where each curve animates a property of either a [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) or a [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html). A Generic clip is authored for and animates a specific [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchy. If you attempt to use a Generic clip on a different [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchy, it might not play back as expected.  
  
A Humanoid animation clip is designed for human or human-like bipedal [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchies. To use a Humanoid clip on a bipedal [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchy, you must configure an Animator with a [Humanoid Avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/AvatarCreationandSetup.html).  
  
You can reuse the same Humanoid clip on any Animator configured with a Humanoid [Avatar](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Avatar.html) to reduce runtime memory usage and build size. However, this increases CPU usage. Expect a 15 to 20 percent increase in the time spent animating a GameObject hierarchy when evaluating Humanoid AnimationClips.  
  
To determine if the benefits of using Humanoid clips is worth the cost in CPU peformance, perform your own experiments on your target platforms.  
  
It is recommended that you exclusively use Humanoid clips or Generic clips.  
  
**Inverse Kinematics**  
  
The Animator class includes inverse kinematics methods that you can use to configure dynamic interactions between a humanoid and scene objects. Consult [Inverse Kinematics](https://docs.unity3d.com/6000.3/Documentation/Manual/InverseKinematics.html) for steps and an example.  
  
**SetTarget**  
  
When you want a character to interact with an object that is too far to reach with inverse kinematics, use [Animator.SetTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTarget.html) to adjust the position and rotation of a character over time to ensure its hand or foot reaches the object.  
  
**Bindings and performance**  
  
To track the properties that an Animator must write to, the Animator Component builds an internal collection of bindings. Each binding is built from the [EditorCurveBinding](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorCurveBinding.html) of each [AnimationClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html) associated with the Animator through assets and custom graphs.  
  
From this collection of bindings, the Animator builds an internal [AnimationStream](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimationStream.html) which defines the size of the buffers to allocate for [AnimationClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html) evaluation.  
  
After an Animator allocates its buffers, it iterates through each binding and searches for the appropriate [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) in the corresponding [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchy. The Animator keeps a reference to each binding so it can be written to in subsequent frames.  
  
This operation is called Rebinding, and it can be triggered by different events:

-   First initialization of the Animator Component when loading a [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) or instantiating a Prefab.
-   Changing the [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) or [AnimatorOverrideController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorOverrideController.html) in [Animator.runtimeAnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-runtimeAnimatorController.html).
-   Making changes to an [AnimatorOverrideController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorOverrideController.html) set in [Animator.runtimeAnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-runtimeAnimatorController.html).
-   Making changes to a [PlayableGraph](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Playables.PlayableGraph.html) connected to the Animator.
-   Manually invoking [Animator.Rebind](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Rebind.html).
-   Enabling the [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) to which the Animator Component is attached.

**Avoid and minimize Rebind**  
  
Use the following strategies to avoid and minimize the occurrence of the Rebind operation:

-   The [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) asset is already optimized to create a known set of bindings at Edit time. The Rebind operation, triggered by changes to [Animator.runtimeAnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-runtimeAnimatorController.html), only needs to bind the properties of the [AnimationStream](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimationStream.html) with scene objects. If you need to change the [AnimationClips](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html) that the Animator evaluates during runtime, then switching to a new [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) asset is the strategy which will incur the smallest Rebind cost. Note that this will reset the state of the state machine to the default state(s) of the new AnimatorController.
-   Prioritize prebuilt [AnimatorOverrideControllers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorOverrideController.html) over dynamically built ones. Use an Animator Override Controller asset to change clips at runtime without resetting the state of the state machine. If you use an Animator Override Controller built at Edit time, the Rebind operation has the same cost as changing an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html). If you dynamically build an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) at Runtime, the Rebind operation iterates over each clip in the [AnimatorOverrideController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimatorOverrideController.html) because the bindings are unknown.
-   [PlayableGraphs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Playables.PlayableGraph.html) execute a Rebind operation after every change to the graph, and large graphs have a significant Rebind cost. There are two optimization strategies you can apply: either maintain a small graph and update it as needed, or build a large graph and avoid changes as much as possible. Performance depends on the complexity of both your clips and your graph; experiment to determine which strategy is better suited for your use case.
-   If you disable a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) for pooling purposes, the Animator performs the Rebind operation when the GameObject is activated again. This might cancel the performance gained by pooling. It is recommended that you disable the components on a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) instead of disabling the [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) itself. When you disable an Animator, it pauses evaluation but keeps the internal state intact.
-   When you add a new GameObject to a hierarchy associated with an Animator Component, you must manually invoke [Animator.Rebind](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Rebind.html) so that the Animator recognizes and is able to write to the new GameObject. If you add many new GameObjects, it is recommended that you add the GameObjects first and invoke [Animator.Rebind](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Rebind.html) once instead of invoking this method multiple times.

**Default values**  
  
You can [configure states to write default values](https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html) in the [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html). When you enable [AnimatorState.writeDefaultValues](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorState-writeDefaultValues.html) and evaluate an [AnimatorState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorState.html), the Animator writes the default values for the properties that are not animated by the Animation Clips of that state.  
  
These default values are collected from the Scene when the Animator is first initialized and whenever a Rebind operation completes. If a Rebind occurs during evaluation, the Animator collects the current state of the properties in the scene as new default values. This might lead to problematic results because the new default values might be arbitrary.  
  
If you want to perform a Rebind operation and some of the states in your [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) rely on default values, use [Animator.writeDefaultValuesOnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-writeDefaultValuesOnDisable.html) to ensure that the Animator restores all animated properties from their original values. This ensures consistent default values across the lifetime of the Animator component.  
  
However, writing default values back to the Scene also has a performance costs. If you are experiencing performance issues, consider not relying on default values or avoiding the Rebind operation.  
  
You can also manually restore the default values of animated properties with [Animator.WriteDefaultValues](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.WriteDefaultValues.html).  
  
**Recording system**  
  
The Animator includes a recording system that you can use to record and play back a maximum of ten thousand frames of animated properties. Consult [Animator.StartRecording](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StartRecording.html) and [Animator.StartPlayback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StartPlayback.html) for more information.  
  
**Other performance considerations**  
  
The Mecanim Animation System is complex. The choices that you make can affect the performance of your game. The following lists some things you should consider when you design your game:  
  

-   The Rebind operation is resource intensive and might lead to CPU spikes. Use a single AnimatorController and avoid Rebind operations as much as possible. This generally results in more stable performance.
-   When you use an AnimatorController, Unity evaluates each non-synchronized state machine at every frame. This includes layers set to a weight of zero. To improve performance, avoid unused AnimatorController layers.
-   The Mecanim Animation System evaluates and updates Animator Components using parallel execution which divides the workload across multiple CPU cores. When you use [Animator.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Update.html) to manually evaluate an Animator Component, Mecanim does not use parallel execution. To manually control the execution and benefit from parallel evaluation, bundle together multiple Animators in a [PlayableGraph](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Playables.PlayableGraph.html) and manually update the [PlayableGraph](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Playables.PlayableGraph.html). This takes advantage of parallel execution while still maintaining manual control.
-   Unity's [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) System only allows a single thread to write to a [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) hierarchy (a Root GameObject and its children) at a time. If you group multiple Animators under the same root [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), this prevents Mecanim from taking advantage of multi-threading when parallel updating [Transforms](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) and might result in reduced performance. It is recommended that you avoid grouping Animators in hierarchies of GameObjects, unless necessary for parenting reasons.
-   [StateMachineBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.html) introduces multiple synchronization points with the main thread. In some cases, callbacks can prevent parallel evaluation of multiple state machines. To avoid this issue, use [StateMachineBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.html) sparingly.
-   To maintain determinism, the Animator writes every animated property at every frame regardless of whether the property value has changed. This can cause known performance issues when animating [RectTransform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RectTransform.html) components. To avoid these issues, use the [Animation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animation.html) Component to animate [RectTransform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RectTransform.html).
-   Since the AnimatorController is a state machine, it continuously evaluates whether transitions must be taken. This evaluation occurs even when the AnimatorController reaches the end of the current state. This means that an idle Animator consumes CPU. For single-shot animations, and for GameObjects that are rarely animated, use the [Animation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animation.html) Component or the [Playables API](https://docs.unity3d.com/6000.3/Documentation/Manual/Playables.html).
-   The Humanoid system has a performance overhead. To avoid this overhead, use Generic animations wherever possible.\`\`\`

### Properties

| Property                                                                                                                               | Description                                                                                                                                    |
|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [angularVelocity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-angularVelocity.html)                         | Gets the avatar angular velocity for the last evaluated frame.                                                                                 |
| [animatePhysics](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-animatePhysics.html)                           | When enabled, the physics system uses animated transforms from GameObjects with kinematic Rigidbody components to influence other GameObjects. |
| [applyRootMotion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-applyRootMotion.html)                         | Should root motion be applied?                                                                                                                 |
| [avatar](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-avatar.html)                                           | Gets/Sets the current Avatar.                                                                                                                  |
| [avatarRoot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-avatarRoot.html)                                   | Returns the Avatar root Transform.                                                                                                             |
| [bodyPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-bodyPosition.html)                               | The position of the body center of mass.                                                                                                       |
| [bodyRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-bodyRotation.html)                               | The rotation of the body center of mass.                                                                                                       |
| [cullingMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-cullingMode.html)                                 | Controls culling of this Animator component.                                                                                                   |
| [deltaPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-deltaPosition.html)                             | Gets the avatar delta position for the last evaluated frame.                                                                                   |
| [deltaRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-deltaRotation.html)                             | Gets the avatar delta rotation for the last evaluated frame.                                                                                   |
| [feetPivotActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-feetPivotActive.html)                         | Blends pivot point between body center of mass and feet pivot.                                                                                 |
| [fireEvents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-fireEvents.html)                                   | Sets whether the Animator sends events of type AnimationEvent.                                                                                 |
| [gravityWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-gravityWeight.html)                             | The current gravity weight based on current animations that are played.                                                                        |
| [hasBoundPlayables](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-hasBoundPlayables.html)                     | Returns true if Animator has any playables assigned to it.                                                                                     |
| [hasRootMotion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-hasRootMotion.html)                             | Returns true if the current rig has root motion.                                                                                               |
| [hasTransformHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-hasTransformHierarchy.html)             | Returns true if the object has a transform hierarchy.                                                                                          |
| [humanScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-humanScale.html)                                   | Returns the scale of the current Avatar for a humanoid rig, (1 by default if the rig is generic).                                              |
| [isHuman](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-isHuman.html)                                         | Returns true if the current rig is humanoid, false if it is generic.                                                                           |
| [isInitialized](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-isInitialized.html)                             | Returns whether the animator is initialized successfully.                                                                                      |
| [isMatchingTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-isMatchingTarget.html)                       | If automatic matching is active.                                                                                                               |
| [isOptimizable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-isOptimizable.html)                             | Returns true if the current rig is optimizable with AnimatorUtility.OptimizeTransformHierarchy.                                                |
| [keepAnimatorStateOnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-keepAnimatorStateOnDisable.html)   | Controls the behaviour of the Animator component when a GameObject is inactive.                                                                |
| [layerCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-layerCount.html)                                   | Returns the number of layers in the controller.                                                                                                |
| [layersAffectMassCenter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-layersAffectMassCenter.html)           | Additional layers affects the center of mass.                                                                                                  |
| [leftFeetBottomHeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-leftFeetBottomHeight.html)               | Get left foot bottom height.                                                                                                                   |
| [parameterCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-parameterCount.html)                           | Returns the number of parameters in the controller.                                                                                            |
| [parameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-parameters.html)                                   | The AnimatorControllerParameter list used by the animator. (Read Only)                                                                         |
| [pivotPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-pivotPosition.html)                             | Get the current position of the pivot.                                                                                                         |
| [pivotWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-pivotWeight.html)                                 | Gets the pivot weight.                                                                                                                         |
| [playableGraph](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-playableGraph.html)                             | The PlayableGraph created by the Animator.                                                                                                     |
| [playbackTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-playbackTime.html)                               | Sets the playback position in the recording buffer.                                                                                            |
| [recorderMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-recorderMode.html)                               | Gets the mode of the Animator recorder.                                                                                                        |
| [recorderStartTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-recorderStartTime.html)                     | Start time of the first frame of the buffer relative to the frame at which StartRecording was called.                                          |
| [recorderStopTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-recorderStopTime.html)                       | End time of the recorded clip relative to when StartRecording was called.                                                                      |
| [rightFeetBottomHeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-rightFeetBottomHeight.html)             | Get right foot bottom height.                                                                                                                  |
| [rootPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-rootPosition.html)                               | The root position, the position of the game object.                                                                                            |
| [rootRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-rootRotation.html)                               | The root rotation, the rotation of the game object.                                                                                            |
| [runtimeAnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-runtimeAnimatorController.html)     | The runtime representation of AnimatorController that controls the Animator.                                                                   |
| [speed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-speed.html)                                             | The playback speed of the Animator. 1 is normal playback speed.                                                                                |
| [stabilizeFeet](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-stabilizeFeet.html)                             | Automatic stabilization of feet during transition and blending.                                                                                |
| [targetPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-targetPosition.html)                           | Returns the position of the target specified by SetTarget.                                                                                     |
| [targetRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-targetRotation.html)                           | Returns the rotation of the target specified by SetTarget.                                                                                     |
| [updateMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-updateMode.html)                                   | Specifies the update mode of the Animator.                                                                                                     |
| [velocity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-velocity.html)                                       | Gets the avatar velocity for the last evaluated frame.                                                                                         |
| [writeDefaultValuesOnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-writeDefaultValuesOnDisable.html) | Specifies whether playable graph values are reset or preserved when the Animator is disabled.                                                  |

### Public Methods

| Method                                                                                                                                         | Description                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| [ApplyBuiltinRootMotion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.ApplyBuiltinRootMotion.html)                   | Apply the default Root Motion.                                                                                    |
| [CrossFade](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.CrossFade.html)                                             | Creates a crossfade from the current state to any other state using normalized times.                             |
| [CrossFadeInFixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.CrossFadeInFixedTime.html)                       | Creates a crossfade from the current state to any other state using times in seconds.                             |
| [GetAnimatorTransitionInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetAnimatorTransitionInfo.html)             | Returns an AnimatorTransitionInfo with the informations on the current transition.                                |
| [GetBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetBehaviour.html)                                       | Returns the first StateMachineBehaviour that matches type T or is derived from T. Returns null if none are found. |
| [GetBehaviours](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetBehaviours.html)                                     | Returns all StateMachineBehaviour that match type T or are derived from T. Returns null if none are found.        |
| [GetBoneTransform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetBoneTransform.html)                               | Retrieves the Transform mapped to a human bone based on its id.                                                   |
| [GetBool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetBool.html)                                                 | Returns the value of the given boolean parameter.                                                                 |
| [GetCurrentAnimatorClipInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorClipInfo.html)           | Returns an array of all the AnimatorClipInfo in the current state of the given layer.                             |
| [GetCurrentAnimatorClipInfoCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorClipInfoCount.html) | Returns the number of AnimatorClipInfo in the current state.                                                      |
| [GetCurrentAnimatorStateInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetCurrentAnimatorStateInfo.html)         | Returns an AnimatorStateInfo with the information on the current state.                                           |
| [GetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetFloat.html)                                               | Returns the value of the given float parameter.                                                                   |
| [GetIKHintPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKHintPosition.html)                             | Gets the position of an IK hint.                                                                                  |
| [GetIKHintPositionWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKHintPositionWeight.html)                 | Gets the translative weight of an IK Hint (0 = at the original animation before IK, 1 = at the hint).             |
| [GetIKPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKPosition.html)                                     | Gets the position of an IK goal.                                                                                  |
| [GetIKPositionWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKPositionWeight.html)                         | Gets the translative weight of an IK goal (0 = at the original animation before IK, 1 = at the goal).             |
| [GetIKRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKRotation.html)                                     | Gets the rotation of an IK goal.                                                                                  |
| [GetIKRotationWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetIKRotationWeight.html)                         | Gets the rotational weight of an IK goal (0 = rotation before IK, 1 = rotation at the IK goal).                   |
| [GetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetInteger.html)                                           | Returns the value of the given integer parameter.                                                                 |
| [GetLayerIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetLayerIndex.html)                                     | Returns the index of the animation layer with the given name.                                                     |
| [GetLayerName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetLayerName.html)                                       | Returns the layer name.                                                                                           |
| [GetLayerWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetLayerWeight.html)                                   | Returns the weight of the layer at the specified index.                                                           |
| [GetNextAnimatorClipInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetNextAnimatorClipInfo.html)                 | Returns an array of all the AnimatorClipInfo in the next state of the given layer.                                |
| [GetNextAnimatorClipInfoCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetNextAnimatorClipInfoCount.html)       | Returns the number of AnimatorClipInfo in the next state.                                                         |
| [GetNextAnimatorStateInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetNextAnimatorStateInfo.html)               | Returns an AnimatorStateInfo with the information on the next state.                                              |
| [GetParameter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetParameter.html)                                       | Obtains a reference to the AnimatorControllerParameter at the given index.                                        |
| [HasState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.HasState.html)                                               | Returns true if the state exists in this layer, false otherwise.                                                  |
| [InterruptMatchTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.InterruptMatchTarget.html)                       | Interrupts the automatic target matching.                                                                         |
| [IsInTransition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.IsInTransition.html)                                   | Returns true if there is a transition on the given layer, false otherwise.                                        |
| [IsParameterControlledByCurve](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.IsParameterControlledByCurve.html)       | Returns true if the parameter is controlled by a curve, false otherwise.                                          |
| [MatchTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.MatchTarget.html)                                         | Automatically adjust the GameObject position and rotation.                                                        |
| [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Play.html)                                                       | Plays a state.                                                                                                    |
| [PlayInFixedTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.PlayInFixedTime.html)                                 | Plays a state.                                                                                                    |
| [Rebind](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Rebind.html)                                                   | Rebind all the animated properties and mesh data with the Animator.                                               |
| [ResetControllerState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.ResetControllerState.html)                       | Resets the AnimatorController to its default state.                                                               |
| [ResetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.ResetTrigger.html)                                       | Resets the value of the given trigger parameter.                                                                  |
| [SetBoneLocalRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBoneLocalRotation.html)                       | Sets local rotation of a human bone during a IK pass.                                                             |
| [SetBool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetBool.html)                                                 | Sets the value of the given boolean parameter.                                                                    |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetFloat.html)                                               | Send float values to the Animator to affect transitions.                                                          |
| [SetIKHintPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKHintPosition.html)                             | Sets the position of an IK hint.                                                                                  |
| [SetIKHintPositionWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKHintPositionWeight.html)                 | Sets the translative weight of an IK hint (0 = at the original animation before IK, 1 = at the hint).             |
| [SetIKPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKPosition.html)                                     | Sets the position of an IK goal.                                                                                  |
| [SetIKPositionWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKPositionWeight.html)                         | Sets the translative weight of an IK goal (0 = at the original animation before IK, 1 = at the goal).             |
| [SetIKRotation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKRotation.html)                                     | Sets the rotation of an IK goal.                                                                                  |
| [SetIKRotationWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetIKRotationWeight.html)                         | Sets the rotational weight of an IK goal (0 = rotation before IK, 1 = rotation at the IK goal).                   |
| [SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetInteger.html)                                           | Sets the value of the given integer parameter.                                                                    |
| [SetLayerWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetLayerWeight.html)                                   | Changes the weight of the layer at a specific index.                                                              |
| [SetLookAtPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetLookAtPosition.html)                             | Sets the look at position for a character during animations.                                                      |
| [SetLookAtWeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetLookAtWeight.html)                                 | Set look at weights.                                                                                              |
| [SetTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTarget.html)                                             | Sets an AvatarTarget and a targetNormalizedTime for the current state.                                            |
| [SetTrigger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.SetTrigger.html)                                           | Sets the value of the given trigger parameter.                                                                    |
| [StartPlayback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StartPlayback.html)                                     | Sets the animator in playback mode.                                                                               |
| [StartRecording](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StartRecording.html)                                   | Sets the animator in recording mode, and allocates a circular buffer of size frameCount.                          |
| [StopPlayback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StopPlayback.html)                                       | Stops the animator playback mode. When playback stops, the avatar resumes getting control from game logic.        |
| [StopRecording](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StopRecording.html)                                     | Stops animator record mode.                                                                                       |
| [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.Update.html)                                                   | Evaluates the animator based on deltaTime.                                                                        |
| [WriteDefaultValues](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.WriteDefaultValues.html)                           | Forces a write of the default values stored in the animator.                                                      |

### Static Methods

| Method                                                                                                   | Description                             |
|----------------------------------------------------------------------------------------------------------|-----------------------------------------|
| [StringToHash](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html) | Generates a parameter id from a string. |

### Inherited Members

### Properties

| Property                                                                                                              | Description                                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html)                       | True if this Behaviour is enabled, otherwise false.                                                                                            |
| [isActiveAndEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-isActiveAndEnabled.html) | Checks whether a component is enabled, attached to a GameObject that is active in the hierarchy, and the component's OnEnable has been called. |
| [gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html)                 | The game object this component is attached to. A component is always attached to a game object.                                                |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-tag.html)                               | The tag of this game object.                                                                                                                   |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transform.html)                   | The Transform attached to this GameObject.                                                                                                     |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transformHandle.html)       | The TransformHandle of this GameObject.                                                                                                        |
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html)                      | Controls whether the object is hidden, saved with the scene, and editable by the user.                                                         |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)                                | The name of the object.                                                                                                                        |

### Public Methods

| Method                                                                                                                          | Description                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.BroadcastMessage.html)               | Calls the method named methodName on every MonoBehaviour in this game object or any of its children.                             |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.CompareTag.html)                           | Checks the GameObject's tag against the defined tag.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html)                       | Gets a reference to a component of type T on the same GameObject as the component specified.                                     |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html)   | Gets a reference to a component of type T on the same GameObject as the component specified, or any child of the GameObject.     |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentIndex.html)             | Gets the index of the component on its parent GameObject.                                                                        |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInParent.html)       | Gets a reference to a component of type T on the same GameObject as the component specified, or any parent of the GameObject.    |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html)                     | Gets references to all components of type T on the same GameObject as the component specified.                                   |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) | Gets references to all components of type T on the same GameObject as the component specified, and any child of the GameObject.  |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInParent.html)     | Gets references to all components of type T on the same GameObject as the component specified, and any parent of the GameObject. |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessage.html)                         | Calls the method named methodName on every MonoBehaviour in this game object.                                                    |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessageUpwards.html)           | Calls the method named methodName on every MonoBehaviour in this game object and on every ancestor of the behaviour.             |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html)                 | Gets the component of the specified type, if it exists.                                                                          |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)                            | Returns the hash code for the object.                                                                                            |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)                        | Gets the instance ID of the object.                                                                                              |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)                                  | Returns the name of the object.                                                                                                  |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |
