---
title: "Unity 6.3 Manual: Web browser compatibility"
page_title: "Unity - Manual: Web browser compatibility"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-browsercompatibility.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-browsercompatibility.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Web browser compatibility

This page gives an overview of Unity’s Web platform support for desktop and mobile browsers.

## Web browser compatibility for desktop

Unity’s Web platform support for desktop browsers differs depending on the browser. It supports browsers providing the following conditions are true:

-   The browser is WebGL 2 capable.
-   The browser is HTML 5 standards-compliant.
-   The browser is 64-bit and supports WebAssembly.

The Unity Web platform supports some compressed texture formats. For information on the compressed texture formats that Unity Web supports, refer to [Recommended, default, and supported texture compression formats, by platform](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-choose-format-by-platform.html). For more detail about texture compression, refer to [Texture compression in Web](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-texture-compression.html).

Web platform supports the following desktop browsers:

| **Desktop Browser** | **Desktop Platforms** |
|:--------------------|:----------------------|
| Google Chrome       | Windows, macOS, Linux |
| Mozilla Firefox     | Windows, macOS, Linux |
| Apple Safari        | macOS                 |
| Microsoft Edge      | Windows, macOS, Linux |

**Notes:**

-   The Web platform also supports the latest version of the Chromium-based Edge browser.
-   Apple Safari doesn’t support WebGL 2 in versions before Safari 15.
-   Apple Safari doesn’t support IndexedDB for content running in an iFrame.
-   On Linux, you might have to install Advanced Audio Coding (AAC) codec support via a package manager (for example, the GStreamer package).

## Web browser compatibility for mobile

The Unity Web platform supports some mobile browsers. To use a Web application on a mobile device, you have a few options:

-   Run the application in your mobile browser.

-   Use WebView to embed the application into native apps.

-   Use a Progressive Web App (PWA) template.

Unity’s Web platform supports the following mobile browsers:

| **Mobile Browser**      | **Mobile Platform** |
|:------------------------|:--------------------|
| iOS Safari 15 and newer | iOS                 |
| Chrome 58 and newer     | Android             |

**Note**: Use the latest browser versions for the best experience. Older versions might have issues that affect performance or prevent Unity content from running.

------------------------------------------------------------------------
