---
title: "Linear or gamma workflow"
page_title: "Unity - Manual: Set a project's color space"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LinearRendering-LinearOrGammaWorkflow.html"
final_url: "https://docs.unity3d.com:443/6000.3/Documentation/Manual/set-project-color-space.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set a project’s color space

The Unity Editor offers both linear and gamma workflows. The linear workflow has a color space crossover where [Textures](https://docs.unity3d.com/6000.3/Documentation/Manual/Textures.html) that were authored in gamma color space can be correctly and precisely rendered in linear color space. See documentation on [Linear rendering overview](https://docs.unity3d.com/6000.3/Documentation/Manual/color-spaces-landing.html) for more information about gamma and linear color space.

Textures tend to be saved in gamma color space, while Shaders expect linear color space. As such, when Textures are sampled in Shaders, the gamma-based values lead to inaccurate results. To overcome this, you can set Unity to use an sRGB sampler to cross over from gamma to linear sampling. This ensures a linear workflow with all inputs and outputs of a Shader in the correct color space, resulting in a correct outcome.

## Select the color space

Select the color space for your project with the following steps:

1.  Go to **Edit** > **Project Settings**, then select the **Player** category.
2.  Navigate to the **Other Settings**, open the **Rendering** section, and set the **Color Space** property to **Linear** or **Gamma**, depending on your preference.
