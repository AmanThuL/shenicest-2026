---
title: "Set up multiple scenes"
page_title: "Unity - Manual: Set up multiple scenes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/setupmultiplescenes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/setupmultiplescenes.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set up multiple scenes

You can add multiple scenes, edit how you view them, and change the scene settings.

To create a new scene, see [Creating, loading, and saving Scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html).

## Add scenes

To add a new scene to your project, do one of the following:

-   Right click to open the menu of a scene asset in the Project window and select **Open Scene Additive**.
-   Drag one or more scenes from the Project window into the Hierarchy window.

## View scenes

The Hierarchy window displays all the scenes that are part of your project:

![The Hierarchy window with multiple scenes added.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ViewScenes.png)

A: Scenes with unsaved changes have an asterisk by the scene name.  
B: The scene More menu allows you to perform actions on the scene.  
C: The scene divider (an inverted triangle) lets you collapse a scene and hide its contents from the Hierarchy to better manage multiple scenes.

**Tip**: To add a scene to the Hierarchy window without loading it, press Alt (macOS: press Option) and drag the scene into the Hierarchy window. This lets you load the scene when it’s convenient for you.

## Loaded scene More menu (⋮)

You can interact with and edit a loaded scene in several ways.

![The More menu for a loaded scene.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/LoadedMoreMenu.png)

| **Setting**            | **Description**                                                                                                                                                                                                                                                                                         |
|:-----------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Set Active Scene**   | Sets the scene as the target for new GameObjects created through scripts. For more information, see [SceneManager.SetActiveScene](https://docs.unity3d.com/ScriptReference/SceneManagement.SceneManager.SetActiveScene.html#:~:text=The%20active%20Scene%20is%20the,kept%20as%20the%20active%20Scene.). |
| **Save Scene**         | Saves the scene that you selected.                                                                                                                                                                                                                                                                      |
| **Save Scene As**      | Opens your file browser so you can choose where and how to save the scene.                                                                                                                                                                                                                              |
| **Save All**           | Saves all the scenes you have open in the Hierarchy window.                                                                                                                                                                                                                                             |
| **Unload Scene**       | Hides the contents of the scene from the Scene view and the Hierarchy window. If you have unsaved changes, save them before you unload the scene to not lose any changes.                                                                                                                               |
| **Remove Scene**       | Removes the scene from the Hierarchy window.                                                                                                                                                                                                                                                            |
| **Discard changes**    | Undoes any changes that you haven’t saved.                                                                                                                                                                                                                                                              |
| **Select Scene Asset** | Highlights the scene asset in the Project window.                                                                                                                                                                                                                                                       |
| **Add New Scene**      | Adds a new untitled scene below the scene you have selected.                                                                                                                                                                                                                                            |
| **GameObject**         | Opens a dropdown menu of GameObjects that you can add to the scene you have selected.                                                                                                                                                                                                                   |

## Unloaded scene More menu (⋮)

You can interact with and edit an unloaded scene in fewer ways than you can a loaded scene.

![The More menu for an unloaded scene.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UnloadedMoreMenu.png)

| **Setting**            | **Description**                                                                                             |
|:-----------------------|:------------------------------------------------------------------------------------------------------------|
| **Load Scene**         | Displays the contents of the scene in the Hierarchy window and the Scene view, and allows you to edit them. |
| **Remove Scene**       | Removes the scene from the Hierarchy window.                                                                |
| **Select Scene Asset** | Highlights the scene asset in the Project window.                                                           |
| **Add New Scene**      | Adds a new untitled scene below the scene you have selected.                                                |

## Multiple scenes in Play mode

When you are in Play mode and have multiple scenes in the Hierarchy window, the Editor displays an additional scene called [DontDestroyOnLoad](https://docs.unity3d.com/ScriptReference/Object.DontDestroyOnLoad.html).

## Scene-specific settings

The following settings are specific to each scene:

-   [RenderSettings](https://docs.unity3d.com/ScriptReference/RenderSettings.html) and [LightmapSettings](https://docs.unity3d.com/2022.2/Documentation/ScriptReference/LightmapSettings.html) (both found in the Lighting window).
-   Scene settings in the [Occlusion Culling](https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html) window.

Each scene manages its own settings, so only settings associated with that scene save to the scene file.

To change the settings of a specific scene, either open that specific scene and change the settings, or set the scene as the active scene then change the settings. Otherwise, if you have multiple scenes open, Unity uses the rendering settings from the active scene.

When you switch to a new active scene in the Editor or at runtime, Unity replaces all previous settings with the settings from the new active scene.

## Additional resources

-   [Creating, loading, and saving Scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html)
-   [Bake data in multiple scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/bakemultiplescenes.html)
-   [Use scripts to edit multiple scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/scriptmultiplescenes.html)
