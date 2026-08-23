---
title: "Theme Style Sheet (TSS)"
page_title: "Unity - Manual: Theme Style Sheet (TSS)"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-tss.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-tss.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Theme Style Sheet (TSS)

Theme Style Sheet (TSS) files are regular [USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html) files. UI Toolkit treats TSS as a distinct asset type and uses it for management purposes.

Regular USS syntax and format apply to TSS files, but usually, a theme file contains references to other USS files through the `@import` rule.

**Note**: USS files also support the `@import` rule.

## Create a TSS

You can create different TSS files for different themes and switch between them at runtime. Typically, you should use USS for styles. Consider TSS when you customize the look and feel for different platforms or devices, or when you use different fonts for different languages if your games or applications support multiple languages.

**Note**: When you add your first UIDocument to a GameObject in your project, it generates a default runtime theme asset at `Assets/UI Toolkit/UnityThemes/UnityDefaultTheme.tss`. Although you can create a TSS from scratch, to get all the default UI controls to work, you must import the default runtime theme, and then overwrite or add new styles to create your custom theme.

To create a new TSS:

1.  Create one or more USS files with your custom styles.

2.  Do one of the following:

    -   Select **Assets** > **Create** > **UI Toolkit** > **TSS Theme File** to create an empty theme file and [import the default theme](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-tss.html#inherit-a-theme).
    -   Select **Assets** > **Create** > **UI Toolkit** > **Default Runtime Theme File** to create a copy of the default runtime theme file. You can rename the file if you want.

3.  Import your style USS files to your theme.

## Preview a TSS

Your custom theme also appears in the theme list of the **Viewport** in UI Builder. To preview your theme, select it from the **Viewport**.

<span id="apply-a-tss"></span>

## Apply a TSS

You can [reference a TSS in UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-add-style-to-uxml.html) or [C#](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-apply-styles-with-csharp.html) the same way as you do with USS.

You can also set a TSS as the default theme for a [Panel Setting](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html) asset. If you have more than one Panel Setting, each one can use a different TSS file.

**Note**: If you set a TSS for a Panel Setting asset, it doesn’t make the TSS a global style for the whole project. You still need to reference the TSS in UXML or C#.

<span id="inherit-a-theme"></span>

## Import a theme

You can use the TSS asset’s Inspector window or the `@import` rule to import a theme.

**Note**: If you define the USS variables or styles in both the current TSS and the imported style sheet, the current TSS overrides the imported style sheet.

### Import a theme with the Inspector window

1.  Select the TSS asset.
2.  Go to the Inspector window > **Inherited Themes**.
3.  Select **+**. This adds a new reference field.
4.  Select the list icon in the reference field. A dropdown list displays with all the style sheets in your project.
5.  Select the style sheet to use.
6.  Select **Apply**.

### Import the default theme with the `@import` rule

To import the default Unity runtime theme, you must use the following syntax:

``` lang-css
@import url("unity-theme://default");
```

**Note**: This URL in this syntax is a special case and it refers the built-in default theme inside the engine. You can’t use this syntax for any other themes.

### Import other themes with the `@import` rule

To import a theme other than the default theme, or a USS file, use the following syntax:

``` lang-css
@import url("<path-to-file>/<file-name-with-extension>");
```

You can use a relative or an absolute path:

-   Absolute paths start from the project’s `Assets` folder and begin with a `/` or `project://database/`. For example, `/Assets/myFolder/myFile.uss` or `project://database/Assets/myFolder/myFile.uss`.
-   Relative paths start from the current file and exclude the `/`. For example, `../myFolder/myFile.uss`.

**Note**: To reference a file from packages, use the absolute path of the package file that starts from the `Packages` folder. For example, `/Packages/com.unity.package.name/file-name.uss` or `project://database/Packages/com.unity.package.name/file-name.uss`. you must use the format of `com.unity.package.name` rather than `package name` for the package name.

## Additional resources

-   [Introduction to USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-about-uss.html)
-   [Apply styles with C#](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-apply-styles-with-csharp.html)
-   [Add styles to UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-add-style-to-uxml.html)
