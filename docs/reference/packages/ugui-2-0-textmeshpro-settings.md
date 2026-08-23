---
title: "TextMesh Pro - Settings"
page_title: "Settings | uGUI | 2.0.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Settings

TextMesh Pro’s project-wide settings are stored in a special Asset named TMP Settings. This Asset must be stored in a Resources folder. By default it’s in the `Assets/TextMesh` Pro folder.

To edit the settings, either select the Asset in the Project View or open the **Project Settings** window and choose **TextMesh Pro** from the category list.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_Inspector.png)  
*TextMesh Pro Settings*

The Settings are divided into the following groups:

| Group: | Function:                                                                                                                                                                                                                                                                      |
|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **A**  | **[Default Font Asset](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#default-font-asset):** Set the default font for text objects.                                                                                                     |
| **B**  | **[Fallback Font Assets](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#fallback-font-assets):** Choose font assets to search when TexMesh Pro can’t find a character in a text object’s main font Asset.                               |
| **C**  | **[Fallback Material Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#fallback-material-settings):** Set style options for characters retrieved from fallback fonts.                                                            |
| **D**  | **[Dynamic Font System Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#dynamic-font-system-settings):** Set options for handling missing characters.                                                                           |
| **E**  | **[Text Container Default Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#text-container-default-settings):** Control the size of the text container for new text objects.                                                     |
| **F**  | **[Text Component Default Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#text-component-default-settings):** Set the basic text formatting options for new text objects.                                                      |
| **G**  | **[Default Sprite Asset](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#default-sprite-asset):** Choose a default Sprite Asset to use for for rich text sprite tags that do not specify an Asset, and set other sprite-related options. |
| **H**  | **[Default Style Sheet](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#default-style-sheet):** Choose a default style sheet.                                                                                                            |
| **I**  | **[Color Gradient Presets](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#color-gradient-presets):** Choose a location to store color gradient presets.                                                                                 |
| **J**  | **[Line Breaking for Asian Languages](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html#line-breaking-for-asian-languages):** Define leading and following characters in order to get proper line breaking when using Asian fonts.         |

## Default Font Asset

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_DefaultFontAsset.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Default Font Asset</strong></td><td>Specify the default font used when you create a new text object.</td></tr><tr class="even"><td><strong>Path</strong></td><td>Specify where to store font assets.<br />
<br />
The <strong>Path</strong> must point to a subfolder of a Resources folder.</td></tr></tbody></table>

## Fallback Font Assets

When a text object contains a character that is not in its font Asset, TextMesh Pro searches these font assets for the glyph. If the object’s font assets has a local fallback font list, TextMesh Pro searches the fonts in that list first.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_FallbackFontAssets.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Fallback Font Assets List</strong></td><td>Manage the global fallback font assets.<br />
<br />
Click <strong>+</strong> and <strong>-</strong> to add and remove font slots.<br />
<br />
Click the circle icon next to a font to choose a font Asset using the Object Picker.<br />
<br />
Drag the handles on the left side of any font Asset to reorder the list.</td></tr></tbody></table>

## Fallback Material Settings

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_FallbackMaterialSettings.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Match Material Presets</strong></td><td>Enable this setting to make glyphs from the fallback font match the style of the main font.<br />
<br />
When TextMesh Pro uses a glyph from a fallback font, it creates a material with the same settings as the main font’s material.<br />
<br />
This looks best when the main font and the fallback font are similar.</td></tr></tbody></table>

## Dynamic Font System Settings

These are project-wide settings for handling missing glyphs.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_DynamicFontSystemSettings.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Get Font Features at Runtime</strong></td><td></td></tr><tr class="even"><td><strong>Replacement</strong></td><td>Specify the ID of the character to use when TextMesh Pro cannot find a missing glyph in any of the fallback fonts.<br />
<br />
The default value of 0 produces the outline of a square.</td></tr><tr class="odd"><td><strong>Disable Warnings</strong></td><td>Enable this setting to prevent Unity from logging a warning for every missing glyph.</td></tr></tbody></table>

## Text Container Default Settings

These settings define the default size for text containers in new text objects.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_TextContainerDefaultSettings.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>TextMeshPro</strong></td><td>Set the default size of text containers for new TextMesh Pro 3D GameObjects, in Unity units.</td></tr><tr class="even"><td><strong>TextMeshPro UI</strong></td><td>Set the default size of text containers for new TextMesh Pro UI GameObjects, in Unity units.</td></tr><tr class="odd"><td><strong>Enable Raycast Target</strong></td><td>Enable this option to make TextMesh Pro GameObjects targets for raycasting by default.<br />
<br />
When you disable this option, the UI ignores TextMesh Pro GameObjects by default when determining what the cursor interacts with.</td></tr><tr class="even"><td><strong>Auto Size Text Container</strong></td><td>Enable this option to automatically size text containers to fit the text when creating new TextMesh Pro UI GameObjects.</td></tr></tbody></table>

## Text Component Default Settings

These settings define default values for new text objects. After adding a text object to the Scene, you can adjust these settings in the object's TextMesh Pro Inspector.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_TextComponentDefaultSettings.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Default Font Size</strong></td><td>Set the default font size, in points.</td></tr><tr class="even"><td><strong>Text Auto Size Ratios</strong></td><td>Set the default <strong>Min</strong> to <strong>Max</strong> size ratio TextMesh Pro uses when it <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObjectUIText.html#font">sets font size automatically</a>.</td></tr><tr class="odd"><td><strong>Word Wrapping</strong></td><td>Enable this option to turn word wrapping on for all new text objects.</td></tr><tr class="even"><td><strong>Kerning</strong></td><td>Enable this option to toggle kerning on for all new text objects.<br />
<br />
If new objects use a font with no kerning data, enabling this setting has no effect.</td></tr><tr class="odd"><td><strong>Extra Padding</strong></td><td>Enable this option to add extra padding to character sprites.<br />
<br />
TextMesh Pro creates sprites to fit the visible text, but the results aren't always perfect. This setting reduces the chances that glyphs are cut off at the boundaries of their sprites.</td></tr><tr class="even"><td><strong>Tint All Sprites</strong></td><td>By default, sprites aren't affected by the text's vertex colors. Enable Tint All Sprites changes this.</td></tr><tr class="odd"><td><strong>Parse Escape Sequence</strong></td><td>Enable this option to make TextMesh Pro interpret backslash-escaped characters as special characters.<br />
<br />
For example <code>\n</code> is interpreted as a newline, <code>\t</code> as a tab, and so on.<br />
<br />
<strong>Note:</strong> This applies to rendered text. In code, escaped characters are already parsed by the compiler.</td></tr></tbody></table>

## Default Sprite Asset

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_DefaultSpriteAsset.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Default Sprite Asset</strong></td><td>Choose the <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Sprites.html">Sprite Asset</a> for TextMesh Pro GameObjects to use by default.</td></tr><tr class="even"><td><strong>IOS Emoji Support</strong></td><td>Toggle support for iOS emoji.</td></tr><tr class="odd"><td><strong>Path</strong></td><td>Specify where to store Sprite Assets.<br />
<br />
The <strong>Path</strong> must point to a subfolder of a Resources folder.</td></tr></tbody></table>

## Default Style Sheet

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_DefaultStyleSheet.png)

| Property:               | Function:                                                                                                                                                                                |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Default Style Sheet** | You can choose a single [style sheet](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/StyleSheets.html) Asset, which is used by all text objects in the project. |

## Color Gradient Presets

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_ColorGradientPresets.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Property:</th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Path</strong></td><td>Specify where to store Sprite Assets.<br />
<br />
The <strong>Path</strong> must point to a subfolder of a Resources folder.</td></tr></tbody></table>

## Line Breaking for Asian Languages

To obtain correct line-breaking behavior for Asian languages, you must specify which characters behave as leading and following characters. This is done via two text assets.

![Example image](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/images/TMP_Settings_LineBreakingforAsianLanguages.png)

| Property:                | Function:                                                             |
|--------------------------|-----------------------------------------------------------------------|
| **Leading Characters**   | Specify the text file that contains the list of leading characters.   |
| **Following Characters** | Specify the text file that contains the list of following characters. |
