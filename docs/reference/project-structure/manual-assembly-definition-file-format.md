---
title: "Assembly Definition file format reference"
page_title: "Unity - Manual: Assembly Definition file format reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Assembly Definition file format reference

Assembly Definition and Assembly Definition Reference assets are JSON files. You can edit the asset files inside the Unity Editor using the **Inspector** window, but you can also modify the JSON content directly with an external tool.

## Assembly Definition JSON

An Assembly Definition is a JSON object with the following fields:

<table><thead><tr class="header"><th style="text-align: left;">Key</th><th style="text-align: left;">Type</th><th style="text-align: left;">Required</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><code>allowUnsafeCode</code></td><td style="text-align: left;">bool</td><td style="text-align: left;">Optional</td><td style="text-align: left;">False by default. For more information on the meaning of this option, refer to <strong>Allow ‘unsafe’ Code</strong> in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#general">General Options</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>autoReferenced</code></td><td style="text-align: left;">bool</td><td style="text-align: left;">Optional</td><td style="text-align: left;">True by default. For more information on the meaning of this option, refer to <strong>Auto Referenced</strong> in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#general">General Options</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>defineConstraints</code></td><td style="text-align: left;">string[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">Can be empty. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#define-constraints">Define Constraints</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>excludePlatforms</code></td><td style="text-align: left;">string[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">The platform name strings to exclude or an empty array. The <code>excludePlatforms</code> array must be empty if <code>includePlatforms</code> contains values. Valid platform name strings are the <a href="Scriptref:Compilation.AssemblyDefinitionPlatform.Name"><code>AssemblyDefinitionPlatform.Name</code></a> properties of the array of <a href="Scriptref:Compilation.AssemblyDefinitionPlatform"><code>AssemblyDefinitionPlatform</code></a> objects returned by <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CompilationPipeline.GetAssemblyDefinitionPlatforms.html"><code>CompilationPipeline.GetAssemblyDefinitionPlatforms</code></a>. Only platforms with build support installed for the current Editor are valid. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#platforms">Platforms</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>includePlatforms</code></td><td style="text-align: left;">string[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">The platform name strings to include or an empty array. The <code>includePlatforms</code> array must be empty if <code>excludePlatforms</code> contains values. Valid platform name strings are the <a href="Scriptref:Compilation.AssemblyDefinitionPlatform.Name"><code>AssemblyDefinitionPlatform.Name</code></a> properties of the array of <a href="Scriptref:Compilation.AssemblyDefinitionPlatform"><code>AssemblyDefinitionPlatform</code></a> objects returned by <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CompilationPipeline.GetAssemblyDefinitionPlatforms.html"><code>CompilationPipeline.GetAssemblyDefinitionPlatforms</code></a>. Only platforms with build support installed for the current Editor are valid. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#platforms">Platforms</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>name</code></td><td style="text-align: left;">string</td><td style="text-align: left;">Required</td><td style="text-align: left;">For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#name">Name</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>noEngineReferences</code></td><td style="text-align: left;">bool</td><td style="text-align: left;">Optional</td><td style="text-align: left;">False by default. For more information on the meaning of this option, refer to <strong>No Engine References</strong> in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#general">General Options</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>overrideReferences</code></td><td style="text-align: left;">bool</td><td style="text-align: left;">Optional</td><td style="text-align: left;">False by default. Set to true if <code>precompiledReferences</code> contains values. For more information on the meaning of this option, refer to <strong>Override References</strong> in <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#general">General Options</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>precompiledReferences</code></td><td style="text-align: left;">string[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">The file names of referenced DLL libraries including extension, but without other path elements. Can be empty. This array is ignored unless you set <code>overrideReferences</code> to true. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html">Referencing assemblies</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>references</code></td><td style="text-align: left;">string[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">References to other assemblies created with Assembly Definition assets. You can use either the GUID of the Assembly Definition asset file or the name of the assembly as defined by the <code>name</code> field of the Assembly Definition. You must use the same form for all references in the list. Can be empty.<br />
<br />
You can use the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.AssetPathToGUID.html"><code>AssetDatabase.AssetPathToGUID</code></a> function to retrieve the GUID of an asset. The GUID is also part of the metadata associated with every asset.<br />
<br />
Note that the Editor displays a <strong>Use GUIDs</strong> option in the Assembly Definition Inspector. This option is not serialized in the associated JSON file. Instead, the choice is inferred from the form of reference found in the file. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html">Referencing assemblies</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>versionDefines</code></td><td style="text-align: left;">object[]</td><td style="text-align: left;">Optional</td><td style="text-align: left;">Contains an object for each version define. This object has three fields:<ul><li><code>name</code>:string – The name of the resource.</li><li><code>expression</code>:string – The expression defining the version or range of versions of the resource.</li><li><code>define</code>:string – The symbol to define.</li></ul>For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#version-defines">Version Defines</a>.</td></tr></tbody></table>

### Example with assembly names and included platforms

The following example Assembly Defintion JSON uses assembly names for references to other Assembly Definitions and the `includePlatforms` key to specify an array of included platforms:

``` lang-yml
{
    "name": "BeeAssembly",
    "references": [
        "Unity.CollabProxy.Editor",
        "AssemblyB",
        "UnityEngine.UI",
        "UnityEngine.TestRunner",
        "UnityEditor.TestRunner"
    ],
    "includePlatforms": [
        "Android",
        "LinuxStandalone64",
        "WebGL"
    ],
    "excludePlatforms": [],
    "overrideReferences": true,
    "precompiledReferences": [
        "Newtonsoft.Json.dll",
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_2019",
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [
        {
            "name": "com.unity.ide.vscode",
            "expression": "[1.7,2.4.1]",
            "define": "MY_SYMBOL"
        },
        
    ],
    "noEngineReferences": false
}
```

### Example with GUIDs and excluded platforms

The following example Assembly Defintion JSON uses assembly GUIDs for references to other Assembly Definitions and the `excludePlatforms` key to specify an array of excluded platforms:

``` lang-yml
{
    "name": "BeeAssembly",
    "references": [
        "GUID:17b36165d09634a48bf5a0e4bb27f4bd",
        "GUID:b470eee7144904e59a1064b70fa1b086",
        "GUID:2bafac87e7f4b9b418d9448d219b01ab",
        "GUID:27619889b8ba8c24980f49ee34dbb44a",
        "GUID:0acc523941302664db1f4e527237feb3"
    ],
    "includePlatforms": [],
    "excludePlatforms": [
        "iOS",
        "macOSStandalone",
        "tvOS"
    ],
    "allowUnsafeCode": false,
    "overrideReferences": true,
    "precompiledReferences": [
        "Newtonsoft.Json.dll",
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_2019",
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [
        {
            "name": "com.unity.ide.vscode",
            "expression": "[1.7,2.4.1]",
            "define": "MY_SYMBOL"
        },
        
    ],
    "noEngineReferences": false
}
```

## Assembly Definition Reference JSON

An Assembly Definition Reference is a JSON object with only one required field: a string called `reference`. It specifies the assembly to reference, either by assembly name or by Assembly Definition asset GUID. You can use the [`AssetDatabase.AssetPathToGUID`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.AssetPathToGUID.html) function to retrieve the GUID of an asset. The GUID is also part of the metadata associated with every asset.

The following Assembly Definition Reference example references another asset by name:

``` lang-yml

```

The following Assembly Definition Reference example references another asset by asset GUID:

``` lang-yml

```

## Additional resources

-   [Create an Assembly Definition](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html#create-asmdef)
-   [Create an Assembly Definition Reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html#create-asmref)
