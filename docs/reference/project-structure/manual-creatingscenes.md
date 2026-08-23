---
title: "Introduction to scenes"
page_title: "Unity - Manual: Introduction to scenes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to scenes

Scenes are where you work with content in Unity. They are assets that contain all or part of a game or application. For example, you might build a simple game in a single scene, while for a more complex game, you might use one scene per level, each with its own environments, characters, obstacles, decorations, and UI. You can create any number of scenes in a project.

When you create a new project and open it for the first time, Unity opens a sample scene that contains only a Camera and a Light.

![The default Unity sample scene, which contains a Main Camera and a directional Light](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/NewEmptyScene_01.png)

For information about working with scenes, see [Creating, loading, and saving scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html).

## Scene Templates

Unity uses scene templates to create new scenes. Scene templates are assets that are stored in a project. They are similar to scenes, but are designed to be copied rather than used directly.

For information about creating and using scene templates, see [Scene templates](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html).

<span id="new-scene-dialog"></span>

## The New Scene dialog

The New Scene dialog opens when you create a new scene from the File menu: (**File** \> **New Scene**) or the **Ctrl/Cmd + n** shortcut. Use it to create new scenes from specific scene templates in your project, and get information about existing templates.

![The New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/scene-template-new-scene-dialog.png)  
*The New Scene dialog*

1.  **Search field:** find available scene templates by name.
2.  **Templates:** a list of all available templates in the project.
3.  **Template details:** displays information about the currently selected template.
4.  **Command bar:** provides commands and options for creating a new scene from the selected template.

### Creating a new scene

To create a new scene from the New Scene dialog, select a template from the templates list, and click **Create**. For a detailed description of creating a scene this way, see [Creating a new scene from the New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html#creating-a-new-scene-from-the-new-scene-dialog).

### Pinning templates

Pinned templates appear before other templates in the New Scene dialog’s template list. The last template pinned appears at the top of the list.

You can pin a template in one of the following ways:

-   In the [New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html#new-scene-dialog), click the pin icon in the bottom right of the template .
-   In the [scene template Inspector](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates-editing.html), enable the **Pin in New Scene Dialog** option.

### Locating and editing templates

When you select a template in the [New Scene dialog](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html#new-scene-dialog), the details pane displays the path to the template.

To highlight the template in the Project window, select the **Locate** link.

To open the template in an Inspector window and [edit its properties](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates-editing.html), select the **Edit** link.

## Multi-scene editing

You can open multiple scenes for editing at the same time. For details, see [Multi-scene editing](https://docs.unity3d.com/6000.3/Documentation/Manual/MultiSceneEditing.html).

------------------------------------------------------------------------
