---
title: "Yield instruction reference"
page_title: "Unity - Manual: Yield instruction reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-yield-instructions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-yield-instructions.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Yield instruction reference

Coroutines suspend their execution at a `yield return` statement. A `yield return null` suspends execution of the coroutine until the next frame. But the `yield return` can also return an instruction for the Unity Editor or runtime to, for example, wait for a specified amount of time or until a condition is met before resuming execution of the coroutine.

## Runtime yield instructions

Unity has a set of custom yield instructions derived from [`UnityEngine.YieldInstruction`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html) that you can use to resume after a specified time, when a specified conditions is met, or at specific points in the Player loop.

<table><thead><tr class="header"><th style="text-align: left;">Instruction</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html"><code>AsyncOperation</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes when an asynchronous operation completes, such as loading a scene or asset.</td></tr><tr class="even"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForEndOfFrame.html"><code>WaitForEndOfFrame</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes at the end of the frame, after all rendering and GUI events.<br />
<br />
<strong>Note</strong>: <code>WaitForEndOfFrame</code> never runs in Edit mode when the Editor is in batch mode, even if scripts are marked with <code>[ExecuteInEditMode]</code> or <code>[ExecuteAlways]</code>.</td></tr><tr class="odd"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForFixedUpdate.html"><code>WaitForFixedUpdate</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes at the end of the next physics update, after all physics calculations.</td></tr><tr class="even"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html"><code>WaitForSeconds</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes after a specified number of seconds, taking the time scale into account.</td></tr><tr class="odd"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime.html"><code>WaitForSecondsRealtime</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes after a specified number of seconds, ignoring the time scale.</td></tr><tr class="even"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitUntil.html"><code>WaitUntil</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes when a supplied delegate evaluates to <code>true</code>.</td></tr><tr class="odd"><td style="text-align: left;"><a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitWhile.html"><code>WaitWhile</code></a></td><td style="text-align: left;">Suspends a coroutine and resumes when a supplied delegate evaluates to <code>false</code>.</td></tr></tbody></table>

For more information and example usage of these yield instructions, refer to their API reference pages.

For a visual representation of where different coroutines resume in the Player loop, refer to the diagram in [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html).

## UnityTest yield instructions

Unity Test Framework tests marked with the `[UnityTest]` attribute run as coroutines. The Test Framework package adds support for additional yield instructions to control the Unity Editor from tests and provides the possibility to define custom yield instructions.

| Instruction                                                                                                                                                         | Description                                                            |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------|
| [`EnterPlayMode`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.EnterPlayMode.html)             | Creates a yield instruction for the Unity Editor to enter Play mode.   |
| [`ExitPlayMode`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.ExitPlayMode.html)               | Creates a yield instruction for the Unity Editor to exit Play mode.    |
| [`RecompileScripts`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.RecompileScripts.html)       | Triggers a recompilation of scripts in the Unity Editor.               |
| [`WaitForDomainReload`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.WaitForDomainReload.html) | Delays the execution of scripts until after an incoming domain reload. |

For more information on the yield instructions provided by Unity Test Framework, refer to [Yield instructions for the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html).

## Editor yield instructions

The Editor coroutines package adds support for coroutines that run in the Unity Editor’s Edit mode. The package includes additional yield instructions for Edit mode coroutines.

| Instruction                                                                                                                                                                     | Description                                                                                         |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
| [`EditorWaitForSeconds`](https://docs.unity3d.com/Packages/com.unity.editorcoroutines@latest/index.html?subfolder=/api/Unity.EditorCoroutines.Editor.EditorWaitForSeconds.html) | Resumes an EditorCoroutine after a specified number of seconds, taking the time scale into account. |

For more information, refer to [Editor coroutines](https://docs.unity3d.com/Packages/com.unity.editorcoroutines@latest).

## Batch mode support

All runtime coroutine yield instructions run as normal when you run a standalone [Player in batch mode](https://docs.unity3d.com/6000.3/Documentation/Manual/PlayerCommandLineArguments.html).

If you run the [Editor in batch mode](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html#batchmode) and your project has scripts marked with [`[ExecuteInEditMode]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteInEditMode.html) or [`[ExecuteAlways]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html) so that they also run in Edit mode, all runtime coroutines in those scripts run in Edit mode except for `WaitForEndOfFrame`. This is because not all Unity subsystems update as regularly in Edit mode as they do at runtime. For more information, refer to the [`[ExecuteAlways]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html) API reference.

## Additional resources

-   [Command-line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/CommandLineArguments.html)
-   [`[ExecuteAlways]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ExecuteAlways.html) API reference
