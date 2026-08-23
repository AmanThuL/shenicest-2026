---
title: "Deferred and Deferred+ rendering paths in URP"
page_title: "Unity - Manual: Deferred and Deferred+ rendering paths in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-landing.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Deferred and Deferred+ rendering paths in URP

![Scene rendered with the Deferred Rendering Path](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rendering-deferred/deferred-intro-image.png)

Resources for using the Deferred and Deferred+ rendering paths. The Deferred rendering path has no limit on the number of lights that can affect an opaque GameObject, however the Deferred+ rendering path uses [Forward+](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/forward-rendering-paths.html) instead of Forward for the transparent pass and for the forward only opaque pass, and has the same light limit as Forward+.

| **Page**                                                                                                                                                                                       | **Description**                                                                                                   |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
| [Render passes in the Deferred and Deferred+ rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/render-passes-deferred.html)                                   | Learn about the sequence of render pass events in the Deferred rendering path.                                    |
| [G-buffer layout in the Deferred and Deferred+ rendering path](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/g-buffer-layout.html)                                        | Understand how Unity stores material attributes in the geometry buffer (G-buffer) in the Deferred rendering path. |
| [Enable accurate G-buffer normals in the Deferred and Deferred+ rendering path in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/accurate-g-buffer-normals.html)      | Configure how Unity encodes normals when it stores them in the G-buffer.                                          |
| [Blend terrain accurately in the Deferred and Deferred+ rendering paths](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/deferred-rendering-path-introduction.html)         | Learn about how the Deferred rendering path works, and its limitations.                                           |
| [Make a shader compatible with the Deferred or Deferred+ rendering paths in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering/make-shader-compatible-with-deferred.html) | Use the `LightMode` tag in a shader to make the shader compatible with the Deferred rendering path.               |
