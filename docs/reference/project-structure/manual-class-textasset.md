---
title: "Text assets"
page_title: "Unity - Manual: Text assets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextAsset.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextAsset.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Text assets

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TextAsset.html" class="switch-link gray-btn sbtn left" title="Go to TextAsset page in the Scripting Reference">Switch to Scripting</a>

Text assets are a format for imported text files. When you drop a text file into your `Project` folder, Unity converts it to a Text Asset. The supported text formats are:

-   `.bytes`
-   `.csv`
-   `.fnt`
-   `.htm`
-   `.html`
-   `.json`
-   `.md`
-   `.txt`
-   `.xml`
-   `.yaml`

**Note:** When you use [`AssetDatabase.FindAssets`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html) with the `t:TextAsset` filter, script files are also considered a text asset, and are included in the results.

If you select a text asset in the Project window, the [Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html) displays the text content of the file.

## Using text assets

Text assets are useful for getting text from different text files into your application while you’re building it. For example, you can use it to add a `.txt` file to your project to bring the text into your application. If you’re making a text-heavy adventure game, you can put the text for each scene separate `.txt` files and reference the text asset when a character enters the scene.

However, text assets aren’t intended for text file generation at runtime. For that you need to use input/output programming techniques to read and write external files. For more information on the ways you can generate text in Unity, refer to [UI systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIToolkits.html).

### Binary data

Text assets can also store binary data. If you create a file with the `.bytes` extension, you can load it as a text asset and access it through the `bytes` property.

For example, put a `.jpeg` file into the `Resources` folder and change the extension to `.bytes`, then use the following script code to read the data at runtime:

``` lang-cs
//Load texture from disk
TextAsset bindata = Resources.Load("Texture") as TextAsset;
Texture2D tex = new Texture2D(1,1);
tex.LoadImage(bindata.bytes); 
```

Unity treats files with the `.txt` and `.bytes` extension as text and binary files, respectively. Don’t attempt to store a binary file using the `.txt` extension, because it creates unexpected behavior when attempting to read data from it.

## Additional resources

-   [UI systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIToolkits.html)
-   [Supported asset type reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-supported-types.html)
