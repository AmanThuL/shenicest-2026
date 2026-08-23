---
title: "TextMesh Pro - Font Asset Creator"
page_title: "Font Asset Creator | uGUI | 2.0.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsCreator.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsCreator.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

## Font Asset Creator

The Font Asset Creator converts [Unity font assets](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssets.html) into TextMesh Pro font assets. You can use it to create both Signed [Distance Field (SDF)](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsSDF.html) fonts and bitmap fonts.

When you create a new font Asset, TextMesh Pro generates the Asset itself, as well as the atlas texture and material for the font.

After you create a TextMesh Pro font Asset, you can delete the Unity font Asset you used as a source, although you may want to keep it in the Scene in case you need to regenerate the TextMesh Pro font Asset.

## Creating a font Asset

Before you start, make sure that you've already imported the font (usually a TrueType .ttf file) you want to use into the project. For more information about importing fonts into Unity, see the documentation on [Fonts](https://docs.unity3d.com/Manual/class-Font.html) in the Unity manual.

**To create a TextMesh Pro font Asset:**

1.  From the menu, choose: **Window > TextMesh Pro > Font Asset Creator** to open the Font Asset Creator.

2.  Choose a **Source Font File**. This the Unity font Asset that you want to convert into a TextMesh Pro font Asset.

