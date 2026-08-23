---
title: "Introduction to Animator Controllers"
page_title: "Unity - Manual: Introduction to Animator Controllers"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimatorController.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimatorController.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to Animator Controllers

Use an Animator Controller to arrange and maintain a set of Animation Clips and associated Animation Transitions for a character or an animated GameObject.

In most situations, it’s normal to have multiple animations and transition between them when certain game conditions occur. For example, you could transition from a walk animation to a jump whenever the spacebar is pressed. However, even if you just have a single animation clip, you still need to place it into an Animator Controller to use it on a Game Object.

The Animator Controller has references to the Animation clips it uses. The Animator Controller manages the various Animation Clips and the Transitions between them using a **State Machine**, which could be thought of as a flow-chart of Animation Clips and Transitions. you can find more information about state machines [here](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationStateMachines.html).

![A simple Animator Controller](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MecanimAnimatorControllerWindow.png)

Unity automatically creates an Animator Controller when you begin animating a GameObject using the Animation Window, or when you attach an Animation Clip to a GameObject.

To manually create an Animator Controller, right-click within either column of the Project window and select **Create** \> **Animator Controller**.

The following topics provide more details on the Animator Controller Asset and state machines:

-   [Create an Animator Controller](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimatorControllerCreation.html)
-   [Animator Controller Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/Animator.html)
-   [Animator Window](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimatorWindow.html)
-   [Animation State Machine](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationStateMachines.html)

## Navigation

Use the scroll wheel to zoom in and zoom out of the Animator Controller view.

To focus on an item in the Animator Controller view, select one or multiple states (click or drag a selection box around the states you wish to select), then press the F key to zoom in on the selection.

![Focus on selected states](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/classAnimatorController-Focus.jpg)

Press the A key to fit all of the animation states into the Animator Controller view.

Unity preserves your selection. Press the A and F keys to switch between your selected animation states and the entire Animator Controller.

![Unity automatically fits all states in the Animator Controller view when the A key is pressed](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/classAnimatorController-Autofit.jpg)

During Play Mode, the Animator pans the view so that the current state being played is always visible. The Animator Controller respects the independent zoom factors of the Base Layer and Sub-State Machine, and the window pans automatically to ensure visibility of the active state or states.

To modify the zoom during Play Mode, follow these steps:

1.  Enable **Auto Live Link** in the Animator Controller window.
2.  Click the Play button to enter Play Mode.
3.  Click Pause.
4.  In the Animator Controller view, select the state or states you want to zoom into.
5.  Press the F key to zoom into the selection.
6.  Click the Play button again to resume Play Mode.

Note that the Animator Controller view pans to each state when it is active.

![The Animator pans to the active state](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/classAnimatorController-Pans.png)
