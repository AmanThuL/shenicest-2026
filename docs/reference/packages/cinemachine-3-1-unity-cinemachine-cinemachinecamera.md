---
title: "CinemachineCamera API"
page_title: "Class CinemachineCamera
 | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCamera.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCamera.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class CinemachineCamera

This behaviour is intended to be attached to an empty GameObject, and it represents a Cinemachine Camera within the Unity scene.

The CinemachineCamera will animate its Transform according to the rules contained in its CinemachineComponent pipeline (Aim, Body, and Noise). When the CM camera is Live, the Unity camera will assume the position and orientation of the CinemachineCamera.

A CinemachineCamera is not a camera. Instead, it can be thought of as a camera controller, not unlike a cameraman. It can drive the Unity Camera and control its position, rotation, lens settings, and PostProcessing effects. Each CM Camera owns its own Cinemachine Component Pipeline, through which you can provide the instructions for procedurally tracking specific game objects. An empty procedural pipeline will result in a passive CinemachineCamera, which can be controlled in the same way as an ordinary GameObject.

A CinemachineCamera is very lightweight, and does no rendering of its own. It merely tracks interesting GameObjects, and positions itself accordingly. A typical game can have dozens of CinemachineCameras, each set up to follow a particular character or capture a particular event.

A CinemachineCamera can be in any of three states:

-   **Live**: The CinemachineCamera is actively controlling the Unity Camera. The CinemachineCamera is tracking its targets and being updated every frame.
-   **Standby**: The CinemachineCamera is tracking its targets and being updated every frame, but no Unity Camera is actively being controlled by it. This is the state of a CinemachineCamera that is enabled in the scene but perhaps at a lower priority than the Live CinemachineCamera.
-   **Disabled**: The CinemachineCamera is present but disabled in the scene. It is not actively tracking its targets and so consumes no processing power. However, the CinemachineCamera can be made live from the Timeline.

The Unity Camera can be driven by any CinemachineCamera in the scene. The game logic can choose the CinemachineCamera to make live by manipulating the CM camerass enabled flags and/or its priority, based on game logic.

In order to be driven by a CinemachineCamera, the Unity Camera must have a CinemachineBrain behaviour, which will select the most eligible CinemachineCamera based on its priority or on other criteria, and will manage blending.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.html" class="xref">Object</a>

<a href="https://docs.unity3d.com/ScriptReference/Component.html" class="xref">Component</a>

<a href="https://docs.unity3d.com/ScriptReference/Behaviour.html" class="xref">Behaviour</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour.html" class="xref">MonoBehaviour</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html" class="xref">CinemachineVirtualCameraBase</a>

<span class="xref">CinemachineCamera</span>

##### Implements

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.ICinemachineCamera.html" class="xref">ICinemachineCamera</a>

