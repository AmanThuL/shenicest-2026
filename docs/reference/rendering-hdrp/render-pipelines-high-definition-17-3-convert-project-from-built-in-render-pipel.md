---
title: "Convert a project from the Built-in Render Pipeline to HDRP"
page_title: "Convert a project from the Built-in Render Pipeline | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-project-from-built-in-render-pipeline.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-project-from-built-in-render-pipeline.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Convert a project from the Built-in Render Pipeline

The High Definition Render Pipeline (HDRP) uses a new set of shaders and lighting units, both of which are incompatible with the [Built-in Render Pipeline](https://docs.unity3d.com/Manual/built-in-render-pipeline.html). To upgrade a Unity Project to HDRP, you must first convert all your materials and shaders, then adjust individual light settings accordingly.

| Topic | Description |
|----|----|
| [Convert post-processing scripts](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-post-processing-scripts.html) | Remove the Post-Processing Version 2 package from a project and update your scripts to work with HDRP's own implementation for post processing. |
| [Convert lighting and shadows](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-lighting-and-shadows.html) | Convert a project to physical Light units to control the intensity of Lights, instead of the arbitrary units the Built-in Render Pipeline uses. |
| [Convert materials and shaders](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-materials-and-shaders.html) | Upgrade the materials in your scene to HDRP-compatible materials, either automatically or manually. |
| [Convert project with HDRP wizard](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/convert-from-built-in-convert-project-with-hdrp-wizard.html) | Add the HDRP package to a Built-in Render Pipeline project and set up HDRP. |
