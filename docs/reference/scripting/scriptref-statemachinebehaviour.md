---
title: "Scripting API: StateMachineBehaviour"
page_title: "Unity - Scripting API: StateMachineBehaviour"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# StateMachineBehaviour

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="cl">ScriptableObject</a>

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

<span style="color:red;"> </span>

### Description

StateMachineBehaviour is a component that you add to a state machine state. It is the base class that a script must derive from.

A state machine can have up to three different active states at the same time: the current state, the next state, and the interrupted state.  
A state machine always has a current state. When a state machine transitions to a new state, it adds a next state. When the transition is completed, the current state terminates and the next state becomes the current state.  
If an ongoing transition is interrupted by a transition to a new state, then the next state becomes the interrupted state and the state targeted by the new transition becomes the next state. The current state remains the same until all interrupted transitions are completed. When the last transition is completed and there are no interruptions, the current and interrupted states terminate and the next state becomes the current state.  
  
StateMachineBehaviour has predefined state-related methods that you can implement:[OnStateEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateEnter.html), [OnStateExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateExit.html), [OnStateIK](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateIK.html), [OnStateMove](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMove.html), [OnStateUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateUpdate.html).  
These methods are invoked for the active states mentioned above in the following order: current state, then interrupted state, then next state.  
Refer to the description of each method for more information.  
  
StateMachineBehaviour also has predefined methods related to transitions in and out of state machines:  
[OnStateMachineEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineEnter.html) and [OnStateMachineExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineExit.html).  
These methods are invoked whenever a state machine transition is taken.  
  
If an [AnimatorController](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorController.html) contains sychronized layers, a method might be invoked multiple times for the same state. When this happens, the method is invoked once for each synchronized layer with the state, in ascending order.  
  
By default the Animator instantiates a new instance of each behaviour defined in the controller. To share behaviour instances, use the [SharedBetweenAnimatorsAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SharedBetweenAnimatorsAttribute.html) class attribute to control how behaviours are instantiated.

``` codeExampleCS
using UnityEngine;

public class AttackBehaviour : StateMachineBehaviour

    override public void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    
    override public void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    
    override public void OnStateMove(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    
    override public void OnStateIK(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    
}
```

### Public Methods

| Method                                                                                                                              | Description                                                                                                                                                           |
|-------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [OnStateMachineEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineEnter.html) | Invoked on the first update frame when taking a transition into a state machine. Implement this message to influence the entry transition into the sub-state machine. |
| [OnStateMachineExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMachineExit.html)   | Invoked on the last update frame when taking a transition out of a StateMachine. Implement this message to influence the exit transition out of the sub-state machine |

### Messages

| Message                                                                                                                 | Description                                                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [OnStateEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateEnter.html)   | Invoked on the first update frame when a state machine evaluates this state. Implement this message to react to a new state starting.                                  |
| [OnStateExit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateExit.html)     | Invoked on the last update frame when a state machine evaluates this state. Implement this message to react to a state ending.                                         |
| [OnStateIK](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateIK.html)         | Invoked during the Animator IK pass. Implement this message to modify the result of the animation after the evaluation of the state machine on a state by state basis. |
| [OnStateMove](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateMove.html)     | Invoked during the Animator Root Motion pass. Implement this message to modify the result of the animation root motion on a state by state basis.                      |
| [OnStateUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/StateMachineBehaviour.OnStateUpdate.html) | Invoked on each update frame except for the first and last frame. Implement this message to execute custom logic on a state by state basis.                            |

### Inherited Members

### Properties

| Property                                                                                         | Description                                                                            |
|--------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html) | Controls whether the object is hidden, saved with the scene, and editable by the user. |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)           | The name of the object.                                                                |

### Public Methods

| Method                                                                                                   | Description                           |
|----------------------------------------------------------------------------------------------------------|---------------------------------------|
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)     | Returns the hash code for the object. |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html) | Gets the instance ID of the object.   |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)           | Returns the name of the object.       |

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
| [CreateInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html)     | Creates an instance of a scriptable object.                                                                                                                 |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |

### Messages

| Message                                                                                                      | Description                                                                                          |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Awake.html)           | Called when an instance of ScriptableObject is created.                                              |
| [OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDestroy.html)   | This function is called when the scriptable object will be destroyed.                                |
| [OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDisable.html)   | This function is called when the scriptable object goes out of scope.                                |
| [OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnEnable.html)     | This function is called when the object is loaded.                                                   |
| [OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnValidate.html) | Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector. |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Reset.html)           | Reset to default values.                                                                             |
