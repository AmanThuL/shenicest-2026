---
title: "State machine basics"
page_title: "Unity - Manual: State machine basics"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBasics.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBasics.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# State machine basics

A state machine is a diagram that represents the behavior of a system or an object. This diagram consists of nodes connected by lines, similar to a flowchart. Each node represents a state and each connecting line represents a transition between states.

A state machine is only in one state at a time. It remains in the same state until the conditions for a transition are met or when a specific action completes.

For example, a state machine that represents the behaviour of a door might include the opened, closed, and locked states. The door can’t be in the opened and closed state at the same time. A transition from the opened to closed state occurs when someone pushes the door closed. The state machine remains in the closed state until the conditions for another transition are met.

## State machines in Mecanim

Unity’s Mecanim Animation system uses a state machine to arrange and play animation associated with a character or GameObject. Like a traditional state machine, an animation state machine remains in the same state until it satisfies the criteria for a transition. This criteria might be when an animation completes, a specific action completes, or when a set of conditions are true.

Each state includes an animation that plays when the state machine enters the state. This animation might play once or loop while the state machine remains in the state. This animation might be a single animation clip or many animation clips blended together.

For example, an Animation state machine for player movement might include states with animation for standing still (idle), walking, running, and jumping. A transition from the idle to the walking state occurs when the user inputs the command to walk. In this case, the transition criteria is true when the user uses an input device to move the character forward.

Use the [Animator window](https://docs.unity3d.com/6000.3/Documentation/Manual/Animator.html) to create a state machines for a character or GameObject.

![Animator window with a state machine.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimStateMachine.png)

An Animation state machine consists of **States**, **Transitions**, and **Events**. Use a Sub-State machine to divide larger state machines. For more information, refer to [Animation States](https://docs.unity3d.com/6000.3/Documentation/Manual/class-State.html) and [Animation transitions](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transition.html).
