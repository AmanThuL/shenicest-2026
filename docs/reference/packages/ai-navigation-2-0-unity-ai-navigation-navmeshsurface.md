---
title: "NavMeshSurface API"
page_title: "Class NavMeshSurface
 | AI Navigation | 2.0.14"
source_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class NavMeshSurface

Component used for building and enabling a NavMesh surface for one agent type.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.html" class="xref">Object</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component.html" class="xref">Component</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Behaviour.html" class="xref">Behaviour</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.html" class="xref">MonoBehaviour</a>

<span class="xref">NavMeshSurface</span>

##### Inherited Members

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.IsInvoking.html" class="xref">MonoBehaviour.IsInvoking()</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.CancelInvoke.html" class="xref">MonoBehaviour.CancelInvoke()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.Invoke(string, float)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.InvokeRepeating(string, float, float)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.CancelInvoke(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.IsInvoking(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StartCoroutine(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StartCoroutine(string, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StartCoroutine(IEnumerator)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StartCoroutine_Auto(IEnumerator)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StopCoroutine(IEnumerator)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html" class="xref">MonoBehaviour.StopCoroutine(Coroutine)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StopCoroutine(string)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.StopAllCoroutines.html" class="xref">MonoBehaviour.StopAllCoroutines()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">MonoBehaviour.print(object)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html" class="xref">MonoBehaviour.destroyCancellationToken</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour-useGUILayout.html" class="xref">MonoBehaviour.useGUILayout</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour-didStart.html" class="xref">MonoBehaviour.didStart</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour-didAwake.html" class="xref">MonoBehaviour.didAwake</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour-runInEditMode.html" class="xref">MonoBehaviour.runInEditMode</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Behaviour-enabled.html" class="xref">Behaviour.enabled</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Behaviour-isActiveAndEnabled.html" class="xref">Behaviour.isActiveAndEnabled</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponent(Type)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponent.html" class="xref">Component.GetComponent&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.TryGetComponent(Type, out Component)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.TryGetComponent.html" class="xref">Component.TryGetComponent&lt;T&gt;(out T)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.GetComponent(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentInChildren(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentInChildren(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentInChildren&lt;T&gt;(bool)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponentInChildren.html" class="xref">Component.GetComponentInChildren&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentsInChildren(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentsInChildren(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentsInChildren&lt;T&gt;(bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentsInChildren&lt;T&gt;(bool, List&lt;T&gt;)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html" class="xref">Component.GetComponentsInChildren&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">Component.GetComponentsInChildren&lt;T&gt;(List&lt;T&gt;)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentInParent(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentInParent(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentInParent&lt;T&gt;(bool)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponentInParent.html" class="xref">Component.GetComponentInParent&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentsInParent(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponentsInParent(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentsInParent&lt;T&gt;(bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Component.GetComponentsInParent&lt;T&gt;(bool, List&lt;T&gt;)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponentsInParent.html" class="xref">Component.GetComponentsInParent&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponents(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Component.GetComponents(Type, List&lt;Component&gt;)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">Component.GetComponents&lt;T&gt;(List&lt;T&gt;)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Component.GetComponents.html" class="xref">Component.GetComponents&lt;T&gt;()</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component.GetComponentIndex.html" class="xref">Component.GetComponentIndex()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.CompareTag(string)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component.CompareTag.html" class="xref">Component.CompareTag(TagHandle)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessageUpwards(string, object, SendMessageOptions)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessageUpwards(string, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessageUpwards(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessageUpwards(string, SendMessageOptions)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessage(string, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessage(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessage(string, object, SendMessageOptions)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.SendMessage(string, SendMessageOptions)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.BroadcastMessage(string, object, SendMessageOptions)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.BroadcastMessage(string, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.BroadcastMessage(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.BroadcastMessage(string, SendMessageOptions)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component-transform.html" class="xref">Component.transform</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component-gameObject.html" class="xref">Component.gameObject</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component-tag.html" class="xref">Component.tag</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.GetInstanceID.html" class="xref">Object.GetInstanceID()</a>

<a href="https://docs.microsoft.com/en-us/dotnet/api/system.object.gethashcode?view=netcore-2.0" class="xref">Object.GetHashCode()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">Object.Equals(object)</a>

<span class="xref">Object.InstantiateAsync\<T>(T)</span>

<span class="xref">Object.InstantiateAsync\<T>(T, Transform)</span>

<span class="xref">Object.InstantiateAsync\<T>(T, Vector3, Quaternion)</span>

<span class="xref">Object.InstantiateAsync\<T>(T, Transform, Vector3, Quaternion)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Vector3, Quaternion)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform, Vector3, Quaternion)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform, Vector3, Quaternion, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.threading.cancellationtoken" class="xref">Object.InstantiateAsync&lt;T&gt;(T, InstantiateParameters, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, InstantiateParameters, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.threading.cancellationtoken" class="xref">Object.InstantiateAsync&lt;T&gt;(T, Vector3, Quaternion, InstantiateParameters, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Vector3, Quaternion, InstantiateParameters, CancellationToken)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;, InstantiateParameters, CancellationToken)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Vector3, Quaternion)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Vector3, Quaternion, Transform)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Scene)</a>

<span class="xref">Object.Instantiate\<T>(T, InstantiateParameters)</span>

<span class="xref">Object.Instantiate\<T>(T, Vector3, Quaternion, InstantiateParameters)</span>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Transform)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.Instantiate(Object, Transform, bool)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Vector3, Quaternion)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Vector3, Quaternion, Transform)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Transform)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.Instantiate&lt;T&gt;(T, Transform, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">Object.Destroy(Object, float)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Destroy.html" class="xref">Object.Destroy(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.DestroyImmediate(Object, bool)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.DestroyImmediate.html" class="xref">Object.DestroyImmediate(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfType(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsSortMode)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsInactive, FindObjectsSortMode)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.DontDestroyOnLoad.html" class="xref">Object.DontDestroyOnLoad(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">Object.DestroyObject(Object, float)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Destroy.html" class="xref">Object.DestroyObject(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindSceneObjectsOfType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfTypeIncludingAssets(Type)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.FindObjectsOfType.html" class="xref">Object.FindObjectsOfType&lt;T&gt;()</a>

<span class="xref">Object.FindObjectsByType\<T>(FindObjectsSortMode)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.FindObjectsOfType&lt;T&gt;(bool)</a>

<span class="xref">Object.FindObjectsByType\<T>(FindObjectsInactive, FindObjectsSortMode)</span>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.FindObjectOfType.html" class="xref">Object.FindObjectOfType&lt;T&gt;()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.FindObjectOfType&lt;T&gt;(bool)</a>

<span class="xref">Object.FindFirstObjectByType\<T>()</span>

<span class="xref">Object.FindAnyObjectByType\<T>()</span>

<span class="xref">Object.FindFirstObjectByType\<T>(FindObjectsInactive)</span>

<span class="xref">Object.FindAnyObjectByType\<T>(FindObjectsInactive)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfTypeAll(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectOfType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindFirstObjectByType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindAnyObjectByType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectOfType(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindFirstObjectByType(Type, FindObjectsInactive)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindAnyObjectByType(Type, FindObjectsInactive)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.ToString.html" class="xref">Object.ToString()</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object-name.html" class="xref">Object.name</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object-hideFlags.html" class="xref">Object.hideFlags</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.equals#system-object-equals(system-object-system-object)" class="xref">object.Equals(object, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.gettype" class="xref">object.GetType()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.memberwiseclone" class="xref">object.MemberwiseClone()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.referenceequals" class="xref">object.ReferenceEquals(object, object)</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.html" class="xref">Unity</a>.<a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.html" class="xref">AI</a>.<a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.html" class="xref">Navigation</a>

###### **Assembly**: Unity.AI.Navigation.dll

##### Syntax

``` lang-csharp
[ExecuteAlways]
[DefaultExecutionOrder(-102)]
[AddComponentMenu("Navigation/NavMesh Surface", 30)]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html")]
public class NavMeshSurface : MonoBehaviour
```

### Properties

<span id="Unity_AI_Navigation_NavMeshSurface_activeSurfaces_" uid="Unity.AI.Navigation.NavMeshSurface.activeSurfaces*"></span>

#### activeSurfaces

Gets the list of all the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html" class="xref">NavMeshSurface</a> components that are currently active in the scene.

##### Declaration

``` lang-csharp
public static List<NavMeshSurface> activeSurfaces 
```

##### Property Value

| Type                                                                                                                                                                                                                                                            | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.collections.generic.list-1" class="xref">List</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html" class="xref">NavMeshSurface</a>\> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_agentTypeID_" uid="Unity.AI.Navigation.NavMeshSurface.agentTypeID*"></span>

#### agentTypeID

Gets or sets the identifier of the agent type that will use this NavMesh Surface.

##### Declaration

``` lang-csharp
public int agentTypeID 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_buildHeightMesh_" uid="Unity.AI.Navigation.NavMeshSurface.buildHeightMesh*"></span>

#### buildHeightMesh

Gets or sets whether the NavMesh building process produces more detailed elevation information.

##### Declaration

``` lang-csharp
public bool buildHeightMesh 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### See Also

<https://docs.unity3d.com/Packages/com.unity.ai.navigation@1.0/manual/NavMeshSurface.html#advanced-settings>

<span id="Unity_AI_Navigation_NavMeshSurface_center_" uid="Unity.AI.Navigation.NavMeshSurface.center*"></span>

#### center

Gets or sets the center position of the volume that delimits the NavMesh created by this component.

##### Declaration

``` lang-csharp
public Vector3 center 
```

##### Property Value

| Type                                                                                                          | Description |
|---------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a> |             |

##### Remarks

It is used only when `collectObjects` is set to `Volume`. The position applies in the local space of the GameObject.

<span id="Unity_AI_Navigation_NavMeshSurface_collectObjects_" uid="Unity.AI.Navigation.NavMeshSurface.collectObjects*"></span>

#### collectObjects

Gets or sets the method for retrieving the objects that will be used for baking.

##### Declaration

``` lang-csharp
public CollectObjects collectObjects 
```

##### Property Value

| Type                                                                                                                                                | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.CollectObjects.html" class="xref">CollectObjects</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_defaultArea_" uid="Unity.AI.Navigation.NavMeshSurface.defaultArea*"></span>

#### defaultArea

Gets or sets the area type assigned to any object that does not have one specified.

##### Declaration

``` lang-csharp
public int defaultArea 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

##### Remarks

To customize the area type of an object add a <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshModifier.html" class="xref">NavMeshModifier</a> component and set <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshModifier.html#Unity_AI_Navigation_NavMeshModifier_overrideArea" class="xref">overrideArea</a> to `true`. The area type information is used when baking the NavMesh.

##### See Also

<https://docs.unity3d.com/Manual/nav-AreasAndCosts.html>

<span id="Unity_AI_Navigation_NavMeshSurface_ignoreNavMeshAgent_" uid="Unity.AI.Navigation.NavMeshSurface.ignoreNavMeshAgent*"></span>

#### ignoreNavMeshAgent

Gets or sets whether the process of building the NavMesh ignores the GameObjects containing a <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshAgent.html" class="xref">NavMeshAgent</a> component.

##### Declaration

``` lang-csharp
public bool ignoreNavMeshAgent 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

There is generally no need for the NavMesh to take into consideration the objects that can move.

<span id="Unity_AI_Navigation_NavMeshSurface_ignoreNavMeshObstacle_" uid="Unity.AI.Navigation.NavMeshSurface.ignoreNavMeshObstacle*"></span>

#### ignoreNavMeshObstacle

Gets or sets whether the process of building the NavMesh ignores the GameObjects containing a <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshObstacle.html" class="xref">NavMeshObstacle</a> component.

##### Declaration

``` lang-csharp
public bool ignoreNavMeshObstacle 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

##### Remarks

There is generally no need for the NavMesh to take into consideration the objects that can move.

<span id="Unity_AI_Navigation_NavMeshSurface_layerMask_" uid="Unity.AI.Navigation.NavMeshSurface.layerMask*"></span>

#### layerMask

Gets or sets a bitmask representing which layers to consider when selecting the objects that will be used for baking the NavMesh.

##### Declaration

``` lang-csharp
public LayerMask layerMask 
```

##### Property Value

| Type                                                                                                              | Description |
|-------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/LayerMask.html" class="xref">LayerMask</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_minRegionArea_" uid="Unity.AI.Navigation.NavMeshSurface.minRegionArea*"></span>

#### minRegionArea

Gets or sets the minimum acceptable surface area of any continuous portion of the NavMesh.

##### Declaration

``` lang-csharp
public float minRegionArea 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> |             |

##### Remarks

This parameter is used only at the time when the NavMesh is getting built. It allows you to cull away any isolated NavMesh regions that are smaller than this value and that do not straddle or touch a tile boundary.

<span id="Unity_AI_Navigation_NavMeshSurface_navMeshData_" uid="Unity.AI.Navigation.NavMeshSurface.navMeshData*"></span>

#### navMeshData

Gets or sets the reference to the NavMesh data instantiated by this surface.

##### Declaration

``` lang-csharp
public NavMeshData navMeshData 
```

##### Property Value

| Type                                                                                                                     | Description |
|--------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshData.html" class="xref">NavMeshData</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_overrideTileSize_" uid="Unity.AI.Navigation.NavMeshSurface.overrideTileSize*"></span>

#### overrideTileSize

Gets or sets whether the NavMesh building process uses the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html#Unity_AI_Navigation_NavMeshSurface_tileSize" class="xref">tileSize</a> value.

##### Declaration

``` lang-csharp
public bool overrideTileSize 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_overrideVoxelSize_" uid="Unity.AI.Navigation.NavMeshSurface.overrideVoxelSize*"></span>

#### overrideVoxelSize

Gets or sets whether the NavMesh building process uses the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html#Unity_AI_Navigation_NavMeshSurface_voxelSize" class="xref">voxelSize</a> value.

##### Declaration

``` lang-csharp
public bool overrideVoxelSize 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_size_" uid="Unity.AI.Navigation.NavMeshSurface.size*"></span>

#### size

Gets or sets the size of the volume that delimits the NavMesh created by this component.

##### Declaration

``` lang-csharp
public Vector3 size 
```

##### Property Value

| Type                                                                                                          | Description |
|---------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Vector3.html" class="xref">Vector3</a> |             |

##### Remarks

It is used only when `collectObjects` is set to `Volume`. The size applies in the local space of the GameObject.

<span id="Unity_AI_Navigation_NavMeshSurface_tileSize_" uid="Unity.AI.Navigation.NavMeshSurface.tileSize*"></span>

#### tileSize

Gets or sets the width of the square grid of voxels that the NavMesh building process uses for sampling the scene geometry.

##### Declaration

``` lang-csharp
public int tileSize 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

##### Remarks

This value represents a number of voxels. Together with <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html#Unity_AI_Navigation_NavMeshSurface_voxelSize" class="xref">voxelSize</a> it determines the real size of the individual sections that comprise the NavMesh.

<span id="Unity_AI_Navigation_NavMeshSurface_useGeometry_" uid="Unity.AI.Navigation.NavMeshSurface.useGeometry*"></span>

#### useGeometry

Gets or sets which type of component in the GameObjects provides the geometry used for baking the NavMesh.

##### Declaration

``` lang-csharp
public NavMeshCollectGeometry useGeometry 
```

##### Property Value

| Type                                                                                                                                           | Description |
|------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshCollectGeometry.html" class="xref">NavMeshCollectGeometry</a> |             |

<span id="Unity_AI_Navigation_NavMeshSurface_voxelSize_" uid="Unity.AI.Navigation.NavMeshSurface.voxelSize*"></span>

#### voxelSize

Gets or sets the width of the square voxels that the NavMesh building process uses for sampling the scene geometry.

##### Declaration

``` lang-csharp
public float voxelSize 
```

##### Property Value

| Type                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> |             |

##### Remarks

This value is in world units. Together with <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html#Unity_AI_Navigation_NavMeshSurface_tileSize" class="xref">tileSize</a> it determines the real size of the individual sections that comprise the NavMesh.

### Methods

<span id="Unity_AI_Navigation_NavMeshSurface_AddData_" uid="Unity.AI.Navigation.NavMeshSurface.AddData*"></span>

#### AddData()

Creates an instance of the NavMesh data and activates it in the navigation system.

##### Declaration

``` lang-csharp
public void AddData()
```

##### Remarks

The instance is created at the position and with the orientation of the GameObject.

<span id="Unity_AI_Navigation_NavMeshSurface_BuildNavMesh_" uid="Unity.AI.Navigation.NavMeshSurface.BuildNavMesh*"></span>

#### BuildNavMesh()

Builds and instantiates this NavMesh surface.

##### Declaration

``` lang-csharp
public void BuildNavMesh()
```

<span id="Unity_AI_Navigation_NavMeshSurface_GetBuildSettings_" uid="Unity.AI.Navigation.NavMeshSurface.GetBuildSettings*"></span>

#### GetBuildSettings()

Retrieves a copy of the current settings chosen for building this NavMesh surface.

##### Declaration

``` lang-csharp
public NavMeshBuildSettings GetBuildSettings()
```

##### Returns

| Type                                                                                                                                       | Description                                     |
|--------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshBuildSettings.html" class="xref">NavMeshBuildSettings</a> | The settings configured in this NavMeshSurface. |

<span id="Unity_AI_Navigation_NavMeshSurface_RemoveData_" uid="Unity.AI.Navigation.NavMeshSurface.RemoveData*"></span>

#### RemoveData()

Removes the instance of this NavMesh data from the navigation system.

##### Declaration

``` lang-csharp
public void RemoveData()
```

##### Remarks

This operation does not destroy the <a href="https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html#Unity_AI_Navigation_NavMeshSurface_navMeshData" class="xref">navMeshData</a>.

<span id="Unity_AI_Navigation_NavMeshSurface_UpdateNavMesh_" uid="Unity.AI.Navigation.NavMeshSurface.UpdateNavMesh*"></span>

#### UpdateNavMesh(NavMeshData)

Rebuilds parts of an existing NavMesh in the regions of the scene where the objects have changed.

##### Declaration

``` lang-csharp
public AsyncOperation UpdateNavMesh(NavMeshData data)
```

##### Parameters

| Type                                                                                                                     | Name                                    | Description                                                  |
|--------------------------------------------------------------------------------------------------------------------------|-----------------------------------------|--------------------------------------------------------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AI.NavMeshData.html" class="xref">NavMeshData</a> | <span class="parametername">data</span> | The NavMesh to update according to the changes in the scene. |

##### Returns

| Type                                                                                                                        | Description                                                        |
|-----------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/AsyncOperation.html" class="xref">AsyncOperation</a> | A reference to the asynchronous coroutine that builds the NavMesh. |

##### Remarks

This operation is executed asynchronously.