##### Inherited Members

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_Priority" class="xref">CinemachineVirtualCameraBase.Priority</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_OutputChannel" class="xref">CinemachineVirtualCameraBase.OutputChannel</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_FollowTargetAttachment" class="xref">CinemachineVirtualCameraBase.FollowTargetAttachment</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_LookAtTargetAttachment" class="xref">CinemachineVirtualCameraBase.LookAtTargetAttachment</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_StandbyUpdate" class="xref">CinemachineVirtualCameraBase.StandbyUpdate</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedFollowTargetDamp_System_Single_System_Single_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedFollowTargetDamp(float, float, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedFollowTargetDamp_UnityEngine_Vector3_UnityEngine_Vector3_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedFollowTargetDamp(Vector3, Vector3, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedFollowTargetDamp_UnityEngine_Vector3_System_Single_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedFollowTargetDamp(Vector3, float, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedLookAtTargetDamp_System_Single_System_Single_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedLookAtTargetDamp(float, float, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedLookAtTargetDamp_UnityEngine_Vector3_UnityEngine_Vector3_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedLookAtTargetDamp(Vector3, Vector3, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_DetachedLookAtTargetDamp_UnityEngine_Vector3_System_Single_System_Single_" class="xref">CinemachineVirtualCameraBase.DetachedLookAtTargetDamp(Vector3, float, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_Name" class="xref">CinemachineVirtualCameraBase.Name</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_Description" class="xref">CinemachineVirtualCameraBase.Description</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_IsValid" class="xref">CinemachineVirtualCameraBase.IsValid</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_ParentCamera" class="xref">CinemachineVirtualCameraBase.ParentCamera</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_PreviousStateIsValid" class="xref">CinemachineVirtualCameraBase.PreviousStateIsValid</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_UpdateCameraState_UnityEngine_Vector3_System_Single_" class="xref">CinemachineVirtualCameraBase.UpdateCameraState(Vector3, float)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_OnCameraActivated_Unity_Cinemachine_ICinemachineCamera_ActivationEventParams_" class="xref">CinemachineVirtualCameraBase.OnCameraActivated(ICinemachineCamera.ActivationEventParams)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_ResolveLookAt_UnityEngine_Transform_" class="xref">CinemachineVirtualCameraBase.ResolveLookAt(Transform)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_ResolveFollow_UnityEngine_Transform_" class="xref">CinemachineVirtualCameraBase.ResolveFollow(Transform)</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_MoveToTopOfPrioritySubqueue" class="xref">CinemachineVirtualCameraBase.MoveToTopOfPrioritySubqueue()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_Prioritize" class="xref">CinemachineVirtualCameraBase.Prioritize()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_FollowTargetChanged" class="xref">CinemachineVirtualCameraBase.FollowTargetChanged</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_LookAtTargetChanged" class="xref">CinemachineVirtualCameraBase.LookAtTargetChanged</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_UpdateTargetCache" class="xref">CinemachineVirtualCameraBase.UpdateTargetCache()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_FollowTargetAsGroup" class="xref">CinemachineVirtualCameraBase.FollowTargetAsGroup</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_FollowTargetAsVcam" class="xref">CinemachineVirtualCameraBase.FollowTargetAsVcam</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_LookAtTargetAsGroup" class="xref">CinemachineVirtualCameraBase.LookAtTargetAsGroup</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_LookAtTargetAsVcam" class="xref">CinemachineVirtualCameraBase.LookAtTargetAsVcam</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_IsLive" class="xref">CinemachineVirtualCameraBase.IsLive</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_IsParticipatingInBlend" class="xref">CinemachineVirtualCameraBase.IsParticipatingInBlend()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_CancelDamping_System_Boolean_" class="xref">CinemachineVirtualCameraBase.CancelDamping(bool)</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour.IsInvoking.html" class="xref">MonoBehaviour.IsInvoking()</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour.CancelInvoke.html" class="xref">MonoBehaviour.CancelInvoke()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.Invoke(string, float)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.InvokeRepeating(string, float, float)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.CancelInvoke(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.IsInvoking(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StartCoroutine(string)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StartCoroutine(string, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StartCoroutine(IEnumerator)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StartCoroutine_Auto(IEnumerator)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.collections.ienumerator" class="xref">MonoBehaviour.StopCoroutine(IEnumerator)</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour.StopCoroutine.html" class="xref">MonoBehaviour.StopCoroutine(Coroutine)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">MonoBehaviour.StopCoroutine(string)</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour.StopAllCoroutines.html" class="xref">MonoBehaviour.StopAllCoroutines()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">MonoBehaviour.print(object)</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour-destroyCancellationToken.html" class="xref">MonoBehaviour.destroyCancellationToken</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour-useGUILayout.html" class="xref">MonoBehaviour.useGUILayout</a>

<a href="https://docs.unity3d.com/ScriptReference/MonoBehaviour-runInEditMode.html" class="xref">MonoBehaviour.runInEditMode</a>

<a href="https://docs.unity3d.com/ScriptReference/Behaviour-enabled.html" class="xref">Behaviour.enabled</a>

<a href="https://docs.unity3d.com/ScriptReference/Behaviour-isActiveAndEnabled.html" class="xref">Behaviour.isActiveAndEnabled</a>

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

<a href="https://docs.unity3d.com/ScriptReference/Component.GetComponentIndex.html" class="xref">Component.GetComponentIndex()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">Component.CompareTag(string)</a>

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

<a href="https://docs.unity3d.com/ScriptReference/Component-transform.html" class="xref">Component.transform</a>

<a href="https://docs.unity3d.com/ScriptReference/Component-gameObject.html" class="xref">Component.gameObject</a>

<a href="https://docs.unity3d.com/ScriptReference/Component-tag.html" class="xref">Component.tag</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.GetInstanceID.html" class="xref">Object.GetInstanceID()</a>

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

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Transform, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;)</a>

