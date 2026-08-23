---
title: "Introduction to Unity Accelerator"
page_title: "Unity - Manual: Introduction to Unity Accelerator"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UnityAccelerator.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UnityAccelerator.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to Unity Accelerator

Unity Accelerator is a caching proxy agent that keeps copies of a team’s imported assets to help reduce development iteration time. Unity Accelerator uses the Asset Import Pipeline to coordinate asset sharing when your team is working on the same local network so that you don’t need to reimport portions of your project.

When you install Unity Accelerator on your local network, the Unity Editor communicates with the cache server to store and retrieve assets that other team members are using or might have modified.

## Installing Unity Accelerator

To install Unity Accelerator, you can either install it [with the installer](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-install-installer.html) or [with Docker Hub](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-install-docker.html). Make sure that the system you install it on meets the minimum [requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-requirements.html).

After installation, you can [verify the Unity Accelerator version](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-verify-version.html) and [configure Unity Accelerator in the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-configure.html).

## Using Unity Accelerator

After you’ve installed Unity Accelerator on your network and set it up in your project, it will work in the background, caching your assets. You [can monitor its usage](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-monitor.html) via the dashboard, at `http://<accelerator-host-ip>/dashboard`.

## Additional resources

-   [Unity Accelerator requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/accelerator-requirements.html)
-   [Importing Assets](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html)
-   [The Asset Database](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetDatabase.html)
