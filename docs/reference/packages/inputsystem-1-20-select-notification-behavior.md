---
title: "Select a notification behavior"
page_title: "Select a notification behavior | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/select-notification-behavior.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/select-notification-behavior.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Select a notification behavior

You can use the <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html" class="xref"><code>Behavior</code></a> property in the Inspector to determine how a `PlayerInput` component notifies game code when something related to the player has occurred.

The following options are available:

<table><colgroup><col style="width: 33%" /><col style="width: 33%" /><col style="width: 33%" /></colgroup><thead><tr class="header"><th>Behavior value (UI)</th><th>Description</th><th>Matching enum value</th></tr></thead><tbody><tr class="odd"><td><strong>Send Messages</strong></td><td>Uses <a href="https://docs.unity3d.com/ScriptReference/GameObject.SendMessage.html"><code>GameObject.SendMessage</code></a> on the <code>GameObject</code> that the <code>PlayerInput</code> component belongs to.</td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_SendMessages" class="xref"><code>SendMessages</code></a></td></tr><tr class="even"><td><strong>Broadcast Messages</strong></td><td>Uses <a href="https://docs.unity3d.com/ScriptReference/GameObject.BroadcastMessage.html"><code>GameObject.BroadcastMessage</code></a> on the <code>GameObject</code> that the <code>PlayerInput</code> component belongs to. This broadcasts the message down the <code>GameObject</code> hierarchy.</td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_BroadcastMessages" class="xref"><code>BroadcastMessages</code></a></td></tr><tr class="odd"><td><strong>Invoke Unity Events</strong></td><td>Uses a separate <a href="https://docs.unity3d.com/ScriptReference/Events.UnityEvent.html"><code>UnityEvent</code></a> for each individual type of message. When this is selected, the events available on the <code>PlayerInput</code> are accessible from the <strong>Events</strong> foldout. The argument received by events triggered for Actions is the same as the one received by <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/set-callbacks-on-actions.html#action-callbacks" class="xref"><code>started</code>, <code>performed</code>, and <code>canceled</code> callbacks</a>.<br />
<br />
<img src="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/MyPlayerActionEvents.png" alt="PlayerInput UnityEvents" /></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeUnityEvents" class="xref"><code>InvokeUnityEvents</code></a></td></tr><tr class="even"><td><strong>Invoke CSharp Events</strong></td><td>Similar to <strong>Invoke Unity Events</strong>, except that the events are plain C# events available on the <code>PlayerInput</code> API. You cannot configure these from the Inspector. Instead, you have to register callbacks for the events in your scripts.<br />
<br />
The following events are available:<br />
<br />
<ul><li><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onActionTriggered" class="xref"><code>onActionTriggered</code></a> (collective event for all actions on the player)</li><li><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceLost" class="xref"><code>onDeviceLost</code></a></li><li><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_onDeviceRegained" class="xref"><code>onDeviceRegained</code></a></li></ul></td><td><a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerNotifications.html#UnityEngine_InputSystem_PlayerNotifications_InvokeCSharpEvents" class="xref"><code>InvokeCSharpEvents</code></a></td></tr></tbody></table>

In addition to per-action notifications, `PlayerInput` sends the following general notifications:

| Notification                                                                                                                                                                                                                      | Description                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_DeviceLostMessage" class="xref"><code>DeviceLostMessage</code></a>         | The player has lost one of the Devices assigned to it. This can happen, for example, if a wireless device runs out of battery. |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html#UnityEngine_InputSystem_PlayerInput_DeviceRegainedMessage" class="xref"><code>DeviceRegainedMessage</code></a> | Notification that triggers when the player recovers from Device loss and is good to go again.                                  |