<span class="xref">Object.InstantiateAsync\<T>(T, InstantiateParameters)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, InstantiateParameters)</a>

<span class="xref">Object.InstantiateAsync\<T>(T, Vector3, Quaternion, InstantiateParameters)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, Vector3, Quaternion, InstantiateParameters)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">Object.InstantiateAsync&lt;T&gt;(T, int, ReadOnlySpan&lt;Vector3&gt;, ReadOnlySpan&lt;Quaternion&gt;, InstantiateParameters)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Vector3, Quaternion)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Vector3, Quaternion, Transform)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Scene)</a>

<span class="xref">Object.Instantiate\<T>(T, InstantiateParameters)</span>

<span class="xref">Object.Instantiate\<T>(T, Vector3, Quaternion, InstantiateParameters)</span>

<a href="https://docs.unity3d.com/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate(Object, Transform)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.Instantiate(Object, Transform, bool)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Vector3, Quaternion)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Vector3, Quaternion, Transform)</a>

<a href="https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Object.Instantiate&lt;T&gt;(T, Transform)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.Instantiate&lt;T&gt;(T, Transform, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">Object.Destroy(Object, float)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.Destroy.html" class="xref">Object.Destroy(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">Object.DestroyImmediate(Object, bool)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.DestroyImmediate.html" class="xref">Object.DestroyImmediate(Object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsOfType(Type, bool)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsSortMode)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsInactive, FindObjectsSortMode)</a>

<a href="https://docs.unity3d.com/ScriptReference/Object.DontDestroyOnLoad.html" class="xref">Object.DontDestroyOnLoad(Object)</a>

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

<a href="https://docs.unity3d.com/ScriptReference/Object.ToString.html" class="xref">Object.ToString()</a>

<a href="https://docs.unity3d.com/ScriptReference/Object-name.html" class="xref">Object.name</a>

<a href="https://docs.unity3d.com/ScriptReference/Object-hideFlags.html" class="xref">Object.hideFlags</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.equals#system-object-equals(system-object-system-object)" class="xref">object.Equals(object, object)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.gettype" class="xref">object.GetType()</a>

<a href="https://learn.microsoft.com/dotnet/api/system.object.referenceequals" class="xref">object.ReferenceEquals(object, object)</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.html" class="xref">Unity</a>.<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.html" class="xref">Cinemachine</a>

###### **Assembly**: Unity.Cinemachine.dll

##### Syntax

``` lang-csharp
[DisallowMultipleComponent]
[ExecuteAlways]
[AddComponentMenu("Cinemachine/Cinemachine Camera")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineCamera.html")]
public sealed class CinemachineCamera : CinemachineVirtualCameraBase, ICinemachineCamera
```

### Fields

#### BlendHint

Hint for transitioning to and from this CinemachineCamera. Hints can be combined, although not all combinations make sense. In the case of conflicting hints, Cinemachine will make an arbitrary choice.

##### Declaration

``` lang-csharp
[Tooltip("Hint for transitioning to and from this CinemachineCamera.  Hints can be combined, although not all combinations make sense.  In the case of conflicting hints, Cinemachine will make an arbitrary choice.")]
public CinemachineCore.BlendHints BlendHint
```

##### Field Value

| Type                                                                                                                                                                                                                                                                                                      | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCore.html" class="xref">CinemachineCore</a>.<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCore.BlendHints.html" class="xref">BlendHints</a> |             |

#### Lens

Specifies the LensSettings of this camera. These settings will be transferred to the Unity camera when the CM Camera is live.

##### Declaration

``` lang-csharp
[Tooltip("Specifies the lens properties of this Virtual Camera.  This generally mirrors the Unity Camera's lens settings, and will be used to drive the Unity camera when the vcam is active.")]
public LensSettings Lens
```

##### Field Value

| Type                                                                                                                                        | Description |
|---------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.LensSettings.html" class="xref">LensSettings</a> |             |

#### Target

The Tracking and LookAt targets for this camera.

##### Declaration

``` lang-csharp
[Tooltip("Specifies the Tracking and LookAt targets for this camera.")]
public CameraTarget Target
```

##### Field Value

| Type                                                                                                                                        | Description |
|---------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CameraTarget.html" class="xref">CameraTarget</a> |             |

