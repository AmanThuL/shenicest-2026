---
title: "Change or detect the active render pipeline"
page_title: "Unity - Manual: Change or detect the active render pipeline"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Change or detect the active render pipeline

This page contains information on how to get, set, and configure the render pipeline that Unity is currently using. The render pipeline that Unity is currently using is called the active render pipeline.

## Overview

To render content, Unity can either use the Built-in Render Pipeline or a render pipeline based on the [Scriptable Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/scriptable-render-pipeline-introduction.html) (SRP), which includes the Universal Render Pipeline (URP) and the High Definition Render Pipeline (HDRP).

To specify which Scriptable Render Pipeline Unity uses, you use render pipeline assets. A render pipeline asset tells Unity which SRP to use, and how to configure it. If you don’t specify a render pipeline asset, Unity uses the Built-in Render Pipeline.

You can create multiple render pipeline assets that use the same render pipeline, but with different configurations; for example, you can use different render pipeline assets for different hardware quality levels. For a general introduction to render pipeline assets, see [Scriptable Render Pipeline introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/scriptable-render-pipeline-introduction.html). For information on the URP asset, see [The Universal Render Pipeline asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html), and for the HDRP asset, see [The High Definition Render Pipeline asset](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/HDRP-Asset.html).

As soon as you change the active render pipeline asset in the Unity Editor or at runtime, Unity uses the new active render pipeline to render content. If you are in the Unity Editor, this includes the Game view, the Scene view, and previews for Materials in the Project panel and the Inspector.

When you change the active render pipeline, you must ensure that the assets and code in your project are compatible with the new render pipeline; otherwise, you might experience errors or unintended visual effects.

<span id="determine-the-active-render-pipeline"></span>

## Determining the active render pipeline

Settings in both [Graphics settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GraphicsSettings.html) and [Quality settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html) determine the active render pipeline.

For each quality level in the **Quality** settings window, Unity uses the render pipeline asset assigned to **Render Pipeline Asset**. If the property is unassigned, Unity uses the render pipeline asset assigned to **Default Render Pipeline Asset** in the **Graphics** settings window instead.

If both **Render Pipeline Asset** and **Default Render Pipeline** aren’t set, Unity uses the Built-In Render Pipeline.

<span id="set-active-render-pipeline-editor"></span>

## How to set the active render pipeline in the Editor UI

### Activating the Built-in Render Pipeline

To set the active render pipeline to the Built-In Render Pipeline, remove any render pipeline assets from graphics settings and quality settings.

To do this:

1.  Select **Edit** > **Project Settings** > **Quality**.
2.  For each quality level, if a render pipeline asset is assigned to **Render Pipeline Asset**, unassign it.
3.  Select **Edit** > **Project Settings** > **Graphics**.
4.  If a render pipeline asset is assigned to **Default Render Pipeline**, unassign it.

### Activating URP, HDRP, or a custom render pipeline based on SRP

To set the active render pipeline to one that is based on SRP, tell Unity which render pipeline asset to use as the default active render pipeline, and optionally which render pipeline assets to use for each quality level.

To do this:

1.  In your Project folder, locate the render pipeline asset(s) that you want to use.
2.  Set the default render pipeline, which Unity uses when there is no override for a given quality level. If you do not set this, Unity uses the Built-in Render Pipeline when no override applies.
    1.  Select **Edit** > **Project Settings** > **Graphics**.
    2.  Set **Default Render Pipeline** to the render pipeline asset you want to use.
3.  **Optional**: Set override render pipeline assets for different quality levels.
    1.  Select **Edit** > **Project Settings** > **Quality**.
    2.  Set **Render Pipeline Asset** to the render pipeline asset you want to use.

<span id="get-set-active-render-pipeline-scripts"></span>

## How to get and set the active render pipeline in C# scripts

In C# scripts, you can get and set the active render pipeline and receive a callback when the active render pipeline changes. You can do this in Edit Mode or Play Mode in the Unity Editor, or at runtime in your application.

To do this, use the following APIs:

-   There are several ways to get the active render pipeline:
    -   To get a reference to the render pipeline asset that defines the active render pipeline, use [GraphicsSettings.currentRenderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.GraphicsSettings-currentRenderPipeline.html).
    -   To get a reference to the render pipeline asset that defines the active render pipeline and to determine whether Unity is using the default value or an override value, get the values of [GraphicsSettings.defaultRenderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.GraphicsSettings-defaultRenderPipeline.html) and [QualitySettings.renderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings-renderPipeline.html). For information on how to use these values, see [Determining the active render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html#determine-the-active-render-pipeline) or the following code sample.
    -   To get the [RenderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipeline.html) instance for the active render pipeline, use [RenderPipelineManager.currentPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-currentPipeline.html). **Note:** Unity updates this property only after it has rendered at least one frame with the active render pipeline.
-   To set the active render pipeline, set the values of [GraphicsSettings.defaultRenderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.GraphicsSettings-defaultRenderPipeline.html) and [QualitySettings.renderPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings-renderPipeline.html). For information on how to use these values, see [Determining the active render pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/srp-setting-render-pipeline-asset.html#determine-the-active-render-pipeline) or the following code sample.
-   To detect and execute code when the type of the active render pipeline changes, use [RenderPipelineManager.activeRenderPipelineTypeChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineManager-activeRenderPipelineTypeChanged.html).

The following example code shows how to use these APIs:

``` lang-cs
using UnityEngine;
using UnityEngine.Rendering;
 
public class ActiveRenderPipelineExample : MonoBehaviour

    void Update()
    
        // When the user presses the right shift key, switch the override render pipeline
        else if (Input.GetKeyDown(KeyCode.RightShift)) 
    }

    // Switch the default render pipeline between null,
    // and the render pipeline defined in defaultRenderPipelineAsset
    void SwitchDefaultRenderPipeline()
    
        else
        
    }

    // Switch the override render pipeline between null,
    // and the render pipeline defined in overrideRenderPipelineAsset
    void SwitchOverrideRenderPipeline()
    
        else
        
    }

    // Print the current render pipeline information to the console
    void DisplayCurrentRenderPipeline()
    
        else
        
        // QualitySettings.renderPipeline determines the override render pipeline for the current quality level
        // If it is null, no override exists for the current quality level
        if (QualitySettings.renderPipeline != null)
        
        else
        
        // If an override render pipeline is defined, Unity uses that
        // Otherwise, it falls back to the default value
        if (QualitySettings.renderPipeline != null)
        
        else
        
        // To get a reference to the render pipeline asset that defines the active render pipeline,
        // without knowing if it is the default or an override, use GraphicsSettings.currentRenderPipeline
        if (GraphicsSettings.currentRenderPipeline != null)
        
        else
        
    }
}
```
