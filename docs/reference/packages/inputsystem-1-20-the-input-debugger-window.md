---
title: "The input debugger window"
page_title: "The input debugger window | Input System | 1.20.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/the-input-debugger-window.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/the-input-debugger-window.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# The input debugger window

When something isn't working as expected, the quickest way to troubleshoot what's wrong is the Input Debugger in the Unity Editor. The Input Debugger provides access to the activity of the Input System in both the Editor and the connected Players.

To open the Input Debugger, go to **Window \> Analysis \> Input Debugger** from Unity's main menu.

## Input Debugger

![Input Debugger](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/images/InputDebugger.png)

The Input Debugger displays a tree breakdown of the state of the Input System.

<table><colgroup><col style="width: 50%" /><col style="width: 50%" /></colgroup><thead><tr class="header"><th>Item</th><th>Description</th></tr></thead><tbody><tr class="odd"><td>Devices</td><td>A list of all <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/devices.html">Input Devices</a> that are currently in the system, and a list of unsupported/unrecognized Devices.</td></tr><tr class="even"><td>Layouts</td><td>A list of all registered Control and Device layouts. This is the database of supported hardware, and information on how to represent a given piece of input hardware.</td></tr><tr class="odd"><td>Actions</td><td>Only visible in Play mode, and only if at least one <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Actions.html">Action</a> is enabled.<br />
<br />
A list of all currently enabled Actions, and the Controls they are bound to.<br />
<br />
Refer to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/debug-action.html">Debugging Actions</a>.</td></tr><tr class="even"><td>Users</td><td>Only visible when one or more <code>InputUser</code> instances exist. See documentation on <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/user-management.html">user management</a>.<br />
<br />
A list of all currently active users, along with their active Control Schemes and Devices, all their associated Actions, and the Controls these Actions are bound to.<br />
<br />
Note that <code>PlayerInput</code> uses <code>InputUser</code> to run. When using <code>PlayerInput</code> components, each player has an entry in this list.<br />
<br />
Refer to <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/debug-users-playerinput.html">Debugging users and PlayerInput</a>.</td></tr><tr class="odd"><td>Settings</td><td>The currently active Input System <a href="https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/input-settings.html">settings</a>.</td></tr><tr class="even"><td>Metrics</td><td>Statistics about Input System resource usage.</td></tr></tbody></table>