### Properties

<span id="Unity_Cinemachine_CinemachineCamera_Follow_" uid="Unity.Cinemachine.CinemachineCamera.Follow*"></span>

#### Follow

Get the current Follow target. Returns parent's Follow if parent is non-null and no specific Follow defined for this camera

##### Declaration

``` lang-csharp
public override Transform Follow 
```

##### Property Value

| Type                                                                                         | Description |
|----------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/ScriptReference/Transform.html" class="xref">Transform</a> |             |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_Follow" class="xref">CinemachineVirtualCameraBase.Follow</a>

<span id="Unity_Cinemachine_CinemachineCamera_LookAt_" uid="Unity.Cinemachine.CinemachineCamera.LookAt*"></span>

#### LookAt

Get the current LookAt target. Returns parent's LookAt if parent is non-null and no specific LookAt defined for this camera

##### Declaration

``` lang-csharp
public override Transform LookAt 
```

##### Property Value

| Type                                                                                         | Description |
|----------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/ScriptReference/Transform.html" class="xref">Transform</a> |             |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_LookAt" class="xref">CinemachineVirtualCameraBase.LookAt</a>

<span id="Unity_Cinemachine_CinemachineCamera_State_" uid="Unity.Cinemachine.CinemachineCamera.State*"></span>

#### State

The current camera state, which will applied to the Unity Camera

##### Declaration

``` lang-csharp
public override CameraState State 
```

##### Property Value

| Type                                                                                                                                      | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CameraState.html" class="xref">CameraState</a> |             |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_State" class="xref">CinemachineVirtualCameraBase.State</a>

### Methods

<span id="Unity_Cinemachine_CinemachineCamera_ForceCameraPosition_" uid="Unity.Cinemachine.CinemachineCamera.ForceCameraPosition*"></span>

#### ForceCameraPosition(Vector3, Quaternion)

Force the CinemachineCamera to assume a given position and orientation

##### Declaration

``` lang-csharp
public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
```

##### Parameters

| Type                                                                                           | Name                                   | Description                     |
|------------------------------------------------------------------------------------------------|----------------------------------------|---------------------------------|
| <a href="https://docs.unity3d.com/ScriptReference/Vector3.html" class="xref">Vector3</a>       | <span class="parametername">pos</span> | World-space position to take    |
| <a href="https://docs.unity3d.com/ScriptReference/Quaternion.html" class="xref">Quaternion</a> | <span class="parametername">rot</span> | World-space orientation to take |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_ForceCameraPosition_UnityEngine_Vector3_UnityEngine_Quaternion_" class="xref">CinemachineVirtualCameraBase.ForceCameraPosition(Vector3, Quaternion)</a>

<span id="Unity_Cinemachine_CinemachineCamera_GetCinemachineComponent_" uid="Unity.Cinemachine.CinemachineCamera.GetCinemachineComponent*"></span>

#### GetCinemachineComponent(Stage)

Get the component set for a specific stage in the pipeline.

##### Declaration

``` lang-csharp
public override CinemachineComponentBase GetCinemachineComponent(CinemachineCore.Stage stage)
```

##### Parameters

| Type                                                                                                                                                                                                                                                                                            | Name                                     | Description                               |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|-------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCore.html" class="xref">CinemachineCore</a>.<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCore.Stage.html" class="xref">Stage</a> | <span class="parametername">stage</span> | The stage for which we want the component |

##### Returns

| Type                                                                                                                                                                | Description                                                       |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineComponentBase.html" class="xref">CinemachineComponentBase</a> | The Cinemachine component for that stage, or null if not present. |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_GetCinemachineComponent_Unity_Cinemachine_CinemachineCore_Stage_" class="xref">CinemachineVirtualCameraBase.GetCinemachineComponent(CinemachineCore.Stage)</a>

<span id="Unity_Cinemachine_CinemachineCamera_GetMaxDampTime_" uid="Unity.Cinemachine.CinemachineCamera.GetMaxDampTime*"></span>

#### GetMaxDampTime()

Query components and extensions for the maximum damping time.

##### Declaration

``` lang-csharp
public override float GetMaxDampTime()
```

##### Returns

