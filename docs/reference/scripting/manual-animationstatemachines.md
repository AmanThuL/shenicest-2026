---
title: "Animation state machine"
page_title: "Unity - Manual: Animation state machine"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationStateMachines.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationStateMachines.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation state machine

It’s common for a character or a GameObject to have several animations for the different actions it performs in a game. For example, a character might breath and sway slightly when idle, walk when commanded, and raise their arms when they fall from a platform. A sliding door might open, close, or jam.

Mecanim uses a state machine to arrange these actions. A state machine is a graph of nodes and connecting lines that resembles a flowchart. A state machine plays the animation linked to the current action and determines the next action. You can create a state machine for each character and GameObject in your scene.

| **Topic**                                                                                                          | **Description**                                                                      |
|:-------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------|
| **[State machine basics](https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBasics.html)**           | Learn core state machine concepts and build animation flow in the Animator window.   |
| **[Animation states](https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html)**                      | Configure states, motions, and defaults to control what each state plays.            |
| **[Animation parameters](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html)**          | Control state logic with scriptable parameters.                                      |
| **[State machine transitions](https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineTransitions.html)** | Simplify complex controllers with Entry and Exit transitions between state machines. |
| **[Animation transitions](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html)**            | Blend between states and define when transitions are triggered.                      |
| **[Animation blend trees](https://docs.unity3d.com/6000.3/Documentation/Manual/animation-blend-trees.html)**       | Blend similar motions smoothly using parameters and normalized time.                 |
| **[State machine behaviors](https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBehaviours.html)**    | Attach behavior scripts to states to run code on enter, update, and exit.            |
| **[Sub-state machines](https://docs.unity3d.com/6000.3/Documentation/Manual/NestedStateMachines.html)**            | Group related states into nested machines to keep large graphs manageable.           |
| **[Animation layers](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationLayers.html)**                  | Separate animation with layered controllers, masks, and blending modes.              |
| **[State machine solo and mute](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationSoloMute.html)**     | Preview transitions faster by soloing key paths and muting irrelevant ones.          |
| **[Target matching](https://docs.unity3d.com/6000.3/Documentation/Manual/TargetMatching.html)**                    | Match character parts to precise world targets during specific animation windows.    |

## Additional resources

-   [Humanoid Avatar](https://docs.unity3d.com/6000.3/Documentation/Manual/AvatarCreationandSetup.html)
-   [Create an Animator Controller](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimatorControllerCreation.html)
