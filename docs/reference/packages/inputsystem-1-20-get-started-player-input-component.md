---
title: "Get started with the Player Input component"
page_title: "Get started with the Player Input component | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/get-started-player-input-component.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/get-started-player-input-component.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with the Player Input component

To get started using the Player Input component, use the following steps:

1.  [Add](https://docs.unity3d.com/Manual/UsingComponents.html) a **Player Input** component to a GameObject. This would usually be the GameObject that represents the player in your game.
2.  Assign your [action asset](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/action-assets.html) to the **Actions** field. This is usually the default project-wide action asset named "InputSystem_Actions" Currently, when using project-wide actions all the action maps are enabled by default. It is advisible to manually disable them and manually enable the default map that **Player Input** during `Start()`.
3.  Set up Action responses, by selecting a **Behavior** type from the Behavior menu. The Behavior type you select affects how you should implement the methods that handle your Action responses. Refer to the [notification behaviors](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/select-notification-behavior.html) section further down for details.  
      
    ![PlayerInput Notification Behavior](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/PlayerInputNotificationBehaviors.png)