3.  Adjust the **[Font Settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsCreator.html#FontAssetCreatorSettings)** as needed, then click **Generate Font Atlas** to create the atlas texture  
      
    The atlas, and information about the font Asset appear in the texture preview area.  
      
    IMAGE

4.  Continue adjusting the settings and regenerating the atlas until you're satisfied with the result.

5.  Click **Save** or **Save as...** to save the font Asset to your project.  
      
    You must save the Asset to a **Resources** folder to make it accessible to TextMesh Pro.

<span id="FontAssetCreatorSettings"></span>

## Font Asset Creator Settings:

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Property:</th><th></th><th>Function:</th></tr></thead><tbody><tr class="odd"><td><strong>Source Font File</strong></td><td></td><td>Select a font from which to generate a Text Mesh Pro font Asset.<br />
<br />
This font is not included in project builds, unless you use it elsewhere in the project, or put it in a Resources folder.<br />
<br />
You can use one of the default TextMesh Pro font assets, or <a href="https://docs.unity3d.com/Manual/class-Font.html">import your own</a>.</td></tr><tr class="even"><td><strong>Sampling Point Size</strong></td><td></td><td>Set the font size, in points, used to generate the font texture.</td></tr><tr class="odd"><td><strong>Auto Sizing</strong></td><td></td><td>Use the largest point size possible while still fitting all characters on the texture.<br />
<br />
This is the usual setting for SDF fonts.</td></tr><tr class="even"><td><strong>Custom Size</strong></td><td></td><td>Use a custom point size. Enter the desired size in the text box.<br />
<br />
Use this setting to achieve pixel-accurate control over bitmap-only fonts.</td></tr><tr class="odd"><td><strong>Padding</strong></td><td></td><td>Specify the space, in pixels, between characters in the font texture.<br />
<br />
Padding provides the space required to render character separately, and to generate the SDF gradient (See the documentation on <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsSDF.html">Font Assets</a> for details).<br />
<br />
The larger the padding, the smoother the transition, which allows for higher-quality rendering and larger effects, like thick outlines.<br />
<br />
A padding of 5 is often fine for a 512x512 texture.</td></tr><tr class="even"><td><strong>Packing Method</strong></td><td></td><td>Specify how to fit the characters into the font texture.</td></tr><tr class="odd"><td></td><td>Optimum</td><td>Finds the largest possible automatic font size that still fits all characters in the texture.<br />
<br />
Use this setting to generate the final font texture.</td></tr><tr class="even"><td></td><td>Fast</td><td>Computes character packing more quickly, but may use a smaller font size than Optimum mode.<br />
<br />
Use this setting when testing out font Asset creation settings.</td></tr><tr class="odd"><td><strong>Atlas Resolution</strong></td><td></td><td>Set the size width and height of the font texture, in pixels.<br />
<br />
A resolution of 512 x 512 is fine for most fonts, as long as you are only including ASCII characters. Fonts with more characters may require larger resolutions, or multiple atlases.<br />
<br />
When using an SDF font, a higher resolution produces finer gradients, and therefore higher quality text.</td></tr><tr class="even"><td><strong>Character Set</strong></td><td></td><td>The characters in a font file aren't included in the font Asset automatically. You have to specify which ones you need. You can select a predefined character set, provide a list of characters to include, or include all of the characters in an existing font Asset or text Asset.</td></tr><tr class="odd"><td></td><td>ASCII</td><td>Includes the visible characters in the ASCII character set.</td></tr><tr class="even"><td></td><td>Extended ASCII</td><td>Includes the visible characters in the extended ASCII character set.</td></tr><tr class="odd"><td></td><td>ASCII Lowercase</td><td>Includes only visible lower-case characters from the ASCII character set.</td></tr><tr class="even"><td></td><td>ASCII Uppercase</td><td>Includes only visible upper-case characters from the ASCII character set.</td></tr><tr class="odd"><td></td><td>Numbers + Symbols</td><td>Includes only the visible numbers and symbols from the ASCII character set.</td></tr><tr class="even"><td></td><td>Custom Range</td><td>Includes a range of characters that you define.<br />
<br />
Enter a sequence of decimal values, or ranges of values, to specify which characters to include.<br />
<br />
Use a hyphen to separate the first and last values of a range. Use commas to separate values and ranges (for example <code>32-126,160,8230</code>).<br />
<br />
You can also choose an existing font Asset to include the characters in that Asset.</td></tr><tr class="odd"><td></td><td>Unicode Range (Hex)</td><td>Includes a range of characters that you define.<br />
<br />
Enter a sequence of unicode hexadecimal values, or ranges of values, to specify which characters to include.<br />
<br />
Use a hyphen to separate the first and last values of a range. Use commas to separate values and ranges (for example <code>20-7E,A0,2026</code>).<br />
<br />
You can also choose an existing font Asset to include the characters in that Asset.</td></tr><tr class="even"><td></td><td>Custom Characters</td><td>Includes a range of characters that you define.<br />
<br />
Enter a sequence of characters to specify which characters to include.<br />
<br />
Enter characters one after the other, with no spaces or delimiting characters in between (for example <code>abc123*#%</code>).<br />
<br />
You can also choose an existing font Asset to include the characters in that Asset.</td></tr><tr class="odd"><td></td><td>Characters from File</td><td>Includes all the characters in a text Asset that you specify.<br />
<br />
Use this option when you want to save your character set.</td></tr><tr class="even"><td><strong>Font Style</strong></td><td></td><td>Apply basic font styling when creating a bitmap-only font Asset.<br />
<br />
For SDF fonts, you configure the styling in the shader rather than the font Asset.</td></tr><tr class="odd"><td></td><td>Normal</td><td>Generates characters with no styling.</td></tr><tr class="even"><td></td><td>Bold, Italic, Bold_Italic</td><td>Generates the font Asset with bold characters, italicized characters, or both.<br />
<br />
With these settings, you can set a strength value that applied to bolding and italicization</td></tr><tr class="odd"><td></td><td>Outline</td><td>Generates the font Asset with outline characters.</td></tr><tr class="even"><td></td><td>Bold_Sim</td><td>Generates the font Asset with a simulated bold.</td></tr><tr class="odd"><td><strong>Render Mode</strong></td><td></td><td>Specify the render mode to use when outputting the font atlas.</td></tr><tr class="even"><td></td><td>SMOOTH</td><td>Renders the atlas to an antialiased bitmap.</td></tr><tr class="odd"><td></td><td>RASTER</td><td>Renders the atlas to a non-antialiased bitmap.</td></tr><tr class="even"><td></td><td>SMOOTH_HINTED</td><td>Renders the atlas to an antialiased bitmap, and aligns character pixels with texture pixels for a crisper result.</td></tr><tr class="odd"><td></td><td>RASTER_HINTED</td><td>Renders the atlas to a non-antialiased bitmap and aligns character pixels with texture pixels for a crisper result.</td></tr><tr class="even"><td></td><td>SDF</td><td>Renders the atlas using a slower, but more accurate SDF generation mode, and no oversampling.</td></tr><tr class="odd"><td></td><td>SDFAA</td><td>Renders the atlas using a faster, but less accurate SDF generation mode. It produces font atlases that are sufficient for most situations.</td></tr><tr class="even"><td></td><td>SDFAA_HINTED</td><td>Renders the atlas using a faster, but less accurate SDF generation mode, and aligns character pixels with texture pixels for a crisper result.. It produces font atlases that are sufficient for most situations</td></tr><tr class="odd"><td></td><td>SDF8</td><td>Renders the atlas using a slower, but more accurate SDF generation mode, and 8x oversampling.</td></tr><tr class="even"><td></td><td>SDF16</td><td>Renders the atlas using a slower, but more accurate SDF generation mode, and 16x oversampling.</td></tr><tr class="odd"><td></td><td>SDF32</td><td>Renders the atlas using a slower, but more accurate SDF generation mode, and 32x oversampling. Use this setting for fonts with complex or small characters.</td></tr><tr class="even"><td><strong>Get Kerning Pairs</strong></td><td></td><td>Enable this option to copy the kerning data from the font.<br />
<br />
Kerning data is used to adjust the spacing between specific character pairs to produce a more visually pleasing result.<br />
<br />
<strong>Note:</strong> It isn't always possible to import kerning data. Some fonts store kerning pairs in their glyph positioning (GPOS) table, which is not supported by FreeType, the font engine used by TextMesh Pro. Other fonts do not store kerning pairs at all.</td></tr><tr class="odd"><td><strong>Generate Font Atlas</strong></td><td></td><td>Generate the font atlas texture.</td></tr><tr class="even"><td><strong>Save</strong></td><td></td><td>Save the current font atlas.</td></tr><tr class="odd"><td><strong>Save As</strong></td><td></td><td>Save the current font atlas as a new font Asset.</td></tr></tbody></table>

## Tips for creating font assets

Characters in the font texture need some padding between them so they can be rendered separately. This padding is specified in pixels. Padding also creates room for the SDF gradient. The larger the padding, the smoother the transition, which allows for higher-quality rendering and larger effects, like thick outlines. A padding of 5 is often fine for a 512x512 texture.

For most fonts, a 512x512 texture resolution is fine when including all ASCII characters. When you need to support thousands of character, you will have to use large textures. But even at maximum resolution, you might not be able to fit everything. In that case, you can split the characters by creating multiple font assets. Put the most often used characters in a main font Asset, and the others in a fallback font assets.
