---
title: "Introduction to importing assets"
page_title: "Unity - Manual: Introduction to importing assets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to importing assets

When you create a Unity project, Unity creates a folder for your project which contains an `Assets` subfolder. You can use this folder to store assets created outside of Unity to then use in your project.

**Important:** Using cloud-based storage methods to store your project is an unsupported workflow. It can cause synchronization issues which corrupt your project. Use [version control](https://docs.unity3d.com/6000.3/Documentation/Manual/VersionControl.html) to manage your project.

## Using the Assets folder

You can either export the asset file directly into the `Assets` folder, or copy it into the folder. For many common formats, you can save the source file directly into your project’s `Assets` folder and Unity can read it. Unity also detects when you save new changes to the file and re-imports files as necessary.

For a list of supported asset types, refer to [Supported asset type reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-supported-types.html).

### Managing assets in the Project window

Use the [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html) to view the contents of your `Assets` folder. Whenever you save or copy a file to your `Assets` folder, Unity imports it and it then appears in your Project window. If you drag a file from your computer’s file browser into Unity’s Project window, Unity makes a copy and places it into your `Assets` folder. You can then access this copy from the Project window.

**Warning:** Usually, the items that appear in your Project window represent actual files on your computer. If you delete them in the Project window, you also delete them from your computer.

![The Project window with the Assets folder opened, containing food related models.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/importing-project-window.png)

### Modifying asset files

When you modify a file in Unity, Unity doesn’t modify your original source file. Instead, the import process reads your source file, and creates a representation of your asset internally, which matches your chosen [import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html#asset-import-settings). If you modify the import settings for an asset, or make a change to the source file in the `Assets` folder, Unity re-imports the asset again to reflect your changes.

If you want to move or rename assets in your project, it’s best practice to do it in the Project window. Unity then automatically moves or renames the asset’s corresponding `.meta` file. For more information on .meta files, refer to [Asset metadata](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html).

If you drag a file from your computer’s file browser into Unity’s Project window, Unity makes a copy and places it into your `Assets` folder. You can then access this copy from the Project window.

### Complex assets

If you import a single asset file that contains complex information, Unity might create multiple assets from it. For example:

-   If a 3D file (such as an FBX file) defines materials or contains embedded textures, Unity extracts the [materials and embedded textures](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html) as separate assets.
-   If you want to import an image file as multiple 2D sprites. Use the 2D Sprite Editor to define multiple sprites from a single graphic image and Unity displays each sprite as a separate sprite asset in the Project window. For more information, refer to [Create sprites from a texture](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sprite-editor/use-editor.html).
-   If a 3D file contains multiple animation timelines or multiple clips, Unity automatically defines separate animation timelines or clips based on its [animation import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/Splittinganimations.html). The resulting multiple animation clips appear as separate Animation Clip assets in the Project window.

<span id="asset-processing"></span>

## Asset processing

Unity reads and processes any files that you add to the `Assets` folder and converts the contents of the file to internal data that’s correctly formatted for your application’s target platform. The source asset files remain unchanged, and Unity stores the internal data in the project’s `Library` folder. This data is part of Unity’s [Asset Database](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetDatabase.html).

Unity uses internal formats for assets so it can use versions of your assets at runtime in the Unity Editor, and can keep your unmodified source files in the `Assets` folder. This system means that you can edit an asset file and the Editor picks up the changes automatically. For example, hardware such as mobile devices can’t convert `.psd` files directly to render them as textures. When you place a `.psd` file in the `Assets` folder, Unity converts the file to an internal version that mobile devices can process.

Unity stores the internal representation of your assets in the `Library` folder, which behaves like a cache folder. You don’t need to ever alter the `Library` folder manually, and if you do, you might negatively affect your project. This also means that you don’t need to include the `Library` folder under version control.

**Tip:** If your project isn’t open, you can safely delete the `Library` folder, because Unity can regenerate all its data from the `Assets` and `ProjectSettings` folders the next time you launch your project.

<span id="asset-import-settings"></span>

## Asset import settings

Each type of asset that Unity supports has a set of import settings, which affect how the asset appears or behaves. To view an asset’s import settings, select the asset in the Project window. The import settings for the selected asset appear in the Inspector. The options that appear vary depending on the type of asset selected.

![A selected model’s Inspector window with its Import Settings displayed.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/importing-model-import-settings.png)

For more information, refer to the documentation on the following Import Settings:

-   [Model Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-FBXImporter.html)
-   [SketchUp Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SketchUpImporter.html)
-   [SpeedTree Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SpeedTreeImporter.html)
-   [Texture Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html)
-   [Cubemap texture Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-type-cubemap.html)
-   [Animation Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html)
-   [Assembly Definition Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html)
-   [Audio Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html)

If you’re developing a cross-platform project, you can override the default settings and assign different import settings on a per-platform basis.

## Reusing assets between projects

As you build your application, [Unity stores metadata](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html) about your assets, such as import settings and links to other assets, among other information. If you want to transfer your assets into a different project and preserve all this information, you can export your assets into one of the following containers:

-   An [asset package](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetPackages.html), which you can create directly in the Editor.
-   A [custom package](https://docs.unity3d.com/6000.3/Documentation/Manual/CustomPackages.html), which you can access and manage inside the <span class="notooltips">[Package Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/Packages.html)</span>.

## Additional resources

-   [Asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetPackages.html)
-   [Materials and shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/Materials.html)
-   [Textures and videos](https://docs.unity3d.com/6000.3/Documentation/Manual/Textures.html)
-   [Import a sprite or spritesheet texture](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/import-images-sprites/import-images-sprites-landing.html)
-   [Audio files](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioFiles.html)
