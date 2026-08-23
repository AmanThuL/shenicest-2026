---
title: "Update Mode (Input System)"
page_title: "Update Mode | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/update-mode.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/update-mode.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Update Mode

This setting determines when the Input System processes input. The Input System can process input in one of three distinct ways:

| Type                                                                                                                                                                                            | Description                                                                                                                                                                                                                                                                                                                                    |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html" class="xref"><code>Process Events In Dynamic Update</code></a> | The Input System processes events at irregular intervals determined by the current framerate.                                                                                                                                                                                                                                                  |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html" class="xref"><code>Process Events In Fixed Update</code></a>   | The Input System processes events at fixed-length intervals. This corresponds to how [`MonoBehaviour.FixedUpdate`](https://docs.unity3d.com/ScriptReference/MonoBehaviour.FixedUpdate.html) operates. The length of each interval is determined by [`Time.fixedDeltaTime`](https://docs.unity3d.com/ScriptReference/Time-fixedDeltaTime.html). |
| <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSettings.UpdateMode.html" class="xref"><code>Process Events Manually</code></a>          | The Input System does not process events automatically. Instead, it processes them whenever you call <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputSystem.html" class="xref"><code>InputSystem.Update()</code></a>.                                                                   |

##### Note

The system performs two additional types of updates in the form of <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputUpdateType.html" class="xref"><code>InputUpdateType.BeforeRender</code></a> (late update for XR tracking Devices) and <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.LowLevel.InputUpdateType.html" class="xref"><code>InputUpdateType.Editor</code></a> (for EditorWindows). Neither of these update types change how the application consumes input.