| Type                                                                                  | Description                                       |
|---------------------------------------------------------------------------------------|---------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a> | Highest damping setting in this CinemachineCamera |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_GetMaxDampTime" class="xref">CinemachineVirtualCameraBase.GetMaxDampTime()</a>

<span id="Unity_Cinemachine_CinemachineCamera_InternalUpdateCameraState_" uid="Unity.Cinemachine.CinemachineCamera.InternalUpdateCameraState*"></span>

#### InternalUpdateCameraState(Vector3, float)

Internal use only. Called by CinemachineCore at designated update time so the vcam can position itself and track its targets.

##### Declaration

``` lang-csharp
public override void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
```

##### Parameters

| Type                                                                                     | Name                                         | Description                                               |
|------------------------------------------------------------------------------------------|----------------------------------------------|-----------------------------------------------------------|
| <a href="https://docs.unity3d.com/ScriptReference/Vector3.html" class="xref">Vector3</a> | <span class="parametername">worldUp</span>   | Default world Up, set by the CinemachineBrain             |
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a>    | <span class="parametername">deltaTime</span> | Delta time for time-based effects (ignore if less than 0) |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_InternalUpdateCameraState_UnityEngine_Vector3_System_Single_" class="xref">CinemachineVirtualCameraBase.InternalUpdateCameraState(Vector3, float)</a>

<span id="Unity_Cinemachine_CinemachineCamera_OnTargetObjectWarped_" uid="Unity.Cinemachine.CinemachineCamera.OnTargetObjectWarped*"></span>

#### OnTargetObjectWarped(Transform, Vector3)

This is called to notify the CinemachineCamera that a target got warped, so that the CinemachineCamera can update its internal state to make the camera also warp seamlessly.

##### Declaration

``` lang-csharp
public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
```

##### Parameters

| Type                                                                                         | Name                                             | Description                              |
|----------------------------------------------------------------------------------------------|--------------------------------------------------|------------------------------------------|
| <a href="https://docs.unity3d.com/ScriptReference/Transform.html" class="xref">Transform</a> | <span class="parametername">target</span>        | The object that was warped               |
| <a href="https://docs.unity3d.com/ScriptReference/Vector3.html" class="xref">Vector3</a>     | <span class="parametername">positionDelta</span> | The amount the target's position changed |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_OnTargetObjectWarped_UnityEngine_Transform_UnityEngine_Vector3_" class="xref">CinemachineVirtualCameraBase.OnTargetObjectWarped(Transform, Vector3)</a>

<span id="Unity_Cinemachine_CinemachineCamera_OnTransitionFromCamera_" uid="Unity.Cinemachine.CinemachineCamera.OnTransitionFromCamera*"></span>

#### OnTransitionFromCamera(ICinemachineCamera, Vector3, float)

Handle transition from another CinemachineCamera. InheritPosition is implemented here.

##### Declaration

``` lang-csharp
public override void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
```

##### Parameters

| Type                                                                                                                                                    | Name                                         | Description                                                           |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------|-----------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.ICinemachineCamera.html" class="xref">ICinemachineCamera</a> | <span class="parametername">fromCam</span>   | The camera being deactivated. May be null.                            |
| <a href="https://docs.unity3d.com/ScriptReference/Vector3.html" class="xref">Vector3</a>                                                                | <span class="parametername">worldUp</span>   | Default world Up, set by the CinemachineBrain                         |
| <a href="https://learn.microsoft.com/dotnet/api/system.single" class="xref">float</a>                                                                   | <span class="parametername">deltaTime</span> | Delta time for time-based effects (ignore if less than or equal to 0) |

##### Overrides

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html#Unity_Cinemachine_CinemachineVirtualCameraBase_OnTransitionFromCamera_Unity_Cinemachine_ICinemachineCamera_UnityEngine_Vector3_System_Single_" class="xref">CinemachineVirtualCameraBase.OnTransitionFromCamera(ICinemachineCamera, Vector3, float)</a>

### Implements

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.ICinemachineCamera.html" class="xref">ICinemachineCamera</a>

### Extension Methods

<a href="https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineInputProviderExtensions.html#Unity_Cinemachine_CinemachineInputProviderExtensions_GetInputAxisProvider_Unity_Cinemachine_CinemachineVirtualCameraBase_" class="xref">CinemachineInputProviderExtensions.GetInputAxisProvider(CinemachineVirtualCameraBase)</a>
