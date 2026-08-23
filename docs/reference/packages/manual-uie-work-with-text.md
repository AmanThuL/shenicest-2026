---
title: "Work with text (UI Toolkit)"
page_title: "Unity - Manual: Work with text"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-work-with-text.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-work-with-text.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Work with text

Text objects are defined by the following attributes of a UI control:

-   The `text` attribute of some UI controls, such as [Label](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Label.html) or [TextElement](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextElement.html), that sets the display text.
-   The `value` attribute of the [TextField](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html) that accepts the input text, and the `label` attribute that sets the display text for [TextField](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html).

You can use [USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html) [text properties](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-SupportedProperties.html#unity-text) to style text, such as set the font size and color, etc.

You can also add a new font to style text. Convert fonts to font assets before you use them in your project. In addition to USS styling, you can use rich text tags to style certain words in a text string.

| **Topic**                                                                                                                         | **Description**                                                                                                   |
|:----------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
| [Get started with text](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-text.html)                      | Learn how to style text, create fonts, and style with rich text tags and style sheets by examples.                |
| [Advanced Text Generator](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-advanced-text-generator.html)                  | Add comprehensive Unicode support and text shaping capabilities to your project.                                  |
| [Style text with USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-styling-ui-text.html)                              | Style text with USS text properties inline in UXML, a USS file, or directly in UI Builder.                        |
| [Style text with rich text tags](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-rich-text-tags.html)                    | Style words between tags in a text string.                                                                        |
| [Font assets](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset-landing.html)                                   | Understand different font assets and all their properties.                                                        |
| [Text effects](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-text-effects.html)                                        | Apply text effects to text elements to enhance the visual appearance of the text.                                 |
| [Style sheet assets](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-style-sheet.html)                                   | Create custom text styles to extend the rich text tags.                                                           |
| [Use sprites in text](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-sprite-text.html)                                  | Create sprite assets to interpret emoji characters and include them in text.                                      |
| [Color gradients](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-color-gradient.html)                                   | Create color gradients to apply up to four colors for each character in a text string.                            |
| [Color emojis](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-color-emojis.html)                                        | Include color glyphs and emojis in text.                                                                          |
| [Language direction](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/language-direction.html)                     | Set the text directionality of a text element to support right-to-left (RTL) languages.                           |
| [UITK Text Settings assets](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-text-setting-asset.html)                     | Referenced by a Panel Settings asset and controls the default values for all text objects used within that Panel. |
| [Fallback font](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-fallback-font.html)                                      | Add fallback font for missing character in a font asset.                                                          |
| [Create custom text animation](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/create-custom-text-animation.html) | Use the `TextElement.PostProcessTextVertices` API to create custom text animation                                 |

## Additional resources

-   [MeshGenerationContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.MeshGenerationContext.html)
-   [UI Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ui-renderer.html)
-   <span aria-hidden="true">📖</span> **E-Book**: [UI Toolkit for advanced Unity developers - Graphic and font assets preparation](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html)
-   <span aria-hidden="true">📖</span> **E-Book**: [UI Toolkit for advanced Unity developers - Text](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html)
