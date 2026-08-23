---
title: "PlayerInput API"
page_title: "Class PlayerInput
 | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class PlayerInput

Represents a separate player in the game complete with a set of actions exclusive to the player and a set of paired devices.

##### Inheritance

<a href="https://learn.microsoft.com/dotnet/api/system.object" class="xref">object</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.html" class="xref">Object</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Component.html" class="xref">Component</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Behaviour.html" class="xref">Behaviour</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MonoBehaviour.html" class="xref">MonoBehaviour</a>

<span class="xref">PlayerInput</span>

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

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsSortMode)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindObjectsByType(Type, FindObjectsInactive, FindObjectsSortMode)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.DontDestroyOnLoad.html" class="xref">Object.DontDestroyOnLoad(Object)</a>

<span class="xref">Object.FindObjectsByType\<T>(FindObjectsSortMode)</span>

<span class="xref">Object.FindObjectsByType\<T>(FindObjectsInactive, FindObjectsSortMode)</span>

<span class="xref">Object.FindFirstObjectByType\<T>()</span>

<span class="xref">Object.FindAnyObjectByType\<T>()</span>

<span class="xref">Object.FindFirstObjectByType\<T>(FindObjectsInactive)</span>

<span class="xref">Object.FindAnyObjectByType\<T>(FindObjectsInactive)</span>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindFirstObjectByType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindAnyObjectByType(Type)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindFirstObjectByType(Type, FindObjectsInactive)</a>

<a href="https://learn.microsoft.com/dotnet/api/system.type" class="xref">Object.FindAnyObjectByType(Type, FindObjectsInactive)</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.ToString.html" class="xref">Object.ToString()</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object-name.html" class="xref">Object.name</a>

<a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object-hideFlags.html" class="xref">Object.hideFlags</a>

###### **Namespace**: <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.html" class="xref">UnityEngine</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.html" class="xref">InputSystem</a>

###### **Assembly**: Unity.InputSystem.dll

##### Syntax

``` lang-csharp
[AddComponentMenu("Input/Player Input")]
[DisallowMultipleComponent]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/player-input-component.html")]
public class PlayerInput : MonoBehaviour
```

##### **Remarks**

