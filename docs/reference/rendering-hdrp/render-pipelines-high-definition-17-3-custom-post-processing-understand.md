---
title: "Understand custom post-processing"
page_title: "Understand custom post-processing | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-understand.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-understand.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand custom post-processing

The High Definition Render Pipeline (HDRP) allows you to write your own post-processing effects in a script. A custom post-processing effect automatically integrates into the [Volume framework](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-volumes.html).

You can customize the order of your custom post-processing effects at each stage in the rendering process. These stages are called injection points. To learn when HDRP executes custom post-process passes, refer to [Execution order](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-execution-order.html)

For an example of a custom post-processing script, refer to [Custom post-processing example scripts](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-post-processing-scripts.html).

## Known issues and limitations

- When you rename a custom post-process class name and file, HDRP removes it from the list in HDRP Project Settings which means HDRP does not render the post-processing effect.
