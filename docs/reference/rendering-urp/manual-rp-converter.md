---
title: "Convert assets using the Render Pipeline Converter"
page_title: "Unity - Manual: Convert assets using the Render Pipeline Converter"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Convert assets using the Render Pipeline Converter

The **Render Pipeline Converter** converts assets made for a Built-In Render Pipeline project to assets compatible with URP.

> **Note**: The conversion process makes irreversible changes to the project. Back up your project before the conversion.

## <span id="converters"></span>Conversion types and converters

The Render Pipeline Converter let’s you select one of the following conversion types:

-   Built-In Render Pipeline to URP

-   Built-In Render Pipeline 2D to URP 2D

-   Upgrade 2D URP Assets

When you select on of the conversion types, the tool shows you the available converters.

The following sections describe the converters available for each conversion type.

### Built-In Render Pipeline to URP

This conversion type converts project elements from the Built-In Render Pipeline to URP. It enables the following options:

-   **Rendering Settings**: Creates the URP asset and Universal Renderer asset, then converts the settings in the Built-In Render Pipeline project to equivalent properties in the URP assets.

-   **Material Upgrade**: Converts [prebuilt materials](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-built-in-birp.html) to URP materials. This converter doesn’t support materials with custom shaders. To support more built-in shaders, or override the current ones. Refeer to the section: [extending material upgraders](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html#how-add-material-upgraders)

-   **Read-only Material Converter**: Converts [prebuilt read-only materials](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-built-in-birp.html) that aren’t in the **Assets** folder of your project, for example **Default-Diffuse** and **Default-Line**. This converter audits the project and creates a temporary `.index` file, which might take a significant amount of time.

-   **Animation Clip Converter**: Converts animation clips after the **Material Upgrade** converter finishes. This converter is available only if the project contains animations that affect the properties of materials, or [Post-Processing Stack v2](https://docs.unity3d.com/Packages/com.unity.postprocessing@latest) properties.

-   **Post-Processing Stack v2 Converter**: Converts [Post-Processing Stack v2](https://docs.unity3d.com/Packages/com.unity.postprocessing@latest) volumes, profiles, and layers to URP volumes, profiles, and cameras. This converter audits the project and creates a temporary `.index` file, which might take a significant amount of time. This converter is available only if the Post-Processing Stack v2 package is installed.

### Built-In Render Pipeline 2D to URP 2D

This conversion type converts elements of a project from Built-In Render Pipeline 2D to URP 2D.

Available converters:

-   **Material and Material Reference Upgrade**

    This converter converts all Materials and Material references from Built-In Render Pipeline 2D to URP 2D.

### Upgrade 2D URP Assets

This conversion type upgrades assets of a 2D project from an earlier URP version to the current URP version.

Available converters:

-   **Parametric to Freeform Light Upgrade**

    This converter converts all parametric lights to freeform lights.

## How to use the Render Pipeline Converter

To convert project assets:

1.  Select **Window** > **Rendering** > **Render Pipeline Converter**. Unity opens the Render Pipeline Converter window.

    ![Render Pipeline Converter dialog](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/rp-converter-dialog.png)

2.  Select the conversion type.

    ![Conversion type](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/conversion-types.png)

3.  Depending on the conversion type, the dialog shows the available converters. Select or clear the check boxes next to converter names to enable or disable the converters.

    ![Select converters](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/select-converters.png)

    For the list of available converters, refer to the section [Converters](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rp-converter.html#converters).

4.  Click **Initialize Converters**. The Render Pipeline Converter preprocesses the assets in the project and shows the list of elements to convert. Select or clear check boxes next to assets to include or exclude them from the conversion process.

    ![Initialize converters](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/initialize.png)

    The following illustration shows initialized converters.

    ![Initialized converters](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/after-initialize.png)

    Click a converter to check the list of items that a converter is about to convert.

    ![Converter detailed view](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/converter-detailed-view.png)

    **Yellow icon**: a yellow icon next to an element indicates that a user action might be required to run the conversion. Hover the mouse pointer over the icon to check the description of the issue.

5.  Click **Convert Assets** to start the conversion process.

    > **Note**: The conversion process makes irreversible changes to the project. Back up your project before the conversion.

    When the conversion process finishes, the window shows the status of each converter.

    ![Conversion finished](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/conversion-finished.png)

    **Green check mark**: the conversion went without issues.

    **Yellow icon**: the conversion finished with warnings and might require user action.

    **Red icon**: the conversion failed.

6.  Click a converter to check the list of processed items in that converter.

    ![Conversion finished. Detailed view of a converter](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/rp-converter/conversion-finished-details.png)

    After reviewing the converted project, close the Render Pipeline Converter window.

# Run conversion using API or CLI

The Render Pipeline Converter implements the [Converters](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEditor.Rendering.Universal.Converters.html) class with [RunInBatchMode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@latest/index.html?subfolder=/api/UnityEditor.Rendering.Universal.Converters.html#UnityEditor_Rendering_Universal_Converters_RunInBatchMode_UnityEditor_Rendering_Universal_ConverterContainerId_) methods that let you run the conversion process from a command line.

For example, the following script initializes and executes the converters **Material Upgrade**, and **Read-only Material Converter**.

``` lang-cs
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.Rendering.Universal;
using UnityEngine;

public class MyUpgradeScript : MonoBehaviour

            , ConverterFilter.Inclusive
        );
        EditorApplication.Exit(0);
    }
}
```

To run the example conversion from the command line, use the following command:

``` lang-shell
"<path to Unity application> -projectPath <project path> -batchmode -executeMethod MyUpgradeScript.ConvertBuiltinToURPMaterials
```

Also check: [Unity Editor command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

## <span id="how-add-material-upgraders"></span>How to Add Custom Material Upgraders to Your Project

Unity’s **Material Upgrader** framework allows you to define upgrade paths for shaders—for example, to automatically migrate legacy shaders to URP or custom alternatives.

To do this, you define: - A custom `MaterialUpgrader` that maps an old shader to a new one. - An `IMaterialUpgradersProvider` to expose the upgrader(s) to the system.

``` lang-cs
// This class defines the upgrade rule from an old shader to a new shader
public class MaterialUpgraderExample : MaterialUpgrader

}

// This provider makes the upgrader discoverable by the upgrader system.
// It declares support for the Universal Render Pipeline and exposes the custom upgrade rule.
[SupportedOnRenderPipeline(typeof(UniversalRenderPipeline))]
private class ExampleMaterialProvider : IMaterialUpgradersProvider

}
```
