---
title: "Install URP into an existing project"
page_title: "Unity - Manual: Install URP into an existing project"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/InstallURPIntoAProject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/InstallURPIntoAProject.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install URP into an existing project

If you have started a Project using the Built-in Render Pipeline, you can install URP and configure your Project to use URP. When you do this, you must configure URP yourself. You will need to manually convert or recreate parts of your Project (such as lit shaders or post-processing effects) to be compatible with URP.

You can download and install the latest version of the Universal Render Pipeline (URP) to your existing Project via the [Package Manager system](https://docs.unity3d.com/Packages/com.unity.package-manager-ui@latest/index.html), and then install it into your Project. If you don’t have an existing Project, refer to documentation on [how to start a new URP Project from a Template](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/creating-a-new-project-with-urp.html).

## Before you begin

URP uses its own [integrated post-processing solution](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/integration-with-post-processing.html). If you have the Post Processing Version 2 package installed in your Project, you need to delete the Post Processing Version 2 package before you install URP into your Project. When you have installed URP, you can then recreate your post-processing effects.

Projects made using URP are not compatible with the High Definition Render Pipeline (HDRP) or the Built-in Render Pipeline. Before you start development, you must decide which render pipeline to use in your Project. For information on choosing a render pipeline, refer to [the Render Pipelines section of the Unity Manual](https://docs.unity3d.com/2019.3/Documentation/Manual/render-pipelines.html).

## Installing URP

1.  In Unity, open your Project.
2.  In the top navigation bar, select **Window** > **Package Management** > **Package Manager** to open the **Package Manager** window.
3.  In the **Packages** menu, select **Unity Registry**. This shows the list of available packages for the version of Unity that you are currently running.
4.  Select **Universal RP** from the list of packages.
5.  In the bottom right corner of the Package Manager window, select **Install**. Unity installs URP directly into your Project.

## Configuring URP

Before you can start using URP, you need to configure it. To do this, you need to [create a URP Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-asset-create.html) and adjust your Graphics settings.

### <span id="set-urp-active"></span>Set URP as the active render pipeline

To set URP as the active render pipeline:

1.  In your project, locate the Render Pipeline Asset that you want to use.  
    **Tip**: to find all URP Assets in a project, use the following query in the search field: `t:universalrenderpipelineasset`.

2.  Select **Edit** > **Project Settings** > **Graphics**.

3.  In the **Scriptable Render Pipeline Settings** field, select the URP Asset. When you select the URP Asset, the available Graphics settings change immediately.

**Optional**:

Set an override URP Assets for different quality levels:

1.  Select **Edit** > **Project Settings** > **Quality**.

2.  Select a quality level. In the **Render Pipeline Asset** field, select the Render Pipeline Asset.

## Upgrading your shaders

If your project uses the prebuilt [Standard Shader](https://docs.unity3d.com/Manual/shader-StandardShader.html), or custom Unity shaders made for the Built-in Render Pipeline, you must convert them to URP-compatible Unity shaders. For more information on this topic, refer to [Upgrading your Shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrading-your-shaders.html).

## Upgrade from the Built-in Render Pipeline

When you upgrade a project from the Built-in Render Pipeline (BiRP) to the Universal Render Pipeline (URP), there are many changes which occur. These changes are wide reaching and require some work beyond the initial installation process for URP shown here. The following pages explain more about these changes and provide guidance on any additional steps required:

-   [Converting your shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrading-your-shaders.html)
-   [Render Pipeline Converter](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html)
-   [Upgrade custom shaders for URP compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/birp-urp-custom-shader-upgrade-guide.html)
-   [Find graphics quality settings in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/birp-onboarding/quality-settings-location.html)
-   [Update graphics quality levels for URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/birp-onboarding/quality-presets.html)

## Additional resources

-   [Create a URP Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-asset-create.html)
