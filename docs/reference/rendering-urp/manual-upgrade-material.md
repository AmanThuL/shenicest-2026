---
title: "Upgrade material assets to Scriptable Render Pipeline"
page_title: "Unity - Manual: Upgrade material assets to Scriptable Render Pipeline"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upgrade-material.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upgrade-material.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade material assets to Scriptable Render Pipeline

When you upgrade your project from the Built-In Render Pipeline (BiRP) to a Scriptable Render Pipeline (SRP) such as the Universal Render Pipeline (URP) or the High Definition Render Pipeline (HDRP), you need to upgrade your materials. If you don’t upgrade your materials, they appear bright pink in Scene view.

![A bright pink cube in Scene view.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/shader-error.png)

**Notes:**

-   Make sure there are no shader-related errors in the console, or in the **Inspector** window when you select a material.

-   If your assets use custom shaders, refer to [Upgrade custom shaders for URP compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/birp-urp-custom-shader-upgrade-guide.html).

## Upgrade Built-In materials to your current SRP

These menu options upgrade Built-In Render Pipeline materials to the currently active Scriptable Render Pipeline in your project.

**Important:** Back up your Built-in Render Pipeline material assets before proceeding. This conversion modifies materials and cannot be easily undone.

To upgrade all material assets in your project:

1.  Go to **Edit** > **Rendering** > **Materials** > **Convert All Built-In Materials to Current SRP**.

2.  In the confirmation dialog, select **Proceed** to start the conversion.

To upgrade only selected material assets:

1.  In the Project window, select the Built-in Render Pipeline material assets you want to convert.

2.  Go to **Edit** > **Rendering** > **Materials** > **Convert Selected Built-In Materials to Current SRP**.

3.  In the confirmation dialog, select **Proceed** to start the conversion.

**Note:** If the console or the **Inspector** window displays [error messages](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-error.html) when you select a material, there’s an issue with a shader that an automatic converter can’t solve.

## Additional resources

-   [Upgrading from the Built-In Render Pipeline to URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrading-from-birp.html)
-   [Upgrading to HDRP from the built-in render pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/manual/convert-project-from-built-in-render-pipeline.html)
-   [Convert assets using the Render Pipeline Converter](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html)
