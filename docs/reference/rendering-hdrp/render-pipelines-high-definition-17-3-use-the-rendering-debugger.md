---
title: "Use the Rendering Debugger (HDRP)"
page_title: "Use the Rendering Debugger | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Use the Rendering Debugger

The **Rendering Debugger** is a specific window for the Scriptable Render Pipeline that contains debugging and visualization tools. You can use these tools to understand and solve any issues you might encounter. It contains graphics-related tools but you can extend it to include tools for any other field, such as animation.

## How to access the Rendering Debugger

The Rendering Debugger window is available in the following modes:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th>Mode</th>
<th>Platform</th>
<th>Availability</th>
<th>How to Open the Rendering Debugger</th>
</tr>
</thead>
<tbody>
<tr>
<td>Editor</td>
<td>All</td>
<td>Yes (window in the Editor)</td>
<td>Select <strong>Window &gt; Analysis &gt; Rendering Debugger</strong></td>
</tr>
<tr>
<td>Play mode</td>
<td>All</td>
<td>Yes (overlay in the Game view)</td>
<td>On a desktop or laptop computer, press <strong>LeftCtrl+Backspace</strong> (<strong>LeftCtrl+Delete</strong> on macOS)<br />
On a console controller, press L3 and R3 (Left Stick and Right Stick)</td>
</tr>
<tr>
<td>Runtime</td>
<td>Desktop/Laptop</td>
<td>Yes (only in Development builds)</td>
<td>Press <strong>LeftCtrl+Backspace</strong> (<strong>LeftCtrl+Delete</strong> on macOS)</td>
</tr>
<tr>
<td>Runtime</td>
<td>Console</td>
<td>Yes (only in Development builds)</td>
<td>Press L3 and R3 (Left Stick and Right Stick)</td>
</tr>
<tr>
<td>Runtime</td>
<td>Mobile</td>
<td>Yes (only in Development builds)</td>
<td>Use a three-finger double tap</td>
</tr>
</tbody>
</table>

To enable all the sections of the **Rendering Debugger** in your built application, disable **Strip Debug Variants** in **Project Settings \> Graphics \> URP Global Settings**. Otherwise, you can only use the [Display Stats](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-the-rendering-debugger.html#display-stats) section.

To disable the runtime UI, use the [enableRuntimeUI](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/api/UnityEngine.Rendering.DebugManager.html#UnityEngine_Rendering_DebugManager_enableRuntimeUI) property.

You can display read-only items, such as the FPS counter, independently of the **Rendering Debugger** window. When you disable the **Rendering Debugger** window, they're still visible in the top right corner of the screen. Use this functionality to track particular values without cluttering the screen.

## Use the Rendering Debugger

Refer to [Rendering Debugger window reference](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/rendering-debugger-window-reference.html) for more information.

## Navigation at runtime

### Keyboard

| Action | Control |
|----|----|
| **Change the current active item** | Use the arrow keys |
| **Change the current tab** | Use the Page up and Page down keys (Fn + Up and Fn + Down keys respectively for MacOS) |
| **Display the current active item independently of the debug window** | Press the right Shift key |

### Xbox Controller

| Action | Control |
|----|----|
| **Change the current active item** | Use the Directional pad (D-Pad) |
| **Change the current tab** | Use the Left Bumper and Right Bumper |
| **Display the current active item independently of the debug window** | Press the X button |

### PlayStation Controller

| Action | Control |
|----|----|
| **Change the current active item** | Use the Directional buttons |
| **Change the current tab** | Use the L1 button and R1 button |
| **Display the current active item independently of the debug window** | Press the Square button |
