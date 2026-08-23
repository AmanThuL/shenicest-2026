---
title: "Write an unlit basic shader in URP"
page_title: "Unity - Manual: Write an unlit basic shader in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Write an unlit basic shader in URP

This example shows a basic URP-compatible shader. This shader fills the mesh shape with a color predefined in the shader code.

To try the shader for yourself, copy and paste the following ShaderLab code into the Shader asset.

**Note**: If you enable **Depth Priming Mode** in the [URP asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html), this shader renders opaque objects as invisible. For more information, refer to [Write depth only in a shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-depth-only.html).

``` lang-cpp
// This shader fills the mesh shape with a color predefined in the code.
Shader "Example/URPUnlitShaderBasic"

    // The SubShader block containing the Shader code.
    SubShader
    
        Pass
        {
            // The HLSL code block. Unity SRP uses the HLSL language.
            HLSLPROGRAM
            // This line defines the name of the vertex shader.
            #pragma vertex vert
            // This line defines the name of the fragment shader.
            #pragma fragment frag

            // The Core.hlsl file contains definitions of frequently used HLSL
            // macros and functions, and also contains #include references to other
            // HLSL files (for example, Common.hlsl, SpaceTransforms.hlsl, etc.).
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            // The structure definition defines which variables it contains.
            // This example uses the Attributes structure as an input structure in
            // the vertex shader.
            struct Attributes
            {
                // The positionOS variable contains the vertex positions in object
                // space.
                float4 positionOS   : POSITION;
            };

            struct Varyings
            {
                // The positions in this struct must have the SV_POSITION semantic.
                float4 positionHCS  : SV_POSITION;
            };

            // The vertex shader definition with properties defined in the Varyings
            // structure. The type of the vert function must match the type (struct)
            // that it returns.
            Varyings vert(Attributes IN)
            
            // The fragment shader definition.
            half4 frag() : SV_Target
            
            ENDHLSL
        }
    }
}
```

The fragment shader colors the GameObject dark red (RGB value (0.5, 0, 0)).

![The shader paints the GameObject dark red](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/shader-examples/unlit-shader-tutorial-basic-hardcoded-color.png)

The following section introduces you to the structure of this basic Unity shader.

<span id="basic-shaderlab-structure"></span>

## Basic ShaderLab structure

Unity shaders are written in a Unity-specific language called [ShaderLab](https://docs.unity3d.com/Manual/SL-Shader.html).

The Unity shader in this example has the following blocks:

-   [Shader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html#shader)
-   [Properties](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html#properties)
-   [SubShader](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html#subshader)
-   [Pass](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html#pass)
-   [HLSLPROGRAM](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-basic-unlit-structure.html#hlsl)

### <span id="shader"></span>Shader block

ShaderLab code starts with the `Shader` declaration.

``` lang-cpp
Shader "Example/URPUnlitShaderBasic"
```

The path in this declaration determines the display name and location of the Unity shader in the Shader menu on a Material. The method [Shader.Find](https://docs.unity3d.com/ScriptReference/Shader.Find.html) also uses this path.

![Location of the shader in the Shader menu on a Material](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/shader-examples/urp-material-ui-shader-path.png)

### <span id="properties"></span>Properties block

The [Properties](https://docs.unity3d.com/Manual/SL-Properties.html) block contains the declarations of properties that users can set in the Inspector window on a Material.

In this example, the Properties block is empty, because this Unity shader does not expose any Material properties that a user can define.

### <span id="subshader"></span>SubShader block

A Unity shader source file contains one or more [SubShader](https://docs.unity3d.com/Manual/SL-SubShader.html) blocks. When rendering a mesh, Unity selects the first SubShader that is compatible with the GPU on the target device.

A SubShader block can optionally contain a SubShader Tags block. Use the `Tags` keyword to declare a SubShader Tags block.

``` lang-hlsl
Tags 
```

A SubShader Tag with a name of `RenderPipeline` tells Unity which render pipelines to use this SubShader with, and the value of `UniversalPipeline` indicates that Unity should use this SubShader with URP.

To execute the same shader in different render pipelines, create multiple SubShader blocks with different `RenderPipeline` tag values. To execute a SubShader block in HDRP, set the `RenderPipeline` tag to `HDRenderPipeline`, to execute it in the Built-in Render Pipeline, set `RenderPipeline` to an empty value.

For more information on SubShader Tags, refer to [ShaderLab: SubShader Tags](https://docs.unity3d.com/Manual/SL-SubShaderTags.html).

### <span id="pass"></span>Pass block

In this example, there is one Pass block that contains the HLSL program code. For more information on Pass blocks, refer to [ShaderLab: Pass](https://docs.unity3d.com/Manual/SL-Pass.html).

A Pass block can optionally contain a Pass tags block. For more information, refer to [URP ShaderLab Pass tags](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/urp-shaderlab-pass-tags.html).

### <span id="hlsl"></span>HLSLPROGRAM block

This block contains the HLSL program code.

> **Note**: HLSL language is the preferred language for URP shaders.

This block contains the `#include` declaration with the reference to the `Core.hlsl` file.

``` lang-cpp
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
```

The `Core.hlsl` file contains definitions of frequently used HLSL macros and functions, and also contains #include references to other HLSL files (for example, `Common.hlsl` and `SpaceTransforms.hlsl`).

For example, the vertex shader in the HLSL code uses the `TransformObjectToHClip` function from the `SpaceTransforms.hlsl` file. The function transforms vertex positions from object space to homogenous space:

``` lang-cpp
Varyings vert(Attributes IN)

```

> **Note**: Don’t import shader library files from both the Scriptable Render Pipeline (SRP) and the Built-In Render Pipeline in the same shader. Some SRP shader macros and functions might conflict with the Built-in Render Pipeline shader functions. For more information, refer to [Shader methods in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/use-built-in-shader-methods.html) and [Import a file from the shader library in the Built-In Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-BuiltinIncludes.html).

The fragment shader in this basic HLSL code outputs the single color predefined in the code:

``` lang-cpp
half4 frag() : SV_Target

```

Section [URP unlit shader with color input](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/writing-shaders-urp-unlit-color.html) shows how to add the editable color property in the Inspector window on the Material.
