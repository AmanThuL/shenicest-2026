---
title: "Create a custom pass in a C# script"
page_title: "Create a Custom Pass in a C# script | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Create a Custom Pass in a C# script

You can extend the `CustomPass` class in the Custom Pass API to create complex effects, such as a Custom Pass that has more than one buffer or uses [Compute Shaders](https://docs.unity3d.com/Manual/class-ComputeShader.html).

When you create your own C# Custom Pass using the instructions in [The Custom Pass C# Template](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html#Custom-Pass-C#-template), it automatically appears in the list of available Custom Passes in the Custom Pass Volume component.

<span id="Custom-Pass-C#-template"></span>

## The Custom Pass C# template

To create a new Custom pass, go to **Assets** \> **Create** \> **Rendering** \> **HDRP C# Custom Pass**. This creates a new script that contains the Custom Pass C# template:

```
class #SCRIPTNAME# : CustomPass

    protected override void Execute(CustomPassContext ctx) 
    protected override void Cleanup() 
}
```

The C# Custom Pass template includes the following entry points to code your custom pass:

| **Entry Point** | **Description** |
|----|----|
| `Setup` | Use this to allocate all the resources you need to render your pass, such as render textures, materials, and compute buffers. |
| `Execute` | Use this to describe what HDRP renders during the Custom Pass. |
| `Cleanup` | Use this to clear the resources you allocated in the Setup method .Make sure to include every allocated resource to avoid memory leaks. |

The `Setup` and `Execute` methods give you access to a `ScriptableRenderContext` and a `CommandBuffer`. For information on using `CommandBuffers` with a `ScriptableRenderContext`, see [Scheduling and executing commands in the Scriptable Render Pipeline](https://docs.unity3d.com/Manual/srp-using-scriptable-render-context.html).

## Create a full-screen Custom Pass in C#

This section demonstrates how to create a full-screen Custom Pass that applies an outline effect to an object in your scene.

![A mesh in a scene rendered using this outline effect](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/CustomPass_FrameDebugger.png)

This effect uses a transparent full screen pass with a blend mode that replaces the pixels around the GameObject you assign the script to.

This shader code performs the following steps:

1.  Renders the objects in the outline layer to a buffer called `outlineBuffer`.
2.  Samples the color in `outlineBuffer`. If the color is below the threshold, it means that the pixel might be in an outline.
3.  Searches neighboring pixels to check if this is the case.
4.  If Unity finds a pixel above the threshold, it applies the outline effect.

<span id="Creating-Cusom-Pass-script"></span>

### Create a CustomPass script

This section provides an example of a Custom Pass C# script that applies an outline effect to every GameObject in a Layer.

The following pass renders all the GameObjects in the `Outline Layer` into a custom buffer named `outlineBuffer` in the code. It performs an edge detection algorithm over the screen that checks for all the GameObjects rendered in the `outlineBuffer`. This edge detection algorithm creates an outline around objects rendered in the `outlineBuffer`. `CoreUtils.DrawFullScreen` applies the full screen effect.

This example only supports a single outline color for all the objects in a Layer.

To use this example Custom Pass script:

1.  Create a new C# script (menu: **Assets** \> **Create** \> **C# Script)**.
2.  Name your script. In this example, the new script is called “Outline”.
3.  Enter the following code:

```
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;

class Outline : CustomPass

    protected override void Execute(CustomPassContext ctx)
    
    protected override void Cleanup()
    
}
```

<span id="Creating-Cusom-Pass-Shader"></span>

### Script a Custom Pass shader

To create a new shader:

1.  Create a new Unity shader using **Assets** \> **Create** \> **Shader** \> **HDRP Custom FullScreen Pass**
2.  Name the new shader source file “Outline”
3.  Enter the following code:

```
Shader "Hidden/Outline"
{
    HLSLINCLUDE

    #pragma vertex Vert

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone vulkan metal switch

    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/RenderPass/CustomPass/CustomPassCommon.hlsl"

    TEXTURE2D_X(_OutlineBuffer);
    float4 _OutlineColor;
    float _Threshold;

    #define v2 1.41421
    #define c45 0.707107
    #define c225 0.9238795
    #define s225 0.3826834

    #define MAXSAMPLES 8
    // Neighbour pixel positions
    static float2 samplingPositions[MAXSAMPLES] =
    {
        float2( 1,  1),
        float2( 0,  1),
        float2(-1,  1),
        float2(-1,  0),
        float2(-1, -1),
        float2( 0, -1),
        float2( 1, -1),
        float2( 1, 0),
    };

    float4 FullScreenPass(Varyings varyings) : SV_Target
    
            }
        }

        return outline;
    }

    ENDHLSL

    SubShader
    
    }
    Fallback Off
}
```

### Use a C# Custom Pass Shader effect

To enable a full-screen effect that you have created in a shader, assign it to the **FullScreen Material** property of a [**FullScreeenCustomPass**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#full-screen-custom-pass) component.

To enable a Draw renderers Custom Pass that you have created in a shader, assign it to the Material property of a [**DrawRenderersCustomPass**](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#draw-renderers-custom-pass) component.

You can also make your Custom Pass effect visible automatically in script. To do this, assign a Material to a shader within a Custom Pass script. The example script provided in [Creating a Custom Pass script](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass-Scripting.html#Creating-Cusom-Pass-script) does this in the following lines:

Reference the shader in a serialized field:

```
// To make sure the shader ends up in the build, we keep a reference to it
​    [SerializeField, HideInInspector]
​    Shader                  outlineShader;
```

Reference the shader when you create a material:

```
fullscreenOutline = CoreUtils.CreateEngineMaterial(outlineShader);
```

## Control a Custom Pass Volume component using code

You can use [GetComponent](https://docs.unity3d.com/2019.3/Documentation/ScriptReference/GameObject.GetComponent.html) to retrieve the `CustomPassVolume` in a script and access most of the properties available in the UI (for example,`isGlobal`, `fadeRadius` and `injectionPoint`).

You can also dynamically change the list of Custom Passes that Unity executes. To do this, modify the `customPasses` list.

The following example copies the current camera color buffer to a render texture asset:

```
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
// Custom pass to copy the current camera color buffer to a render texture asset
public class CopyPass : CustomPass

    }
}
public class ExtractColorBuffer : MonoBehaviour

    void Update()
    
}
```

### Create a custom editor for a C# custom pass

To write a custom editor you can use a similar pattern to the [CustomPropertyDrawer](https://docs.unity3d.com/ScriptReference/CustomPropertyDrawer.html) MonoBehaviour Editor, but with different attributes.

The following script creates a [custom editor](https://docs.unity3d.com/Manual/editor-CustomEditors.html) that you can use to customize the properties of a Custom Pass in the Inspector window:

```
public class OutlineDrawer : CustomPassDrawer

   protected override void DoPassGUI(SerializedProperty customPass, Rect rect)
   
   protected override float GetPassHeight(SerializedProperty customPass)
   
}
```

When you create a Custom Pass drawer, Unity provides a default list of Custom Pass properties. Unity still does this when `DoPassGUI` is empty. These properties are the same properties that Unity provides in the [draw renderers CustomPass Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-create-gameobject.html#draw-renderers-custom-pass) component by default.

If you don't need all these settings, you can override the `commonPassUIFlags` property to remove some of them. The following example only keeps the name and the target buffer enum:

```
protected override PassUIFlag commonPassUIFlags => PassUIFlag.Name | PassUIFlag.TargetColorBuffer;
```