The `PlayerInput` class is a high-level wrapper around much of the input system's functionality which helps set up the new input system quickly. PlayerInput manages <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>s and has a custom UI to help set up input. Note that the input system's custom UI requires the [Unity UI](https://docs.unity3d.com/Packages/com.unity.ugui@latest) package.

The [Player Input](xref:input-system-player-input) component supports local multiplayer implicitly. Each PlayerInput instance represents a distinct user with its own set of devices and actions. To orchestrate player management and facilitate mechanics, such as joining by device activity, use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>.

The way PlayerInput notifies script code of events is determined by the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> property. By default, this is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_SendMessages" class="xref">PlayerNotifications.SendMessages</a>, which uses <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.SendMessage.html" class="xref">SendMessage</a> to send messages to the <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html" class="xref">GameObject</a> that the PlayerInput is connected to.

When enabled, PlayerInput creates an <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html" class="xref">InputUser</a> instance and pairs devices to the user which are then associated to the player. If you instantiate a PlayerInput through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_Instantiate_UnityEngine_GameObject_System_Int32_System_String_System_Int32_UnityEngine_InputSystem_InputDevice___" class="xref">Instantiate(GameObject, int, string, int, params InputDevice[])</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_Instantiate_UnityEngine_GameObject_System_Int32_System_String_System_Int32_UnityEngine_InputSystem_InputDevice_" class="xref">Instantiate(GameObject, int, string, int, InputDevice)</a>, you can also control the set of devices explicitly through the PlayerInput instance. This also makes it possible to assign the same device to two different players, for example for split-keyboard play:

    var p1 = PlayerInput.Instantiate(playerPrefab,
        controlScheme: "KeyboardLeft", device: Keyboard.current);
    var p2 = PlayerInput.Instantiate(playerPrefab,
        controlScheme: "KeyboardRight", device: Keyboard.current);

If a PlayerInput instance isn't paired to a specific device, the Player Input component looks for compatible devices present in the input system and pairs them to the PlayerInput instance automatically. If the PlayerInput's set of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> have control schemes defined, the PlayerInput looks for a control scheme for which all required devices are available and doesn't pair to any other player. The PlayerInput tries to pair using the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_defaultControlScheme" class="xref">defaultControlScheme</a> first (if set). If the pairing is unsuccessful, it tries each available scheme in order. After it finds a scheme where all required devices are available, PlayerInput pairs those devices to itself and selects the given scheme.

If no control schemes are defined, PlayerInput tries to bind as many unpaired devices to itself as it can match to the bindings present in its set of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>. For example, when the PlayerInput is enabled, if it finds a binding for both keyboard and gamepad, and one keyboard and two gamepads are available in the input system, the PlayerInput pairs all three devices to the player.

##### Note

When you use the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/player-input-manager-component.html" class="xref">Player Input Manager</a> component, the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a> itself controls pairing devices to players through the joining logic. For more information, refer to the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a> class documentation.

To change device pairings at any time, you can use either of these techniques:

-   Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html#UnityEngine_InputSystem_Users_InputUser_PerformPairingWithDevice_UnityEngine_InputSystem_InputDevice_UnityEngine_InputSystem_Users_InputUser_UnityEngine_InputSystem_Users_InputUserPairingOptions_" class="xref">PerformPairingWithDevice(InputDevice, InputUser, InputUserPairingOptions)</a> (and related methods) to manually control pairing using a PlayerInput's assigned <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_user" class="xref">user</a> property.
-   Switch control schemes (for example, using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_System_String_UnityEngine_InputSystem_InputDevice___" class="xref">SwitchCurrentControlScheme(string, params InputDevice[])</a>), if any are present in the PlayerInput's set of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>.

When a player loses a paired device (such as when it is unplugged or loses power), <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html" class="xref">InputUser</a> signals <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUserChange.html#UnityEngine_InputSystem_Users_InputUserChange_DeviceLost" class="xref">DeviceLost</a> which is also surfaced as a message, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_deviceLostEvent" class="xref">deviceLostEvent</a>, or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceLost" class="xref">onDeviceLost</a> (depending on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a>). When the device reconnects, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html" class="xref">InputUser</a> signals <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUserChange.html#UnityEngine_InputSystem_Users_InputUserChange_DeviceRegained" class="xref">DeviceRegained</a> which also is surfaced as a message, as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_deviceRegainedEvent" class="xref">deviceRegainedEvent</a>, or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceRegained" class="xref">onDeviceRegained</a> (depending on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a>).

When there is only a single active PlayerInput in the game, joining is not enabled (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_joiningEnabled" class="xref">joiningEnabled</a>), and if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_neverAutoSwitchControlSchemes" class="xref">neverAutoSwitchControlSchemes</a> is not set to `true`, device pairings for the player also update automatically based on device usage.

If control schemes are present in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>, then if a device is used (not merely plugged in but rather receives input on a non-noisy, non-synthetic control) which is compatible with a control scheme other than the currently used one, PlayerInput will attempt to switch to that control scheme. Success depends on whether all device requirements for that scheme are met from the set of available devices. If a control scheme happens, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html" class="xref">InputUser</a> signals <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUserChange.html#UnityEngine_InputSystem_Users_InputUserChange_ControlSchemeChanged" class="xref">ControlSchemeChanged</a> on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html#UnityEngine_InputSystem_Users_InputUser_onChange" class="xref">onChange</a>.

If no control schemes are present in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>, PlayerInput will automatically pair any newly available device to itself if the given device has any bindings available for it.

Both behaviors described in the previous two paragraphs are automatically disabled if more than one PlayerInput is active.

##### **Examples**

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    // 'Move' input action has been triggered.
    public void OnMove(InputValue value)
    
    // 'Look' input action has been triggered.
    public void OnLook(InputValue value)
    
    public void OnUpdate()
    
}
```

It is also possible to use the polling API of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>s (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_triggered" class="xref">triggered</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_ReadValue__1" class="xref">ReadValue&lt;TValue&gt;()</a>) in combination with PlayerInput.

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    if (m_FireAction.triggered)
        /* firing logic... */;

    var move = m_MoveAction.ReadValue<Vector2>();
    var look = m_LookAction.ReadValue<Vector2>();
    /* Update transform from move&look... */
}
```

}

### Fields

#### ControlsChangedMessage

Name of the message that is sent with `UnityEngine.Object.SendMessage` when the controls used by a player are changed.

##### Declaration

``` lang-csharp
public const string ControlsChangedMessage = "OnControlsChanged"
```

##### Field Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> |             |

##### Remarks

The default value is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onControlsChanged" class="xref">onControlsChanged</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

#### DeviceLostMessage

Name of the message that is sent with `UnityEngine.Object.SendMessage` when a player loses a device.

##### Declaration

``` lang-csharp
public const string DeviceLostMessage = "OnDeviceLost"
```

##### Field Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> |             |

##### Remarks

The default value is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceLost" class="xref">onDeviceLost</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

#### DeviceRegainedMessage

Name of the message that is sent with `UnityEngine.Object.SendMessage` when a player regains a device.

##### Declaration

``` lang-csharp
public const string DeviceRegainedMessage = "OnDeviceRegained"
```

##### Field Value

| Type                                                                                   | Description |
|----------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> |             |

##### Remarks

The default value is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceRegained" class="xref">onDeviceRegained</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

### Properties

<span id="UnityEngine_InputSystem_PlayerInput_actionEvents_" uid="UnityEngine.InputSystem.PlayerInput.actionEvents*"></span>

#### actionEvents

List of events invoked in response to actions being triggered.

##### Declaration

``` lang-csharp
public ReadOnlyArray<PlayerInput.ActionEvent> actionEvents 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.ActionEvent.html" class="xref">ActionEvent</a>\> |             |

##### Remarks

This array is only used if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref">InvokeUnityEvents</a>.

The list of actions will be dependent on the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a> specified in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> Editor UI.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_actions_" uid="UnityEngine.InputSystem.PlayerInput.actions*"></span>

#### actions

Input actions associated with the player.

##### Declaration

``` lang-csharp
public InputActionAsset actions 
```

##### Property Value

| Type                                                                                                                                                       | Description                               |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html" class="xref">InputActionAsset</a> | Asset holding the player's input actions. |

##### Remarks

Note that every player will maintain a unique copy of the given actions such that each player receives an identical copy. When assigning the same actions to multiple players, the first player will use the given actions as is but any subsequent player will make a copy of the actions using <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Instantiate(Object)</a>.

The asset may contain an arbitrary number of action maps. By setting <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_defaultActionMap" class="xref">defaultActionMap</a>, one of them can be selected to enabled automatically when PlayerInput is enabled. If no default action map is selected, none of the action maps will be enabled by PlayerInput itself. Use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentActionMap_System_String_" class="xref">SwitchCurrentActionMap(string)</a> or just call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_Enable" class="xref">Enable()</a> directly to enable a specific map.

Notifications will be sent for all actions in the asset, not just for those in the first action map. This means that if additional maps are manually enabled and disabled, notifications will be sent for their actions as they receive input.

Actions can also be associated with a user via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html#UnityEngine_InputSystem_Users_InputUser_actions" class="xref">actions</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_all_" uid="UnityEngine.InputSystem.PlayerInput.all*"></span>

#### all

List of all players that are currently joined. Sorted by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a> in increasing order.

##### Declaration

``` lang-csharp
public static ReadOnlyArray<PlayerInput> all 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                 | Description                  |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>\> | List of active PlayerInputs. |

##### Remarks

While the list is sorted by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a>, note that this does not mean that the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a> of a player corresponds to the index in this list. If, for example, three players join and then the second player leaves, the list will contain one player with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a> 0 followed by one player with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a> 2.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine.InputSystem.PlayerInputManager.JoinPlayer(System.Int32,System.Int32,System.String,UnityEngine.InputSystem.InputDevice)" class="xref">JoinPlayer</a>(<a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>, <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>, <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>)

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_Instantiate_UnityEngine_GameObject_System_Int32_System_String_System_Int32_UnityEngine_InputSystem_InputDevice_" class="xref">Instantiate(GameObject, int, string, int, InputDevice)</a>

<span id="UnityEngine_InputSystem_PlayerInput_camera_" uid="UnityEngine.InputSystem.PlayerInput.camera*"></span>

#### camera

Optional camera associated with the player.

##### Declaration

``` lang-csharp
public Camera camera 
```

##### Property Value

| Type                                                                                                        | Description |
|-------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Camera.html" class="xref">Camera</a> |             |

##### Remarks

Camera specific to the player or `null`. This is `null` by default.

Associating a camera with a player is necessary only when using split-screen (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_splitScreen" class="xref">splitScreen</a>).

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_controlsChangedEvent_" uid="UnityEngine.InputSystem.PlayerInput.controlsChangedEvent*"></span>

#### controlsChangedEvent

Event that is triggered when the controls used by the player change.

##### Declaration

``` lang-csharp
public PlayerInput.ControlsChangedEvent controlsChangedEvent 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                            | Description |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.ControlsChangedEvent.html" class="xref">ControlsChangedEvent</a> |             |

##### Remarks

This event is only used if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref">InvokeUnityEvents</a>.

The event is trigger when the set of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a> used by the player change, when the player switches to a different control scheme (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a>), or when the bindings used by the player are changed (e.g. when rebinding them). Also, for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> devices, the event is triggered when the currently used keyboard layout (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html#UnityEngine_InputSystem_Keyboard_keyboardLayout" class="xref">keyboardLayout</a>) changes.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_currentActionMap_" uid="UnityEngine.InputSystem.PlayerInput.currentActionMap*"></span>

#### currentActionMap

The currently enabled action map on the PlayerInput component.

##### Declaration

``` lang-csharp
public InputActionMap currentActionMap 
```

##### Property Value

| Type                                                                                                                                                   | Description                                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a> | Reference to the currently enabled action map or `null` if no action map has been enabled by PlayerInput. |

##### Remarks

Note that the concept of "current action map" is local to PlayerInput. You can still freely enable and disable action maps directly on the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> asset. This property only tracks which action map has been enabled under the control of PlayerInput, i.e. either by means of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_defaultActionMap" class="xref">defaultActionMap</a> or by using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentActionMap_System_String_" class="xref">SwitchCurrentActionMap(string)</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_currentControlScheme_" uid="UnityEngine.InputSystem.PlayerInput.currentControlScheme*"></span>

#### currentControlScheme

Name of the currently active control scheme.

##### Declaration

``` lang-csharp
public string currentControlScheme 
```

##### Property Value

| Type                                                                                   | Description                                            |
|----------------------------------------------------------------------------------------|--------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Name of the currently active control scheme or `null`. |

##### Remarks

Note that this property will be `null` if there are no <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_controlSchemes" class="xref">controlSchemes</a> defined in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>.

This can be set via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_UnityEngine_InputSystem_InputDevice___" class="xref">SwitchCurrentControlScheme(params InputDevice[])</a>. When the player input is enabled it is dependent on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_defaultControlScheme" class="xref">defaultControlScheme</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_defaultActionMap_" uid="UnityEngine.InputSystem.PlayerInput.defaultActionMap*"></span>

#### defaultActionMap

Name (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_name" class="xref">name</a>) or ID (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_id" class="xref">id</a>) of the action map to enable by default.

##### Declaration

``` lang-csharp
public string defaultActionMap 
```

##### Property Value

| Type                                                                                   | Description                                |
|----------------------------------------------------------------------------------------|--------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Action map to enable by default or `null`. |

##### Remarks

By default, when enabled, PlayerInput will not enable any of the actions in the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> asset. By setting this property, however, PlayerInput can be made to automatically enable the respective action map.

It will impact the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentActionMap" class="xref">currentActionMap</a> when the PlayerInput is enabled. Note that you can still switch action map manually using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentActionMap_System_String_" class="xref">SwitchCurrentActionMap(string)</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_defaultControlScheme_" uid="UnityEngine.InputSystem.PlayerInput.defaultControlScheme*"></span>

#### defaultControlScheme

The default control scheme to try to activate when the PlayerInput component is enabled

##### Declaration

``` lang-csharp
public string defaultControlScheme 
```

##### Property Value

| Type                                                                                   | Description                         |
|----------------------------------------------------------------------------------------|-------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | Name of the default control scheme. |

##### Remarks

When PlayerInput is enabled and this is not `null` and not empty, the PlayerInput will look up the control scheme in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_controlSchemes" class="xref">controlSchemes</a> of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>. If found, PlayerInput will try to activate the scheme. This will succeed only if all devices required by the control scheme are either already paired to the player or are available as devices not used by other PlayerInputs.

Note that this property only determines the first control scheme to try. If using the control scheme fails, PlayerInput will fall back to trying the other control schemes (if any) available from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>.

Note that you can switch the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a> manually using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_UnityEngine_InputSystem_InputDevice___" class="xref">SwitchCurrentControlScheme(params InputDevice[])</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_deviceLostEvent_" uid="UnityEngine.InputSystem.PlayerInput.deviceLostEvent*"></span>

#### deviceLostEvent

Event that is triggered when the player loses a device (e.g. the batteries run out).

##### Declaration

``` lang-csharp
public PlayerInput.DeviceLostEvent deviceLostEvent 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                  | Description |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.DeviceLostEvent.html" class="xref">DeviceLostEvent</a> |             |

##### Remarks

This event is only used if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref">InvokeUnityEvents</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_deviceRegainedEvent_" uid="UnityEngine.InputSystem.PlayerInput.deviceRegainedEvent*"></span>

#### deviceRegainedEvent

Event that is triggered when the player recovers from device loss and is good to go again.

##### Declaration

``` lang-csharp
public PlayerInput.DeviceRegainedEvent deviceRegainedEvent 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                          | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.DeviceRegainedEvent.html" class="xref">DeviceRegainedEvent</a> |             |

##### Remarks

This event is only used if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref">InvokeUnityEvents</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_devices_" uid="UnityEngine.InputSystem.PlayerInput.devices*"></span>

#### devices

The list of devices paired to the player.

##### Declaration

``` lang-csharp
public ReadOnlyArray<InputDevice> devices 
```

##### Property Value

| Type                                                                                                                                                                                                                                                                                                                 | Description                       |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Utilities.ReadOnlyArray-1.html" class="xref">ReadOnlyArray</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\> | List of devices paired to player. |

##### Remarks

An InputUser also has a list of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html#UnityEngine_InputSystem_Users_InputUser_pairedDevices" class="xref">pairedDevices</a>

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_hasMissingRequiredDevices_" uid="UnityEngine.InputSystem.PlayerInput.hasMissingRequiredDevices*"></span>

#### hasMissingRequiredDevices

Whether the player is missed required devices. This means that the player's input setup is probably at least partially non-functional.

##### Declaration

``` lang-csharp
public bool hasMissingRequiredDevices 
```

##### Property Value

| Type                                                                                  | Description                                                           |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the player is missing devices required by the control scheme. |

##### Remarks

This can happen, for example, if a device is unplugged during the game. This can also be queried at user level via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html#UnityEngine_InputSystem_Users_InputUser_hasMissingRequiredDevices" class="xref">hasMissingRequiredDevices</a>. The control scheme set on the PlayerInput component will specify the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlScheme.html#UnityEngine_InputSystem_InputControlScheme_deviceRequirements" class="xref">deviceRequirements</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_inputIsActive_" uid="UnityEngine.InputSystem.PlayerInput.inputIsActive*"></span>

#### inputIsActive

Whether input is on the player is active.

##### Declaration

``` lang-csharp
public bool inputIsActive 
```

##### Property Value

| Type                                                                                  | Description                             |
|---------------------------------------------------------------------------------------|-----------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | If true, the player is receiving input. |

##### Remarks

To activate and deactivate input use <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_ActivateInput" class="xref">ActivateInput()</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_DeactivateInput" class="xref">DeactivateInput()</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_isSinglePlayer_" uid="UnityEngine.InputSystem.PlayerInput.isSinglePlayer*"></span>

#### isSinglePlayer

Whether PlayerInput operates in single-player mode.

##### Declaration

``` lang-csharp
public static bool isSinglePlayer 
```

##### Property Value

| Type                                                                                  | Description                                     |
|---------------------------------------------------------------------------------------|-------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | If true, there is at most a single PlayerInput. |

##### Remarks

Single-player mode is active while there is at most one PlayerInput (there can also be none) and while joining is not enabled in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a> (if one exists). See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_joiningEnabled" class="xref">joiningEnabled</a>.

Automatic control scheme switching (if enabled) is predicated on single-player mode being active. This is controlled by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_neverAutoSwitchControlSchemes" class="xref">neverAutoSwitchControlSchemes</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_neverAutoSwitchControlSchemes_" uid="UnityEngine.InputSystem.PlayerInput.neverAutoSwitchControlSchemes*"></span>

#### neverAutoSwitchControlSchemes

If true, do not automatically switch control schemes even when there is only a single player. By default, this property is false.

##### Declaration

``` lang-csharp
public bool neverAutoSwitchControlSchemes 
```

##### Property Value

| Type                                                                                  | Description                                                         |
|---------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | If true, do not switch control schemes when other devices are used. |

##### Remarks

By default, when there is only a single PlayerInput enabled (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_isSinglePlayer" class="xref">isSinglePlayer</a>), we assume that the game is in single-player mode and that the player should be able to freely switch between the control schemes supported by the game. For example, if the player is currently using mouse and keyboard, but is then switching to a gamepad, PlayerInput should automatically switch to the control scheme for gamepads, if present.

When there is more than one PlayerInput or when joining is enabled <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>, this behavior is automatically turned off as we wouldn't know which player is switching if a currently unpaired device is used.

By setting this property to true, auto-switching of control schemes is forcibly turned off and will thus not be performed even if there is only a single PlayerInput in the game.

Note that you can still switch the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a> manually using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_System_String_UnityEngine_InputSystem_InputDevice___" class="xref">SwitchCurrentControlScheme(string, params InputDevice[])</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_notificationBehavior_" uid="UnityEngine.InputSystem.PlayerInput.notificationBehavior*"></span>

#### notificationBehavior

Determines how the component notifies listeners about input actions and other input-related events pertaining to the player.

##### Declaration

``` lang-csharp
public PlayerNotifications notificationBehavior 
```

##### Property Value

| Type                                                                                                                                                             | Description                             |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html" class="xref">PlayerNotifications</a> | How to trigger notifications on events. |

##### Remarks

By default, the component will use <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">SendMessage(string, object)</a> to send messages to the <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html" class="xref">GameObject</a>. This can be changed by selecting a different <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html" class="xref">PlayerNotifications</a> behavior.

Action Events are listed in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actionEvents" class="xref">actionEvents</a>. Device events can be set via <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_deviceLostEvent" class="xref">deviceLostEvent</a> and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_deviceRegainedEvent" class="xref">deviceRegainedEvent</a>.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_playerIndex_" uid="UnityEngine.InputSystem.PlayerInput.playerIndex*"></span>

#### playerIndex

Unique, zero-based index of the player. For example, `2` for the third player.

##### Declaration

``` lang-csharp
public int playerIndex 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

##### Remarks

Once assigned, a player index will not change.

Note that the player index does not necessarily correspond to the player's index in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_all" class="xref">all</a>. The array will always contain all currently enabled players so when a player is disabled or destroyed, it will be removed from the array. However, the player index of the remaining players will not change.

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_splitScreenIndex_" uid="UnityEngine.InputSystem.PlayerInput.splitScreenIndex*"></span>

#### splitScreenIndex

If split-screen is enabled (<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_splitScreen" class="xref">splitScreen</a>), this is the index of the screen area used by the player.

##### Declaration

``` lang-csharp
public int splitScreenIndex 
```

##### Property Value

| Type                                                                               | Description |
|------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> |             |

##### Remarks

Index of split-screen area assigned to player or -1 if the player is not using split-screen.

Split screen areas are enumerated row by row and within rows, column by column. So, if, for example, there are four separate <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_splitScreen" class="xref">splitScreen</a> areas, the upper left one is #0, the upper right one is #1, the lower left one is #2, and the lower right one is #3.

Split screen areas are usually assigned automatically but players can also be assigned to areas explicitly through <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_Instantiate_UnityEngine_GameObject_System_Int32_System_String_System_Int32_UnityEngine_InputSystem_InputDevice_" class="xref">Instantiate(GameObject, int, string, int, InputDevice)</a> or <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html#UnityEngine_InputSystem_PlayerInputManager_JoinPlayer_System_Int32_System_Int32_System_String_UnityEngine_InputSystem_InputDevice_" class="xref">JoinPlayer(int, int, string, InputDevice)</a>.

See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_camera" class="xref">camera</a>

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_uiInputModule_" uid="UnityEngine.InputSystem.PlayerInput.uiInputModule*"></span>

#### uiInputModule

UI InputModule that should have it's input actions synchronized to this PlayerInput's actions.

##### Declaration

``` lang-csharp
public InputSystemUIInputModule uiInputModule 
```

##### Property Value

| Type                                                                                                                                                                          | Description |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.UI.InputSystemUIInputModule.html" class="xref">InputSystemUIInputModule</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_user_" uid="UnityEngine.InputSystem.PlayerInput.user*"></span>

#### user

The internal user tied to the player.

##### Declaration

``` lang-csharp
public InputUser user 
```

##### Property Value

| Type                                                                                                                                               | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUser.html" class="xref">InputUser</a> |             |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

### Methods

<span id="UnityEngine_InputSystem_PlayerInput_ActivateInput_" uid="UnityEngine.InputSystem.PlayerInput.ActivateInput*"></span>

#### ActivateInput()

Enable input on the player, by enabling the current action map

##### Declaration

``` lang-csharp
public void ActivateInput()
```

##### Remarks

Input will automatically be activated when the PlayerInput component is enabled. However, this method can be called to reactivate input after deactivating it with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_DeactivateInput" class="xref">DeactivateInput()</a>.

Note that activating input will activate the current action map only (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentActionMap" class="xref">currentActionMap</a>). The state can be checked with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_inputIsActive" class="xref">inputIsActive</a>.

##### Examples

``` lang-csharp
PlayerInput.all[0].ActivateInput();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_DeactivateInput_" uid="UnityEngine.InputSystem.PlayerInput.DeactivateInput*"></span>

#### DeactivateInput()

Disable input on the player, by disabling the current action map

##### Declaration

``` lang-csharp
public void DeactivateInput()
```

##### Remarks

Input is automatically activated when the PlayerInput component is enabled. This method can be used to deactivate input manually.

Note that activating input will deactivate the current action map only (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentActionMap" class="xref">currentActionMap</a>).

##### Examples

``` lang-csharp
PlayerInput.all[0].DeactivateInput();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_ActivateInput" class="xref">ActivateInput()</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_inputIsActive" class="xref">inputIsActive</a>

<span id="UnityEngine_InputSystem_PlayerInput_DebugLogAction_" uid="UnityEngine.InputSystem.PlayerInput.DebugLogAction*"></span>

#### DebugLogAction(CallbackContext)

Debug helper method that can be hooked up to actions.

##### Declaration

``` lang-csharp
public void DebugLogAction(InputAction.CallbackContext context)
```

##### Parameters

| Type                                                                                                                                                                                                                                                                                                                  | Name                                       | Description                                  |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|----------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">CallbackContext</a> | <span class="parametername">context</span> | Information about what triggered the action. |

##### Remarks

Debug helper method that can be hooked up to actions when using <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref">InvokeUnityEvents</a>.

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    public void OnDisable()
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_FindFirstPairedToDevice_" uid="UnityEngine.InputSystem.PlayerInput.FindFirstPairedToDevice*"></span>

#### FindFirstPairedToDevice(InputDevice)

Find the first PlayerInput who the given device is paired to.

##### Declaration

``` lang-csharp
public static PlayerInput FindFirstPairedToDevice(InputDevice device)
```

##### Parameters

| Type                                                                                                                                             | Name                                      | Description              |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|--------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">device</span> | An input device to query |

##### Returns

| Type                                                                                                                                             | Description                                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> | The player who is paired to the given device or `null` if no PlayerInput currently is paired to `device`. |

##### Remarks

There could be multiple players paired to the device. This function will return the first one found.

##### Examples

``` lang-csharp
// Find the player paired to first gamepad.
var player = PlayerInput.FindFirstPairedToDevice(Gamepad.all[0]);
```

##### Exceptions

| Type                                                                                                                 | Condition           |
|----------------------------------------------------------------------------------------------------------------------|---------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `device` is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_GetDevice_" uid="UnityEngine.InputSystem.PlayerInput.GetDevice*"></span>

#### GetDevice\<TDevice>()

Return the first device of the given type from <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a> paired to the player.

##### Declaration

``` lang-csharp
public TDevice GetDevice<TDevice>() where TDevice : InputDevice
```

##### Returns

| Type                              | Description                                                                                                              |
|-----------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| <span class="xref">TDevice</span> | The first device paired to the player that is of the given type or `null` if the player does not have a matching device. |

##### Type Parameters

| Name                                       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span class="parametername">TDevice</span> | Type of device to look for (such as <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Mouse.html" class="xref">Mouse</a>). Can be a supertype of the actual device type. For example, querying for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Pointer.html" class="xref">Pointer</a>, may return a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Mouse.html" class="xref">Mouse</a>. |

##### Remarks

If no device of this type is paired to the player, return `null`.

##### Examples

``` lang-csharp
var device = PlayerInput.all[0].GetDevice<Mouse>();
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a>

<span id="UnityEngine_InputSystem_PlayerInput_GetPlayerByIndex_" uid="UnityEngine.InputSystem.PlayerInput.GetPlayerByIndex*"></span>

#### GetPlayerByIndex(int)

Return the player with specified player index.

##### Declaration

``` lang-csharp
public static PlayerInput GetPlayerByIndex(int playerIndex)
```

##### Parameters

| Type                                                                               | Name                                           | Description                            |
|------------------------------------------------------------------------------------|------------------------------------------------|----------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a> | <span class="parametername">playerIndex</span> | The index into the active player list. |

##### Returns

| Type                                                                                                                                             | Description                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> | The player with the given player index or `null` if no such player exists. |

##### Remarks

Return the player with specified player index.

##### Examples

``` lang-csharp
PlayerInput player = PlayerInput.GetPlayerByIndex(0);
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a>

<span id="UnityEngine_InputSystem_PlayerInput_Instantiate_" uid="UnityEngine.InputSystem.PlayerInput.Instantiate*"></span>

#### Instantiate(GameObject, int, string, int, InputDevice)

Instantiate a player object, set up and enable its inputs.

##### Declaration

``` lang-csharp
public static PlayerInput Instantiate(GameObject prefab, int playerIndex = -1, string controlScheme = null, int splitScreenIndex = -1, InputDevice pairWithDevice = null)
```

##### Parameters

| Type                                                                                                                                             | Name                                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html" class="xref">GameObject</a>                              | <span class="parametername">prefab</span>           | Prefab to clone. Must contain a PlayerInput component somewhere in its hierarchy.                                                                                                                                                                                                                                                                                                                                                                                                                        |
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>                                                               | <span class="parametername">playerIndex</span>      | Player index to assign to the player. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_playerIndex" class="xref">playerIndex</a>. By default will be assigned automatically based on how many players are in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_all" class="xref">all</a>. |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                           | <span class="parametername">controlScheme</span>    | Control scheme to activate.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>                                                               | <span class="parametername">splitScreenIndex</span> | Which split screen to instantiate on.                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a> | <span class="parametername">pairWithDevice</span>   | Device to pair to the user. By default, this is `null` which means that PlayerInput will automatically pair with available, unpaired devices based on the control schemes (if any) present in <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> or on the bindings therein (if no control schemes are present).                                                   |

##### Returns

| Type                                                                                                                                             | Description                          |
|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> | Newly created PlayerInput component. |

##### Remarks

Instantiate a player object, set up and enable its inputs.

##### Examples

``` lang-csharp
var p1 = PlayerInput.Instantiate(playerPrefab, controlScheme: "KeyboardLeft", device: Keyboard.current);
```

##### Exceptions

| Type                                                                                                                 | Condition           |
|----------------------------------------------------------------------------------------------------------------------|---------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `prefab` is `null`. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_Instantiate_" uid="UnityEngine.InputSystem.PlayerInput.Instantiate*"></span>

#### Instantiate(GameObject, int, string, int, params InputDevice\[\])

A wrapper around <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Instantiate(Object)</a> that allows instantiating a player prefab and automatically pair one or more specific devices to the newly created player.

##### Declaration

``` lang-csharp
public static PlayerInput Instantiate(GameObject prefab, int playerIndex = -1, string controlScheme = null, int splitScreenIndex = -1, params InputDevice[] pairWithDevices)
```

##### Parameters

| Type                                                                                                                                                 | Name                                                | Description                                                                                                                                                                                               |
|------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html" class="xref">GameObject</a>                                  | <span class="parametername">prefab</span>           | A player prefab containing a <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> component in its hierarchy. |
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>                                                                   | <span class="parametername">playerIndex</span>      | Player index to instantiate.                                                                                                                                                                              |
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                               | <span class="parametername">controlScheme</span>    | Control scheme to activate.                                                                                                                                                                               |
| <a href="https://learn.microsoft.com/dotnet/api/system.int32" class="xref">int</a>                                                                   | <span class="parametername">splitScreenIndex</span> | Which split screen to instantiate on.                                                                                                                                                                     |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\[\] | <span class="parametername">pairWithDevices</span>  | Which devices to limit pairing to.                                                                                                                                                                        |

##### Returns

| Type                                                                                                                                             | Description                          |
|--------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a> | Newly created PlayerInput component. |

##### Remarks

Note that unlike <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Object.Instantiate.html" class="xref">Instantiate(Object)</a>, this method will always activate the resulting <a href="https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html" class="xref">GameObject</a> and its components.

##### Examples

``` lang-csharp
var devices = new InputDevice[] { Gamepad.all[0], Gamepad.all[1] };
var p1 = PlayerInput.Instantiate(playerPrefab, controlScheme: "Gamepad", pairWithDevices: devices);
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

<span id="UnityEngine_InputSystem_PlayerInput_SwitchCurrentActionMap_" uid="UnityEngine.InputSystem.PlayerInput.SwitchCurrentActionMap*"></span>

#### SwitchCurrentActionMap(string)

Switch the player to use the given action map

##### Declaration

``` lang-csharp
public void SwitchCurrentActionMap(string mapNameOrId)
```

##### Parameters

| Type                                                                                   | Name                                           | Description                       |
|----------------------------------------------------------------------------------------|------------------------------------------------|-----------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a> | <span class="parametername">mapNameOrId</span> | Name of the action map or its ID. |

##### Remarks

This method can be used to explicitly set an action map.

##### Examples

``` lang-csharp
PlayerInput.all[0].SwitchCurrentActionMap("Player");
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html" class="xref">InputActionMap</a>

<span id="UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_" uid="UnityEngine.InputSystem.PlayerInput.SwitchCurrentControlScheme*"></span>

#### SwitchCurrentControlScheme(string, params InputDevice\[\])

Switch the player to use the given control scheme together with the given devices.

##### Declaration

``` lang-csharp
public void SwitchCurrentControlScheme(string controlScheme, params InputDevice[] devices)
```

##### Parameters

| Type                                                                                                                                                 | Name                                             | Description                                                                                                                                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.string" class="xref">string</a>                                                               | <span class="parametername">controlScheme</span> | Name of the control scheme. See <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputControlScheme.html#UnityEngine_InputSystem_InputControlScheme_name" class="xref">name</a>. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\[\] | <span class="parametername">devices</span>       | A list of input devices to consider for pairing against                                                                                                                                                                           |

##### Remarks

This method can be used to explicitly force a combination of control scheme and a specific set of devices. The player's currently paired devices (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a>) will get unpaired.

##### Examples

``` lang-csharp
// Put player 1 on the "Gamepad" control scheme together
// with the second gamepad.
PlayerInput.all[0].SwitchControlScheme(
    "Gamepad",
    Gamepad.all[1]);
```

##### Exceptions

| Type                                                                                                                 | Condition                                                    |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a> | `devices` is `null` -or- `controlScheme` is `null` or empty. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_controlSchemes" class="xref">controlSchemes</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a>

<span id="UnityEngine_InputSystem_PlayerInput_SwitchCurrentControlScheme_" uid="UnityEngine.InputSystem.PlayerInput.SwitchCurrentControlScheme*"></span>

#### SwitchCurrentControlScheme(params InputDevice\[\])

Switch the current control scheme to one that fits the given set of devices.

##### Declaration

``` lang-csharp
public bool SwitchCurrentControlScheme(params InputDevice[] devices)
```

##### Parameters

| Type                                                                                                                                                 | Name                                       | Description                                                                                                                                  |
|------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputDevice.html" class="xref">InputDevice</a>\[\] | <span class="parametername">devices</span> | A list of input devices. Note that if any of the devices is already paired to another player, the device will end up paired to both players. |

##### Returns

| Type                                                                                  | Description                                                                                                                                                                                                                                                                                                                                            |
|---------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.boolean" class="xref">bool</a> | True if the switch was successful, false otherwise. The latter can happen, for example, if <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> does not have a control scheme that fits the given set of devices. |

##### Remarks

The player's currently paired devices (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a>) will get unpaired.

##### Examples

``` lang-csharp
// Switch the first player to keyboard and mouse.
PlayerInput.all[0].SwitchCurrentControlScheme(Keyboard.current, Mouse.current);
```

##### Exceptions

| Type                                                                                                                         | Condition                                                                                                                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.argumentnullexception" class="xref">ArgumentNullException</a>         | `devices` is `null`.                                                                                                                                                                                            |
| <a href="https://learn.microsoft.com/dotnet/api/system.invalidoperationexception" class="xref">InvalidOperationException</a> | <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a> has not been assigned. |

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionAsset.html#UnityEngine_InputSystem_InputActionAsset_controlSchemes" class="xref">controlSchemes</a>

### Events

#### onActionTriggered

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, this event is triggered when an action fires.

##### Declaration

``` lang-csharp
public event Action<InputAction.CallbackContext> onActionTriggered
```

##### Event Type

| Type                                                                                                                                                                                                                                                                                                                                                                                                              | Description                                        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html" class="xref">InputAction</a>.<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.CallbackContext.html" class="xref">CallbackContext</a>\> | Callbacks that get called when an action triggers. |

##### Remarks

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is not set to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, the value of this property is ignored.

The callbacks are called in sync (and with the same argument) with <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>, <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>, and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>.

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    void OnAction(InputAction.CallbackContext context)
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionMap.html#UnityEngine_InputSystem_InputActionMap_actionTriggered" class="xref">actionTriggered</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_started" class="xref">started</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_performed" class="xref">performed</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html#UnityEngine_InputSystem_InputAction_canceled" class="xref">canceled</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_actions" class="xref">actions</a>

#### onControlsChanged

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, this event is triggered when the controls used by the players are changed.

##### Declaration

``` lang-csharp
public event Action<PlayerInput> onControlsChanged
```

##### Event Type

| Type                                                                                                                                                                                                                                         | Description |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>\> |             |

##### Remarks

The callback is invoked when the set of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_devices" class="xref">devices</a> used by the player change, when the player switches to a different control scheme (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_currentControlScheme" class="xref">currentControlScheme</a>), or when the bindings used by the player are changed (e.g. when rebinding them). Also, for <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html" class="xref">Keyboard</a> devices, the callback is invoked when the currently used keyboard layout (see <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Keyboard.html#UnityEngine_InputSystem_Keyboard_keyboardLayout" class="xref">keyboardLayout</a>) changes.

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    void OnControlsChanged(PlayerInput context)
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>

#### onDeviceLost

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, this event is triggered when a device paired to the player is disconnected.

##### Declaration

``` lang-csharp
public event Action<PlayerInput> onDeviceLost
```

##### Event Type

| Type                                                                                                                                                                                                                                         | Description                                               |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>\> | Callbacks that get called when the player loses a device. |

##### Remarks

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is not <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, the value of this property is ignored.

The argument is the player that lost its device (i.e. the player on which the callback is installed).

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    void OnDeviceLost(PlayerInput context)
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceRegained" class="xref">onDeviceRegained</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUserChange.html#UnityEngine_InputSystem_Users_InputUserChange_DeviceLost" class="xref">DeviceLost</a>

#### onDeviceRegained

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, this event is triggered when the player previously lost a device and has now regained it or an equivalent device.

##### Declaration

``` lang-csharp
public event Action<PlayerInput> onDeviceRegained
```

##### Event Type

| Type                                                                                                                                                                                                                                         | Description                                                 |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| <a href="https://learn.microsoft.com/dotnet/api/system.action-1" class="xref">Action</a>\<<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref">PlayerInput</a>\> | Callbacks that get called when the player regains a device. |

##### Remarks

If <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_notificationBehavior" class="xref">notificationBehavior</a> is not <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref">InvokeCSharpEvents</a>, the value of this property is ignored.

The argument is the player that regained a device (i.e. the player on which the callback is installed).

##### Examples

``` lang-csharp
using UnityEngine;
using UnityEngine.InputSystem;
// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerLogic : MonoBehaviour

    void OnDeviceRegained(PlayerInput player)
    
}
```

##### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceLost" class="xref">onDeviceLost</a>

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.Users.InputUserChange.html#UnityEngine_InputSystem_Users_InputUserChange_DeviceRegained" class="xref">DeviceRegained</a>

### See Also

<a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInputManager.html" class="xref">PlayerInputManager</a>
