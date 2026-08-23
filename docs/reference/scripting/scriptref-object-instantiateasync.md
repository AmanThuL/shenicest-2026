---
title: "Scripting API: Object.InstantiateAsync"
page_title: "Unity - Scripting API: Object.InstantiateAsync"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).InstantiateAsync

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects.

The operation is mainly asynchronous, but the last stage involving integration and awake calls is executed on the main thread. The operation can be cancelled, or the integration stage can be delayed using allowSceneActivation.  
  
It is possible to yield a return operation or call its WaitForCompletion() method to finish the operation in a synchronized way.  
  
For extra control you can use the overrides that take an [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct. This includes extra options like deciding between using local or world space, or to specify a target scene for the objects.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, sets `parent` as the parent of the clone, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |
| position  | The position for the new object or objects.                                                                                           |
| rotation  | The rotation for the new object or objects.                                                                                           |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, sets the parent, position, and rotation of the clone, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |
| position  | The position for the new object or objects.         |
| rotation  | The rotation for the new object or objects.         |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, sets the position and rotation of the clone, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                                                                                                |
| position          | The position for the new object or objects.                                                                                                                                                                                                        |
| rotation          | The rotation for the new object or objects.                                                                                                                                                                                                        |
| parameters        | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                                                                                                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, sets the position and rotation of the clone, applies the settings in `parameters`, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                                                                                                |
| parameters        | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                                                                                                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, applies the settings in `parameters`, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |
| count     | The number of new copies to create.                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                                                                                                |
| count             | The number of new copies to create.                                                                                                                                                                                                                |
| parameters        | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                                                                                                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, applies the settings in `parameters`, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| count     | The number of new copies to create.                                                                                                   |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets `parent` as the parent of the clones, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                           |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                   |
| count             | The number of new copies to create.                                                                                                   |
| parent            | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |
| position          | The position for the new object or objects.                                                                                           |
| rotation          | The rotation for the new object or objects.                                                                                           |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                    |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the parent, position, and rotation of the clones, and returns an `AsyncInstantiateOperation` that you can cancel with `cancellationToken`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, ReadOnlySpan\<Vector3> <span class="sig-kw">positions</span>, ReadOnlySpan\<Quaternion> <span class="sig-kw">rotations</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                 |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                         |
| count             | The number of new copies to create.                                                                                                                                         |
| parent            | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object.                                       |
| positions         | The read only span of positions for the new object or objects. The length of the span can be less than `count`, in which case Unity uses positions\[i % positions.Length\]. |
| rotations         | The read only span of rotations for the new object or objects. The length of the span can be less than `count`, in which case Unity uses rotations\[i % rotations.Length\]. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                          |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the parent and the per-copy positions and rotations of the clones, and returns an `AsyncInstantiateOperation` that you can cancel with `cancellationToken`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |
| count     | The number of new copies to create.                 |
| position  | The position for the new object or objects.         |
| rotation  | The rotation for the new object or objects.         |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the position and rotation of the clones, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                                                                                                |
| count             | The number of new copies to create.                                                                                                                                                                                                                |
| position          | The position for the new object or objects.                                                                                                                                                                                                        |
| rotation          | The rotation for the new object or objects.                                                                                                                                                                                                        |
| parameters        | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                                                                                                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the position and rotation of the clones, applies the settings in `parameters`, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, ReadOnlySpan\<Vector3> <span class="sig-kw">positions</span>, ReadOnlySpan\<Quaternion> <span class="sig-kw">rotations</span>);

### Parameters

| Parameter | Description                                                                                                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                                                         |
| count     | The number of new copies to create.                                                                                                                                         |
| positions | The read only span of positions for the new object or objects. The length of the span can be less than `count`, in which case Unity uses positions\[i % positions.Length\]. |
| rotations | The read only span of rotations for the new object or objects. The length of the span can be less than `count`, in which case Unity uses rotations\[i % rotations.Length\]. |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the per-copy positions and rotations of the clones, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, ReadOnlySpan\<Vector3> <span class="sig-kw">positions</span>, ReadOnlySpan\<Quaternion> <span class="sig-kw">rotations</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>, CancellationToken <span class="sig-kw">cancellationToken</span>);

### Parameters

| Parameter         | Description                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original          | An existing object that you want to make a copy of.                                                                                                                                                                                                |
| count             | The number of new copies to create.                                                                                                                                                                                                                |
| positions         | The read only span of positions for the new object or objects. The length of the span can be less than `count`, in which case Unity uses positions\[i % positions.Length\].                                                                        |
| rotations         | The read only span of rotations for the new object or objects. The length of the span can be less than `count`, in which case Unity uses rotations\[i % rotations.Length\].                                                                        |
| parameters        | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |
| cancellationToken | A token that you can use to cancel the asynchronous operation before it completes.                                                                                                                                                                 |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the per-copy positions and rotations of the clones, applies the settings in `parameters`, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| count     | The number of new copies to create.                                                                                                   |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |
| position  | The position for the new object or objects.                                                                                           |
| rotation  | The rotation for the new object or objects.                                                                                           |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the parent, position, and rotation of the clones, and returns an `AsyncInstantiateOperation`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static AsyncInstantiateOperation\<T> <span class="sig-kw">InstantiateAsync</span>(T <span class="sig-kw">original</span>, int <span class="sig-kw">count</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, ReadOnlySpan\<Vector3> <span class="sig-kw">positions</span>, ReadOnlySpan\<Quaternion> <span class="sig-kw">rotations</span>);

### Parameters

| Parameter | Description                                                                                                                                                                 |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                                                         |
| count     | The number of new copies to create.                                                                                                                                         |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object.                                       |
| positions | The read only span of positions for the new object or objects. The length of the span can be less than `count`, in which case Unity uses positions\[i % positions.Length\]. |
| rotations | The read only span of rotations for the new object or objects. The length of the span can be less than `count`, in which case Unity uses rotations\[i % rotations.Length\]. |

### Returns

**AsyncInstantiateOperation\<T>** An asynchronous operation that contains the resulting objects.

### Description

Clones the object of type T asynchronously, creates a specified number of copies, sets the parent and the per-copy positions and rotations of the clones, and returns an `AsyncInstantiateOperation`.
