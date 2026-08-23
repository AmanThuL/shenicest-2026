---
title: "Animation transitions"
page_title: "Unity - Manual: Animation transitions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Animation transitions

Use animation transitions in the [state machine](https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBasics.html) to switch or blend from one animation state to another. Transitions define the duration of the blend between states and the conditions when a transition occurs. To set these conditions, specify values of parameters in the Animator Controller.

For example, your character might have a `Patrolling` state and a `Sleeping` state. You can set the transition between patrolling and sleeping to occur only when an `Alertness` parameter value decreases below a certain level.

To name a transition, type its name in the field above the transition:

![The empty field above the transition in the Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorTransitionName.png)

The Inspector window displays the transitions that the state uses:

![List of transitions that the Patrolling state uses.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorTransitionNameInState.png)

You can only activate one transition at a given time. However, you can configure the settings to interrupt the currently active transition with another transition. Refer to [Transition interruption](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html#TransitionInterruption) for more information.

## Transition properties

To view the properties for a transition, select the transition line connecting two states in the Animator window. The properties appear in the Inspector window.

![Tranisition properties in the Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/class-Transition-Properties.png)

Use the following properties to adjust the transition and how it blends between the current and next state.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Has Exit Time</strong></td><td style="text-align: left;"><strong>Exit Time</strong> is a special transition that doesn’t rely on a parameter. Instead, it relies on the normalized time of the state. Check to make the transition happen at the specific time specified in <strong>Exit Time</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Settings</strong></td><td style="text-align: left;">Fold-out menu containing detailed transition settings. Each transition setting is described below.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Exit Time</strong></td><td style="text-align: left;">If <strong>Has Exit Time</strong> is checked, this value represents the exact time at which the transition can take effect. This is represented in normalized time (for example, an exit time of 0.75 means that on the first frame where 75% of the animation has played, the <strong>Exit Time</strong> condition is true). On the next frame, the condition is false.<br />
<br />
For looped animations, transitions with exit times smaller than 1 are evaluated every loop, so you can use this to time your transition with the proper timing in the animation every loop.<br />
<br />
Transitions with an <strong>Exit Time</strong> greater than 1 are evaluated only once, so they can be used to exit at a specific time after a fixed number of loops. For example, a transition with an exit time of 3.5 are evaluated once, after three and a half loops.</td></tr><tr class="even"><td style="text-align: left;"><strong>Fixed Duration</strong></td><td style="text-align: left;">If the <strong>Fixed Duration</strong> box is checked, the transition time is interpreted in seconds. If the <strong>Fixed Duration</strong> box is not checked, the transition time is interpreted as a fraction of the normalized time of the source state.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Transition Duration</strong></td><td style="text-align: left;">The duration of the transition, in normalized time or seconds depending on the <strong>Fixed Duration</strong> mode, relative to the current state’s duration. This is visualized in the transition graph as the portion between the two blue markers.</td></tr><tr class="even"><td style="text-align: left;"><strong>Transition Offset</strong></td><td style="text-align: left;">The offset of the time to begin playing in the destination state which is transitioned to. For example, a value of 0.5 means the target state begins playing at 50% of the way through its own timeline.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Interruption Source</strong></td><td style="text-align: left;">Use this to control the circumstances under which this transition might be interrupted. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html#TransitionInterruption">Transition interruption</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Ordered Interruption</strong></td><td style="text-align: left;">Determines whether the current transition can be interrupted by other transitions independently of their order (see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html#TransitionInterruption">Transition interruption</a> below).</td></tr><tr class="odd"><td style="text-align: left;"><strong>Conditions</strong></td><td style="text-align: left;">A transition can have a single condition, multiple conditions, or no conditions at all. If your transition has no conditions, the Unity Editor only considers the <strong>Exit Time</strong>, and the transition occurs when the exit time is reached. If your transition has one or more conditions, the conditions must all be met before the transition is triggered. A condition consists of:<br />
<ul><li>An event parameter (the value considered in the condition).</li><li>A conditional predicate (if needed, for example, &lt;<code>less than</code> or &gt; <code>greater than</code> for floats).</li><li>A parameter value (if needed).</li></ul>If you have <strong>Has Exit Time</strong> selected for the transition and have one or more conditions, note that the Unity Editor considers whether the conditions are true after the <strong>Exit Time</strong>. This allows you to ensure that your transition occurs during a certain portion of the animation.</td></tr></tbody></table>

<span id="TransitionInterruption"></span>

## Transition interruption

Use the **Interruption Source** and **Ordered Interruption** properties to control how your transition can be interrupted. The interruption order works, conceptually, as if transitions are queued and then parsed for a valid transition from the first transition inserted to the last.

### Interruption Source property

The transitions in [AnyState](https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html) are always added first in the queue, then other transitions are queued depending on the value of **Interruption Source**:

| **Value**                         | **Function**                                                                           |
|:----------------------------------|:---------------------------------------------------------------------------------------|
| **None**                          | Don’t add any more transitions.                                                        |
| **Current State**                 | Queue the transitions from the current state.                                          |
| **Next State**                    | Queue the transitions from the next state.                                             |
| **Current State then Next State** | Queue the transitions from the current state, then queue the ones from the next state. |
| **Next State then Current State** | Queue the transitions from the next state, then queue the ones from the current state. |

### Ordered Interruption property

The property **Ordered Interruption** changes how the queue is parsed. Depending on its value, parsing the queue ends at a different moment as listed below.

| **Value**     | **Ends when**                                                |
|:--------------|:-------------------------------------------------------------|
| **Checked**   | A valid transition or the current transition has been found. |
| **Unchecked** | A valid transition has been found.                           |

Only an [AnyState](https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html) transition can be interrupted by itself. To learn more about transition interruptions, refer to [State Machine Transition Interruptions](https://unity.com/blog/engine-platform/state-machine-transition-interruptions).

## Transition graph

Use the Transition graph to visually adjust the transition settings.

![The Transition graph as shown in the Inspector.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorTransitionSettingsAndGraph.svg)

The white line in the Transition graph represents IK foot contact for each State. The top of the graph represents the Left foot and the bottom represents the Right foot. When the white line is at the top of the graph, the Left foot contacts the floor plane. When the white line is at the bottom, the Right foot contacts the floor plane.

Adjust the transition settings until there is a smooth transition between states. A white line with a smooth transition avoids foot slips, jumps in animation, and preserves the dynamics of the motion.

Use the following manipulations to adjust the transition settings:

-   Drag the **Duration “out”** marker to change the **Duration** of the transition.
-   Drag the **Duration “in”** marker to change the duration of the transition and the **Exit Time**.
-   Drag the target state to adjust the **Transition Offset**.
-   Drag the preview playback marker to scrub through the animation blend in the preview window at the bottom of the Inspector.

## Transitions between Blend Tree states

If either the current or next state belonging to this transition is a [Blend Tree](https://docs.unity3d.com/6000.3/Documentation/Manual/class-BlendTree.html) state, the Blend Tree parameters appear in the **Inspector** window. Adjust these values to preview how your transition looks with the Blend Tree values set to different configurations. If your Blend Tree contains clips of differing lengths, you should test what your transition looks like when showing both the short clip and the long clip. Adjusting these values does not affect how the transition behaves at runtime; they are solely for helping you preview how the transition could look in different situations.

![The Blend Tree parameter preview controls, visible when either your current or next state is a Blend Tree state.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AnimatorTransitionInspectorShowingBlendtreeParams.png)

<span id="Conditions"></span>

## Conditions

A transition can have a single condition, multiple conditions, or no conditions. If your transition has no conditions, the Unity Editor only considers the **Exit Time**, and the transition occurs when the exit time is reached. If your transition has one or more conditions, the conditions must all be met before the transition is triggered.

A condition consists of:

-   An event parameter, the value of which is considered in the condition.
-   A conditional predicate, if needed (for example, less or greater for floats).
-   A parameter value, if needed.

If you enabled **Has Exit Time** for the transition and the transition has one or more conditions, Unity only checks these conditions after the exit time of the state. This ensures that your transition only occurs during a certain portion of the animation.

<span class="search-words">Transition</span>
