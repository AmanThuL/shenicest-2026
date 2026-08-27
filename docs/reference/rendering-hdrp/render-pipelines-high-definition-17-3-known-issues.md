---
title: "HDRP known issues"
page_title: "Known issues | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Known-Issues.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Known-Issues.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Known issues

This page contains information on known about issues you may encounter while using the High Definition Render Pipeline (HDRP). Each entry describes the issue and then details the steps to follow in order to resolve the issue.

## Material array size

If you upgrade your HDRP Project to a later version, you may encounter an error message similar to:

    Property (_Env2DCaptureForward) exceeds previous array size (48 vs 6). Cap to previous size.

    UnityEditor.EditorApplication:Internal_CallGlobalEventHandler()

To fix this issue, restart the Unity editor.

## Working with Collaborate and a local HDRP config package

If you installed the [config package](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/configure-a-project-using-the-hdrp-config-package.html) locally using the [HDRP Wizard](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Render-Pipeline-Wizard.html), Unity may have placed it in `LocalPackages/com.unity.render-pipelines.high-definition-config` depending on the HDRP version your project used at that time.

In this case, Collaborate does not track changes you make to the local HDRP config package files. To fix this, move the local config package from `LocalPackages/com.unity.render-pipelines.high-definition-config` to `Packages/com.unity.render-pipelines.high-definition-config`. This embeds it in your project and allows Collaborate to tracks and version changes you make.
