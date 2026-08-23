---
title: "About project-wide actions"
page_title: "About project-wide actions | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# About project-wide actions

You can assign an individual action asset to be available "project-wide", which means the actions within that asset are available more conveniently through the Input System API without needing to set up references to the asset.

When you [assign an action asset as project-wide](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/assign-project-wide-actions.html), it also becomes automatically [preloaded](https://docs.unity3d.com/ScriptReference/PlayerSettings.GetPreloadedAssets.html) when your app starts up, and is kept available until it terminates.

Unless you have specific project requirements that require more than one action asset, the recommended workflow is to use a single action asset assigned as the project-wide actions.

## Edit project-wide actions

Once you have created and assigned project-wide actions, the Input System Package page in Project Settings displays the **Actions Editor** interface. Read more about how to use the [Actions Editor](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/actions-editor.html) to configure your actions.

![image alt text](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/ProjectSettingsInputActionsSimpleShot.png) *The Input System Package Project Settings after creating and assigning the default actions*

## Using project-wide actions in code

The benefit of assign an action asset as the project-wide actions is that you can access the actions directly through the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html" class="xref"><code>InputSystem.actions</code></a> property directly, rather than needing to set up a reference to your action asset first.

For example, you can get a reference to an action named "Move" in your project-wide actions using a line of code like this:

      InputSystem.actions.FindAction("Move");

Project-wide actions are also enabled by default.
