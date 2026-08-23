---
title: "UI Toolkit BPG - Text"
page_title: "Unity - Manual: Text"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Text

Table of Contents

-   [Source font file](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#source-font-file)
-   [Font asset settings](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#font-asset-settings)
    -   [Font asset variant](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#font-asset-variant)
-   [Rich text](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#rich-text)
    -   [Gradients](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#gradients)
    -   [Sprite asset and emojis](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/text.html#sprite-asset-and-emojis)

UI Toolkit uses **TextCore**, a font rendering technology originally based on **TextMesh Pro** (which is used by the legacy UI system, uGUI (Unity UI)). TextCore offers advanced styling capabilities and can render text cleanly at various point sizes and resolutions. It takes advantage of [**Signed Distance Field**](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html) (SDF) font rendering, which can generate font assets that look crisp even when transformed and magnified. You can get the details of the different rendering modes for TextCore in the [documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html).

Let’s look at the different font asset types and what they are used for.

<span id="source-font-file"></span>

## Source font file

The most common font formats, **TTF** and **OTF** files, need to be converted into **font assets** before they can be used in your Unity project. A font asset is a Unity-specific resource that contains the data required to render a font including character glyphs, font metrics, and rendering configurations like size, weight, and style. The imported source file shows information on each font family and their rendering options.

![Many of these import options are remnants of the legacy text system in uGUI (Unity UI). There are plans to remove them in future releases. Rendering Mode, Character, and Include Font Data are used for generating the Font Asset.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image33.png)

To generate corresponding font assets, select the source font file and then right-click on the Assets menu and generate via **Create \> Text Core \> Font Asset \> SDF** (if SDF is your preferred rendering mode).

![Different UI systems use different font assets.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image1.png)

<span id="font-asset-settings"></span>

## Font asset settings

Once you have the source font file converted, select the font asset and you’ll find all of the options to give you full control over the font generation. Let’s look at some key options here (read more about font assets in the [documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html)):

-   **Face Info:** Spacing and scaling options for your font to adjust parameters that can better suit your application if the default source font required tweaks

-   **Generation Settings**: Essential configuration including the source font, the font face to use for the font asset in case the source font includes several styles, the atlas population mode, as well as the render modes

-   **Atlas and Material:** The material and texture generated; whether the atlas is static, dynamic, or has the rendering mode as bitmap or SDF; provides control of the size of atlas generated in the case of supporting languages with large character sets

-   **Font Weights:** Simulates different font weights when the source asset doesn’t have such variations

-   **Fallback Font Asset:** Provides for a fallback font in cases where the current Font asset lacks a character or glyph

-   **Character and Glyph Tables:** A detailed list of all the characters and glyphs included in the font asset

-   **Ligature table:** For adding a glyph to be used when two characters are together (improves readability and visual flow)

-   **Glyph Adjustments:** Defines overrides per character or glyph

![Source fonts and atlases can increase the build size: On the left is an atlas with ASCII characters and on the right is an atlas of a complete Unicode character set.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image244.png)

At the top of the Inspector, when selecting a font asset, you’ll find the [**Font Asset Creator**](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-creator-properties.html) under the **Update Atlas Texture** button. It gives you all the control to populate and define atlas properties.

💡 **Tip: Padding and atlas resolution**

Characters in the **Font Texture** need some padding between them (specified in pixels) so they can be rendered separately. Padding also creates room for the SDF gradient. The larger it is, the smoother the transition, which allows for high-quality rendering and effects like thick outlines.

If you are only using **ASCII** characters, an atlas resolution of `512 x 512` with a padding of 5 is sufficient for most fonts. Fonts with more characters might need larger resolutions or multiple atlases. As a general rule, aim for the padding size to be at a 1:10 ratio with the sampling size.

<span id="font-asset-variant"></span>

### Font asset variant

To make changes without employing a new font atlas, create a font asset variant via **Create \> Text Core \> Font Asset Variant.** This variant can hold an alternate version of the font’s line metrics.

The variant stores its own [Face Info](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset-properties.html) settings – think line height and subscript position – but still refers to the original atlas. As such, it can have its own styling, distinct from the original Font asset, without consuming extra space for textures.

<span id="rich-text"></span>

## Rich text

[Rich text tags](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-rich-text-tags.html) alter the appearance and layout of text through the use of supplemental tags in the text field. You can use rich text tags with both visual elements in code UI Builder. The tags enable text to be formatted at runtime, for example, to customize the appearance of a username.

Rich text tags can change the color or alignment of text without modifying its properties or styling. Use them to format the text in a dialogue system or visually reinforce what you want to communicate.

Go to **Extra Settings** to enable the rich text feature in UI Builder. Doing so will format your text (including tags) appropriately. For instance, text between the `<b>` and closing `</b>` tags will show up as bold.

![Enable rich text tags in UI Builder to make the tags modify your visual text properties.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image159.png)

Check out [this complete list](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-supported-tags.html) of available rich text tags and parameters.

<span id="gradients"></span>

### Gradients

[Gradients](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-color-gradient.html) add stylization throughout the interface; in UI Toolkit you can apply them via the `<gradient>` tag. Follow these steps to create a simple gradient:

![Example of creating and applying a gradient to text in UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image18.png)

1.  Create a gradient color asset via **Create > Text Core > Gradient Color**. Make sure to place this file inside **Assets/Resources** or any subfolder under Resources.

2.  Create a [Text Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-text-setting-asset.html) to refer to from the Panel Settings. In the asset look for Color Gradient Presets, and indicate the folder or subfolder inside Resources where the asset is.

3.  Add the following rich text tags inside UI Builder: `<color=white><gradient="testColorGradient">Gradient Test</gradient></color>`.

4.  The color tag restores the font color to white so the gradient looks as intended, while the referred gradient has to match the asset name created in step 1. Make sure **Rich Text** is enabled.

5.  You can see the changes take effect inside UI Builder or in the Game view.

<span id="sprite-asset-and-emojis"></span>

### Sprite asset and emojis

You can include sprites like emojis in your text via rich text tags. To use them, you’ll need to use a [Sprite asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-sprite.html) similar to the Gradient asset.

When importing multiple sprites, pack them into a single atlas to reduce draw calls. Make sure that the sprite atlas has a suitable resolution for your target platform. Return to the asset preparation section for more on sprite resolutions.

![A common example showing emojis or icons integrated into text strings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image130.png)

Follow these steps to import sprites for this purpose:

1.  Import the sprite or PSD file that contains the emojis or icons

2.  Slice the image into multiple sprites; if you use a PSD file as described in the [Graphic and font assets preparation section](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html) you won’t need to do this slicing. Generate the **Sprite Asset** from the file (select and then use the **Create > Text Core > Sprite Asset** menu). Make sure the asset is placed under Assets/Resources or a subfolder.

3.  You can adjust the Face Info and customize the appearance/names of each “glyph” in this new Sprite asset. Any changes here will replace the default Face Settings from the Font asset.

**Note**: In this context, **Update Sprite Asset** syncs the Sprite asset to the latest Sprite Editor changes.

To use this asset with UI Toolkit, you must follow the same step as you did with gradients:

1.  Select the **Panel Settings** from the **UI Document**.

2.  Open the **Text Settings** asset (or create one, if there’s none).

3.  Link to the **Sprite asset** using the file browser in the Text Settings file. Save and enter Play mode for the updated settings to take effect.

Use the rich text tag (`<sprite index=0>` or `<sprite name="name">`) to add the sprite. The embedded sprite will respect other text tags as well.

![Add a Sprite Asset to a text field in UI Toolkit using rich text tags: Make sure that the Enable Rich Text option is checked (top).](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image263.png)

💡 **Tip: Using emojis from the OS**

If you are targeting a specific runtime platform, such as iOS or Android, you can make use of the system’s built-in emoji font instead of including the source font in your project. This can save memory and eliminate the need to package a large collection of emojis with your application. They are also often a great fit for Global Fallbacks in Text Settings.

![Example of using OS emojis with Apple Emoji font](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image30.png)

These are the steps to use OS emojis in your project:

1.  Create a Font asset from the font that your target system uses. On iOS the font is called Apple Emoji (used in this example), and on Android it’s called Noto Color Emoji (currently only [COLRv0](https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf) is supported). Make sure the Font Asset is of the type **Color**, and then set the atlas population mode to **Dynamic OS** which doesn’t require you to include the source font in your asset, saving space.
2.  Ensure **Clean Dynamic Data On Build** is checked on the Font Asset.
3.  Enable **Parse Escape Sequences** on UI Builder and enter the desired emojis using the emoji keyboard from MacOS or Windows or in UTF format, for example, you would introduce a smiley as U0001F601. You can check the UTF of each emoji in the Character Table of the Font Asset.
4.  The build running on MacOS displays the emojis according to the OS font.
5.  We can observe that in our test, the **build size** is smaller than the standalone emoji font, proving that it was not included in the project but still being used to render the appropriate emojis.

### Text Style Sheets

If your application deals with a significant amount of text, you might want to consider creating a [text style sheet](https://docs.unity3d.com/Packages/com.unity.textmeshpro@4.0/manual/StyleSheets) to manage its formatting. This lets you create custom text styles with the `<style>` rich text tag. You can do this from the Create menu via **Assets \> Text Core \> Text Stylesheet**.

![A reusable Text Style Sheet](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image73.png)

Consider these benefits of text style sheets:

-   A custom style can include opening and closing rich text tags, plus leading and trailing text.

-   You can conveniently update a text style sheet, especially when compared to directly changing rich text formatting.

-   Custom styles can reduce the amount of rich text tags. You can just use one tag, `<style= name>`, that applies all the necessary styling.

-   This makes it easier to change one rich text tag in a text style sheet, and is less error prone than manually changing multiple `<style>` tags.
