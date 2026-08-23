---
title: "Get started with text"
page_title: "Unity - Manual: Get started with text"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-text.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-text.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with text

UI Toolkit uses TextCore to render text, a technology based on [TextMesh Pro](https://docs.unity3d.com/Manual/com.unity.textmeshpro.html). TextCore allows advanced styling capabilities and can render text clearly at various point sizes and resolutions. It takes advantage of [Signed Distance Field (SDF)](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html#sdf-fonts) font rendering, which can generate font assets that look crisp even when transformed and magnified.

This example demonstrates how to style text in UI Builder, create and apply static and dynamic font assets, use rich text tags and custom style sheets to style text, and create a UITK Text Settings asset to manage the text settings for a panel.

**Note**: For demonstration purposes, this guide uses a runtime UI. The instructions to create font assets and a style sheet also apply to the Editor UI. However, you can’t change the default UITK Text Settings for Editor UI in the current release.

## Prerequisites

This guide is for developers familiar with the Unity Editor, UI Toolkit, and C# scripting. Before you start, get familiar with the following:

-   [UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIBuilder.html)
-   [UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [Runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-runtime-ui.html)

## Create a UITK Text Settings asset

Start with a runtime UI and create a [UITK Text Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-text-setting-asset.html) that manages text settings for the panel. You also create a `Resources` folder and sub-folders to store font assets and custom style sheets.

1.  Follow the steps in [Get started with Runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html) to create a simple runtime UI.
2.  In the `Assets` folder, create a `Resources` folder.
3.  Right-click in the `Assets\UI Toolkit` folder, and select **Create** > **UI Toolkit** > **Text Settings** to create a `UITK Text Settings.asset`. The Inspector window for `UITK Text Settings.asset` shows the default path names for the font asset, Text Style Sheets asset, Sprite asset, and Color Gradient presets.
4.  In the `Resources` folder, create two folders named `Fonts & Materials` and `Text Style Sheets`.

<span id="style-text-with-ui-build"></span>

## Style text with UI Builder

Use UI Builder to style the Toggle text to be bold and italic, and have a font size of `12px`. For more information, see [Style text with USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-styling-ui-text.html).

1.  Double-click `SimpleRuntimeUi.uxml` to open it in UI Builder.
2.  In the Inspector window for the Toggle control, select **Text**.
3.  In the **Font Style** field, select **B** and **I**.
4.  In the **Size** field, enter **12**.

<span id="create-a-static-font-asset"></span>

## Create a static font asset

Create a [static font asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html#atlas-population-modes) and apply it to the Button control. For a static font asset, you don’t need to include the source font file in the build. However, you must generate atlas for all the characters in the Button’s display text. The display text is `This is a Button` and you will add a `*` in the text, so you generate atlas for `TBhinostua*`.

1.  Download the [Lato](https://fonts.google.com/download?family=Lato) font package from Google Fonts.

2.  Unzip the font package file and place `Lato-Regula.ttf` in your project’s `Assets` folder.

3.  In the Inspector window for the font file, confirm the following:

    -   **Include Font Data** is enabled.
    -   **Character** is set to **Dynamic**.

4.  In the Project window, right-click `Lato-Regula.ttf` and select **Create** > **Text Core** > **Font Asset** > **SDF**. This creates a dynamic font asset called `Lato-Regula SDF.asset`.

5.  In the Inspector window for `Lato-Regula SDF.asset`, set the **Atlas Population Mode** to **Static**.

6.  Click **Update Atlas Texture**.

7.  In the **Font Asset Creator** window, from the **Character Set** list, choose [**Custom Characters**](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-creator-properties.html#custom-characters).

8.  In the **Custom Characters List** box, enter `TBhinostua*`.

9.  Click **Generate Font Atlas**.

10. Save your changes.

11. Place `Lato-Regula SDF.asset` in the `Assets\Resources\Fonts & Materials` folder.

12. Double-click `SimpleRuntimeUi.uxml` to open it in UI Builder.

13. In the Inspector window for the Button control, select **Text** > **Font Asset** > **Lato-Regula SDF**.

<span id="create-a-dynamic-font-asset"></span>

## Create a dynamic font asset

Create a [dynamic font asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html#atlas-population-modes) and apply it to the TextField control. For a dynamic font asset, you must include the source font file in the build. Import the source font file directly to the path set for the font.

1.  Download the [Roboto](https://fonts.google.com/download?family=Roboto) font package from Google Fonts.

2.  Unzip the font package file and place `Roboto-Regular.ttf` in your project’s `Assets\Resources\Fonts & Materials` folder.

3.  In the Inspector window for the font file, confirm the following:

    -   **Include Font Data** is enabled
    -   **Character** is set to **Dynamic**

4.  Right-click `Roboto-Regular.ttf` and select **Create** > **Text Core** > **Font Asset** > **SDF**. This creates a dynamic font asset called `Roboto-Regular SDF.asset`.

5.  Double-click `SimpleRuntimeUi.uxml` to open it in UI Builder.

6.  In the TextField control’s Inspector window, select **Text** > **Font Asset** > **Roboto-Regular SDF**.

## Style with rich text tags

Use [rich text tags](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-rich-text-tags.html) to style text in the Label control.

**Note**: In the current release, rich text tags aren’t supported for [TextField](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html).

1.  Double-click `SimpleRuntimeUi.uxml` to open it in UI Builder.
2.  In the **Inspector** panel for the Label control, change **Text** to `This is a <font-weight=700><size=2em><color=#FF0000>*Label*</color></size></font-weight>`. This makes the word `Label` big, red, bold, and with an asterisk on either side of it.
3.  Make sure **Enable Rich Text** is selected.

The label text looks like the following in the Viewport window:

![Label text preview shows the word “Label” as big, red, and with an asterisk to either side.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/font/label-rich-text.png)

<span id="style-with-style-sheets"></span>

## Style with style sheets

To apply the same style for `Label` to `Button`, create a [custom style sheet](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-style-sheet.html), and apply the style to both words.

1.  Right-click in the `Assets\Resources\Text Style Sheets` folder and select **Create** > **Text Core** > **Text StyleSheet**. This creates a `Text StyleSheet.asset` in the path you set in the UITK Text Settings asset.

2.  In the Inspector window for `Text StyleSheet.asset`, do the following:

    -   In **Name**, enter `ExampleStyle`.
    -   In **Opening Tags**, enter `<font-weight=700><size=2em><color=#FF0000>*`.
    -   In **Closing Tags**, enter `*</color></size></font-weight>`.

3.  In the Inspector window for `UITK Text Settings.asset`, from the **Default Style Sheet** list, select **Text StyleSheet**.

4.  Double-click `SimpleRuntimeUi.uxml` to open it in UI Builder.

5.  In the Label control’s Inspector window, change **Text** to `<s>This is a <style="ExampleStyle">Label</style>`.

6.  Make sure **Enable Rich Text** is selected.

7.  In the Button control’s Inspector window, change **Text** to `<s>This is a <style="ExampleStyle">Button</style>`.

8.  Make sure **Enable Rich Text** is selected.

9.  Enter Play mode and check the text in the runtime UI.

10. In the text field, enter some random characters. For a dynamic font asset, the font atlas is dynamically generated as you enter text in the text field.

11. In your project’s `Assets\Resources\Fonts & Materials` folder, select `Roboto-Regular SDF.asset`.

12. In the Inspector window for `Roboto-Regular SDF.asset`, select **Update Atlas Texture** to open the **Font Asset Creator** window. If the atlas window is hidden, expand it. You should see the characters you entered in the atlas window.

![Newly entered characters appear in the font atlas window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/font/get-started-with-text.png)

## Additional resources

-   [Font Asset properties](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset-properties.html)
-   [Include sprites in text](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-sprite.html)
-   [Color gradients](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-color-gradient.html)
-   [Fallback font](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-fallback-font.html)
-   [Get started with runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html)
