---
title: "Unity Input System controls in Backyard Baseball 2026"
page_title: "Unity Input System controls in Backyard Baseball 2026"
source_url: "https://unity.com/blog/input-system-event-driven-architecture-for-scalable-controls"
final_url: "https://unity.com/blog/input-system-event-driven-architecture-for-scalable-controls"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity Input System controls in Backyard Baseball 2026

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

Game teardown

# Batting a thousand: How Unity’s event-driven Input System powers controls in Backyard Baseball

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">MATTHEW WOJTECHKO / MEGA CAT STUDIOS</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Lead Game Developer</span>

<span class="mr-2">Jun 22, 2026</span>

Engine

Input

Programming

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

*This is the second in a series of blog posts by Mega Cat Studios where they share their Unity expertise and solutions for real-world commercial game development challenges. In this post, Matthew Wojtechko explores how to leverage Unity’s event-driven Input System package to improve responsiveness and reduce inefficient polling.*

*Read the first post in the series:* [Scaling Unity workflows: Lessons from medium to large projects](https://unity.com/blog/scaling-workflows-lessons-from-medium-to-large-projects)

Input is often the first thing we implement when starting a game, and for good reason: If you can’t move a character or navigate a menu, nothing else matters. However, "just get it working" input code has a habit of becoming permanent. What starts as a few simple lines of polling can quietly become a fragile codebase that collapses when real requirements, like rebindable controls or local multiplayer, arrive.

At [Mega Cat Studios](https://megacatstudios.com/), we shifted away from constant frame-by-frame checking (polling) toward an event-driven workflow. Whether we are developing the QTEs for the jumpscare reactions in [*Five Nights at Freddy’s: Into the Pit*](https://megacatstudios.com/pages/five-nights-at-freddys-into-the-pit) or local multiplayer for [*Backyard Baseball*](https://megacatstudios.com/pages/backyard-baseball), leveraging [Unity’s Input System package](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/index.html) keeps gameplay responsive and maintainable.

Features like the following become painful to support if they aren’t top-of-mind while programming input:

-   Multiple input devices (keyboard, controller, touch)
-   Rebindable controls
-   UI navigation that doesn’t fight gameplay input
-   Local multiplayer
-   Timing-sensitive gameplay

In this post, we’ll walk through how we use the Input System to solve these problems. Along the way, we’ll talk about architecture – what enables our projects to scale, and what tends to collapse under its own weight.

## Unity’s input system has evolved. So have we.

When Unity released the new Input System in 2020, it wasn’t just a makeover for the legacy Input.GetAxis and Input.GetButtonDown functions. It’s a [fundamentally different approach](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/Concepts.html) to input that is event-driven, device-agnostic, and focused on player intent. The following are the core concepts we’ve internalized.

### Actions

[Actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/Actions.html) are the building blocks. In *Backyard Baseball*, it looks something like this:

-   [Action Maps](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/ActionsEditor.html#configure-action-maps) represent input contexts.
    -   Gameplay
    -   Menus
    -   Debug/developer tools
-   Actions are the player’s intent:
    -   Swing
    -   Slide
    -   Steal base
    -   Confirm
    -   Cancel

Our game code talks to intent, not devices. Maybe the player presses the spacebar. Or maybe they tap the cross button on a PlayStation controller. No matter what, our player code only needs to worry about when the “Swing” action is performed. That level of abstraction makes our lives easier.

### Bindings

[Bindings](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/ActionBindings.html) are the concrete device-to-action mappings that let us handle multiple control schemes without extra complexity. A single Action can react to multiple inputs from multiple devices.

This is how we can support keyboard + mouse, controller, touch, and accessibility setups without branching our code into oblivion. We can easily rebind actions in the Editor and at runtime. We’ll explore this more in a later section.

### Responsiveness

Traditional input relies on polling:

pre]:rounded-xl [&>pre]:!p-4">

```
if (Input.GetButtonDown("Swing Bat"))

```

It’s simple, but it ties input detection to the frame loop. If the input is pressed and released faster than the framerate, it may never be seen.

For games that rely on quick reactions, like those in the fighting, rhythm, and precision platforming genres, inconsistent input can ruin the experience. And even for slow-paced games, dropping an input can be devastating if it's at a critical moment, like when the batter takes that all-important swing in *Backyard Baseball*.

The Input System is designed around events. You subscribe once, and Unity notifies you when input occurs. This reduces CPU overhead, simplifies logic, and makes missed inputs a non-issue. From button presses and releases to axis value changes, everything is queued, so inputs never get lost. Even at variable frame rates or at sub-frame rate levels of speed, those events are processed in order and delivered reliably to your callbacks.

The result? Input that bats a thousand.

### Local Multiplayer

Local multiplayer is one area where the Input System provides a major advantage over the legacy Input Manager.

With the PlayerInput component and control schemes:

-   Each player gets their own action instance.
-   Devices can be paired dynamically.
-   Split keyboard, multiple controllers, or hybrid setups “just work.”

Importantly, player controls are isolated by design. No more device indexing or input conflicts between players. This was a huge benefit for the Mega Cat team when we implemented the couch co-op in *Backyard Baseball*.

If local multiplayer is even a possibility for your project, starting with the Input System package could save you a lot of rework later.

The Input System made the local multiplayer feature much easier to implement than it would have been with the legacy Input Manager.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Sometimes, developers continue to use polling even when using the Input System. There’s a certain allure in just typing in Keyboard.current.spaceKey.isPressed without worrying about any other setup. This may be fine for certain projects, but keep in mind that if you’re building for the long term, subscribing to input action callbacks is the better approach.

## Structure for Scale

Input bindings make it seamless to switch between gameplay and UI contexts and handle different controller types.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Reading the input is easy. The real challenge is creating the architecture that fits input into different menus, modes of gameplay, and gameplay systems.

Here are the patterns we’ve used across multiple shipped games:

-   **Separate Input Contexts**: At a minimum, most projects benefit from the following:
    -   Gameplay map – player movement, combat, interactions
    -   UI map – navigation, confirm/cancel, scrolling
    -   Debug map – dev-only shortcuts like console toggles or time scaling  
          
        Why does this matter? To avoid input leaks. If you don’t separate contexts, it’s much harder to avoid edge cases where, for example, pressing the Spacebar both confirms a menu and makes the player jump. Action Maps let us explicitly enable and disable entire input contexts as game state changes. It makes input leakage practically a non-issue.
-   **Central Input Manager**: While the Input System supports per-object InputActionReferences, a large project benefits from a single, authoritative input manager. A good Input Manager typically:
    -   Enables and disables Action Maps
    -   Subscribes to input callbacks
    -   Handles device changes
    -   Acts as the boundary between input and gameplay logic

Here’s a simple example:

pre]:rounded-xl [&>pre]:!p-4">

```
public class GameInputManager : MonoBehaviour

    private void OnDisable()
    
    private void OnJump(InputAction.CallbackContext context) 
    
    private void OnShoot(InputAction.CallbackContext context) 
    
}
```

In many of our codebases, we have a custom class for game input that contains functions that allow you to register and deregister callbacks by supplying little more than a string key. We also add a priority system that allows us to stop listening to certain inputs in specific scenarios, such as the input contexts noted above. Using this manager to hook up player input looks like this:

pre]:rounded-xl [&>pre]:!p-4">

