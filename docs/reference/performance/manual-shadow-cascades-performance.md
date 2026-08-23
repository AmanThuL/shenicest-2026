---
title: "Performance impact of shadow cascades"
page_title: "Unity - Manual: Performance impact of shadow cascades"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-performance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-performance.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Performance impact of shadow cascades

Increasing the number of shadow cascades increases the number of draw calls in the shadow rendering pass, which has a negative impact on rendering performance.

Reducing the number of shadow cascades lets you significantly reduce the number of shadow rendering draw calls.

A lower number of shadow cascades might reduce the visual quality of shadows in the scene. Choose the number of cascades based on the performance and visual quality requirements of your project on a scene-by-scene basis.

You can configure different shadow cascade settings and shadow resolution settings for different quality levels using multiple URP assets.
