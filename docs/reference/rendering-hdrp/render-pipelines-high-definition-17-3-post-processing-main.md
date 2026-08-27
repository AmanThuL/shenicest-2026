---
title: "Understand post-processing (HDRP)"
page_title: "Post-processing in the High Definition Render Pipeline | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Main.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Post-Processing-Main.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Post-processing in the High Definition Render Pipeline

The High Definition Render Pipeline (HDRP) includes its own purpose-built implementation for [post-processing](https://docs.unity3d.com/Manual/PostProcessingOverview.html). This is built into HDRP, so you don't need to install any other package.

Post-processing effects in HDRP use the [Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html) framework. You add post-processing effects to your Camera in the same way you add any other [Volume Override](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/volume-component.html).

**Note**: Some post-processing effects are enabled by default in the [HDRP Graphics settings](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Default-Settings-Window.html#volume-profiles)

The images below display a Scene with and without HDRP post-processing.

![A scene of a human without post-processing effects.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/PostProcessingMain1.png) Without post-processing.

![A scene of a human with post-processing effects.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/PostProcessingMain2.png) With post-processing.
