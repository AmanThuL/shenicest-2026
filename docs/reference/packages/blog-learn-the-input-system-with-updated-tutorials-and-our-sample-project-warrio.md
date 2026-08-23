---
title: "Learn the Input System with updated tutorials and our sample project, Warriors"
page_title: "Learn the Input System with updated tutorials and our sample project, Warriors"
source_url: "https://unity.com/blog/technology/learn-the-input-system-with-updated-tutorials-and-our-sample-project-warriors"
final_url: "https://unity.com/blog/technology/learn-the-input-system-with-updated-tutorials-and-our-sample-project-warriors"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Learn the Input System with updated tutorials and our sample project, Warriors

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Learn the Input System with updated tutorials and our sample project, Warriors

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">KRISTYNA HOUGAARD / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Contributor</span>

<span class="mr-2">Nov 26, 2020</span><span class="mr-2">\|</span><span class="mr-2">7 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

With the [Input System](https://unity.com/features/input-system), you can quickly set up controls for multiple platforms, from mobile to VR. Get started with our example projects and new video tutorials for beginners and intermediate users.

Input is at the heart of what makes your real-time projects interactive. Unity’s system for input standardizes the way you implement controls and provides new advanced functionality. It’s verified for Unity 2019 LTS and newer versions (see the documentation for a [full list of supported input devices](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.0/manual/SupportedDevices.html)).

Our new tutorial content can help you to get started quickly, even if you’re completely new to developing for multiple platforms. If you’re already familiar with the workflows, learn more about how to use the Input System to drive (other) Unity tools like Cinemachine or Unity UI with Warriors, our main example project.

This Meet the Devs session from March explains why we created this new system and includes a demo that outlines workflows for setting up local multiplayer, quickly adding gamepad controls, spawning new players, and implementing mobile controls. Rene Damm, the lead developer of the Input System, also answers questions from the audience about tooling and the team’s roadmap.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

Roll-a-Ball: Input System for beginners

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you’re a beginner who just wants to get to know the basic input workflows for Unity, check the updated [Roll-a-Ball project on Unity Learn](https://learn.unity.com/project/roll-a-ball?uv=2019.4). It walks you through first steps like [installing the Input System package](https://learn.unity.com/tutorial/moving-the-player?uv=2019.4&projectId=5f158f1bedbc2a0020e51f0d#5f0fc8a0edbc2a0020763f8a), [adding a Player Input component](https://learn.unity.com/tutorial/moving-the-player?uv=2019.4&projectId=5f158f1bedbc2a0020e51f0d#5f107d23edbc2a002027994e), and [applying input data to the Player](https://learn.unity.com/tutorial/moving-the-player?uv=2019.4&projectId=5f158f1bedbc2a0020e51f0d#5f107d5cedbc2a001f705c15).

The Prototype Series: Controlling a spaceship

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Our Prototype Series also uses the Input System, as you can see in this [video](https://youtu.be/LVSmp0zW8pY) and [example project](https://on.unity.com/37K5j1b) on creating a boss with procedural animation. The spaceship’s input action asset uses input for movement controls, shooting laser projectiles, and boosting.

Warriors: Intermediate integrations and gameplay scenarios

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[Warriors](https://github.com/UnityTechnologies/InputSystem_Warriors) is a project that demonstrates more intermediate tooling and APIs with the Input System in a typical third-person local-multiplayer cross-platform game setup. It’s available for [Unity 2019 LTS](https://unity.com/releases/2019-lts) and will be updated for the 2020 LTS version when it’s released next year. You can download the project from GitHub, where we have three branches available:

-   [V1](https://github.com/UnityTechnologies/InputSystem_Warriors/tree/V1) captures the state of the project at the time of the Meet the Devs session mentioned above;
-   [V2](https://github.com/UnityTechnologies/InputSystem_Warriors/tree/V2) is what we’ve used for the most recent Input System Unite Now session (see below);
-   We’re continuing our work in the [Master](https://github.com/UnityTechnologies/InputSystem_Warriors) branch.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The project is built around characters that can be controlled in both Single Player and Local Multiplayer modes. When the Game Manager is set to Local Multiplayer, it will instantiate several instances of the Warrior prefab. As the Warrior prefab is set up to use the Input System’s Player Input component, each instance of the Warrior will automatically have a connected input device paired to it.

Control schemes

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The control scheme for this Warrior is set up for cross-platform play and auto-switches between the keyboard and different gamepads. This setup provides an example of applying smoothing to the raw runtime input data so that the character’s directional movement is even no matter which axes input (keyboard keys or gamepad joystick) the player uses. The following control scheme also uses a button press for a basic attack animation.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Warrior’s Input Action asset is also set up for two different Action Maps: one for controlling the character (Running and Attacking), and the other for controlling input for the menu. A game or any other interactive project usually has different states with different control requirements that share the same input bindings.

For example, pushing a joystick in one direction will cause the Warrior to run toward that axis. However, when the game is paused, the player can use the joystick to navigate between different selectable buttons and options in the pause menu.

Using the Input System, you can easily set up different Action Maps for various control scheme scenarios and switch them, per PlayerInput component, at runtime with a simple API:

playerInput.SwitchCurrentActionMap(stringForMapName);

Interacting with the UI

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Once you have set up an Action Map for interacting with the UI, actions can then be assigned to the Event System’s UI Input Module:

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the Warriors project, each player can pause the game and interact with the pause menu. The overlay UI consists of a few option buttons and a context-changing panel on the right. The Input System UI Input Module applies actions assigned to interacting with any [Unity UI](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/index.html) component with Interactable enabled (such as Buttons and Sliders).

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This UI interaction will be isolated for the specific player that pressed pause. For example, if Player 3 pauses the game, then Player 1 and 2 will not be able to interact with it, and only Player 3 will be in control. When Player 3 unpauses the game, all Player controls are resumed. We do this by calling the following methods on a PlayerInput component:

playerInput.ActivateInput();  
  
playerInput.DeactivateInput();

Runtime rebinding

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the UI Menu, there is a context panel for runtime rebinding controls. This allows you to perform an Interactive Rebind for a specific Input Action and set a new input binding to it. For example, when using a PlayStation controller you could rebind the Attack action from the Cross button to another input button such as Triangle or R2.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This rebind applies as an override to a specific PlayerInput component. For example, Player 2 will be able to rebind their Attack button to a different button, but this will not affect Player 3’s use of their Attack Input Action.

The API for setting up an interactive rebind also contains an operation for when the rebind has completed. This allows you to set up your own control when updating the UI, saving the game state or changing any other gameplay element based on this event.

pre]:rounded-xl [&>pre]:!p-4">

```
private InputActionRebindingExtensions.RebindingOperation rebindOperation;

    void StartInteractiveRebind()
    
    void RebindCompleted()
    
```

Input System and Cinemachine

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Besides the Input System’s integration with the Event System and Unity UI, the Warriors project also demonstrates how it can be set up to work in concert with [Cinemachine](https://unity.com/unity/features/editor/art-and-design/cinemachine). A typical camera setup for a third-person game would feature an orbiting follow camera where the view direction is set by a mouse position or joystick push direction. The Cinemachine Input Provider component can be added to a Cinemachine Free Look camera rig, which allows an Input action to send Vector 2 axis data directly into Cinemachine’s axis control values. In the image below, you can see that the CinemachineInputProvider is using the input data from the Look Input Action.

The Input System APIs: Display data through UI example

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Input System also contains a variety of APIs so that other systems can access data at runtime that can be displayed in the UI or other visuals. The Warriors example project uses data from Player Input to display information such as the current player device, player input ID, or even to update the UI-based rebind controls on the current binding. We created a custom system that takes the device and binding strings and returns a specific icon.

For example, if the player is using an Xbox controller and the Attack action is bound to the northern context button, this will display a Y button icon. However, if the player is using a keyboard, then it will display a string for the currently bound keyboard key. You are welcome to extract and use this Device Display Configurator tool in your own projects.

Input System package samples and documentation

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Input System package also contains several extra samples that you can explore in the Package Manager. You can use these as a reference and extend or adapt them for your own projects. You can also find the official documentation there, including this [Quick start guide](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.0/manual/QuickStartGuide.html).

Coming up: Input System 1.1

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[Input System 1.1](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.1/manual/SupportedDevices.html) is currently in preview, and it brings lots of fixes and some improvements. You can now save and load rebinds as JSON (see the RebindSaveLoad.cs sample script) and Device layouts can now be precompiled, greatly reducing instantiation time and garbage collection (GC) heap cost for these devices.

Looking for more content? Let us know!

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We hope that the sample project and the other learning materials will help you get started with using the Input System to bring your ideas to life. Please share what you want to learn next in the comment section below. Also, keep an eye on the [Input System page](https://unity.com/features/input-system) for more tutorials and other resources.