```
InputManager.Register(“Swing”, Priority.Character, SwingBat);
```

The GameObjects controlled by input are decoupled from the input logic that controls them. That makes refactoring later in the process less expensive, while also simplifying the code for the devs who work with it.

## Embrace rebinding

Rebindable controls aren’t a luxury feature any longer. They’re expected for accessibility, device diversity, and basic user experience.

Many of us at Mega Cat Studios have implemented rebinding with the legacy input manager, so we know how painful it used to be (and it may be the reason for more than a few gray hairs in our whiskers). Fortunately, the Input System package gives us this feature almost for free.

InputActionRebindingExtensions.PerformInteractiveRebinding() does the heavy lifting; all we need to do is wire it into the game code. We typically do this with two scripts that split concerns between the frontend and backend:

-   **RebindsManager**
    -   Handles the current operation so only one action is being rebinded at a time
    -   Disable callbacks during rebinding
    -   Contains the input action reference  
-   **RebindActionUI**
    -   Handles interaction to start and end the operation
    -   Attached to each UI panel that remaps input

“Initially, we didn't have a manager for this, so the UI script alone handled both the interaction and rebind operation,” says Sofia Nacional, a developer on *Backyard Baseball*. “This didn’t scale and made it possible to have multiple active rebind operations at the same time.”

Proper organization of input on the backend gives players more freedom to customize things on the front end, too. Take the example of input contexts. In a baseball game, players’ actions occur in distinct phases: batting, pitching, fielding, and baserunning. So, in our game, a player is allowed to bind the button to both “swing bat” and “steal base” because those two actions never occur in the same scenario. Input contexts make it easy to allow the right duplicate bindings while preventing the problematic ones that would cause multiple input actions to fire.

## Input is a system

The biggest mistake teams make is treating input as an implementation detail rather than a core game system. Input affects everything: gameplay feel, UI usability, and long-term maintainability. If you’re prototyping or shipping something small, you might get away with scattershot polling buried in your MonoBehaviours. But if your game needs to scale, you need something robust.

As video game developers, we work for the player; it’s our job to give them the tools to do *their* job properly! By embracing an event-driven architecture, we aren't just optimizing code; we’re protecting our games against bugs that frustrate players’ control and giving them the best experience possible.

### Learn more about the Input System

-   [Input System package documentation](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/manual/index.html)
-   [Input System tutorials playlist (2025)](https://www.youtube.com/playlist?list=PLX2vGYjWbI0RpLvO3B7aH-ObfcOifMD20)
-   [Persistent Input Rebinds Tutorial by Damyan Momchev](https://dastmo.com/tutorials/unity-input-system-persistent-rebinds/)
-   [Input Frame Update Troubleshooting by CodeMonkey](https://unitycodemonkey.com/video.php?v=5JN9n1Lsp8g)
