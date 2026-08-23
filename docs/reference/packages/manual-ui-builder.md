---
title: "UI Toolkit BPG - UI Builder"
page_title: "Unity - Manual: UI Builder"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/ui-builder.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/ui-builder.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# UI Builder

Table of Contents

-   [Canvas background](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/ui-builder.html#canvas-background)
-   [Viewport settings](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/ui-builder.html#viewport-settings)

![UI Builder is accessible from the Window/UI Toolkit/UI Builder menu.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image125.png)

UI Builder enables you to create, visualize, and modify UXML and USS files in a visual interface that’s integrated into the main Editor. Let’s look at the key features of UI Builder:

1.  **StyleSheets:** This is where you manage layout and styling formatting rules (also known as USS selectors) to share styles across UXML Documents and UI elements.
2.  **Hierarchy:** Similar to the Scene view, it displays the hierarchy of visual elements in your UXML document.
3.  **Library:** This contains predefined or custom controls ready to be added to your hierarchy, like buttons, labels, and sliders. From here you can also add other UXML (templates) into your current UXML.
4.  **Viewport:** This shows how your interface looks; you can edit elements directly in the Canvas using gizmos.
5.  **Code Previews:** This shows the code that the UI Builder is creating behind the scenes for both the UI Document (UXML) and the StyleSheets (USS). You may have to resize the window in order to see it properly.
6.  **Inspector:** Use it to change the attributes and style properties of the selected element or USS selector.

💡 **Tip: Saving UI assets**

In UI Builder, save your changes from the **Viewport** menu (**File \> Save**). This saves all open UXML and USS files.

Unlike with uGUI (Unity UI), the game can run in the Editor while you actively make changes in UI Toolkit. Look for the asterisk **\*** next to the file name in the UI Builder’s Canvas header; this indicates unsaved changes.

<span id="canvas-background"></span>

## Canvas background

Enabling the Canvas background can help you visualize your element styling over a color or background image. Select the UXML file in the Hierarchy pane and then choose a Canvas background that approximates the final UI interface to judge style changes in context.

The Canvas background provides a few different options:

-   **Background Color**: Represents a specific shade or hue of the game environment

-   **Image**: For choosing a sprite or texture as the background (useful for replicating mockup screens or reference art)

-   **Camera**: Displays the current gameplay in the background, enabling you to see the UI in context of the actual game

![The Canvas of a new UXML document: Use the Color and Image options to adjust its appearance.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image287.png)

<span id="viewport-settings"></span>

## Viewport settings

To navigate the work area, adjust the zoom level (between 25%–500%), or choose the **Fit Canvas** option which automatically adjusts the zoom according to the current screen real estate.

Use **Preview** to visualize the UI without accidentally editing the selected elements. When active, the Viewport can also show styles applied for specific mouse events (e.g., hovering, focusing).

💡 **Tip: Match Game view and themes**

![UI Builder viewport settings showing Match Game View option](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image197.png)

To approximate a runtime UI, select the currently loaded UI Document (UXML) in the Hierarchy and check **Match Game View**. This sizes the Viewport to your project Reference Resolution. Remember that modifying this parameter does not affect the UI files themselves, only the visualization. From UI Builder you can also previsualize different themes used in your project, a feature that’s covered later in the guide.
