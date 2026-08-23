---
title: "Creating, loading, and saving scenes"
page_title: "Unity - Manual: Creating, loading, and saving scenes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Creating, loading, and saving scenes

This page explains how to [create](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene), [load](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#loading-scenes), and [save](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#saving-scenes) scenes.

<span id="creating-a-new-scene"></span>

## Creating a new scene

There are several ways to create a new scene:

-   Use the [New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene-from-the-new-scene-dialog) to create a new scene from a specific scene template.
-   Use the [menu](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene-from-the-menu) or the [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene-from-the-project-window) to create new scenes from your Project’s Basic scene template without opening the New Scene dialog.
-   Create a scene from a specific template directly [from a C# script](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene-from-a-csharp-script).

Unity creates every new scene from a scene template. For information about creating and managing scene templates, see [Scene templates](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html).

<span id="creating-a-new-scene-from-the-new-scene-dialog"></span>

### Creating a new scene from the New Scene dialog

Use the New Scene dialog to create new scenes from specific scene templates in your Project. You can also use the New Scene dialog to find and manage scene templates. For details see [The New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html#new-scene-dialog).

By default, the New Scene dialog opens when you create a new scene from the menu (**File** \> **New Scene**) or by using a shortcut (**Ctrl/Cmd + n**).

To create a new Scene:

1.  Select a template from the list.
2.  If you want Unity to load the new scene additively (see note below), enable **Load Additively**.
3.  Click **Create** to create a new scene from the template.

| **Note:**                                                                                                                                                                                                                      |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Additive loading means that Unity loads the scene in addition to any other scenes you have open. For more information, see [Multi-Scene editing](https://docs.unity3d.com/6000.3/Documentation/Manual/MultiSceneEditing.html). |

If the template does not have any [cloneable dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html#templates-and-scene-dependencies), Unity loads the new scene in memory, but does not save it.

If the template has [cloneable dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html#templates-and-scene-dependencies), Unity prompts you to choose a location in the Project to save it to. When you save the scene, Unity creates a folder in the same location, and with the same name as the new scene. It then clones the cloneable dependencies into the new folder, and updates the new scene to use the cloned assets instead of the original assets used by the template scene.

<span id="creating-a-new-scene-from-the-menu"></span>

### Creating a new scene from the menu:

Use the menu (**Assets** \> **Create** \> **Scene**) to create a new scene without opening the New Scene dialog.

When you create a new scene from the menu, Unity automatically copies the project’s Basic template, and adds the new scene to whichever folder is currently open in the project window.

<span id="creating-a-new-scene-from-the-project-window"></span>

### Creating a new scene from the project window

Use the context menu in the Project window to create a new scene without opening the New Scene dialog.

1.  Navigate to the folder where you want to create the new scene.
2.  Right click the folder in the left-hand pane, or right-click an empty area in the right hand pane, and select **Create** > **Scene** from the context menu.

When you create a new scene from the menu, Unity automatically copies the project’s Basic template, and adds the new scene to the selected folder.

<span id="creating-a-new-scene-from-a-csharp-script"></span>

### Creating a new scene from a C# script

To create a new scene from a C# script using a specific scene template, use the [`SceneTemplateService.Instantiate` method](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneTemplate.SceneTemplateService.Instantiate.html).

The `Instantiate` method instantiates a new scene from a scene template. It returns the newly created `Scene` handle, and its matching `SceneAsset`. You can create this scene additively. If the scene contains [assets that need to be cloned](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html#templates-and-scene-dependencies), you must provide a path for Unity to save the scene to disk.

#### New scene events

When you create a new scene from a template, either from a script or using the New Scene dialog, Unity triggers an [event](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneTemplate.SceneTemplateService-newSceneTemplateInstantiated.html). Unity triggers this event after the template is instantiated, and also after it triggers the [`EditorSceneManager.newSceneCreated`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager-newSceneCreated.html) or [`EditorSceneManager.sceneOpened`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.EditorSceneManager-sceneOpened.html) events.

``` lang-cs
public class SceneTemplate

```

<span id="loading-scenes"></span>

## Loading scenes

To open a scene, do one of the following:

-   In the Project window, double-click the scene asset.
-   From the menu, select **File** > **Open Scene**.
-   From the menu, select **File** > **Recent Scenes** and select the name of the scene.

If your current scene contains unsaved changes, Unity prompts you to save the scene or discard the changes.

### Opening multiple scenes at once

You can open multiple scenes for editing at the same time. For details, see [Multi-Scene editing](https://docs.unity3d.com/6000.3/Documentation/Manual/MultiSceneEditing.html).

<span id="saving-scenes"></span>

## Saving scenes

To save the scene you’re currently working on, choose **File** \> **Save Scene** from the menu, or press Ctrl + S (Windows) or Cmd + S (macOS).

![Saved scene assets visible in the Project window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SceneAssetsInProjectView_01.png)
