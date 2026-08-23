---
title: "TextMesh Pro - The Fallback Chain"
page_title: "Fallback font assets | uGUI | 2.0.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsFallback.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsFallback.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Fallback font assets

A font atlas, and by extension a font Asset, can only contain a certain number of glyphs. The exact number depends on the font, the size of the atlas texture, and the settings you use when generating the atlas. The fallback font system allows you to specify other font assets to search when TextMesh Pro can't find a glyph in a text object's font Asset.

This is useful in a variety of situations, including:

-   Working with languages that have very large alphabets (Chinese, Korean, and Japanese, for example). Use fallback fonts to distribute an alphabet across several assets.

-   Designing for mobile devices, where an imposed maximum texture size prevents you from fitting an entire set of glyphs in a single atlas of sufficient quality.

-   Including special characters from other alphabets in your text.

## Local and general fallback font assets

Every font Asset can have its own list of fallback font assets. You set these in the [font Asset properties](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsProperties.html).

You can also set general fallback font assets that apply to every TextMesh Pro font Asset in your project. You set these in the [TextMesh Pro settings](https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html).

## The fallback chain

In addition to a text object's fallback fonts, TextMesh Pro searches several other assets for missing glyphs. Together, these assets form the fallback chain.

The table below lists the assets in the fallback chain in the order in which they are searched.

<table><colgroup><col style="width: 25%" /><col style="width: 25%" /><col style="width: 25%" /><col style="width: 25%" /></colgroup><thead><tr class="header"><th style="text-align: center;">Position:</th><th>Asset:</th><th>Defined in:</th><th>Notes:</th></tr></thead><tbody><tr class="odd"><td style="text-align: center;">1</td><td>TextMesh Pro object's primary <strong>Font Asset</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObjects.html">Text object properties</a></td><td></td></tr><tr class="even"><td style="text-align: center;">2</td><td>Primary font assets <strong>Fallback Font Assets</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsProperties.html">Font Asset properties</a></td><td>TexMesh Pro searches these assets in the order they're listed in the <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsProperties.html">font Asset properties</a>.<br />
<br />
The search is recursive, and includes each fallback Asset's fallback assets.</td></tr><tr class="odd"><td style="text-align: center;">3</td><td>Text object's <strong>Sprite Asset</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObjects.html">Text object properties</a></td><td>When searching sprite assets, TextMesh Pro looks for sprites with an assigned unicode value that matches the missing character's unicode value.</td></tr><tr class="even"><td style="text-align: center;">4</td><td>General <strong>Fallback Font Assets</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html">TextMesh Pro settings</a></td><td>TexMesh Pro searches these assets in the order they're listed in the <a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/FontAssetsProperties.html">font Asset properties</a>.<br />
<br />
The search is recursive, and includes each fallback Asset's fallback assets.</td></tr><tr class="odd"><td style="text-align: center;">5</td><td><strong>Default Sprite Asset</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html">TextMesh Pro settings</a></td><td>When searching sprite assets, TextMesh Pro looks for sprites with an assigned unicode value that matches the missing character's unicode value.</td></tr><tr class="even"><td style="text-align: center;">6</td><td><strong>Default Font Asset</strong></td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html">TextMesh Pro settings</a></td><td></td></tr><tr class="odd"><td style="text-align: center;">7</td><td><strong>Missing glyphs</strong> character</td><td><a href="https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/Settings.html">TextMesh Pro settings</a></td><td></td></tr></tbody></table>

The fallback chain search is designed to detect circular references so each Asset in the chain is only searched once.
