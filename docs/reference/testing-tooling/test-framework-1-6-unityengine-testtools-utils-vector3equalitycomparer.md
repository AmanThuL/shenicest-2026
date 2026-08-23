---
title: "Vector3EqualityComparer API"
page_title: "Class Vector3EqualityComparer
 | Test Framework | 1.6.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.Vector3EqualityComparer.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.Vector3EqualityComparer.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class Vector3EqualityComparer

Use this class to compare two Vector3 objects for equality with NUnit constraints. Call Vector3EqualityComparer.Instance comparer to perform a comparison with the default calculation error value 0.0001f. To specify a different error value, use the one argument constructor to instantiate a new comparer.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<span class="xref">Vector3EqualityComparer</span>

##### Implements

<a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.iequalitycomparer-1" class="xref">IEqualityComparer</a>\<<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a>\>

##### Inherited Members

<a href="https://learn.microsoft.com/dotnet/api/system.object.equals#system-object-equals(system-object)" class="xref">object.Equals(object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.equals#system-object-equals(system-object-system-object)" class="xref">object.Equals(object, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.gethashcode" class="xref">object.GetHashCode()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.gettype" class="xref">object.GetType()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.memberwiseclone" class="xref">object.MemberwiseClone()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.referenceequals" class="xref">object.ReferenceEquals(object, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.tostring" class="xref">object.ToString()</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.html" class="xref">UnityEngine</a>.<a href="https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.html" class="xref">TestTools</a>.<a href="https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.html" class="xref">Utils</a>

###### **Assembly**: UnityEngine.TestRunner.dll

##### Syntax

``` lang-csharp
public class Vector3EqualityComparer : IEqualityComparer<Vector3>
```

### Constructors

<span id="UnityEngine_TestTools_Utils_Vector3EqualityComparer__ctor_"></span>

#### Vector3EqualityComparer(float)

A comparer instance with the default calculation error value equal to 0.0001f.

##### Declaration

``` lang-csharp
public Vector3EqualityComparer(float allowedError)
```

##### Parameters

| Type                                                                                  | Name                                            | Description                                          |
|---------------------------------------------------------------------------------------|-------------------------------------------------|------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> | <span class="parametername">allowedError</span> | This value identifies the calculation error allowed. |

### Properties

<span id="UnityEngine_TestTools_Utils_Vector3EqualityComparer_Instance_"></span>

#### Instance

A comparer instance with the default calculation error value equal to 0.0001f.

##### Declaration

``` lang-csharp
public static Vector3EqualityComparer Instance 
```

##### Property Value

| Type                                                                                                                                                                           | Description |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.Vector3EqualityComparer.html" class="xref">Vector3EqualityComparer</a> |             |

### Methods

<span id="UnityEngine_TestTools_Utils_Vector3EqualityComparer_Equals_"></span>

#### Equals(Vector3, Vector3)

Compares the actual and expected Vector3 objects for equality using <a href="https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.Utils.html#UnityEngine_TestTools_Utils_Utils_AreFloatsEqual_System_Single_System_Single_System_Single_" class="xref">AreFloatsEqual(float, float, float)</a> to compare the x, y, and z attributes of Vector3.

##### Declaration

``` lang-csharp
public bool Equals(Vector3 expected, Vector3 actual)
```

##### Parameters

| Type                                                                                                          | Name                                        | Description                              |
|---------------------------------------------------------------------------------------------------------------|---------------------------------------------|------------------------------------------|
| <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a> | <span class="parametername">expected</span> | The expected Vector3 used for comparison |
| <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a> | <span class="parametername">actual</span>   | The actual Vector3 to test               |

##### Returns

| Type                                                                                  | Description                                      |
|---------------------------------------------------------------------------------------|--------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the vectors are equals, false otherwise. |

##### Examples

The following example shows how to verify if two Vector3 are equals

``` lang-csharp
[TestFixture]
public class Vector3Test

```

}

<span id="UnityEngine_TestTools_Utils_Vector3EqualityComparer_GetHashCode_"></span>

#### GetHashCode(Vector3)

Serves as the default hash function.

##### Declaration

``` lang-csharp
public int GetHashCode(Vector3 vec3)
```

##### Parameters

| Type                                                                                                          | Name                                    | Description        |
|---------------------------------------------------------------------------------------------------------------|-----------------------------------------|--------------------|
| <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a> | <span class="parametername">vec3</span> | A not null Vector3 |

##### Returns

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | Returns 0   |

### Implements

<a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.iequalitycomparer-1" class="xref">IEqualityComparer&lt;T&gt;</a>
