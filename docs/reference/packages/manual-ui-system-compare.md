---
title: "Comparison of UI systems in Unity"
page_title: "Unity - Manual: Comparison of UI systems in Unity"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UI-system-compare.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UI-system-compare.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Comparison of UI systems in Unity

This page provides a high-level feature comparison of [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIElements.html), [uGUI (Unity UI)](https://docs.unity3d.com/Packages/com.unity.ugui@latest), and [IMGUI](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-imgui.html), and their respective approaches to UI design.

## General consideration

The following table lists the recommended and alternative UI system for runtime and Editor:

| **Unity 6.3**                                                                                      | **Recommendation** | **Alternative** |
|:---------------------------------------------------------------------------------------------------|:-------------------|:----------------|
| **[Runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/UI-system-compare.html#runtime)** | uGUI (Unity UI)    | UI Toolkit      |
| **[Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/UI-system-compare.html#editor)**   | UI Toolkit         | IMGUI           |

## Roles and skill sets

Your team’s skill set and comfort level with different technologies is also an important consideration.

The following table lists the recommended system for different roles:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Roles</strong></th><th style="text-align: left;"><strong>UI Toolkit</strong></th><th style="text-align: left;"><strong>uGUI (Unity UI)</strong></th><th style="text-align: left;"><strong>IMGUI</strong></th><th style="text-align: left;"><strong>Skill sets</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Programmer</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td><td style="text-align: left;">Programmers can use any game development tool or API.</td></tr><tr class="even"><td style="text-align: left;"><strong>Technical Artist</strong></td><td style="text-align: left;">Partial</td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td><td style="text-align: left;">Technical artists who are familiar with Unity’s GameObject-based tools and workflows are likely to be comfortable working with GameObjects, Components, and the Scene view.<br />
<br />
They might not be comfortable with UI Toolkit’s web-like approach or IMGUI’s pure C# approach.</td></tr><tr class="odd"><td style="text-align: left;"><strong>UI Designer</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">Partial</td><td style="text-align: left;">❌</td><td style="text-align: left;">UI designers who are familiar with UI creation tools are likely to be comfortable with UI Toolkit’s document-based approach and can use the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/UIBuilder.html">UI Builder</a> to visually edit their UI.<br />
<br />
If they are not familiar with GameObject-based workflows, they might require help from programmers or level designers.</td></tr></tbody></table>

## Innovation and development

UI Toolkit is in active development and releases new features frequently. uGUI and IMGUI are established and production-proven UI systems that are updated infrequently.

uGUI and IMGUI might be better choices if you need features that are not yet available in UI Toolkit, or you need to support or reuse older UI content.

<span id="runtime"></span>

## Runtime

UI Toolkit is an alternative to uGUI (Unity UI) if you create a screen overlay UI that runs on a wide variety of screen resolutions. Consider UI Toolkit to do the following:

-   Produce work with a significant amount of user interfaces
-   Require familiar authoring workflows for artists and designers
-   Seek textureless UI rendering capabilities
-   UI positioned and lit in a 3D world
-   Advanced visuals with custom shaders and materials

uGUI is the recommended solution for the following:

-   Easy referencing from `MonoBehaviours`

### Use Cases

The following table summarizes which system is often used for major runtime use cases:

| **Unity 6.3**                                               | **Often used for** |
|:------------------------------------------------------------|:-------------------|
| **Multi-resolution menus and HUD in intensive UI projects** | UI Toolkit         |
| **World space UI and VR**                                   | UI Toolkit         |
| **UI that requires customized shaders and materials**       | UI Toolkit         |
| **UI that requires keyframed animations**                   | uGUI               |

### In details

The following table compares support for detailed runtime features across UI systems:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Unity 6.3</strong></th><th style="text-align: left;"><strong>UI Toolkit</strong></th><th style="text-align: left;"><strong>uGUI</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>WYSIWYG authoring</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Nesting reusable components</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong>Layout and Styling Debugger</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>In-scene authoring</strong></td><td style="text-align: left;">❌</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-rich-text-tags.html">Rich text tags</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Scalable text</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-fallback-font.html">Font fallbacks</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Adaptive layout</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.inputsystem.html">Input system</a> support</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Serialized events</strong></td><td style="text-align: left;">❌</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong>Compatible with <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/render-pipelines.html">Rendering pipelines</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Screen-space (2D) rendering</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/world-space-ui.html">World-space (3D) rendering</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/ui-shader-graph.html">Custom materials and shaders</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sprite-landing.html">Sprites</a> / <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/atlas/atlas-landing.html">Sprite atlas</a></strong>Graphics:** A utility that packs several sprite textures tightly together within a single texture known as an atlas. . <strong>2D:</strong> A texture that is composed of several smaller textures. Also referred to as a texture atlas, image sprite, sprite sheet or packed texture. .<br />
support**</td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Rectangle clipping</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong>Mask clipping</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong>Nested masking</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">✅</td></tr><tr class="odd"><td style="text-align: left;"><strong>Integration with Animation Clips and Timeline</strong></td><td style="text-align: left;">❌</td><td style="text-align: left;">✅</td></tr><tr class="even"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html">Data binding system</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Transitions.html">UI transition animations</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="even"><td style="text-align: left;"><strong>Textureless elements</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="odd"><td style="text-align: left;"><strong>Advanced flexible layout</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="even"><td style="text-align: left;"><strong>Global style management</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="odd"><td style="text-align: left;"><strong>Dynamic texture atlas</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="even"><td style="text-align: left;"><strong>UI anti-aliasing</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="odd"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/language-direction.html">Right-to-left language</a> and emoji</strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr><tr class="even"><td style="text-align: left;"><strong><a href="https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/work-with-vector-graphics.html">SVG support</a></strong></td><td style="text-align: left;">✅</td><td style="text-align: left;">❌</td></tr></tbody></table>

<span id="editor"></span>

## Editor

UI Toolkit is recommended if you create complex editor tools. It’s recommended for the following reasons:

-   Better reusability and decoupling
-   Visual tools for authoring UI
-   Better scalability for code maintenance and performance

IMGUI is an alternative to UI Toolkit for the following:

-   Unrestricted access to editor extensible capabilities
-   Light API to quickly render UI on screen

### Use Cases

The following table lists the recommended system for major Editor use cases:

| **Unity 6.3**                    | **Recommendation** |
|:---------------------------------|:-------------------|
| **Complex editor tool**          | UI Toolkit         |
| **Property drawers**             | UI Toolkit         |
| **Collaboration with designers** | UI Toolkit         |

### In details

The following table lists the recommended system for detailed Editor features:

| **Unity 6.3**                                                                                                                   | **UI Toolkit** | **IMGUI** |
|:--------------------------------------------------------------------------------------------------------------------------------|:---------------|:----------|
| **WYSIWYG authoring**                                                                                                           | ✅              | ❌         |
| **Nesting reusable components**                                                                                                 | ✅              | ❌         |
| **Global style management**                                                                                                     | ✅              | ✅         |
| **Layout and Styling Debugger**                                                                                                 | ✅              | ❌         |
| **Rich text tags**                                                                                                              | ✅              | ✅         |
| **Scalable text**                                                                                                               | ✅              | ❌         |
| **Font fallbacks**                                                                                                              | ✅              | ✅         |
| **Adaptive layout**                                                                                                             | ✅              | ✅         |
| **Default Inspectors**                                                                                                          | ✅              | ✅         |
| **Inspector: Edit custom object types**                                                                                         | ✅              | ✅         |
| **Inspector: Edit custom property types**                                                                                       | ✅              | ✅         |
| **Inspector: Mixed values (multi-editing) support**                                                                             | ✅              | ✅         |
| **[Array and list-view control](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-ListView.html)**          | ✅              | ✅         |
| **[Data binding: Serialized properties](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Binding.html)**                | ✅              | ✅         |
| **Advanced flexible layout**                                                                                                    | ✅              | ❌         |
| **[Right-to-left language](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/language-direction.html) and emoji** | ✅              | ❌         |
| **[SVG support](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/work-with-vector-graphics.html)**.              | ✅              | ❌         |

## Additional resources

-   [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIElements.html)
-   [uGUI (Unity UI)](https://docs.unity3d.com/Packages/com.unity.ugui@latest)
-   [IMGUI (Immediate Mode GUI)](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-imgui.html)
-   [Migrate from uGUI to UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Transitioning-From-UGUI.html)
-   [Migrate from IMGUI to UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-IMGUI-migration.html)
