---
title: "Custom Function Node"
page_title: "Custom Function Node | Shader Graph | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom Function Node

Use the Custom Function Node to inject your own custom HLSL code in Shader Graphs to do some fine-grained optimization, for example.

You can either write small functions directly into graphs by using the string mode, or reference external HLSL files. Use the [Custom Port Menu](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Port-Menu.html) to define your own input and output ports on the node itself.

![The Custom Function node properties](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/images/Custom-Function-Node-File.png)

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th style="text-align: left;">Property</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Inputs</strong></td><td style="text-align: left;">Define the node's input ports. The names you enter here define the names for the input values you use in the code.</td></tr><tr class="even"><td style="text-align: left;"><strong>Outputs</strong></td><td style="text-align: left;">Define the node's output ports. The names you enter here define the names for the output values you use in the code.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Type</strong></td><td style="text-align: left;">Select the way to reference the custom function in the node. The options are:<ul><li><strong>File</strong>: Reference an external file that contains the functions.</li><li><strong>String</strong>: Directly write functions in the node.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Name</strong></td><td style="text-align: left;">The name of the custom function in the code, <strong>without</strong> the function precision suffix <code>_half </code> or <code>_float </code>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Source</strong></td><td style="text-align: left;">When you set <strong>Type</strong> to <strong>File</strong>, the reference to the HLSL file that includes the custom functions. The file can be anywhere in your Unity project and must have the <code>.hlsl</code> extension. For more details, refer to <a href="https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html#file-content-syntax-details-and-examples">file content syntax</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Body</strong></td><td style="text-align: left;">When you set <strong>Type</strong> to <strong>String</strong>, the HLSL code that defines the contents of the custom functions. Unity handles the arguments, braces, and indent scope automatically.</td></tr></tbody></table>

## Set up a Custom Function node

To set up a Custom Function node:

1.  [Create a new node](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Create-Node-Menu.html) of **Custom Function** type (from the **Utility** category).
2.  In the [Graph Inspector](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Internal-Inspector.html), select **Node Settings**.
3.  [Define custom **Inputs** and **Outputs**](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Port-Menu.html) to set the node's ports and the corresponding variables to use in the custom function.
4.  Define the custom function according to your needs, either with a [file](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html#define-the-custom-function-with-a-file) or a [string](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html#define-the-custom-function-with-a-string).

### Define the custom function with a string

In **String** mode, the graph generates the shader function.

To define the function with a string:

1.  In the Graph Inspector, in the Node Settings, Set **Type** to **String**.
2.  In the **Name** field, specify a name for the function.
3.  In the **Body** field, write the contents of the function. Unity handles the arguments, braces, and indent scope automatically.

In **String** mode, you may use the token `$precision` instead of `half` or `float` in the **Body** field. Unity replaces this with the correct type when the node is processed, based on that node's precision.

![04](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/images/Custom-Function-Node-String-wFunction.png)

The example in the image above generates the following function:

    void MyFunction_float(float3 A, float B, out float3 Out)
    
### Define the custom function with a file

In **File** mode, the graph does not automatically generate the shader function. This mode injects an include reference in the final generated shader, and uses a function from within the referenced file.

To create an HLSL file to use from a Custom Function node:

1.  Use your file system to create an empty text file with the `.hlsl` extension in any folder of your Unity project.
2.  Write your custom function according to the [file content syntax](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html#file-content-syntax-details-and-examples).

To use a function from the HLSL file in the node:

1.  In the Graph Inspector, in the Node Settings, set **Type** to **File**.
2.  In the **Source** field, reference the HLSL file that contains the function.
3.  In the **Name** field, specify the name of the function to call in the file, **without** the function precision suffix `_half ` or `_float `.

![06](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/images/Custom-Function-Node-File-wFunction.png)

#### File content syntax, details, and examples

HLSL files you reference in Custom Function nodes can contain one or multiple functions. In all cases, you have to match the following expectations:

-   The file should include a `#ifndef` condition along with a `#define` statement with an identifier to make sure Unity doesn't load the same functions twice, which would result in a compile error.
    -   You must use the same id string for the `#ifndef` condition and the `#define` statement.
    -   If you create multiple HLSL files for Custom Function nodes in the same project, you must use a different id string for each file.
-   Each function name must have a precision suffix:
    -   Use `_float` to run the function in full precision mode.
    -   Use `_half` if you need to save resources, which might only apply to certain platforms.
-   The function arguments must correspond to the Inputs you defined in the Node Settings.

For example:

    //UNITY_SHADER_NO_UPGRADE
    #ifndef MYHLSLINCLUDE_INCLUDED
    #define MYHLSLINCLUDE_INCLUDED

    void MyFunction_float(float3 A, float B, out float3 Out)
    
    #endif //MYHLSLINCLUDE_INCLUDED

The **File** mode allows for more flexibility with custom functions in a graph.

#### Shared data and uniform variables

To supply shared data to your function without additional ports, use uniform variables defined outside the function scope.

    //UNITY_SHADER_NO_UPGRADE
    #ifndef MYHLSLINCLUDE_INCLUDED
    #define MYHLSLINCLUDE_INCLUDED
    float4x4 _MyMatrix;
    void MyFunction_float(float3 A, float B, out float3 Out)
    
    #endif //MYHLSLINCLUDE_INCLUDED

When you add a uniform variable in a Custom Function, like the `float4x4` matrix in the example above, you make this variable global. As a result:

-   You can set this uniform globally only, using `Shader.SetGlobalMatrix()`.
-   You don't have to add an input parameter to allow the shader to access them directly.
-   You can't set it per material, because it's not declared in the `UnityPerMaterial` cbuffer and doesn't have a material property associated with it.

#### Multiple functions and multiple files

You can define multiple functions in the same file, and call them from your referenced function. Alternatively, you can reference the same file, but use different functions from different Custom Function nodes.

    //UNITY_SHADER_NO_UPGRADE
    #ifndef MYHLSLINCLUDE_INCLUDED
    #define MYHLSLINCLUDE_INCLUDED
    float3 MyOtherFunction_float(float3 In)
    
    void MyFunction_float(float3 A, float B, out float3 Out)
    
    #endif //MYHLSLINCLUDE_INCLUDED

You can even include other files that contain other functions.

    //UNITY_SHADER_NO_UPGRADE
    #ifndef MYHLSLINCLUDE_INCLUDED
    #define MYHLSLINCLUDE_INCLUDED
    #include "Assets/MyOtherInclude.hlsl"
    void MyFunction_float(float3 A, float B, out float3 Out)
    
    #endif //MYHLSLINCLUDE_INCLUDED

### Reusing Custom Function Nodes

The Custom Function node, on its own, is a single node instance. If you wish to reuse the same custom function without re-creating the inputs, outputs, and function referencing, include the Custom Function node in a [Sub Graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Sub-graph.html). Once created, the Sub Graph appears in the [Create Node Menu](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Create-Node-Menu.html), along with the nodes.

![11](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/images/Custom-Function-Node-Subgraph.png)

You can create a Sub Graph and add a Custom Function node to it, or right-click an existing Custom Function node and select `Convert to Sub Graph`. To add the appropriate input and output ports, use the [Graph Inspector](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Internal-Inspector.html) and [Custom Port Menu](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Port-Menu.html).

### Working with texture wires

From version 10.3, Shader Graph has five new data structures to ensure that Custom Function nodes and Sub Graphs input and output data from texture wire in a consistent way. The new structures also make it possible for SamplerState to compile on [GLES2](https://en.wikipedia.org/wiki/OpenGL_ES#OpenGL_ES_2.0) platforms and access data associated with textures via `myInputTex.samplerstate` and `myInputTex.texelSize`.

Four structures are for the texture types, and one is for the sampler state:

-   UnityTexture2D
-   UnityTexture2DArray
-   UnityTexture3D
-   UnityTextureCube
-   UnitySamplerState

Custom Function nodes you create with earlier versions of Shader Graph continue to work after this change. As part of the automatic update, Unity transitions them to the new **Bare** node type. This type replicates the old input and output behavior. All other types pass the new structs.

However, you should manually upgrade Custom Function nodes that produce texture or samplerstate types as output to ensure that they behave consistently—and to gain the benefits of the new design. Unity flags this type of outdated Custom Function Nodes with a warning when you open your Shader Graph in 10.3 or later.

#### How to upgrade

1.  Change all of the input and output types from **Bare** to **non-Bare**.  

-   **String** type: Ensure that your HLSL string already uses Unity's texture access macros (such as `SAMPLE_TEXTURE2D`).

-   **File** type: Replace Bare types (such as Texture2D) with the new struct types (such as UnityTexture2D) in your function parameters.

2.  If your HLSL code is using platform-specific or non-standard texture operations, you'll need to convert the way you access textures to take that structure into account. For example, `myInputTex.GetDimensions(...)` would become `myInputTex.tex.GetDimensions(...)`

From version 10.3, you can access data associated with textures via `myInputTex.samplerstate` and `myInputTex.texelSize`.
