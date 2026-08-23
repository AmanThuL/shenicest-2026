---
title: "Unity 6.3 Manual: Web development and publishing process"
page_title: "Unity - Manual: Web development and publishing process"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Web development and publishing process

Build and deploy a Web application in mobile and desktop environments.

Before you get started, check the [browser compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-browsercompatibility.html) and [technical limitations](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-technical-overview.html) for Web. Make sure you’re aware of any limitations for developing a project for this platform.

For a guided tutorial of the Web platform, refer to [Getting started with Unity Web](https://learn.unity.com/tutorial/getting-started-with-unity-web).

To build and deploy a Web application, complete the following tasks:

-   [Add the Web module.](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html#add-module)
-   [Set up a testing environment.](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html#test)
-   [Profile and optimize.](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html#profile-optimize)
-   [Host your build.](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-gettingstarted.html#host)

<span id="add-module"></span>

## Add the Web module

To get started with Web, [add the Web module](https://docs.unity.com/hub/add-modules) to your project. Once you add the module, you can access the Web **Player** and **Build** settings.

<span id="test"></span>

## Set up a testing environment

Browser security policies restrict loading scripts from `file://` URLs, so you can’t open a Web build directly from your file system by double-clicking `index.html`.

To test your project, do either of the following:

-   Use the **Build and Run** option in the Unity Editor’s [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html) window.
-   Run your own web server.

If you run your own web server, Unity doesn’t need to rebuild the project for every test. For a simple local server, try running one of these options:

-   Python: `python -m http.server`
-   Node.js: `npx http-server`

**Note**: WebGPU builds require a secure context. They only run on `localhost` or sites served over HTTPS.

For more advanced server configurations, refer to [Server configuration code samples](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-server-configuration-code-samples.html) and [Deploy a web application](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-deploying.html) for information about running your own server.

<span id="profile-optimize"></span>

## Profile and optimize

Before you publish, gather performance metrics and reduce the build size to make a project that runs smoothly with the best quality possible.

[Profile your Web build](https://docs.unity3d.com/6000.3/Documentation/Manual/web-profile.html) to get performance data and refer to [Optimize your Web build](https://docs.unity3d.com/6000.3/Documentation/Manual/web-optimization.html) and [Optimize Web platform for mobile](https://docs.unity3d.com/6000.3/Documentation/Manual/web-optimization-mobile.html).

<span id="host"></span>

## Host your build

You need to host projects online to make them accessible to users. Use web hosting services such as [Unity Play](https://play.unity.com/en) depending on your needs.

## Additional resources

-   [Unity Learn tutorial: Getting started with Unity Web](https://learn.unity.com/tutorial/getting-started-with-unity-web)
-   [Web Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html)
-   [Web build settings](https://docs.unity3d.com/6000.3/Documentation/Manual/web-build-settings.html)
-   [Memory in Web](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html)
-   [Web graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-graphics.html)
