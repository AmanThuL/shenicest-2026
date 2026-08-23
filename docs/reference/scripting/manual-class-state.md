---
title: "Unity 6.3 Manual: Animation States"
page_title: "Unity - Manual: Animation States"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation States

**Animation States** are the basic building blocks of an **Animation State Machine**. Each state contains an animation sequence (or [blend tree](https://docs.unity3d.com/6000.3/Documentation/Manual/class-BlendTree.html)) that plays when the character is in that state. Select the state in the **Animator Controller**, to view the properties for the state in the Inspector window.

![Animation State properties in the Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/anim-insp-state-properties.png)

| ***Property:***    | ***Description:***                                                                                                                                                                                                              |
|:-------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Motion**         | The animation clip or blend tree assigned to this state.                                                                                                                                                                        |
| **Speed**          | The default speed of the motion for this state. Enable Parameter to modify the speed with a custom value from a script. For example, you can multiply the speed with a custom value to decelerate or accelerate the play speed. |
| **Motion Time**    | The time used to play the motion for this state. Enable Parameter to control the motion time with a custom value from a script.                                                                                                 |
| **Mirror**         | This property only applies to states with humanoid animation. Enable to mirror the animation for this state. Enable Parameter to enable or disable mirroring from a script.                                                     |
| **Cycle Offset**   | The offset added to the state time of the motion. This offset doesn’t affect the Motion Time. Enable Parameter to specify the Cycle Offset from a script.                                                                       |
| **Foot IK**        | This property only applies to states with humanoid animation. Enable to respect Foot IK for this state.                                                                                                                         |
| **Write Defaults** | Whether the AnimatorStates writes the default values for properties that aren’t animated by its motion.                                                                                                                         |
| **Transitions**    | The list of transitions originating from this state.                                                                                                                                                                            |

The default state, displayed in brown, is the state where the state machine starts when it’s first activated. To change the default state, right-click on another state and select **Set As Default** from the context menu. Use the **Solo** and **Mute** checkboxes on each transition to control the behaviour of **animation previews**. For more information, refer to [this page](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationSoloMute.html).

To add a new empty state, right-click in the Animator Controller view and select **Create State** \> **Empty** from the context menu. To create a new state with an animation clip, drag the animation clip into the Animator Controller view.

## Any State

Use **Any State** to add a transition from any state to a specific state. **Any State** is a special state that represents all states. Adding a transition from **Any State** is an efficient way of adding the same transition from all states.

For example, your game has a timer and you want to transition to a time expired animation when the timer reaches zero. You can add a transition from **Any State** to the timer expired state. When the timer reaches zero, regardless of the current state, your state machine transitions to the time expired state.

![The Any State in the Animator Controller view.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnyState.png)

Because of its special purpose, you can’t place **Any State** at the end of a transition. You can’t have an animation or transition end with **Any State**. You also can’t set **Any State** as the default state.
