---
title: "TextMesh Pro - 3D Text GameObjects"
page_title: "3D Text GameObjects | uGUI | 2.0.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 3D Text GameObjects

By default, a TextMesh Pro 3D Text GameObject has the following components:

-   **Rect Transform:** Controls the GameObject's position and size. For more information, see the [Rect Transform](https://docs.unity3d.com/Manual/class-RectTransform.html) documentation in the Unity Manual.

##### Note

**Note:** If you want to use the Rect Transform component's anchoring system, the TextMesh Pro component's parent GameObject must also have a Rect Transform component.

-   **Mesh Renderer:** Renders the GameObject. For more information, see the [Mesh Renderer](https://docs.unity3d.com/Manual/class-MeshRenderer.html) documentation in the Unity Manual.
-   **TextMesh Pro UGUI (Script):** Contains the text to display, and the properties that control its appearance and behavior. These properties are described [below](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#properties).
-   **Material:** A Unity material that uses one of the TextMesh Pro shaders to further control the text's appearance. For more information see the [Shaders](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Shaders.html) section.

## Properties Overview

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_3DInspector.png)

|       |                                                                                                                                                                                                                                                                               |
|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|       | **Text input**                                                                                                                                                                                                                                                                |
| **A** | **[Text](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#text):** Where you enter the text to display, along with any [rich text markup](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/RichText.html). |
|       | **Main settings**                                                                                                                                                                                                                                                             |
| **B** | **[Font](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#font):** Specifies the font to use, as well as basic font attributes (size, style, and so on).                                                                          |
| **C** | **[Color](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#color):** Defines the base color or [color gradient](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/ColorGradients.html) for the text         |
| **D** | **[Spacing](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#spacing):** Controls spacing between characters, words, lines and, paragraphs.                                                                                       |
| **E** | **[Alignment](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#alignment):** Controls horizontal and vertical text alignment.                                                                                                     |
| **F** | **[Wrapping and Overflow](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#wrapping):** Controls word wrapping and defines what happens when text doesn't fit inside its display area.                                            |
| **G** | **[UV Mapping](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#uv-mapping):** Controls how textures are mapped to the face and outline of the text.                                                                              |
| **H** | **[Extra Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObject3DText.html#extra-settings):** Additional options for controlling the appearance and behavior of text.                                                                    |

## Text Input

The text section is where you enter the text to display, and optionally customize it using [rich text markup](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/RichText.html).

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Text.png)

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Text</strong></td><td></td><td>The input field for text to display.</td></tr><tr class="even"><td><strong>Enable RTL Editor</strong></td><td></td><td>Enable this option to display text right-to-left instead of left-to-right.<br />
<br />
The Inspector displays an additional input field where you can view the reversed text and edit it directly.<br />
<br />
The text is reversed before it is displayed on screen or rendered.</td></tr></tbody></table>

## Main Settings

The Main Settings section contains the properties needed to define the basic appearance of text. You can further customize the look of text by changing or editing its [material](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Shaders.html).

### Font

The fonts settings panel is where you choose a font for your text, and customize the font style.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Font.png)

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Font Asset</strong></td><td></td><td>Choose a <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssets.html">font Asset</a> for the TextMesh Pro GameObject to use.<br />
<br />
TextMesh Pro ships with several font assets, and you can create others from standard font files such as truetype (ttf) fonts.<br />
<br />
<strong>Note:</strong> You can set the default font Asset for new text objects in the <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html">TextMesh Pro settings</a>.</td></tr><tr class="even"><td><strong>Material Preset</strong></td><td></td><td>Choose a material for your font.<br />
<br />
Each font Asset has a default material, but you can also create customized materials for it.<br />
<br />
This preset list includes all materials whose names contain the font Asset's name, and use the corresponding font atlas texture.</td></tr><tr class="odd"><td><strong>Font Style</strong></td><td></td><td>Enable standard text styling options.<br />
<br />
You can use these options in any combination, except for the casing options (lowercase, uppercase, and small caps), which are mutually exclusive.</td></tr><tr class="even"><td></td><td>B</td><td>Bold the text.<br />
<br />
The appearance of bold text is defined in the font Asset properties.</td></tr><tr class="odd"><td></td><td>I</td><td>Italicize the text.<br />
<br />
The appearance of italicized text is defined in the font Asset properties.</td></tr><tr class="even"><td></td><td>U</td><td>Underline the text.<br />
<br />
This renders an extra line below the baseline.</td></tr><tr class="odd"><td></td><td>S</td><td>Add a strikethrough line to the text.<br />
<br />
This renders an extra line above the baseline.</td></tr><tr class="even"><td></td><td>ab</td><td>Convert the text to lowercase before rendering.<br />
<br />
This does not change text casing in the <strong>Text</strong> field.</td></tr><tr class="odd"><td></td><td>AB</td><td>Convert the text to uppercase before rendering.<br />
<br />
This does not change text casing in the <strong>Text</strong> field.</td></tr><tr class="even"><td></td><td>SC</td><td>Use small caps.<br />
<br />
The text is displayed in all uppercase, but letters you actually entered in uppercase are larger.</td></tr><tr class="odd"><td><strong>Font Size</strong></td><td></td><td>Specify the text display size, in points.</td></tr><tr class="even"><td><strong>Auto Size</strong></td><td></td><td>Enable this option to set the font size automatically, based on the <strong>Auto Size Options</strong>.<br />
<br />
When this option is enabled, TextMesh Pro lays out the text multiple times to find a good fit. This is a resource intensive process, so avoid auto-sizing dynamic text that changes frequently.<br />
<br />
<strong>Tip:</strong> For static text, you can enable <strong>Auto Size</strong>, note the calculated font size (displayed in the Font Size field), then disable Auto Size and apply the calculated size manually.</td></tr><tr class="odd"><td><strong>Auto Size Options</strong></td><td></td><td>Define the basic rules for auto-sizing text.</td></tr><tr class="even"><td></td><td>Min</td><td>Specify the smallest acceptable font size, in points.</td></tr><tr class="odd"><td></td><td>Max</td><td>Specify the largest acceptable font size, in points.</td></tr><tr class="even"><td></td><td>WD%</td><td>Specify the maximum acceptable amount to reduce character width when sizing the text.<br />
<br />
TextMesh Pro squeezes characters to make them taller. This is usually only acceptable for digits.</td></tr><tr class="odd"><td></td><td>Line</td><td>Adjust the line height.<br />
<br />
This is useful for fitting a larger font into a given space.</td></tr></tbody></table>

### Color

TextMesh Pro uses vertex colors to tint the text. You can apply a uniform color as well a [gradient](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/ColorGradients.html) of up to four colors.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Color.png)

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Vertex Color</strong></td><td></td><td>Choose the main color for the text.<br />
<br />
Any colors and textures defined in the TextMesh Pro GameObject or its material ar multiplied with this color.</td></tr><tr class="even"><td><strong>Color Gradient</strong></td><td></td><td>Enable this option to apply a <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/ColorGradients.html">color gradient</a> to each character sprite.<br />
<br />
You can then set the gradient’s type and colors, or apply a <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/ColorGradientsPresets.html">color gradient preset</a>.<br />
<br />
Gradient colors are multiplied with the <strong>Vertex Color</strong>. If <strong>Vertex Color</strong> is set to white you see only the gradient colors. If it’s set to black you don’t see the gradient colors at all.</td></tr><tr class="odd"><td><strong>Color Preset</strong></td><td></td><td>Choose a <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/ColorGradientsPresets.html">color gradient preset</a>.<br />
<br />
When you apply a preset its <strong>Color Mode</strong> and <strong>Colors</strong> replace the text's local properties in the Inspector.<br />
<br />
Editing these properties modifies the preset, which affects every TextMesh Pro GameObject that uses it.<br />
<br />
Set this property to <strong>None</strong> to revert to the text’s local gradient properties.</td></tr><tr class="even"><td><strong>Color Mode</strong></td><td></td><td>Choose the type of color gradient to apply.<br />
<br />
TextMesh Pro applies gradients to each character individually.</td></tr><tr class="odd"><td></td><td>Single</td><td>A uniform color that modifies the base <strong>Vertex Color</strong>.</td></tr><tr class="even"><td></td><td>Horizontal Gradient</td><td>A two-color gradient with each color emanating from one side of the character.</td></tr><tr class="odd"><td></td><td>Vertical Gradient</td><td>A two-color gradient with one color emanating from the top of the character, and the other from the bottom.</td></tr><tr class="even"><td></td><td>Four Corners Gradient</td><td>A four-color gradient with each color emanating from a different corner of the character.</td></tr><tr class="odd"><td><strong>Colors</strong></td><td></td><td>Choose each gradient color.<br />
<br />
The number of available colors depends on the type of gradient, and the color fields are arranged to match the position of each color in the gradient (left and right, top and bottom, 2 rows of 2 for four-corner gradients).<br />
<br />
You can set the color in any of the following ways:<br />
<br />
<strong>Swatch:</strong> Click to open a color picker.<br />
<br />
<strong>Eyedropper:</strong> Click to choose a color from any part of the screen.<br />
<br />
<strong>Hex Value:</strong> Enter the RGBA hex value directly.</td></tr><tr class="even"><td><strong>Override Tags</strong></td><td></td><td>Enable this option to ignore any <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/RichText.html">rich text tags</a> that change text color.</td></tr></tbody></table>

### Spacing

These options control spacing between characters, words, lines and, paragraphs. You can use them to fine-tune the text for individual TextMesh Pro GameObjects, without adjusting their [font assets](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssets.html).

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Spacing.png)

To control spacing within a single TextMesh Pro GameObject, use [rich text tags](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/RichText.html).

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td>Character</td><td></td><td>Set the spacing between characters for this TextMesh Pro GameObject.</td></tr><tr class="even"><td>Word</td><td></td><td>Set the spacing between words for this TextMesh Pro GameObject.</td></tr><tr class="odd"><td>Line</td><td></td><td>Set the spacing between lines for this TextMesh Pro GameObject.</td></tr><tr class="even"><td>Paragraph</td><td></td><td>Set the spacing between paragraphs for this TextMesh Pro GameObject.<br />
<br />
Paragraphs are defined by explicit line breaks.</td></tr></tbody></table>

### Alignment

The horizontal and vertical alignment options control how text is placed in the display area.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Alignment.png)

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>[Horizontal Alignment Options]</strong></td><td></td><td></td></tr><tr class="even"><td></td><td>Left, Center, Right</td><td>Position the text horizontally in the display area, without changing the text itself.</td></tr><tr class="odd"><td></td><td>Justified, Flush</td><td>Stretch the text to fill the width of the display area by increasing the distance between words and characters.<br />
<br />
The <strong>Wrap Mix</strong> option controls the balance between word and character spacing.<br />
<br />
<strong>Justified</strong> mode does not stretch the last lines of paragraphs, while <strong>Flush</strong> mode does.</td></tr><tr class="even"><td></td><td>Geometry Center</td><td>Centers the text based on the mesh rather than the text metrics.<br />
<br />
The difference is not always noticeable, but in some cases this mode yields better looking results than regular Center alignment.</td></tr><tr class="odd"><td><strong>[Vertical Alignment Options]</strong></td><td></td><td></td></tr><tr class="even"><td></td><td>Top, Middle, Bottom</td><td>Position the text vertically in the display area, without changing the text itself.</td></tr><tr class="odd"><td></td><td>Baseline</td><td>Position the text so the baseline of the line is aligned with the middle of the display area.<br />
<br />
This is useful when working with a single line of text.</td></tr><tr class="even"><td></td><td>Midline</td><td>Use this as an alternative to Middle alignnment.<br />
<br />
This option determine vertical placement using the bounds of the text mesh, rather than <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssets.html#LineMetrics">line metrics</a>. This is useful in tight spaces when ascenders and descenders might otherwise extend too far.</td></tr><tr class="odd"><td></td><td>Capline</td><td>Position the text so the middle of the first the line is aligned with the middle of the display area.</td></tr><tr class="even"><td><strong>Wrap Mix (W &lt;-&gt; C)</strong></td><td></td><td>Adjust the balance between extra word spacing and extra character spacing when horizontal alignment is set to <strong>Justified</strong> or <strong>Flush</strong>.</td></tr></tbody></table>

### Wrapping and Overflow

Wrapping splits lines of text to ensure that they don't get wider than the display area. Lines are normally wrapped at word boundaries, but words that are longer than an entire line are split as well. Overflow controls what happens when the text doesn't fit inside the display area.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Wrapping.png)

Some overflow options supersede wrapping. For example, if Overflow is set to truncate, the text is truncated when it reaches the edge of the display area, irrespective of whether Wrapping is enabled.

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Wrapping</strong></td><td></td><td><strong>Enable</strong> or <strong>Disable</strong> word wrapping.</td></tr><tr class="even"><td><strong>Overflow</strong></td><td></td><td>Specify what happens when the text doesn't fit inside the display area.</td></tr><tr class="odd"><td></td><td>Overflow</td><td>Extends the text beyond the bounds of the display area, but still wraps it if <strong>Wrapping</strong> is enabled.</td></tr><tr class="even"><td></td><td>Ellipsis</td><td>Cuts off the text and inserts an ellipsis (…) to indicate that some of the text is omitted.</td></tr><tr class="odd"><td></td><td>Masking</td><td>Like <strong>Overflow</strong>, but the shader hides everything outside of the display area.</td></tr><tr class="even"><td></td><td>Truncate</td><td>Cuts off the text when it no longer fits.</td></tr><tr class="odd"><td></td><td>Scroll Rect</td><td>A legacy mode that’s similar to <strong>Masking</strong>. This option is available strictly for compatibility with older TextMesh Pro projects. For new projects, use Masking mode instead.</td></tr><tr class="even"><td></td><td>Page</td><td>Cuts the text into several pages that each fit inside the display area.<br />
<br />
You can choose which page to display. You can also use rich text to manually insert page breaks.<br />
<br />
<strong>Note:</strong> The vertical alignment options work on a per-page basis.</td></tr><tr class="odd"><td></td><td>Linked</td><td>Extends the text into another TextMesh Pro GameObject that you select.<br />
<br />
This is useful for creating multi-column text.</td></tr></tbody></table>

### UV Mapping

Some [TextMesh Pro shaders](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Shaders.html) allow you to apply one or more image textures to text. These options control how those textures stretch to fit the text.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_UVMapping.png)

You can also edit shader-specific texturing options in the shaders themselves. The available options depend on the shader you use.

When texturing text, make sure that your texture assets have their **Wrap Mode** set to **Repeat**. Otherwise the texture is likely to be heavily distorted when applied to the text. See the [Render Texture documentation](https://docs.unity3d.com/Manual/class-RenderTexture.html) in the Unity Manual for more information.

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Horizontal Mapping</strong></td><td></td><td>Specify how textures map to text horizontally when you use a shader that supports textures.</td></tr><tr class="even"><td></td><td>Character</td><td>Stretches the texture horizontally across each character's sprite.</td></tr><tr class="odd"><td></td><td>Line</td><td>Stretches the texture horizontally across the entire width of each line.</td></tr><tr class="even"><td></td><td>Paragraph</td><td>Stretches the texture horizontally across the entire text.</td></tr><tr class="odd"><td></td><td>Match Aspect</td><td>Scales the texture horizontally so it maintains its aspect ratio, and is not deformed.<br />
<br />
When you use this horizontal mapping mode, the <strong>Vertical Mapping</strong> setting determines how the texture is mapped to the text, and must be set to something other than <strong>Match Aspect</strong>.</td></tr><tr class="even"><td><strong>Vertical Mapping</strong></td><td></td><td>Specify how textures map to text vertically when you use a shader that supports textures.</td></tr><tr class="odd"><td></td><td>Character</td><td>Stretches the texture vertically across each character's sprite.</td></tr><tr class="even"><td></td><td>Line</td><td>Stretches the texture vertically across the entire width of each line.</td></tr><tr class="odd"><td></td><td>Paragraph</td><td>Stretches the texture vertically across the entire text.</td></tr><tr class="even"><td></td><td>Match Aspect</td><td>Scales the texture vertically so it maintains its aspect ratio, and is not deformed.<br />
<br />
When you use this vertical mapping mode, the <strong>Horizontal Mapping</strong> setting determines how the texture is mapped to the text, and must be set to something other than <strong>Match Aspect</strong>.</td></tr><tr class="odd"><td><strong>Line Offset</strong></td><td></td><td>When Horizontal Mapping is set to Line, <strong>Paragraph</strong>, or <strong>Match Aspect</strong>, set this value to add a horizontal texture offset to each successive line.<br />
<br />
This value is added to the <strong>Offset X</strong> value you specify in the shader.</td></tr></tbody></table>

### Extra Settings

This section contains assorted options for further controlling the appearance and behavior of text.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Object_Extra3D.png)

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Margins</strong></td><td></td><td>Set positive values to increase the distance between the text and the boundaries of the text container.<br />
<br />
Set negative values to make the text extend beyond the boundaries of the text container.<br />
<br />
You set the <strong>Left</strong>, <strong>Top</strong>, <strong>Right</strong>, and <strong>Bottom</strong> margins separately.<br />
<br />
You can also adjust the margins by dragging the handles of the text container Widget (yellow rectangle) in the Scene view.</td></tr><tr class="even"><td><strong>Sorting Layer</strong></td><td></td><td></td></tr><tr class="odd"><td><strong>Order in Layer</strong></td><td></td><td></td></tr><tr class="even"><td><strong>Geometry Sorting</strong></td><td></td><td>Each character is contained in a quad. <strong>Geometry Sorting</strong> controls how TextMesh Pro sorts these quads. This determines which character appears on top when two quads overlap.</td></tr><tr class="odd"><td></td><td>Normal</td><td>TextMesh Pro draws quads in the order that they appear in the mesh. When two quads overlap, the "later" quad appears on top of the "earlier" one.</td></tr><tr class="even"><td></td><td>Reverse</td><td>TextMesh Pro draws quads in reverse order. When two quads overlap, the "earlier" quad appears on top of the "later" one.</td></tr><tr class="odd"><td><strong>Othographic Mode</strong></td><td></td><td>Enable this option when creating camera-aligned text with an orthographic camera.<br />
<br />
It prevents the TextMesh Pro shader from using perspective correction.</td></tr><tr class="even"><td><strong>Rich Text</strong></td><td></td><td>Enable this option to turn off rich text support for the TextMesh Pro GameObject.<br />
<br />
When rich text support is disabled, tags are not parsed and are rendered as plain text.</td></tr><tr class="odd"><td><strong>Parse Escape Characters</strong></td><td></td><td>Enable this option to make TextMesh Pro interpret backslash-escaped characters as special characters.<br />
<br />
For example <code>\n</code> is interpreted as a newline, <code>\t</code> as a tab, and so on.<br />
<br />
<strong>Note:</strong> This applies to rendered text. In code, escaped characters are already parsed by the compiler.</td></tr><tr class="even"><td><strong>Visible Descender</strong></td><td></td><td>Use this option when using a script to slowly reveal text.<br />
<br />
Enable it to reveal the text at the bottom and move up as new lines are revealed.<br />
<br />
Disable it to reveal the text from top to bottom.<br />
<br />
To set up this type of text reveal, you must also set the vertical alignment to Bottom.</td></tr><tr class="odd"><td><strong>Sprite Asset</strong></td><td></td><td></td></tr><tr class="even"><td><strong>Kerning</strong></td><td></td><td>Enable this option to toggle kerning on for this TextMesh Pro GameObject.<br />
<br />
If new objects use a font with no kerning data, enabling this setting has no effect.</td></tr><tr class="odd"><td><strong>Extra Padding</strong></td><td></td><td>Enable this option to add extra padding to character sprites.<br />
<br />
TextMesh Pro creates sprites to fit the visible text, but the results isn't always perfect. This setting reduces the chances that glyphs are cut off at the boundaries of their sprites.</td></tr></tbody></table>
